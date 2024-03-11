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
printFileContent (Just (Opt r _ _)) = openFile r >>= print . run

splitIt :: [(Point, Color)] -> [Color]
splitIt [] = []
splitIt ((_, c) : xs) = c : splitIt xs

tryRun :: Either String [(Point, Color)] -> [[Color]]
tryRun (Left _) = []
tryRun (Right l) = calculate 2 (splitIt l) [[Color 2 3 4], [Color 1 4 5]]

calculate :: Int -> [Color] -> [[Color]] -> [[Color]]
calculate 0 _ r = r
calculate _ [] _ = []
calculate n l r = calculate (n - 1) l (kMeans l 2 0.0 (map getMean r))

run :: [String] -> [[Color]]
run = tryRun . parseFile

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
