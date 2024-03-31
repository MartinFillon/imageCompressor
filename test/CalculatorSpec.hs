{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- CalculatorSpec
-}

module CalculatorSpec (spec) where

import Test.Hspec
import Calculator

spec :: Spec
spec = do
  describe "getMean" $ do
    context "when provided an empty list" $ do
      it "returns (255, 255, 255)" $
        getMean [] `shouldBe` (255, 255, 255)

    context "when provided a list of tuples" $ do
      it "returns the mean of each component" $ do
        getMean [(10, 20, 30), (20, 30, 40), (30, 40, 50)] `shouldBe` (20, 30, 40)

    context "when provided a list with one tuple" $ do
      it "returns the single tuple" $ do
        getMean [(100, 200, 300)] `shouldBe` (100, 200, 300)
