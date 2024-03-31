{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- ColorSpec
-}

module ColorSpec (spec) where

import Test.Hspec

import Colors

spec :: Spec
spec = do
    describe "distance" $ do
        context "when provided 2 colors" $ do
            it "returns the distance" $ do
                let color1 = (100, 150, 200)
                let color2 = (120, 160, 220)
                let expectedDistance = 30.0
                distance color1 color2 `shouldBe` expectedDistance

            it "returns 0 when provided 2 identical colors" $ do
                let color = (100, 150, 200)
                distance color color `shouldBe` 0.0
