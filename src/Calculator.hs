{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Calculator (appendToArr, kMeans, generateArrs) where

import Colors (Color (Color), distance)
import Data.List
import Data.Word (Word8)

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

generateArrs :: Int -> [[Color]]
generateArrs 0 = []
generateArrs x = [] : generateArrs (x - 1)

kMeans :: [Color] -> Int -> Float -> [Color] -> [[Color]]
kMeans [] n _ _ = generateArrs n
kMeans (x : xs) n l cls = appendToArr cls x (kMeans xs n l cls)
