module Main where

import MwLib
import System.Environment
import Data.List

main :: IO ()
main = do
  -- Get command-line args, input file should be only arg
  args <- getArgs

  -- load input file
  fileContents <- readFile $ head args

  -- split into lines
  let l = lines fileContents
