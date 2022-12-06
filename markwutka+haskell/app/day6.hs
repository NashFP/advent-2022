module Main where

import MwLib
import System.Environment
import Data.List
import Data.Maybe

uniquePos :: Int -> String -> String -> Int -> Int
uniquePos _ [] _ _ = 0
uniquePos limit (x:xs) lastseen pos =
  if length lastseen == limit then
    pos
  else if x `elem` lastseen then
    -- Drop everything in lastseen up to and including the duplicate x
    -- and then append x to lastseen
    uniquePos limit xs ((drop ((fromJust $ elemIndex x lastseen)+1) lastseen)++[x]) (pos+1)
  else
    uniquePos limit xs (lastseen++[x]) (pos+1)

main :: IO ()
main = do
  -- Get command-line args, input file should be only arg
  args <- getArgs

  -- load input file
  fileContents <- readFile $ head args

  putStr "Part A pos: "
  print $ uniquePos 4 fileContents [] 0

  putStr "Part B pos: "
  print $ uniquePos 14 fileContents [] 0
