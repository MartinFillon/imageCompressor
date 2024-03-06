{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Calculator (appendToArr) where

import Colors (Color, distance)
import Data.List

appendAtIdx' :: a -> [[a]] -> Int -> [[a]]
appendAtIdx' _ [] _ = []
appendAtIdx' c (x : xs) 0 = (c : x) : xs
appendAtIdx' c (x : xs) i = x : appendAtIdx' c xs (i - 1)

appendAtIdx :: a -> [[a]] -> Maybe Int -> [[a]]
appendAtIdx _ y Nothing = y
appendAtIdx x y (Just i) = appendAtIdx' x y i

appendToArr :: [Color] -> Color -> [[Color]] -> [[Color]]
appendToArr means color cls =
    appendAtIdx
        color
        cls
        (elemIndex (foldl1 min m) m)
  where
    m = map (\x -> distance x color) means
