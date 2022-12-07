module Main where

import System.Environment
import Data.List
import Data.Char

parseLine :: [String] -> Int -> [Int] -> (Int, [Int], [String])
parseLine [] currSize sizes = (currSize, currSize : sizes, [])
-- When the line is "$ cd ..", we return the current size and
-- also store the current size in the accumulated sizes
parseLine ("$ cd .." : rest) currSize sizes = (currSize, currSize : sizes, rest)
parseLine (line:rest) currSize sizes =
  if isDigit (head line) then
    -- If the line starts with a number, parse it and add
    -- it to the current size
    parseLine rest (currSize + read (head parts)) sizes
  else if "$ cd " `isPrefixOf` line then
    -- If the line is a cd, we recurse down into the next directory
    -- (see the where clause below) and then continue parsing starting
    -- with whatever lines the recursive call didn't process
    parseLine newRest (currSize + childSize) updatedSizes
  else
    -- otherwise just ignore the line
    parseLine rest currSize sizes
  where
    parts = words line
    -- This is a recursive call to drill into a subdirectory
    (childSize, updatedSizes, newRest) = parseLine rest 0 sizes

main :: IO ()
main = do
  -- Get command-line args, input file should be only arg
  args <- getArgs

  -- load input file
  fileContents <- readFile $ head args

  -- split into lines
  let l = lines fileContents

  -- parse the lines and get the root size and a list of all dir sizes
  let (rootSize, sizes, _) = parseLine l 0 []

  -- sum all the dir sizes <= 100000
  let partA = sum $ filter (<= 100000) sizes
  putStrLn $ "Part A sum: " ++ show partA

  -- find the smallest directory that is large enough
  let amountNeeded = rootSize + 30000000 - 70000000
  let partB = minimum $ filter (>= amountNeeded) sizes
  putStrLn $ "Part B value: " ++ show partB
