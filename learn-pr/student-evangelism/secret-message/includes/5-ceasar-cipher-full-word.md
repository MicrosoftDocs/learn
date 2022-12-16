Now that you know how to decode one letter given a certain shift amount, you can decode entire words and phrases!

To decipher a complete word, you need to invoke the `lasso_letter()` function for each letter in the word. Then you put all of the decoded letters together into a decoded word. 

This time, you'll write a function called `lasso_word()` that has two parameters: `word` and `shift_amount`.

```python
def lasso_word( word, shift_amount ):
```

## Words as collections of letters

One way to think about words is that they're just collections of letters. For example, you can think of the word "Hello" as:

> 'H' - 'e' - 'l' - 'l' - 'o'

A variable can be a name for one piece of data: one word, one letter, one formula, one function, and so on. Python has many ways to represent collections of data. One way is with a *list*.

A list is exactly what it sounds like. A word can be considered a list of letters. Even better: Python has a way to loop through each item in a list one at a time. 

## List iteration with a for loop

Because you want to invoke the `lasso_letter()` function on each letter, you need to loop through each letter in the word that you're trying to decode. 

Here's the syntax for a `for` loop:

```python
for item in list:
    do something
```

The word that's passed in as a parameter can be considered a list of letters. So, you can write:

```python
def lasso_word( word, shift_amount ):

    for letter in word:
```

Now that you understand this Python functionality, you can do something to _each letter_ in a word, like invoking the `lasso_letter()` function.

## Invoke the lasso_letter() function

It's fairly straightforward to invoke the `lasso_letter()` function on each letter in a word:

```python
def lasso_word( word, shift_amount ):

    for letter in word:
        lasso_letter( letter, shift_amount )
```

Remember that when you wrote the `lasso_letter()` function, the last line of code in the function was the following:

```python
# Send the decoded letter back
return decoded_letter
```

This code is called a *return statement*. This statement sends back the value to the line that invoked the function. To capture that return value, all you have to do is use a variable:

```python
def lasso_word( word, shift_amount ):

    for letter in word:
        decoded_letter = lasso_letter(letter, shift_amount)
```

Now you're invoking a function that you wrote, `lasso_letter()`, from a new function that you're writing now: `lasso_word()`.

## String letters together

With the code that you just wrote, you'll have one value in the `decoded_letter` variable. When the loop runs again, the variable gets updated.

You can trace the code to see how this works:

- `word` = "gdkkn"  
- `shift_amount` = 1

| Loop<br>iteration | Value of <br>`letter` | Value of <br>`decoded_letter` |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|---------------|--------|---------------|-------------|
| 1 | 'g' | 'h' | |
| 2 | 'd' | 'e' | |
| 3 | 'k' | 'l' | |
| 4 | 'k' | 'l' | |
| 5 | 'n' | 'o' | |

You're left with a variable named `decoded_letter` that has a value of just the letter 'o'. But, what you wanted was a variable named `decoded_word` to have the value `hello`. Recall from the Python basics that we reviewed earlier in this module, you can use the plus sign (`+`) between two words or letters to combine them.

```python
def lasso_word( word, shift_amount ):

    decoded_word = ""
    
    for letter in word:
        decoded_letter = lasso_letter(letter, shift_amount)
        decoded_word = decoded_word + decoded_letter

    return decoded_word
```

With this code, the entire word is now stored in the variable `decoded_word`. You can send back this value to the line where this function was invoked. You can trace the code like before:

| Loop<br>iteration | Value of <br>`letter` | Value of <br>`decoded_letter` | Value of <br>`decoded_word` |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|----------------|----------|-----------------|---------------|---------------|
| 1 | 'g' | 'h' | "h" | |
| 2 | 'd' | 'e' | "he" | |
| 3 | 'k' | 'l' | "hel" | |
| 4 | 'k' | 'l' | "hell" | |
| 5 | 'n' | 'o' | "hello" | |

### Comment your code

Don't forget to add comments to your code, so you know exactly what's happening! (If you return to this exercise later on, you don't want to have to decipher your own code.)

```python
# Define a function to find the truth in a secret message
# Shift the letters in a word by a specified amount to discover the hidden word
def lasso_word( word, shift_amount ):

    # This variable is updated each time another letter is decoded
    decoded_word = ""

    # This for loop iterates through each letter in the word parameter
    for letter in word:
        # The lasso_letter() function is invoked with each letter and the shift amount
        # The result (the decoded letter) is stored in a variable called decoded_letter
        decoded_letter = lasso_letter(letter, shift_amount)

        # The decoded_letter value is added to the end of the decoded_word value
        decoded_word = decoded_word + decoded_letter

    # The decoded_word is sent back to the line of code that invoked this function
    return decoded_word
```

> [!Important]
> Be sure to use the same indentation as in this example. Indent the new code from the left margin as shown.

## Test your functions

Press the green **Run** button, and . . . nothing should happen. You've written your two functions, and the `lasso_word()` function does invoke the `lasso_letter()` function. But nothing invokes the `lasso_word()` function yet! 

Test your new code by invoking the `lasso_word()` function with `terra` as the value for the `word` parameter and `13` as the value for the `shift_amount` parameter. 

```python
# Try to decode the word "terra"
print( "Shifting terra by 13 gives: \n" + lasso_word( "terra", 13 ) )
```

Now when you select the **Run** button, you should see the word **green** printed on the console:

![Screenshot of a test of calls to the lasso functions.](../media/test-lasso-function.png)

## Review the complete file

Now that you've written two lasso functions, your complete <b>decrypt.py</b> file should look like this:

```python
# Define a function to find the truth by shifting the letter by a specified amount
def lasso_letter( letter, shift_amount ):
    # Invoke the ord function to translate the letter to its ASCII code 
    # Save the code value to the variable called letter_code
    letter_code = ord(letter.lower())
    
    # The ASCII number representation of lowercase letter a
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

# Define a function to find the truth in a secret message
# Shift the letters in a word by a specified amount to discover the hidden word
def lasso_word( word, shift_amount ):

    # This variable is updated each time another letter is decoded
    decoded_word = ""

    # This for loop iterates through each letter in the word parameter
    for letter in word:
        # The lasso_letter() function is invoked with each letter and the shift amount
        # The result (the decoded letter) is stored in a variable called decoded_letter
        decoded_letter = lasso_letter(letter, shift_amount)

        # The decoded_letter value is added to the end of the decoded_word value
        decoded_word = decoded_word + decoded_letter

    # The decoded_word is sent back to the line of code that invoked this function
    return decoded_word

# Try to decode the word "terra"
print( "Shifting terra by 13 gives: \n" + lasso_word( "terra", 13 ) )
```

Now you're ready to decode the secret message!
