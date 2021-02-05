A **helper method** is a function that's available to values of a particular data type (or object), and provides additional helpful functionality.  The string data type has many helper methods, and in this exercise we'll work with over a dozen that you'll likely use when building real-world Python programs.

### Step 1 - Create a new code file for this exercise

Use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module. For example, you might create a new file named `exercise2.py`.

### Step 2 - Add code to call the `capitalize()` function by using three different techniques

Add the code in the following listing to the new file:

```python
message = str.capitalize('first message')
print(message)

message = 'second message'.capitalize()
print(message)

message = 'third message'
print(message.capitalize())
```

The `capitalize()` function ensures that the first character in a string is capitalized (uppercase). Only the first letter in the string is capitalized. If the string contains multiple words separated by empty characters, only the first character is capitalized.

While the `capitalize()` function is useful, pay attention to the three different ways in which we call it.

The first time we call it as a member of the `str` class. In other words, we access the `str` helper method by using the member access operator, a period symbol (`.`), on the name of the data type itself. Then, we call the function name, passing in our literal string as an argument.

The second time we call the function as a member of the literal string. In other words, we access the `str` helper method by using the member access operator on the literal string value itself. When we do this, we don't need to pass anything as an argument. The function operates on the literal string itself.

The third time we call the function as a member of a variable. Like the previous example, we access the `str` helper method by using the member access operator on the variable that points to a literal string. Again, we don't need to pass anything as an argument, because the function operates on the string our variable points to.

There are multiple ways to call these helper methods, and you'll likely use the one that makes the most sense in a particular context.

For the remainder of this exercise, we'll usually use the third example. However, the important takeaway is to understand there are different ways to achieve the same result when you're writing code. Even if we do not demonstrate it here, you can use one of several different styles when you're calling these methods.

When you run the code, you should see the following output:

```output
First message
Second message
Third message
```

### Step 3 - Comment out the previous code, and add code to call functions that modify the case of the string

Similar to the `capitalize()` function, there are functions that change the case from upper to lower, or lower to upper.  

Comment out the code from the previous step, and add the following code listing:

```python
message = 'hello world'
print(message.lower())
print(message.upper())

message = message.title()
print(message)
print(message.swapcase())
```
When you run the code, you should see the following output:

```output
hello world
HELLO WORLD
Hello World
hELLO wORLD
```

### Step 4 - Comment out the previous code, and add code that counts the number of times one string is found in another

The `count()` method provides a count of the number of times a specified character is used in a string.

Comment out the code from the previous step, and add the following code listing:

```python
location = 'Mississippi'
print(location.count('s'))
```
When you run the code, you should see the following output:

```output
4
```

What if you want to know how many letters are in a string? In that case, use a method, called `len()`. Note that this isn't a helper method in the way we've defined it, because it works on more than just the string values.

Comment out the code from earlier in this step, and add the following code listing:

```python
print(len('how many letters in this string?'))
```
When you run the code, you should see the following output:

```output
32
```

### Step 5 - Comment out the previous code, and add code that calls functions that inspect the contents of the string

Call the `startswith()` and `endswith()` functions to inspect the contents of a string to find out if it matches what you expected it to start with or end with, respectively.

Comment out the code from the previous step, and add the following code listing:

```python
message = 'racecar'
print(message.startswith('r'))
print(message.startswith('a'))
print(message.startswith('ra'))

print(message.endswith('r'))
print(message.endswith('a'))
print(message.endswith('ar'))
```

When you run the code, you should see the following output:

```output
True
False
True
True
False
True
```

### Step 6 - Comment out the previous code, and add code that finds the position of a string inside another string

The `find()` method locates the zero-based position of one string inside another string. In other words, starting with the number `0`, the method tells you where the search string is located. If it can't find the string, it returns `-1`.

You can use the `find()` function to split a string at a specific place, to perform additional modifications to the string. In an upcoming module, you'll learn a technique called *slicing* that can use the character position to retrieve some portion of a longer string.

Comment out the code from the previous step, and add the following code listing:

```python
message = 'The quick brown fox jumps over the lazy dog'
print(message.find('q'))

print(message.find('t'))
print(message.find('T'))
```

When you run the code, you should see the following output:

```output
4
31
0
```
Notice that the `find()` method is case-sensitive. The position for the lowercase `t` and the uppercase `T` is different.

### Step 7 - Comment out the previous code, and add code that strips empty characters from the left or right, or both

Python provides the `lstrip()` to remove empty space characters from the left side of a string, and the `rstrip()` function to remove them from the right side of a string. Or, you can use the `strip()` function to remove both.

Comment out the code from the previous step, and add the following code listing:

```python
message = '    middle     '
print('.' + message.lstrip() + '.')
print('.' + message.rstrip() + '.')
print('.' + message.strip() + '.')
```
Here, we concatenate a literal string that contains a period symbol (``.``) before and after the `message` variable and the call to one of the stripping functions. This enables you to see how it affects the content of the string.

When you run the code, you should see the following output:

```output
.middle     .
.    middle.
.middle.
```

### Step 8 - Comment out the previous code, and add code that replaces one string found in another string

The `replace()` function swaps every instance of a string with a different string.

Comment out the code from the previous step, and add the following code listing:

```python
message = 'brevity is the essence of wit'
message = message.replace('essence', 'soul')
print(message)
```
When you run the code, you should see the following output:

```output
brevity is the soul of wit
```

### Step 9 - Comment out the previous code, and add code that justifies a string by adding empty space characters

The `rjust()` and `ljust()` methods add empty space characters to a string to provide justification to the right or left, respectively.

Comment out the code from the previous step, and add the following code listing:

```python
message = 'howdy'
print(message.rjust(20))
print(message.rjust(20, '-'))
print(message.ljust(20))
print(message.ljust(20, '-'))
```
Notice that in both cases, you can add a second argument. This argument uses a different character, instead of an empty space, to add leading or trailing characters, respectively.

When you run the code, you should see the following output:

```output
               howdy
---------------howdy
howdy
howdy---------------
```

## Recap

Python provides many helper functions to format strings or modify its contents. If you need to modify a string, before you begin writing code to manipulate a string, check whether you can use a function that already exists. Spend a few moments in Python's documentation or search online for the right helper method to achieve your desired result.
