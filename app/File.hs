{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module File (openFile, parseFile) where

import Data.Functor
import Text.Read (readMaybe)

import Colors (Color)
import Lib (pError)
import Points (Point)

openFile :: Maybe String -> IO [String]
openFile Nothing = pError "File not specified" >> return []
openFile (Just p) = readFile p <&> lines

splitAtFirst :: Eq a => a -> [a] -> ([a], [a])
splitAtFirst x = fmap (drop 1) . break (x ==)

parseFile :: [String] -> [(Maybe Point, Maybe Color)]
parseFile = map (parseLine . splitAtFirst ' ')

parseLine :: (String, String) -> (Maybe Point, Maybe Color)
parseLine (a, b) = (readMaybe a, readMaybe b)
