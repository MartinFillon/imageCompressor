{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Data
-}

module ImageData (ImageData (color, point, centroid),
  imageDataFrom, dumpImageData) where

import Data.Word (Word8)

data ImageData = ImageData
    { color :: (Word8, Word8, Word8),
      point :: (Int, Int),
      centroid :: Int
    }
    deriving (Eq)

imageDataFrom :: (Word8, Word8, Word8) -> (Int, Int) -> ImageData
imageDataFrom cl pt = ImageData cl pt 0

instance Show ImageData where
    show (ImageData c p _) = show p ++ " " ++ show c

dumpImageData :: [ImageData] -> IO ()
dumpImageData [] = return ()
dumpImageData (x : xs) = print x >> dumpImageData xs
