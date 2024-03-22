{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Colors (Color (..), colorFrom, distance, printColor) where

import Data.Word (Word8)

data Color = Color
    { r :: Int,
      g :: Int,
      b :: Int
    }
    deriving (Eq, Show)

colorFrom :: (Int, Int, Int) -> Color
colorFrom (red, green, blue) = Color red green blue

printColor :: Color -> IO ()
printColor (Color 255 255 255) = return ()
printColor (Color r g b) =
    putStrLn $
        "("
            ++ show r
            ++ ", "
            ++ show g
            ++ ", "
            ++ show b
            ++ ")"

-- instance Read Color where
--     readsPrec _ str =
--         (\(red, green, blue) -> [(colorFrom (red, green, blue), "")])
--             (read str :: (Word8, Word8, Word8))

distance' :: Int -> Int -> Float
distance' x y = fromIntegral ((x - y) ^ 2) :: Float

distance :: (Int, Int, Int) -> (Int, Int, Int) -> Float
distance (xr, xg, xb) (yr, yg, yb) = sqrt dist
  where
    dist = distance' yr xr + distance' yg xg + distance' yb xb
