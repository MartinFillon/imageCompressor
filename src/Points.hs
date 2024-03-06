{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Points (Point (..), pointFrom) where

data Point = Point
    { x :: Int,
      y :: Int
    }
    deriving (Eq, Show)

pointFrom :: (Int, Int) -> Point
pointFrom (cx, cy) = Point cx cy
