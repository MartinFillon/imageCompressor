{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- KMeans
-}

module KMeans where

import ImageData (ImageData (ImageData), imageDataFrom, dumpImageData)
import Data.List (elemIndex, genericLength, minimumBy)
import Data.Word (Word8)
import Data.Function (on)

distance :: (Word8, Word8, Word8) -> (Word8, Word8, Word8) -> Double
distance (r1, g1, b1) (r2, g2, b2) = sqrt $ fromIntegral $ (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2

updateCentroids :: [[ImageData]] -> [ImageData] -> [ImageData]
updateCentroids clusters centroids =
    let newCentroids = map (calculateCentroid . map point) clusters
    in zipWith (\(ImageData c p _) newC -> ImageData c p newC) centroids newCentroids

calculateCentroid :: [(Int, Int)] -> (Int, Int)
calculateCentroid points =
    let (xs, ys) = unzip points
    in (sum xs `div` length points, sum ys `div` length points)

groupBy :: Eq b => (a -> b) -> [a] -> [[a]]
        groupBy f [] = []
        groupBy f (x:xs) = let (matches, rest) = span ((==) (f x) . f) xs
                           in (x:matches) : groupBy f rest

assignClusters :: [ImageData] -> [ImageData] -> [[ImageData]]
assignClusters centroids points =
    let nearestCentroid point = minimumBy (compare `on` distance (point.point)) centroids
    in groupBy (centroid . nearestCentroid) points

kMeans :: Int -> [ImageData] -> [ImageData]
kMeans k points = kMeans' (initializeCentroids k points) points
    where
        initializeCentroids k' points' = take k' points'
        kMeans' centroids points' =
            let clusters = assignClusters centroids points'
                newCentroids = updateCentroids clusters centroids
            in if newCentroids == centroids
                then newCentroids
                else kMeans' newCentroids points'

main :: IO ()
main = do
    let points = [ imageDataFrom (33,18,109) (0,0),
                   imageDataFrom (33,18,109) (0,1),
                   imageDataFrom (33,21,109) (0,2),
                   imageDataFrom (33,21,112) (0,3),
                   imageDataFrom (33,25,112) (0,4),
                   imageDataFrom (33,32,112) (0,5),
                   imageDataFrom (33,18,109) (1,0),
                   imageDataFrom (35,18,109) (1,1),
                   imageDataFrom (35,21,109) (1,2),
                   imageDataFrom (38,21,112) (1,3)
                 ]
    let k = 2
    let centroids = kMeans k points
    let clusteredPoints = assignClusters centroids points
    print centroids
    dumpImageData clusteredPoints