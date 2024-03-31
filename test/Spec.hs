{-
-- EPITECH PROJECT, 2024
-- image
-- File description:
-- Spec
-}

import Test.Hspec
import CalculatorSpec

main :: IO ()
main = hspec $ do
  describe "Calculator" CalculatorSpec.spec
