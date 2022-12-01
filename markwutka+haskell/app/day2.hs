module Main where

import qualified MwLib (splitGroups)
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    fileContents <- readFile $ head args
    let groups = MwLib.splitGroups $ lines fileContents
    putStrLn $ show $ groups

