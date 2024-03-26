{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- KMeans
-}

module KMeans (doKMeans) where

import Colors (colorFrom, distance)
import ImageData (ImageData (centroid, color))

import Data.Function (on)
import Data.List (minimumBy)

updateCentroid :: ImageData -> Int -> ImageData
updateCentroid imgData newCentroid = imgData {centroid = newCentroid}

doKMeans' :: [ImageData] -> [(Int, Int, Int)] -> Int -> [ImageData]
doKMeans' d means _ = map (\img -> updateCentroid img $ nearestCentroid img) d
  where
    centroids = zip [1 ..] means
    nearestCentroid img =
        fst $
            minimumBy
                (compare `on` snd)
                [(i, distance (color img) c) | (i, c) <- centroids]

doKMeans :: [ImageData] -> [(Int, Int, Int)] -> Int -> [ImageData]
doKMeans = doKMeans'
