{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Lib
-}

module Lib (
    usage,
    pError,
) where

import System.Exit (ExitCode (ExitFailure), exitWith)
import System.IO (hPutStrLn, stderr)

pError :: String -> IO ()
pError str = hPutStrLn stderr str >> exitWith (ExitFailure 84)

usage :: IO ()
usage =
    putStrLn
        "USAGE: ./imageCompressor -n N -l L -f F\n\n\
        \    N   number of colors in the final image\n\
        \    L   convergence limit\n\
        \    F   path to the file containing the colors of the pixels"
