{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import Lib (usage)
import Options (defaultOpt, optParser)

main :: IO ()
main = usage >> getArgs >>= print . optParser defaultOpt
