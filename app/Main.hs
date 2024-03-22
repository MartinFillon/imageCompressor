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
import Debug.Trace (traceShowId)
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
    ([ImageData], [(Int, Color)])
calcKmeans dt st _ n True = (dt, zip [1 ..] $ init)
calcKmeans dt st c n False = calcKmeans ndata mn c n conv
  where
    ndata = doKMeans dt st n
    mn = computeClusterMeans n st ndata
    init = map colorFrom $ computeClusterMeans n st dt
    conv = (checkConvergence c $ zip st mn)

startingClusters :: Int -> [ImageData] -> IO [ImageData]
startingClusters 0 _ = return []
startingClusters n l =
    randomRIO (0, length l - 1)
        >>= (\c -> (l !! c :) <$> startingClusters (n - 1) l)

prepareStart :: [ImageData] -> IO [(Int, Int, Int)]
prepareStart x = return (map color x)

printFileContent :: Maybe Opt -> IO ()
printFileContent (Just (Opt r (Just c) (Just l))) = do
    a <- openFile r >>= checkImageData . parseFile
    st <- startingClusters c a >>= prepareStart
    printResult c $ calcKmeans a st l c False
printFileContent _ = exitWith $ ExitFailure 84

printResult :: Int -> ([ImageData], [(Int, Color)]) -> IO ()
printResult _ (_, []) = return ()
printResult nClusters (imgData, x : xs) =
    printCluster x imgData
        >> printResult nClusters (imgData, xs)

printCluster :: (Int, Color) -> [ImageData] -> IO ()
printCluster (mean, color) imgData =
    putStrLn "--"
        >> printColor color
        >> putStrLn "-"
        >> dumpImageData (filter (\img -> mean == centroid img) imgData)

checkImageData :: Either String [ImageData] -> IO [ImageData]
checkImageData (Left _) = exitWith (ExitFailure 84) >> return []
checkImageData (Right d) = return d

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
