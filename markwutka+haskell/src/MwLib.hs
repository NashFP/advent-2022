module MwLib where

import Data.List

-- Takes a list of strings and splits them into groups
-- delimited by blank lines
-- It does this by doing a right-fold over the lines
-- so for each line in the list, starting at the rightmost, 
-- it calls the grouper function with that line and the
-- current accumulator, which is a part of lists where the
-- first list is the current group being accumulated
-- and the second list is the list of groups that have
-- been accumulated so far
splitGroups :: [String] -> [[String]]
splitGroups ls =
    -- uncurry (:) is shorthand for (fst groups) : (snd groups)
    uncurry (:) groups
    where   
        -- apply grouper to each item in ls and accumulate a result
        groups = foldr grouper ([],[]) ls
        grouper line (acc,lsAcc) =
            -- if the current line is blank, add the current group (acc) to
            -- the list of groups (lsAcc)
            if line == "" then
                ([], acc:lsAcc)
            else
                -- if the current line isn't blank, add it to the current group (acc)
                (line:acc,lsAcc)

-- I find it easier to define a readInt rather than trying
-- to use type annotations when Haskell can't figure out
-- that I want to read an int.
readInt :: String -> Int
readInt = read
