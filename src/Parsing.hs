{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- Parsing
-}

module Parsing where

import Utils

findValue :: String -> Maybe Vector
findValue input = parseVector input

parseVector :: String -> Maybe Vector
parseVector str = case reads str of
  [(triple, "")] -> Just triple
  _ -> Nothing

initDistance :: Vector -> Vector -> IO ()
initDistance p1 p2 = print $ euclideanDistance p1 p2

parseArgs :: [String] -> IO ()
parseArgs [] = pError "No arguments provided."
parseArgs (_:[]) = pError "Invalid arguments, provide two vectors."
parseArgs (a:b:_) = case (findValue a, findValue b) of
  (Just v1, Just v2) -> initDistance v1 v2
  _ -> pError "Invalid vector, use (x, y, z)."
