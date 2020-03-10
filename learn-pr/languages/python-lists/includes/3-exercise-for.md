Most collections are iterable, meaning, they have the internal implementation that allows you to iterate through each item in the collection (in this module, a Python list) one by one using a `for` statement.

### Step 1 - Add a new file for this exercise to the working folder.

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create a file named `exercise2.py`.

### Step 2 - Add code to use the `in` and `not in` to test a value for inclusion in a list.

The `in` keyword will allow us to iterate through each item in a list.  However, we can use it as a stand-alone operator to test whether an item belongs to a list.  What if we want to know if a certain number is part of a list of numbers?  We could iterate through each number, then use an `if` statement to see if we find the value.  A better approach would be to simply use the `in` or `not in` operators to test the item for inclusion.

Add the following code to your new code file:

```python
numbers = [1, 3, 5]

print(5 in numbers)
print(8 in numbers)

print(5 not in numbers)
print(8 not in numbers)
```
When you execute the code, you should see the following output:

```output
True
False
False
True
```

### Step 3 - Comment out the code from the previous step, then add code to loop through a list.

The `for` statement allows us to iterate through each item in a list.  There are several parts to the `for` statement:
- the `for` keyword
- the variable name that will hold the next item in the list.  This variable will be available in the code block below.
- the `in` keyword
- the variable name of the list
- the colon symbol `:`, which terminates the statement

What comes after the `for` statement is just as important.  You define a code block that will be executed for each item in the list.  The current item's value will be set to a variable in the `for` statement, and will be available in the body of the code block.

Comment out the code from the previous step and add the following code listing:

```python
cities = ["Chicago", "London", "Tokyo"]

for city in cities:
  print(city)
```
In this example, we merely print each item in the list, one per line.  However, you can see the basic structure of the `for` loop and how all the parts work.

When you execute the code, you should see the following output:

```output
Chicago
London
Tokyo
```

### Step 4 - Comment out the previous code and add code to break out of a `for` loop.

The `for` statement has similar features to the `while` statement that we learned about in another module.

The `break` statement allows you to break out of the `for` iteration.  In this example, we'll break out of the loop once we find a value that exceeds a specific threshold.  This allows us to filter the original list.

Comment out the code from the previous step and add the following code listing:

```python
numbers = [42, 77, 16, 101, 23, 8, 4, 15, 55]
numbers.sort()

for number in numbers:
  if number > 42:
    break
  print(number)
```
When you execute the code, you should see the following output:

```output
4
8
15
16
23
42
```

### Step 6 - Comment out the previous code and add code that utilizes an `else` statement.

If you want to execute code only after each item in the list has been processed successfully (and you did not break out of the loop), then you can use the `else` statement.  In the example below, we'll only print the phrase `No numbers greater than 90` if each number in our random list of five numbers is below the value `90`.

Comment out the code from the previous step and add the following code listing:

```python
import random
numbers = []

while len(numbers) < 5:
  numbers.append(random.randint(1, 100))

for number in numbers:
  print(number)
  if number >= 90:
    print('Found at least one number greater than 90')
    break
else:
  print('No numbers greater than 90')

print('Complete')
```
When you execute the code, you should see the following output (given that the numbers generated will be random):

```output
82
60
84
29
49
No numbers greater than 90
```

However, if one of the random numbers is 90 or greater, you would see the following output (given that the numbers generated will be random):

```output
37
70
2
69
95
Found at least one number greater than 90
Complete
```

### Step 7 - Comment out the previous code and add code that utilizes a `continue` statement.

Use the `continue` statement inside of a code block to skip the remainder of the logic and move to the next item in a list in a `for` statement.

In this step, we'll build a short program that filters out a list.  The list contains both `int` and `string`, and we want to create a new list that only contains the `str` values.  We use the `continue` statement to move to the next item in the list instead of adding the current item to the filtered list.

Comment out the code from the previous step and add the following code listing:

```python
values = ["laptop", 7, "phone", 3, "dslr", 5]
equipment = []

for value in values:
  if isinstance(value, str) == False:
    continue
  equipment.append(value)

print(equipment)
```
When you execute the code, you should see the following output:

```output
laptop
phone
dslr
```
### Step 8 - Comment out code in previous steps and add code to create nested for loops.

Nesting one `for` loop inside of another `for` loop is a common pattern when you want to generate a combination of values.

Suppose we were building a playing card program.  We would want to create one card for each combination of a suit and rank.  We could hardcode all 52 values in a deck of cards, or we could generate a deck of cards by creating a list of suits and a list of ranks, then using a nested `for` loop to generate all the cards.

Comment out the code from the previous step and add the following code listing:

```python
suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

for  suit in suits:
  for rank in ranks:
    print(f'{rank} of {suit}') 
```

When you execute the code, you should see the following output:

```output
2 of Hearts
3 of Hearts
4 of Hearts
5 of Hearts
6 of Hearts
7 of Hearts
8 of Hearts
9 of Hearts
10 of Hearts
Jack of Hearts
Queen of Hearts
King of Hearts
Ace of Hearts
2 of Spades
3 of Spades
4 of Spades
5 of Spades
6 of Spades
7 of Spades
8 of Spades
9 of Spades
10 of Spades
Jack of Spades
Queen of Spades
King of Spades
Ace of Spades
2 of Clubs
3 of Clubs
4 of Clubs
5 of Clubs
6 of Clubs
7 of Clubs
8 of Clubs
9 of Clubs
10 of Clubs
Jack of Clubs
Queen of Clubs
King of Clubs
Ace of Clubs
2 of Diamonds
3 of Diamonds
4 of Diamonds
5 of Diamonds
6 of Diamonds
7 of Diamonds
8 of Diamonds
9 of Diamonds
10 of Diamonds
Jack of Diamonds
Queen of Diamonds
King of Diamonds
Ace of Diamonds
```
This technique will come in handy when we work on the challenge later in this module.

### Step 9 - Comment out the previous code and add code that makes random choices from a list.

You may want to retrieve a sampling of all the values in a list.  Using the `random` module, you can call the `choice()` function to randomly select a single item from a list, or the `choices()` function to randomly select a number of items from a list.

Comment out the code from the previous step and add the following code listing:

```python
import random

numbers = [42, 77, 16, 101, 23, 8, 4, 15, 55]
selected_number = random.choice(numbers)
print(selected_number)

selected_numbers = random.choices(numbers, k=3)
print(selected_numbers)
```

When you execute the code, you should see the following output (given the random items that are selected):

```output
101
[77, 4, 8]
```
This technique will also prove useful when we work on the challenge later in this module.

### Recap

- Use the `in` and `not in` keyword as part of a Boolean expression to test whether a value is part of a list or not.
- Use the `for` statement to iterate through all items `in` a list and execute a code block that puts the current item of the list in scope to be inspected in the logic of code block.
- Use the `continue` statement to skip the remaining code block logic and continue to the next list item as assigned by the `for` statement.
- Use the `break` statement to break out of the `for` statement pre-maturely.
- Use the `else` statement to create a code block that executes at the successful completion of iterating through all items in the list when using the `for` statement.
- You can nest `for` statements to create a list of every combination of two lists.
- Use the `random` module's `choice()` and `choices()` functions to select one or many items from the list, respectively.