## Advent of Code 2022, day 21 ##

### Solution method ###

From puzzle input, generate a model for [MiniZinc](https://www.minizinc.org) using *`awk`*, then run it with a solver that supports floats.


**For part 1**, each line of input translates to the description of decision variable in MiniZinc model.
For instance,
```
rzwt: fdqz + hpqd
```
translates to:
```
var float: rzwt = fdqz + hpqd;
```
The 
```code
output[show(floor(fix(root)))];
``` 
line is added to show the answer.


**For part 2**, it's the same as part 1, except for:
- for *humn*, we drop the value;
- *root* line is translated to *constraint* line, like so:
    ```
    root: zhfp + hghd
    ```
    to:
    ```
    constraint  zhfp = hghd;
    ```
- For model output, use 
    ```
    output[show(floor(fix(humn)))];
    ``` 
### How to run ###


Install MiniZinc (https://www.minizinc.org/software.html) 

./part1.sh <data_file>

./part2.sh <data_file>

