{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Calculator (getMean) where

import Data.List (genericLength)

mean :: [Int] -> Int
mean [] = 0
mean x = sum x `div` genericLength x

means :: ([Int], [Int], [Int]) -> (Int, Int, Int)
means (a, b, c) = (mean a, mean b, mean c)

getMean :: [(Int, Int, Int)] -> (Int, Int, Int)
getMean [] = (255, 255, 255)
getMean l = means $ unzip3 l
