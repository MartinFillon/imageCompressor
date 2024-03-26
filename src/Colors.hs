{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Colors (distance) where

distance' :: Int -> Int -> Float
distance' x y = fromIntegral ((x - y) ^ (2 :: Int)) :: Float

distance :: (Int, Int, Int) -> (Int, Int, Int) -> Float
distance (xr, xg, xb) (yr, yg, yb) = sqrt dist
  where
    dist = distance' yr xr + distance' yg xg + distance' yb xb
