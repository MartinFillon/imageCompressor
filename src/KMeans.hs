{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- KMeans
-}

module KMeans where

import Calculator
import ImageData
import Data.List (elemIndex, genericLength)
import Data.Word (Word8)

distance :: (Word8, Word8, Word8) -> (Word8, Word8, Word8) -> Double
distance (r1, g1, b1) (r2, g2, b2) = sqrt $ fromIntegral $ (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2

appendAtIdx' :: a -> [[a]] -> Int -> [[a]]
appendAtIdx' _ [] _ = []
appendAtIdx' c (x : xs) 0 = (c : x) : xs
appendAtIdx' c (x : xs) i = x : appendAtIdx' c xs (i - 1)

appendAtIdx :: a -> [[a]] -> Maybe Int -> [[a]]
appendAtIdx _ y Nothing = y
appendAtIdx x y (Just i) = appendAtIdx' x y i

appendToArrII :: [ImageData] -> ImageData -> [[ImageData]] -> [[ImageData]]
appendToArrII meansl imgData cls =
    appendAtIdx
        imgData
        cls
        (elemIndex (foldl1 minDist m) m)
  where
    minDist = map (`distance` color imgData) meansl
    m = map (`distance` imgData) meansl

kMeans :: Int -> [ImageData] -> [ImageData] -> ([[ImageData]], [ImageData])
kMeans _ [] centroids = ([], centroids)
kMeans n (x : xs) centroids = (newCls : otherCls, newCentroid : otherCentroids)
  where
    (newCls, newCentroid) = appendToArrII centroids x (kMeans n xs centroids)
    (otherCls, otherCentroids) = kMeans n xs centroids

calculateCentroid :: [ImageData] -> Int -> ImageData
calculateCentroid cluster centroidIndex = ImageData meanColor meanPoint centroidIndex
  where
    meanColor = calculateMeanColor cluster
    meanPoint = calculateMeanPoint cluster

calculateMeanColor :: [ImageData] -> (Word8, Word8, Word8)
calculateMeanColor cluster = means $ unzip3 [(r, g, b) | ImageData (r, g, b) _ _ <- cluster]

calculateMeanPoint :: [ImageData] -> (Int, Int)
calculateMeanPoint cluster = (mean xs, mean ys)
  where
    (xs, ys) = unzip [point imgData | imgData <- cluster]
    mean values = round $ fromIntegral (sum values) / fromIntegral (length values)

extractClusters :: [ImageData] -> [[ImageData]]
extractClusters imgDataList = groupBy (\a b -> centroid a == centroid b) sortedImgData
  where
    sortedImgData = sortOn centroid imgDataList
