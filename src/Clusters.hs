{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Clusters
-}

module Clusters (computeClusterMeans, checkConvergence) where

import Calculator (getMean)
import Colors (distance)
import ImageData (ImageData (centroid, color))

computeClusterMeans ::
    Int -> [(Int, Int, Int)] -> [ImageData] -> [(Int, Int, Int)]
computeClusterMeans _ [] _ = []
computeClusterMeans n (x : xs) imgData =
    imgMean (filter (\img -> n == centroid img) imgData) x
        : computeClusterMeans (n + 1) xs imgData

checkConvergence ::
    Float -> [((Int, Int, Int), (Int, Int, Int))] -> Bool
checkConvergence n =
    foldr (\(a, b) acc -> acc && distance a b <= n) True

imgMean :: [ImageData] -> (Int, Int, Int) -> (Int, Int, Int)
imgMean [] x = x
imgMean x _ = getMean (map color x)
