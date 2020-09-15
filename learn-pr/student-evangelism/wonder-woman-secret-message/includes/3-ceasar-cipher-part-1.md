Remember the secret message you're trying to decode:

![Graphic of the encoded secret message from Wonder Woman.](../media/encoded-secret-message.png)

It looks like the message might be encrypted with something called a *Caesar cipher,* where all the letters are shifted in the alphabet by some amount. Similar to Wonder Woman's golden lasso, we'll need to give Python the power to find the true meaning of the words "WHY," "oskza," "ohupo," and "ED."

If you're not familiar with Caesar ciphers, you can explore more on [Smithsonian Learning Labs](https://learninglab.si.edu/collections/decode-a-secret-message/Y4F5099N4wjRAEmz#r/).


To decipher this message, we need to start by giving our code the power to shift a single letter. First, we create a function called `lassoLetter()` that takes in two parameters. The first parameter is `letter`, and it holds the letter to decode. The second parameter is `shiftAmount`, and it says how far to shift the letter.

```python
def lassoLetter( letter, shiftAmount ):
```

Before you write this function, it's a good idea to know what you expect to happen. If you invoke this function and pass in `a` as the first parameter and `2` as the second parameter, what do you expect will be the output?

> [!Important]
> Don't actually do this yet in your code! We haven't written the function yet.

```python
lassoLetter('a', 2)
```

You would expect the function to return the letter `c`. 

## Convert a character to a number

Next, you need to convert your letter (also called a _character_, or _char_) into a number. If you recall from the code hunt challenge, when you [convert binary to letters and numbers](https://www.bing.com/search?q=binary+to+text+converter&qs=SC&pq=binary+to+text+coner&sc=8-20&cvid=4F01F15EE0D540698C86EF6B95AFD7C7&FORM=QBLH&sp=1?azure-portal=true), a binary number represents an ASCII character code (letter or number). It also represents a decimal number:

| Char | ASCII | Binary | Char | ASCII | Binary | Char | ASCII | Binary |
|:--:|--:|:--------:|:--:|--:|:--------:|:--:|---:|:--------:|
| 0 | 48 | 00110000 | A | 65 | 01000001 | a |  97 | 01100001 |	
| 1 | 49 | 00110001 | B | 66 | 01000010 | b |  98 | 01100010 |
| 2 | 50 | 00110010 | C | 67 | 01000011 | c |  99 | 01100011 |
| 3 | 51 | 00110011 | D | 68 | 01000100 | d | 100 | 01100100 |
| 4 | 52 | 00110100 | E | 69 | 01000101 | e | 101 | 01100101 |
| 5 | 53 | 00110101 | F | 70 | 01000110 | f | 102 | 01100110 |
| 6 | 54 | 00110110 | G | 71 | 01000111 | g | 103 | 01100111 |
| 7 | 55 | 00110111 | H | 72 | 01001000 | h | 104 | 01101000 |
| 8 | 56 | 00111000 | I | 73 | 01001001 | i | 105 | 01101001 |
| 9 | 57 | 00111001 | J | 74 | 01001010 | j | 106 | 01101010 |
|   |    |          | K | 75 | 01001011 | k | 107 | 01101011 |
|   |    |          | L | 76 | 01001100 | l | 108 | 01101100 |
|   |    |          | M | 77 | 01001101 | m | 109 | 01101101 |
|   |    |          | N | 78 | 01001110 | n | 110 | 01101110 |
|   |    |          | O | 79 | 01001111 | o | 111 | 01101111 |
|   |    |          | P | 80 | 01010000 | p | 112 | 01110000 |
|   |    |          | Q | 81 | 01010001 | q | 113 | 01110001 |
|   |    |          | R | 82 | 01010010 | r | 114 | 01110010 |
|   |    |          | S | 83 | 01010011 | s | 115 | 01110011 |	
|   |    |          | T | 84 | 01010100 | t | 116 | 01110100 |
|   |    |          | U | 85 | 01010101 | u | 117 | 01110101 |
|   |    |          | V | 86 | 01010110 | v | 118 | 01110110 |
|   |    |          | W | 87 | 01010111 | w | 119 | 01110111 |
|   |    |          | X | 88 | 01011000 | x | 120 | 01111000 |
|   |    |          | Y | 89 | 01011001 | y | 121 | 01111001 |
|   |    |          | Z | 90 | 01011010 | z | 122 | 01111010 |	

> [!NOTE]
> This table shows only numbers and letters, but every key on the keyboard has an ASCII character code and a binary representation of that number. 

Suppose you pass in the letter `a` and a `shiftAmount` value of `2` to the `lassoLetter()` function, and you expect it to return the letter `c`. How would you update your code to return that output? 

If you try to add `a + 2`, it doesn't make sense. How do you add a number and a letter together?

Python to the rescue! Python has a function called `ord` that converts a character to its corresponding ASCII character code.

If we call the `ord()` function and pass in the lowercase letter `a`:

```python
ord('a')
```

The output is `97`. `97` is the ASCII character code for the character `a`.


If we call the `ord()` function and pass in the uppercase letter `W`:

```python
ord('W')
```

The output is `87`. `87` is the ASCII character code for the character `W`.


If we call the `ord()` function and pass in the number `6`:

```python
ord('6')
```

The output is `54`. `54` is the ASCII character code for the number `6`.


We couldn't add a letter and number together: `a + 2`, but we can add two numbers together. If we add `97` for the letter `a` with the number `2`, we get `99`. `99` is the ASCII number representation for the character `c`. The output make sense!

Here's the next bit of code to add to your function:

1. Convert a letter to lowercase, for consistency.
1. Convert a letter to its corresponding ASCII character code by using the `ord()` function. 

```python
def lassoLetter( letter, shiftAmount ):
    letterCode = ord(letter.lower())
```

> [!Important]
> When you add the new code to your file, be sure to use the same indentation as in this example. Indent the new code from the left margin as shown. If the indentation isn't correct, Python won't read the new code as part of the function.

To decode this message, we need to shift the letter `W` by `13`. To do this shift, here are the values for our parameters:
- `letter` = 'W'
- `shiftAmount` = 13
- `letterCode` = `ord('w')` = 119

## Calculate a decoded character: The simple way

Now it's time to calculate the new character. First, review the original example. If you start with the letter `a` and want to get the letter `c`, then you do the following steps:

1. Confirm that the value passed in the `letter` parameter is lowercase. In this case, it's `a`.
1. Use the `ord()` function to convert the letter `a` to its ASCII code `97`. Save the code value `97` in the `letterCode` variable.
1. Add a `shiftAmount` value of `2` to the `letterCode` value of `97` to get the new number value: `99`. Store the value `99` in the `decodedLetterCode` variable.
1. Use the `chr()` function to _decode_ the number value `99` into a character to get `c`. (The `chr()` function simply does the opposite of the `ord()` function.) Store the decoded value `c` in the `decodedLetter` variable.
1. Return the `decodedLetter` value: `c`.

So, your code might look like this:

```python
letterCode = ord(letter.lower())

decodedLetterCode = letterCode + shiftAmount

decodedLetter = chr(decodedLetterCode)

return decodedLetter
```

Let's see what would happen if you ran this code with the first letter of the actual secret message, `W`, and the shift amount, `13`.

| Variable | Value |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|:---------|:------|-------|
| `letter` | W | |
| `shiftAmount` | 13 | |
| `letterCode` | `ord('W')` = 119 | |
| `decodedLetterCode` | 119 + 13 = 132 | |
| `decodedLetter` | chr(132) = `error` | |

The code won't return the expected result because a Caesar cipher loops back to lowercase `a` when it reaches lowercase `z`.

To take into account the loop behavior, you have to change the formula for getting the `decodedLetterCode` value. Instead of simply adding the `shiftAmount` value to `letterCode`, you have to figure out what the *true* letter code is for the decoded letter.

We'll take a look at that formula in the next unit.

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*
