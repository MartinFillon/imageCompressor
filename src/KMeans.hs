{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- KMeans
-}

module KMeans where

import ImageData

import Data.List (minimumBy)
import Data.Word (Word8)
import Data.Function (on)

distance :: (Word8, Word8, Word8) -> (Word8, Word8, Word8) -> Double
distance (r1, g1, b1) (r2, g2, b2) =
  sqrt $ fromIntegral $ (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2

updateCentroid :: ImageData -> Int -> ImageData
updateCentroid imgData 0 = imgData
updateCentroid imgData newCentroid = imgData { centroid = newCentroid }

doKMeans' :: [ImageData] -> Float -> Int -> [ImageData]
doKMeans' imgData convergence nClusters = map (\img ->
    updateCentroid img $ nearestCentroid img) imgData
  where
    centroids = take nClusters $ zip [1..] imgData
    nearestCentroid img =
      fst $ minimumBy (compare `on` snd) [(i, distance (color img) (color c)) |
        (i, c) <- centroids]

doKMeans :: [ImageData] -> Float -> Int -> [ImageData]
doKMeans imgData convergence nClusters =
    doKMeans' imgData' convergence nClusters
  where
    imgData' = zipWith (\img idx -> img { centroid = idx }) imgData clusterInd
    clusterInd = take (length imgData) $ cycle [1..nClusters]
