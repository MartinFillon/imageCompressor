{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module File (openFile) where

import System.IO (readFile)

import Lib (pError)

openFile :: Maybe String -> IO (String)
openFile Nothing = pError "File not specified" >> return "a"
openFile (Just p) = readFile p
