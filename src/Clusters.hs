{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Clusters
-}

module Clusters (computeClusterMeans) where

import ImageData (ImageData (color, point, centroid))
import Colors (Color (..), colorFrom)
import Calculator (getMean)

import Data.Function (on)
import Data.List (groupBy, sortOn)

computeClusterMeans :: [ImageData] -> Int -> [(Int, (Color))]
computeClusterMeans imgData nClusters =
  map computeMean $ groupBy ((==) `on` centroid) sortedImgData
  where
    sortedImgData = sortByCentroid imgData
    computeMean cluster = (centroid (head cluster), calculateMeanColor cluster)
    calculateMeanColor cluster = getMean (map (colorFrom . color) cluster)

sortByCentroid :: [ImageData] -> [ImageData]
sortByCentroid = sortOn centroid
