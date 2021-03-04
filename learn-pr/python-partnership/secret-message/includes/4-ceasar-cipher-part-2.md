How to figure out the *true* letter code that matches the decoded letter involves cycling around the alphabet. If your `letterCode` + `shiftAmount` value is equal to or greater than 123, you need to return to 97 to continue counting.

How do you get 123? It's just 97 (the letter code for the 'a' character) plus 26 (the number of letters in the alphabet). If you look at the ASCII number for 'z', you'll see that it's 122.

You could write conditional statements to check this value, but there's an easier way.

## Mod operator

To wrap around the alphabet the easy way, you need a special operator called `mod`, which is the percent sign (%). 

The `mod` operator divides two numbers and returns the remainder. If you run the following code in Python to set three variables by using `mod`:

```python
threeTwo = 3 % 2
elevenFour = 11 % 4 
fiveTen = 5 % 10
```

The result is:

| Variable | Formula | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------|---------|:-----:|-------|
| `threeTwo`   | 3/2 = 1 remainder 1  | 1 | |
| `elevenFour` | 11/4 = 2 remainder 3 | 3 | |
| `fiveTen`    | 5/10 = 0 remainder 5 | 5 | |

## Calculate a decoded character: The right way 

With the `mod` operator in mind, you need two new variables:
- `aAscii`: Holds the ASCII code value for the letter 'a'. We get this value by calling the `ord('a')` function and passing in the letter.
- `alphabetSize`: Holds the number of letters in the alphabet, 26.

Here's the formula to figure out the `trueLetterCode` value:

`aAscii` + (((`letterCode` - `aAscii`) + `shiftAmount`) % `alphabetSize`)

You can review this formula with a couple of examples.

### Example 1: Letter 'a' and shift by 2

Start with these two values:
- `letter` = 'a'
- `shiftAmount` = 2

| Variable | Formula | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------|---------|-------|-------|
| `letter`         |            | 'a' | |
| `shiftAmount`    |            | 2   | |
| `letterCode`     | `ord('a')` | 97  | |
| `aAscii`         | `ord('a')` | 97  | |
| `alphabetSize`   |            | 26  | |
| `trueLetterCode` | 97 + (((97 - 97) + 2) % 26)  | 2 <br>**Note:** See the detailed explanation for this calculation after the table. | |
| `decodedLetter`  | `chr(99)`  | `c` | |

You can review the formula for `trueLetterCode` just as you would any other math formula. Follow [PEMDAS](https://www.bing.com/search?q=pemdas&form=QBLH&sp=-1&pq=&sc=0-0&qs=n&sk=&cvid=AC7B1BB83E3C4E5B9C6F4AAEF3A32874), where you evaluate a mathematical expression in the order of parenthesis, exponents, multiplication, division, addition, and subtraction.

> `aAscii` + (((`letterCode` - `aAscii`) + `shiftAmount`) % `alphabetSize`)
> 
> 97 + (((97 - 97) + 2) % 26) 
> 97 + ((0 + 2) % 26)
> 97 + (2 % 26)
> 97 + 2
> 99

### Example 2: Letter 'W' and shift by 13

Start with these two values:
- `letter` = 'W'
- `shiftAmount` = 13

| Variable | Formula | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------|---------|-------|-------|
| `letter`         |            | 'W' | |
| `shiftAmount`    |            | 13  | |
| `letterCode`     | `ord('w')` | 119 | |
| `aAscii`         | `ord('a')` | 97  | |
| `alphabetSize`   |            | 26  | |
| `trueLetterCode` | 97 + (((119 - 97) + 13) % 26)  | 106 <br>**Note:** See the detailed explanation for this calculation after the table. | |
| `decodedLetter`  | `chr(106)` | `j` | |

You can review the formula for `trueLetterCode` just as you would any other math formula (remember PEMDAS):

> `aAscii` + (((`letterCode` - `aAscii`) + `shiftAmount`) % `alphabetSize`)
> 
> 97 + (((119 - 97) + 13) % 26)
> 97 + ((22 + 13) % 26)
> 97 + (35 % 26)
> 97 + 9
> 106

## Final code

Now that you have your decoder formula, you can put it all together in your function.

> [!Tip]
> Be sure to add useful comments to your code so you can remember what's happening!

```python
# Define a function to find the truth by shifting the letter by the specified amount
def lassoLetter( letter, shiftAmount ):
    # Invoke the ord function to translate the letter to its ASCII code 
    # Save the code to the letterCode variable
    letterCode = ord(letter.lower())
    
    # The ASCII number representation of lowercase letter 'a'
    aAscii = ord('a')

    # The number of letters in the alphabet
    alphabetSize = 26

    # The formula to calculate the ASCII number for the decoded letter
    # Take into account looping around the alphabet
    trueLetterCode = aAscii + (((letterCode - aAscii) + shiftAmount) % alphabetSize)

    # Convert the ASCII number to the character or letter
    decodedLetter = chr(trueLetterCode)

    # Send the decoded letter back
    return decodedLetter
```

Now that you have the `lassoLetter()` function, you can call this on each letter in the secret message.

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*
