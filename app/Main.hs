{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import File (openFile, parseFile)
import ImageData (ImageData, dumpImageData)
import Options (Opt (..), defaultOpt, optParser)
import System.Exit (ExitCode (ExitFailure), exitWith)

printFileContent :: Maybe Opt -> IO ()
printFileContent (Just (Opt r (Just _) (Just _))) =
    openFile r >>= checkImageData . parseFile >>= dumpImageData
printFileContent _ = exitWith $ ExitFailure 84

checkImageData :: Either String [ImageData] -> IO ([ImageData])
checkImageData (Left _) = (exitWith $ ExitFailure 84) >> return []
checkImageData (Right d) = return d

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
