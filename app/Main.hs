{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import Data (Data, dumpData)
import File (openFile, parseFile)
import Options (Opt (..), defaultOpt, optParser)
import System.Exit (ExitCode (ExitFailure), exitWith)

printFileContent :: Maybe Opt -> IO ()
printFileContent (Just (Opt r (Just _) (Just _))) =
    openFile r >>= checkData . parseFile >>= dumpData
printFileContent _ = exitWith $ ExitFailure 84

checkData :: Either String [Data] -> IO ([Data])
checkData (Left _) = (exitWith $ ExitFailure 84) >> return []
checkData (Right d) = return d

-- splitIt :: [(Point, Color)] -> [Color]
-- splitIt [] = []
-- splitIt ((_, c) : xs) = c : splitIt xs

-- check :: Either String a -> IO a
-- check (Left _) = exitWith $ ExitFailure 84
-- check (Right a) = return a

-- tryRun :: Int -> Float -> [[Color]] -> [Color] -> [[Color]]
-- tryRun n k st l = calculate n l st k

-- calculate :: Int -> [Color] -> [[Color]] -> Float -> [[Color]]
-- calculate n l ra k
--     | compareMeans (traceShow (map getMean new) (map getMean new)) (traceShow (map getMean ra) (map getMean ra)) k = new
--     | otherwise = calculate n l new k
--   where
--     new = traceShow (kMeans n l (map getMean ra)) (kMeans n l (map getMean ra))

-- compareMeans :: [Color] -> [Color] -> Float -> Bool
-- compareMeans [] _ _ = True
-- compareMeans _ [] _ = True
-- compareMeans (x : xs) (y : ys) l = compareMeans xs ys l && distance x y <= l

-- generateRandArrs :: Int -> [Color] -> IO [[Color]]
-- generateRandArrs 0 _ = return []
-- generateRandArrs x l = randomRIO (0, length l - 1) >>= (\c -> ([l !! c] :) <$> generateRandArrs (x - 1) l)

-- allDiff :: Eq a => [a] -> Bool
-- allDiff [] = True
-- allDiff (x : xs) = x `notElem` xs && allDiff xs

-- generateArr :: Int -> [Color] -> IO [[Color]]
-- generateArr n x = generateRandArrs n x >>= (\c -> if allDiff c then return c else generateArr n x)

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
