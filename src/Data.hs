{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Data
-}

module Data (Data (Data), dataFrom, dumpData) where

import Data.Word (Word8)

data Data = Data
    { color :: (Word8, Word8, Word8),
      point :: (Int, Int),
      centroid :: Int
    }
    deriving (Eq)

dataFrom :: (Word8, Word8, Word8) -> (Int, Int) -> Data
dataFrom cl pt = Data cl pt 0

instance Show Data where
    show (Data c p _) = show p ++ " " ++ show c

dumpData :: [Data] -> IO ()
dumpData [] = return ()
dumpData (x : xs) = print x >> dumpData xs
