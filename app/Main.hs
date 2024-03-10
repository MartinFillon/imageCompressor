{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import Calculator
import Colors
import File (openFile, parseFile)
import Options (Opt (..), defaultOpt, optParser)
import Points

printFileContent :: Maybe Opt -> IO ()
printFileContent Nothing = return ()
printFileContent (Just (Opt r _ _)) = openFile r >>= print . (\x -> tryRun (parseFile x))

splitIt :: [(Point, Color)] -> [Color]
splitIt [] = []
splitIt ((_, c) : xs) = c : splitIt xs

tryRun :: Either String [(Point, Color)] -> [[Color]]
tryRun (Left _) = []
tryRun (Right l) = kMeans (splitIt l) 2 0.0 [Color 1 2 3, Color 3 2 1]

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
