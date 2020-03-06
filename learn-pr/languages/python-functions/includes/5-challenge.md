Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

In this challenge, you will create a new module containing functions so that the provided code will function as expected.

### Step 1: Create a new code file for this challenge.

Use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create the following file:

```
challenge.py
```

### Step 2: 

Copy the following code into the new `challenge.py` file:

```python
import processor

my_list = [5, 'Dan', '4', 7, 'Steve', 'Amy', 'Rhonda', 4, '9', 'Jill', 7, 'Kim']
my_bad_list = 5

numbers = processor.process_numbers(my_list)
print(numbers)

names = processor.process_names(my_list)
print(names)

numbers = processor.process_numbers(my_bad_list)
print(numbers)

names = processor.process_names(my_bad_list)
print(names)
```


### Step 3 - Make sure you follow the rules of the challenge.

Rule 1: You cannot modify the code in the `challenge.py` file at all.  You must create a new module named `processor.py` in the same working folder.

Rule 2: When finished, executing the `challenge.py` file must produce the following output:

```output
[4, 4, 5, 7, 7, 9]
['Amy', 'Dan', 'Jill', 'Kim', 'Rhonda', 'Steve']
[]
[]
```

Rule 3: The `process_numbers()` function must select all numeric values, even those that are string values, and return them as a list.  They must be converted to numbers and included in the returned list.  The list must be sorted.  The function must be able to handle the possibility that the input parameter is not formatted as a list.  In that case, it must pass back an empty list.

Rule 4: The `process_names()` function must select all string values that are not numeric and return them as a list.  The list must be sorted.  The function must be able to handle the possibility that the input parameter is not formatted as a list.  In that case, it must pass back an empty list.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.