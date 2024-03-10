{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Colors (Color (..), colorFrom, distance) where

import Data.Word (Word8)

data Color = Color
    { r :: Word8,
      g :: Word8,
      b :: Word8
    }
    deriving (Eq, Show)

colorFrom :: (Word8, Word8, Word8) -> Color
colorFrom (red, green, blue) = Color red green blue

instance Read Color where
    readsPrec _ str =
        (\(red, green, blue) -> [(colorFrom (red, green, blue), "")])
            (read str :: (Word8, Word8, Word8))

distance' :: Word8 -> Word8 -> Float
distance' x y = fromIntegral ((x - y) ^ 2) :: Float

distance :: Color -> Color -> Float
distance (Color xr xg xb) (Color yr yg yb) = sqrt dist
  where
    dist = distance' yr xr + distance' yg xg + distance' yb xb
