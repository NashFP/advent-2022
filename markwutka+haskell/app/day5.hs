module Main where

import MwLib
import System.Environment
import Data.List
import Debug.Trace

-- get all the items in the stack at a particular column
-- and reverse them so the top of the stack is first
getStack :: [String] -> Int -> [Char]
getStack l n =
  reverse $ takeWhile (' ' /=) $ map (!! n) l
  
-- parse a move into a triplet of ints containint (amount, from, to)
parseMove :: String -> (Int,Int,Int)
parseMove ln =
  (read $ parts !! 1, (read $ parts !! 3) - 1, (read $ parts !! 5) - 1)
  where
    parts = words ln

-- apply a single move A operation (i.e. pop 1 then push 1)
applyOneMoveA :: Int -> Int -> [[Char]] -> Int -> [[Char]]
applyOneMoveA from to stacks _ =
  zipWith replaceItem stacks [0..]
  where
    fromChar = head $ stacks !! from
    replaceItem s i =
      if i == from then
        tail s
      else if i == to then
        fromChar : s
      else
        s

-- apply a move A operation to the stacks by doing amount
-- applyOneMoveA operations
applyMoveA :: [[Char]] -> (Int,Int,Int) -> [[Char]]
applyMoveA stacks (amount, from, to) =
  foldl' (applyOneMoveA from to) stacks [1..amount]

-- apply a move B operation
applyMoveB :: [[Char]] -> (Int,Int,Int) -> [[Char]]
applyMoveB stacks (amount, from, to) =
  zipWith replaceItem stacks [0..]
  where
    fromChars = take amount $ stacks !! from
    replaceItem s i =
      if i == from then
        drop amount s
      else if i == to then
        fromChars ++ s
      else
        s

main :: IO ()
main = do
  -- Get command-line args, input file should be only arg
  args <- getArgs

  -- load input file
  fileContents <- readFile $ head args

  -- split into lines
  let l = lines fileContents

  let initialStacks = reverse $ takeWhile (\ln -> head ln == '[') l
  let moves = map parseMove $ drop 2 $ drop (length initialStacks) l

  -- this is kinda cheap, but I'm hard-coding the columns
  -- in the data file because I don't feel like writing smart parser
  let stackPositions = [1, 5, 9, 13, 17, 21, 25, 29, 33]
  
  let stacks = map (getStack initialStacks) stackPositions

  let resultA = foldl' applyMoveA stacks moves
  putStr "Result A: "
  putStrLn $ map head resultA

  let resultB = foldl' applyMoveB stacks moves
  putStr "Result B: "
  putStrLn $ map head resultB


