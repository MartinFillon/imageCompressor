{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Opts
-}

module Options (
    optParser,
    defaultOpt,
    Opt (..),
) where

import Text.Read

data Opt = Opt
    { path :: Maybe String,
      colors :: Maybe Int,
      limit :: Maybe Float
    }

instance Show Opt where
    show (Opt p c l) = show p ++ " " ++ show c ++ " " ++ show l

defaultOpt :: Opt
defaultOpt = Opt Nothing Nothing Nothing

optParser :: Opt -> [String] -> Maybe Opt
optParser o [] = Just o
optParser o ("-l" : x : xs) = optParser (o {limit = readMaybe x}) xs
optParser o ("-n" : x : xs) = optParser (o {colors = readMaybe x}) xs
optParser o ("-f" : x : xs) = optParser (o {path = Just x}) xs
optParser _ _ = Nothing
