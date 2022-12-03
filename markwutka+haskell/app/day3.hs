module Main where

import System.Environment
import Data.List
import Data.Char

-- Computes the priority for a char
priority :: Char -> Int
priority ch =
  if (ch >= 'a') && (ch <= 'z') then
    ord ch - 96
  else if (ch >= 'A') && (ch <= 'Z') then
    26 + ord ch - 64
  else
    0

-- Sum the common priorities between two halves of a line
linePriorities :: String -> Int
linePriorities l =
  sum $ map priority common
  where
    splitPoint = (length l) `div` 2
    left = nub $ take splitPoint l
    right = nub $ drop splitPoint l
    common = left `intersect` right

elfBadges :: [String] -> Int -> Int
elfBadges [] acc = acc
elfBadges (a:b:c:rest) acc =
  elfBadges rest (acc+score)
  where
    score = sum $ map priority common
    common = ((nub a) `intersect` (nub b)) `intersect` (nub c)

main :: IO ()
main = do
    -- Get command-line args, input file should be only arg
    args <- getArgs

    -- load input file
    fileContents <- readFile $ head args

    let l = lines fileContents

    let partA = sum $ map linePriorities l

    putStr "Part A result = "
    print partA

    let partB = elfBadges l 0
    putStr "Part B result = "
    print partB

