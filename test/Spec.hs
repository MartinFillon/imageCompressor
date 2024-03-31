{-
-- EPITECH PROJECT, 2024
-- image
-- File description:
-- Spec
-}

import Test.Hspec

import CalculatorSpec
import ClusterSpec
import ColorSpec
import PointsSpec

main :: IO ()
main = hspec $ do
    describe "Calculator" CalculatorSpec.spec
    describe "Cluster" ClusterSpec.spec
    describe "Color" ColorSpec.spec
    describe "Points" PointsSpec.spec