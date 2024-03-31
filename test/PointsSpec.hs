{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- PointsSpec
-}

module PointsSpec (spec) where

import Test.Hspec

import Points

spec :: Spec
spec = do
    describe "pointFrom" $ do
        context "when provided a tuple" $ do
            it "creates a Point with given coordinates" $ do
                let input = (3, 5)
                let expectedPoint = Point { x = 3, y = 5 }
                pointFrom input `shouldBe` expectedPoint

        context "when provided negative" $ do
            it "creates a Point with given negative coordinates" $ do
                let input = (-2, -4)
                let expectedPoint = Point { x = -2, y = -4 }
                pointFrom input `shouldBe` expectedPoint
