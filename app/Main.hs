{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import Options (Opt (..), defaultOpt, optParser)

import File (openFile)

printFileContent :: Maybe Opt -> IO ()
printFileContent Nothing = return ()
printFileContent (Just (Opt r _ _)) = openFile r >>= putStr

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
