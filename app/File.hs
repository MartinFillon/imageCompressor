{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module File (openFile, parseFile) where

import Control.Exception (IOException, catch)
import Data.Functor ((<&>))
import Data.Word (Word8)
import Text.Read (readEither)

import ImageData (ImageData, imageDataFrom)
import Lib (pError)

openFile :: Maybe String -> IO [String]
openFile Nothing = pError "File not specified" >> return []
openFile (Just p) =
    catch
        (readFile p)
        ( \e ->
            pError ("Couldn't open " ++ p ++ ": " ++ show (e :: IOException)) >> return []
        )
        <&> lines

splitAtFirst :: Eq a => a -> [a] -> ([a], [a])
splitAtFirst x = fmap (drop 1) . break (x ==)

parseFile :: [String] -> Either String [ImageData]
parseFile = mapM (unwrapLine . parseLine . splitAtFirst ' ')

unwrapLine ::
    (Either String (Int, Int), Either String (Word8, Word8, Word8)) ->
    Either String ImageData
unwrapLine (Left a, _) = Left a
unwrapLine (_, Left b) = Left b
unwrapLine (Right a, Right b) = Right (imageDataFrom b a)

parseLine ::
    (String, String) ->
    (Either String (Int, Int), Either String (Word8, Word8, Word8))
parseLine (a, b) = (readEither a, readEither b)
