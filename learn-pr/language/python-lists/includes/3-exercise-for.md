Most collections are *iterable*. They have an internal implementation that allows you to iterate through each item in the collection one by one, by using a `for` statement. In this module, we'll iterate through a Python list.

## Step 1 - Add a file for this exercise

Use the techniques that you learned in previous modules to add a new code file in this module's folder.  For example, you might create a file named *exercise2.py*.

## Step 2 - Test a value for inclusion in a list

The `in` keyword allows us to iterate through each item in a list. But we can also use it as a standalone operator to test whether an item belongs to a list.  

What if we want to know if a certain number is part of a list of numbers?  We can iterate through each number and then use an `if` statement to see if we find the value. But a better approach uses the `in` or `not in` operators to test the item for inclusion.

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

## Step 3 - Loop through a list

The `for` statement allows us to iterate through each item in a list.  The `for` statement includes:
- The `for` keyword.
- The variable name that will hold the next item in the list.  This variable is available in the code block that follows.
- The `in` keyword.
- The variable name of the list.
- The colon symbol (`:`), which ends the statement.

The part after the `for` statement is just as important. There, you define a code block that will be executed for each item in the list.  The current item's value is set to a variable in the `for` statement. It's available in the body of the code block.

Comment out the code from the previous section. Then add the following code listing:

```python
cities = ["Chicago", "London", "Tokyo"]

for city in cities:
  print(city)
```
In this example, we merely print each item in the list, one item per line. But you can see the basic structure of the `for` loop and how all of the parts work.

When you execute the code, you should see the following output:

```output
Chicago
London
Tokyo
```

## Step 4 - Break out of a `for` loop

The `for` statement has features similar to the `while` statement, which we explored in another module.

The `break` statement allows you to break out of the `for` iteration.  In this example, we break out of the loop after we find a value that exceeds a specific threshold. After we break out of the loop, we can filter the original list.

Comment out the code from the previous section. Then add the following code listing:

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

## Step 5 - Use an `else` statement

If you didn't break out of the loop and you want to execute code only after each item in the list has been processed, then you can use the `else` statement.  In the following example, we'll print the phrase `No numbers greater than 90` only if each number in our random list of five numbers is below the value `90`.

Comment out the code from the previous section. Then add the following code listing:

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
When you execute the code, you might see something like the following output. Your output will differ because the generated numbers are random.

```output
82
60
84
29
49
No numbers greater than 90
Complete
```

If one of the random numbers is 90 or greater, you see something like the following output. Again, your output will differ because the generated numbers are random.

```output
37
70
2
69
95
Found at least one number greater than 90
Complete
```

## Step 6 - Use a `continue` statement

Use the `continue` statement in a code block to skip the remaining logic and move to the next item in a list in a `for` statement.

In this section, we build a short program that filters out a list.  The list contains both `int` and `string`. We want to create a new list that contains only the `str` values.  We use the `continue` statement to move to the next item in the list instead of adding the current item to the filtered list.

Comment out the code from the previous section. Then add the following code listing:

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
['laptop', 'phone', 'dslr']
```

> [!NOTE]
> In the output for this step, we're printing the entire array of values that were filtered. Python displays these values as an array of strings using square brackets, commas, and single quotes.  If you want each individual item to print on a new line without all the extra characters, you must use the `print()` **inside** of the for loop.  See the other code listings on this page for examples of how to do this.

## Step 7 - Create nested `for` loops

Nesting one `for` loop inside of another `for` loop is a common way to generate a combination of values.

Suppose we're building a program for card playing. We want to create one card for each combination of a suit and a rank.  We could hard-code all 52 values in a deck of cards. Or we could generate a deck of cards by first creating a list of suits and a list of ranks and then using a nested `for` loop.

Comment out the code from the previous section. Then add the following code listing:

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
This technique will come in handy when we work on a challenge later in this module.

## Step 8 - Choose randomly from a list

Suppose you want to retrieve a sampling of all values in a list. By using the `random` module, you can call the `choice()` function to randomly select an item from a list. Or you can call the `choices()` function to randomly select a number of items from a list.

Comment out the code from the previous section. Then add the following code listing:

```python
import random

numbers = [42, 77, 16, 101, 23, 8, 4, 15, 55]
selected_number = random.choice(numbers)
print(selected_number)

selected_numbers = random.choices(numbers, k=3)
print(selected_numbers)
```

When you execute the code, you should see something like the following output. Your output will differ because the selected items are random.

```output
101
[77, 4, 8]
```
This technique will also prove useful when we work on a challenge later in this module.

### Recap

- Use the `in` and `not in` keywords as part of a Boolean expression to test whether a value is part of a list.
- Use the `for` statement to iterate through all items in a list. Also use the statement to execute a code block that puts the current item in scope to be inspected in the logic of the code block.
- Use the `continue` statement to skip the remaining code block logic and continue to the next list item that's assigned by the `for` statement.
- Use the `break` statement to break out of the `for` statement prematurely.
- Use the `else` statement to create a code block that executes after you use the `for` statement to iterate through all items in the list.
- Nest `for` statements to create a list of every combination of two lists.
- Use the `random` module's `choice()` and `choices()` functions to select one or many items from the list, respectively.
