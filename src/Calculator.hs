{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Calculator (getMean) where

import Colors (Color (Color))
import Data.List (genericLength)
import Data.Word (Word8)

mean :: [Int] -> Int
mean [] = 0
mean x = sum x `div` genericLength x

means :: ([Int], [Int], [Int]) -> (Int, Int, Int)
means (a, b, c) = (mean a, mean b, mean c)

getMean :: [Color] -> (Int, Int, Int)
getMean [] = (255, 255, 255)
getMean l = means $ unzip3 (map (\(Color a b c) -> (a, b, c)) l)
