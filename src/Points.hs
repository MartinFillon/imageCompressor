{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Points (Point (..)) where

data Point = Point
    { x :: Int,
      y :: Int
    }
    deriving (Eq, Show)

pointFrom :: (Int, Int) -> Point
pointFrom (cx, cy) = Point cx cy

instance Read Point where
    readsPrec _ str = (\xs -> [(pointFrom xs, "")]) (read str :: (Int, Int))
