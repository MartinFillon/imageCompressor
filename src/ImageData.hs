{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Data
-}

module ImageData (
    ImageData (color, point, centroid),
    imageDataFrom,
    dumpImageData,
) where

import Data.Word (Word8)

data ImageData = ImageData
    { color :: (Int, Int, Int),
      point :: (Int, Int),
      centroid :: Int
    }
    deriving (Eq)

imageDataFrom :: (Word8, Word8, Word8) -> (Int, Int) -> ImageData
imageDataFrom (a, b, c) pt = ImageData convert pt 0
  where
    convert = (fromIntegral a, fromIntegral b, fromIntegral c)

instance Show ImageData where
    show (ImageData c p d) = show p ++ " " ++ show c ++ " " ++ show d

dumpImageData :: [ImageData] -> IO ()
dumpImageData = foldr ((>>) . print) (return ())
