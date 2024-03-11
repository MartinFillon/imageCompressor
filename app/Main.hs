{-
-- EPITECH PROJECT, 2024
-- Wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment (getArgs)

import Calculator (getMean, kMeans)
import Colors (Color (Color), distance)
import File (openFile, parseFile)
import Options (Opt (..), defaultOpt, optParser)
import Points (Point)
import System.Exit (ExitCode (ExitFailure), exitWith)
import System.Random (randomIO)

printFileContent :: Maybe Opt -> IO ()
printFileContent (Just (Opt r (Just n) (Just c))) = do
    file <- openFile r
    arrs <- generateRandArrs n
    print (map getMean arrs)
    print $ run n c file arrs
    return ()
printFileContent _ = exitWith $ ExitFailure 84

splitIt :: [(Point, Color)] -> [Color]
splitIt [] = []
splitIt ((_, c) : xs) = c : splitIt xs

tryRun :: Int -> Float -> [[Color]] -> Either String [(Point, Color)] -> [[Color]]
tryRun _ _ _ (Left _) = []
tryRun n k st (Right l) = calculate n (splitIt l) st k

calculate :: Int -> [Color] -> [[Color]] -> Float -> [[Color]]
calculate n l ra k
    | compareMeans (map getMean new) (map getMean ra) k = new
    | otherwise = calculate n l new k
  where
    new = kMeans n l (map getMean ra)

compareMeans :: [Color] -> [Color] -> Float -> Bool
compareMeans [] _ _ = True
compareMeans _ [] _ = True
compareMeans (x : xs) (y : ys) l = compareMeans xs ys l && distance x y < l

run :: Int -> Float -> [String] -> [[Color]] -> [[Color]]
run n c x l = tryRun n c l $ parseFile x

randomColor :: IO Color
randomColor = (\c -> randomIO >>= (\g -> Color c g <$> randomIO)) =<< randomIO

generateRandArrs :: Int -> IO [[Color]]
generateRandArrs 0 = return []
generateRandArrs x = randomColor >>= (\c -> ([c] :) <$> generateRandArrs (x - 1))

main :: IO ()
main = getArgs >>= printFileContent . optParser defaultOpt
