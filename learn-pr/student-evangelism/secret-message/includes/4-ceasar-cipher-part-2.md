How to figure out the *true* letter code that matches the decoded letter involves cycling around the alphabet. If your `letter_code` + `shift_amount` value is equal to or greater than 123, you need to return to 97 to continue counting.

How do you get 123? It's just 97 (the letter code for the 'a' character) plus 26 (the number of letters in the alphabet). If you look at the ASCII number for 'z', you'll see that it's 122.

You could write conditional statements to check this value, but there's an easier way.

## Mod operator

To wrap around the alphabet the easy way, you need a special operator called `mod`, which is the percent sign (%). 

The `mod` operator divides two numbers and returns the remainder. If you run the following code in Python to set three variables by using `mod`:

```python
three_two = 3 % 2
eleven_four = 11 % 4 
five_ten = 5 % 10

print(three_two)
print(eleven_four)
print(five_ten)
```

The result is:

| Variable | Formula | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------|---------|:-----:|-------|
| `three_two`   | 3/2 = 1 remainder 1  | 1 | |
| `eleven_four` | 11/4 = 2 remainder 3 | 3 | |
| `five_ten`    | 5/10 = 0 remainder 5 | 5 | |

## Calculate a decoded character: The right way 

With the `mod` operator in mind, you need two new variables:

- `a_ascii`: Holds the ASCII code value for the letter 'a'. We get this value by calling the `ord('a')` function and passing in the letter.
- `alphabet_size`: Holds the number of letters in the alphabet, 26.

Here's the formula to figure out the `true_letter_code` value:

`a_ascii` + (((`letter_code` - `a_ascii`) + `shift_amount`) % `alphabet_size`)

You can review this formula with a couple of examples.

### Example 1: Letter 'a' and shift by 2

Start with these two values:
- `letter` = 'a'
- `shift_amount` = 2

| Variable | Formula | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------|---------|-------|-------|
| `letter`         |            | 'a' | |
| `shift_amount`    |            | 2   | |
| `letter_code`     | `ord('a')` | 97  | |
| `a_ascii`         | `ord('a')` | 97  | |
| `alphabet_size`   |            | 26  | |
| `true_letter_code` | 97 + (((97 - 97) + 2) % 26)  | 2 <br>**Note:** See the detailed explanation for this calculation after the table. | |
| `decoded_letter`  | `chr(99)`  | `c` | |

You can review the formula for `true_letter_code` just as you would any other math formula. Follow [PEMDAS](https://www.bing.com/search?q=pemdas&form=QBLH&sp=-1&pq=&sc=0-0&qs=n&sk=&cvid=AC7B1BB83E3C4E5B9C6F4AAEF3A32874), where you evaluate a mathematical expression in the order of parenthesis, exponents, multiplication, division, addition, and subtraction.

> `a_ascii` + (((`letter_code` - `a_ascii`) + `shift_amount`) % `alphabet_size`)
> 
> 97 + (((97 - 97) + 2) % 26)  
> 97 + ((0 + 2) % 26)  
> 97 + (2 % 26)  
> 97 + 2  
> 99  

### Example 2: Letter 'N' and shift by 13

Start with these two values:

- `letter` = 'N'
- `shift_amount` = 13

| Variable | Formula | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------|---------|-------|-------|
| `letter`         |            | 'N' | |
| `shift_amount`    |            | 13  | |
| `letter_code`     | `ord('n')` | 110 | |
| `a_ascii`         | `ord('a')` | 97  | |
| `alphabet_size`   |            | 26  | |
| `true_letter_code` | 97 + (((110 - 97) + 13) % 26)  | 97 <br>**Note:** See the detailed explanation for this calculation after the table. | |
| `decoded_letter`  | `chr(97)` | `a` | |

You can review the formula for `true_letter_code` just as you would any other math formula (remember PEMDAS):

> `a_ascii` + (((`letter_code` - `a_ascii`) + `shift_amount`) % `alphabet_size`)
> 
> 97 + (((110 - 97) + 13) % 26)  
> 97 + ((13 + 13) % 26)  
> 97 + (26 % 26)  
> 97 + 0  
> 97  

## Final code

Now that you have your decoder formula, you can put it all together in your function.

> [!Tip]
> Be sure to add useful comments to your code so you can remember what's happening!

```python
# Define a function to find the truth by shifting the letter by the specified amount
def lasso_letter( letter, shift_amount ):
    # Invoke the ord function to translate the letter to its ASCII code 
    # Save the code to the letter_code variable
    letter_code = ord(letter.lower())
    
    # The ASCII number representation of lowercase letter 'a'
    a_ascii = ord('a')

    # The number of letters in the alphabet
    alphabet_size = 26

    # The formula to calculate the ASCII number for the decoded letter
    # Take into account looping around the alphabet
    true_letter_code = a_ascii + (((letter_code - a_ascii) + shift_amount) % alphabet_size)

    # Convert the ASCII number to the character or letter
    decoded_letter = chr(true_letter_code)

    # Send the decoded letter back
    return decoded_letter
```

Now that you have the `lasso_letter()` function, you can call the function on each letter in the secret message.

You'll use this function in the next unit, but you can try it out now by calling the `lasso_letter()` function within a `print()` function, like this:

```python
print(lasso_letter('a', 2))
```

What output do you see in the terminal?
