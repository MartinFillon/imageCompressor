{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Calculator (appendToArr, getMean) where

import Colors (Color (Color), colorFrom, distance)
import Data.List (elemIndex, genericLength)
import Data.Word (Word8)
import Debug.Trace

appendAtIdx' :: a -> [[a]] -> Int -> [[a]]
appendAtIdx' _ [] _ = []
appendAtIdx' c (x : xs) 0 = (c : x) : xs
appendAtIdx' c (x : xs) i = x : appendAtIdx' c xs (i - 1)

appendAtIdx :: a -> [[a]] -> Maybe Int -> [[a]]
appendAtIdx _ y Nothing = y
appendAtIdx x y (Just i) = appendAtIdx' x y i

appendToArr :: [Color] -> Color -> [[Color]] -> [[Color]]
appendToArr meansl color cls =
    appendAtIdx
        color
        cls
        (elemIndex (foldl1 min m) m)
  where
    m = map (`distance` color) meansl

kMeans :: Int -> [Color] -> [Color] -> [[Color]]
kMeans _ [] x = map (: []) x
kMeans n (x : xs) cls = appendToArr cls x (kMeans n xs cls)

mean :: [Word8] -> Word8
mean [] = 0
mean x = sum x `div` traceShow (genericLength x) (genericLength x)

means :: ([Word8], [Word8], [Word8]) -> (Word8, Word8, Word8)
means (a, b, c) = (mean a, mean b, mean c)

getMean :: [Color] -> Color
getMean [] = Color 255 255 255
getMean l = colorFrom $ means $ unzip3 (map (\(Color a b c) -> (a, b, c)) l)
