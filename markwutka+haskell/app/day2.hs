module Main where

import MwLib
import System.Environment
import Data.List
import Data.Maybe

-- Compute the score for regular rock-paper-scissors
rpsScore :: Int -> Int -> Int
rpsScore 1 1 = 4  -- Rock-Rock = 3 + 1
rpsScore 1 2 = 8  -- Rock-Paper = 6 + 2
rpsScore 1 3 = 3  -- Rock-Scissors = 0 + 3
rpsScore 2 1 = 1  -- Paper-Rock = 0 + 1
rpsScore 2 2 = 5  -- Paper-Paper = 3 + 2
rpsScore 2 3 = 9  -- Paper-Scissors = 6 + 3
rpsScore 3 1 = 7  -- Scissors-Rock = 6 + 1
rpsScore 3 2 = 2  -- Scissors-Paper = 0 + 2
rpsScore 3 3 = 6  -- Scissors-Scissors = 3 + 3

-- Compute the score for trying to lose-win-tie
rpsBScore :: Int -> Int -> Int
rpsBScore 1 1 = 3 -- Rock-Lose = 0 + 3 (Scissors)
rpsBScore 1 2 = 4 -- Rock-Tie = 3 + 1 (Rock)
rpsBScore 1 3 = 8 -- Rock-Win = 6 + 2 (Paper)
rpsBScore 2 1 = 1 -- Paper-Lose = 0 + 1 (Rock)
rpsBScore 2 2 = 5 -- Paper-Tie = 3 + 2 (Paper)
rpsBScore 2 3 = 9 -- Paper-Win = 6 + 3 (Scissors)
rpsBScore 3 1 = 2 -- Scissors-Lose = 0 + 2 (Paper)
rpsBScore 3 2 = 6 -- Scissors-Tie = 3 + 3 (Scissors)
rpsBScore 3 3 = 7 -- Scissors-Win = 6 + 1 (Rock)

-- Maps a character to the index of that character + 1 in a mapping string
charToRPS :: [Char] -> Char -> Int
charToRPS chs ch = 1 + (fromJust $ elemIndex ch chs)

-- Compute the score for a line using a scoring func and mappings
scoreLine :: (Int->Int->Int) -> [Char] -> [Char] -> String -> Int
scoreLine scoreFunc leftMap rightMap l =
  -- call the scoring func with the two values
  scoreFunc leftVal rightVal
  where
    -- the left val is the first char in the string
    leftVal = charToRPS leftMap $ head l
    -- the right val is the third char in the string
    rightVal = charToRPS rightMap $ l !! 2
        
main :: IO ()
main = do
  -- Get command-line args, input file should be only arg
  args <- getArgs

  -- load input file
  fileContents <- readFile $ head args

  -- split the input file into a list of lines
  let l = lines fileContents

  -- compute the score for the A part
  let ascore = sum $ map (scoreLine rpsScore "ABC" "XYZ") l

  putStr "Part A Score: "
  print ascore

  -- compute the score for the B part
  let bscore = sum $ map (scoreLine rpsBScore "ABC" "XYZ") l

  putStr "Part B Score: "
  print bscore
