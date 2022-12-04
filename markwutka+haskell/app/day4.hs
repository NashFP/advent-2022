module Main where

import MwLib
import System.Environment
import Data.List
import Data.List.Split

getPairs :: String -> ((Int,Int),(Int,Int))
getPairs line =
  ((lf,lt),(rf,rt)) 
  where
    [l,r] = splitOn "," line
    [lfs,lts] = splitOn "-" l
    [rfs,rts] = splitOn "-" r
    lf = read lfs
    lt = read lts
    rf = read rfs
    rt = read rts

contained :: ((Int,Int),(Int,Int)) -> Bool
contained ((lf,lt),(rf,rt)) =
  ((lf <= rf) && (lt >= rt)) ||
  ((rf <= lf) && (rt >= lt))

overlaps :: ((Int,Int),(Int,Int)) -> Bool
overlaps ((lf,lt),(rf,rt)) =
  ((lf >= rf) && (lf <= rt)) ||
  ((lt >= rf) && (lt <= rt)) ||
  ((rf >= lf) && (rf <= lt)) ||
  ((rt >= lf) && (rt <= lt))

main :: IO ()
main = do
  -- Get command-line args, input file should be only arg
  args <- getArgs

  -- load input file
  fileContents <- readFile $ head args

  let l = lines fileContents

  let countA = length $ filter contained $ map getPairs l

  putStr "Part A count: "
  print countA

  let countB = length $ filter overlaps $ map getPairs l

  putStr "Part B count: "
  print countB

