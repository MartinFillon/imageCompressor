{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- KMeans
-}

module KMeans (doKMeans) where

import ImageData (ImageData (color, point, centroid))
import Colors (Color (..), colorFrom, distance)

import Data.Word (Word8)
import Data.List (minimumBy)
import Data.Function (on)

updateCentroid :: ImageData -> Int -> ImageData
updateCentroid imgData 0 = imgData
updateCentroid imgData newCentroid = imgData { centroid = newCentroid }

doKMeans' :: [ImageData] -> Float -> Int -> [ImageData]
doKMeans' imgData convergence nClusters = map (\img ->
    updateCentroid img $ nearestCentroid img) imgData
  where
    centroids = take nClusters $ zip [1..] imgData
    nearestCentroid img =
      fst $ minimumBy (compare `on` snd) [(i, distance (colorFrom (color img))
        (colorFrom (color c))) | (i, c) <- centroids]

doKMeans :: [ImageData] -> Float -> Int -> [ImageData]
doKMeans imgData convergence nClusters =
    doKMeans' imgData' convergence nClusters
  where
    imgData' = zipWith (\img idx -> img { centroid = idx }) imgData clusterInd
    clusterInd = take (length imgData) $ cycle [1..nClusters]
