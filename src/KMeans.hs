{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- KMeans
-}

module KMeans where

import ImageData
import Data.List (elemIndex, genericLength, minimumBy)
import Data.Word (Word8)
import Data.Function (on)

distance :: (Word8, Word8, Word8) -> (Word8, Word8, Word8) -> Double
distance (r1, g1, b1) (r2, g2, b2) = sqrt $ fromIntegral $ (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2

updateCentroid :: ImageData -> Int -> ImageData
updateCentroid imgData 0 = imgData
updateCentroid imgData newCentroid = imgData { centroid = newCentroid }

doKMeans' :: [ImageData] -> Float -> [ImageData]
doKMeans' imgData convergence = updateCentroid imgData' newCentroid
  where
    imgData' = map (\x -> x { centroid = 0 }) imgData
    newCentroid = map (\x -> x { centroid = 0 }) imgData

doKMeans :: [ImageData] -> Float -> Int -> [ImageData]
doKMeans imgData convergence 0 = imgData
doKMeans imgData convergence nClusters =
  doKMeans (doKMeans' imgData convergence) convergence (nClusters - 1)

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
    -- let centroids = kMeans 2 points
    let clusteredPoints = doKMeans points (0.8) 2
    dumpImageData clusteredPoints
