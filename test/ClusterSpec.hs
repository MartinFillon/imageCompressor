{-
-- EPITECH PROJECT, 2024
-- imageCompressor
-- File description:
-- ClusterSpec
-}

module ClusterSpec (spec) where

import Test.Hspec

import Clusters
import ImageData

data ImageData = ImageData { color :: (Int, Int, Int), centroid :: Int }

spec :: Spec
spec = do
    describe "computeClusterMeans" $ do
        let testData = [imageDataFrom (100, 100, 100) (1, 1), imageDataFrom (200, 200, 200) (1, 2), imageDataFrom (50, 50, 50) (2, 3)]
        let testMeans = [(100, 100, 100), (50, 50, 50)]

        context "when provided empty list of means" $ do
            it "returns an empty list" $
                computeClusterMeans 0 [] testData `shouldBe` []

        context "when provided data and means" $ do
            it "computes the means for each cluster correctly" $
                computeClusterMeans 0 testMeans testData `shouldBe` [(116, 116, 116), (50, 50, 50)]

    describe "checkConvergence" $ do
        let testTuples = [((100, 100, 100), (110, 110, 110)), ((200, 200, 200), (210, 210, 210))]

        context "when provided conv and list of tuples" $ do
            it "returns True if all distances are within limit" $
                checkConvergence 20 testTuples `shouldBe` True

            it "returns False if any distance is greater than the limit" $
                checkConvergence 5 testTuples `shouldBe` False
