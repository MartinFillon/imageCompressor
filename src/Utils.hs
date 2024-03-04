{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Utils
-}

module Utils where

import System.Exit
import System.IO (hPutStrLn, stderr)

type Vector = (Int, Int, Int)

pError :: String -> IO ()
pError str = hPutStrLn stderr str >> exitWith (ExitFailure 84)

usage :: IO ()
usage = putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n\n\
\    N   number of colors in the final image\n\
\    L   convergence limit\n\
\    F   path to the file containing the colors of the pixels"

distance :: (Ord a, Floating a) => (a, a, a) -> (a, a, a) -> a
distance (x1, y1, z1) (x2, y2, z2) =
    sqrt ((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)

euclideanDistance :: Vector -> Vector -> Double
euclideanDistance (x1, y1, z1) (x2, y2, z2) =
    sqrt $ fromIntegral ((x1 - x2) ^ (2 :: Integer))
        + fromIntegral ((y1 - y2) ^ (2 :: Integer))
        + fromIntegral ((z1 - z2) ^ (2 :: Integer))
