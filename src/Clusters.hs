{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Clusters
-}

module Clusters (computeClusterMeans, checkConvergence) where

import Calculator (getMean)
import Colors (colorFrom, distance)
import ImageData (ImageData (centroid, color, point))

import Data.List (sortOn)
import Debug.Trace (traceShow, traceShowId)

computeClusterMeans ::
    Int -> [(Int, Int, Int)] -> [ImageData] -> [(Int, Int, Int)]
computeClusterMeans _ [] _ = []
computeClusterMeans n (x : xs) imgData =
    imgMean (filter (\img -> n == centroid img) imgData) x
        : computeClusterMeans (n - 1) xs imgData

checkConvergence ::
    Float -> [((Int, Int, Int), (Int, Int, Int))] -> Bool
checkConvergence n =
    foldr
        (\(a, b) acc -> acc && distance a b <= n)
        True

sortByCentroid :: [ImageData] -> [ImageData]
sortByCentroid = sortOn centroid

imgMean :: [ImageData] -> (Int, Int, Int) -> (Int, Int, Int)
imgMean [] x = x
imgMean x _ = getMean (map (colorFrom . color) (traceShowId x))
