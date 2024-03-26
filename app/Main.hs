{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import Clusters (checkConvergence, computeClusterMeans)
import Colors (Color (..), colorFrom, printColor)
import File (openFile, parseFile)
import ImageData (ImageData (centroid, color), dumpImageData)
import KMeans (doKMeans)
import Options (Opt (..), defaultOpt, optParser)
import System.Exit (ExitCode (ExitFailure), exitWith)
import System.Random (randomRIO)

calcKmeans ::
    [ImageData] ->
    [(Int, Int, Int)] ->
    Float ->
    Int ->
    Bool ->
    ([ImageData], [(Int, (Int, Int, Int))])
calcKmeans dt st _ _ True = (dt, end)
  where
    end = zip [1 ..] st
calcKmeans dt st c n False = calcKmeans new end c n (checkConvergence c (zip st end))
  where
    end = computeClusterMeans 1 st new
    new = doKMeans dt st n

startingClusters :: Int -> [ImageData] -> IO [ImageData]
startingClusters 0 _ = return []
startingClusters n l =
    randomRIO (0, length l - 1)
        >>= (\c -> (l !! c :) <$> startingClusters (n - 1) l)

prepareStart :: [ImageData] -> IO [(Int, Int, Int)]
prepareStart x = return (map color x)

printFileContent :: Maybe Opt -> IO ()
printFileContent (Just (Opt r (Just c) (Just l))) | c > 0 && l > 0 = do
    a <- openFile r >>= checkImageData . parseFile
    st <- startingClusters c a >>= prepareStart
    printResult c $ calcKmeans a st l c False
printFileContent _ = exitWith $ ExitFailure 84

printResult :: Int -> ([ImageData], [(Int, (Int, Int, Int))]) -> IO ()
printResult _ (_, []) = return ()
printResult nClusters (imgData, x : xs) =
    printCluster x imgData
        >> printResult nClusters (imgData, xs)

printCluster :: (Int, (Int, Int, Int)) -> [ImageData] -> IO ()
printCluster (mean, color) imgData =
    putStrLn "--"
        >> print color
        >> putStrLn "-"
        >> dumpImageData (filter (\img -> mean == centroid img) imgData)

checkImageData :: Either String [ImageData] -> IO [ImageData]
checkImageData (Left _) = exitWith (ExitFailure 84) >> return []
checkImageData (Right d) = return d

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
