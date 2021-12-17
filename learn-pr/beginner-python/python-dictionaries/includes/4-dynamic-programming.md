In our program we want to perform various calculations, like totaling the number of moons. Additionally, as we get into more advanced programming we may find we're loading this type of information from files or a database rather than having it coded directly into a Python file.

To help support these scenarios, Python allows you to treat both the keys and values inside of a dictionary as a list. This enables us to dynamically determine keys and values, and perform various calculations.

Imagine a dictionary storing monthly rainfall amounts. You would likely have keys for each month and the associated rainfall. You want to add up the total rainfall, and writing the code to perform the operation by using each individual key would be rather tedious.

## Retrieve all keys and values

The `keys()` method returns a list object containing all the keys. You can use this to iterate through all items in the dictionary.

Imagine you have the following dictionary storing the last three months of rainfall.

```python
rainfall = {
    'october': 3.5,
    'november': 4.2,
    'december': 2.1
}
```

Let's say you want to display the list of all rainfall. While you could type out each month name, this would become tedious.

```python

for key in rainfall.keys():
    print(f'{key}: {rainfall[key]}cm')

# Output:
# october: 3.5cm
# november: 4.2cm
# december: 2.1cm
```

> [!NOTE]
> You can still use square brackets (`[ ]`) with a variable name rather than the hard-coded string literal.

## Determine if a key exists in a dictionary

When you update a value in a dictionary, Python will either overwrite the existing value or create a new one if the key does not exist. If you wish to add to a value rather than overwriting it, you can check to see if the key exists using `in`. If you wanted to add a value to December or create a new one if it doesn't exist, you could use the following:

```python
if 'december' in rainfall:
    rainfall['december'] = rainfall['december'] + 1
else:
    rainfall['december'] = 1

# Because december exists, the value will be 3.1
```

## Retrieve all values

Similar to `keys()`, `values()` returns the list of all values in a dictionary **without** their respective keys. This can be helpful in scenarios where the key is used for labeling purposes, such as the example above where the keys are the name of the month, but you need to perform operations on all the values. You could use `values()` to determine the total rainfall amount:

```python
total_rainfall = 0
for value in rainfall.values():
    total_rainfall = total_rainfall + value

print(f'There was {total_rainfall}cm in the last quarter')

# Output:
# There was 10.8cm in the last quarter
```
