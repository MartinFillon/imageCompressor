{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module File (openFile, parseFile) where

import Data.Functor ((<&>))
import Data.Word (Word8)
import Text.Read (readEither)

import Colors (Color, colorFrom)
import Lib (pError)
import Points (Point, pointFrom)

openFile :: Maybe String -> IO [String]
openFile Nothing = pError "File not specified" >> return []
openFile (Just p) = readFile p <&> lines

splitAtFirst :: Eq a => a -> [a] -> ([a], [a])
splitAtFirst x = fmap (drop 1) . break (x ==)

parseFile :: [String] -> Either String [(Point, Color)]
parseFile = mapM (unwrapLine . parseLine . splitAtFirst ' ')

unwrapLine :: (Either String (Int, Int), Either String (Word8, Word8, Word8)) -> Either String (Point, Color)
unwrapLine (Left a, _) = Left a
unwrapLine (_, Left b) = Left b
unwrapLine (Right a, Right b) = Right (pointFrom a, colorFrom b)

parseLine :: (String, String) -> (Either String (Int, Int), Either String (Word8, Word8, Word8))
parseLine (a, b) = (readEither a, readEither b)
