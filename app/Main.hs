{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import Utils
import Parsing

import System.Environment

main :: IO ()
main = do
    args <- getArgs
    parseArgs args
