{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Data
-}

module Data (Data (Data)) where

import Data.Word (Word8)

data Data = Data
    { color :: (Word8, Word8, Word8),
      point :: (Int, Int),
      centroid :: Int
    }
    deriving (Eq, Show)
