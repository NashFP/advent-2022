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

    -- split lines into groups (see src/MwLib.hs)
    let groups = splitGroups $ lines fileContents

    -- for each group, convert the lines into ints and sum them
    let counts = map (sum . map readInt) groups

    -- answer for part A is the maximum
    let best = maximum counts

    putStrLn "Day 1 A:"
    print best

    -- part b wants the top 3, so sort the list
    -- to make the sort descending, flip the order of the
    -- args to the compare function
    let sortedCounts = sortBy (flip compare) counts

    -- take the first three items in the list and sum them
    let best3 = sum $ take 3 sortedCounts

    putStrLn "Day 1 B:"
    print best3
