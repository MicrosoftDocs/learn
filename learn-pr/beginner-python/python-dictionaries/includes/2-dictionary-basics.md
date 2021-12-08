Variables in Python can store various data types. Previously, you learned you can store strings and numbers:

```python
name = 'Earth'
moons = 1
```

While this does work for smaller amounts of data, it can become increasingly complex when working with related data. Imagine wanting to store information about both Earth and Jupiter's moons.

```python
earth_name = 'Earth'
earth_moons = 1

jupiter_name = 'Jupiter'
jupiter_moons = 79
```

Notice how we duplicated variables with different prefixes. After a little while this becomes unwieldy. Because you will frequently find yourself working with related sets of data, like average rainfall for different months in different cities, storing those as individual values isn't a viable option. This is where Python dictionaries can help.

Python dictionaries allow you to work with related sets of data. A dictionary is a collection of key/value pairs. You can almost think about it like a group of variables inside of a container, where the key is the name of the variable, and the value is the value stored inside it.

## Creating a dictionary

Python uses curly braces (`{ }`) and the colon (`:`) to denote a dictionary. You can either create an empty dictionary and add values later, or populate it at creation time. Each key/value is separated by a colon, and the name of each key is contained in quotes as a string literal. Because the key is a string literal, you can use whatever name is appropriate to describe the value.

Let's create a dictionary to store the name of the planet Earth, and the number of moons Earth has:

```python
planet = {
    'name': 'Earth',
    'moons': 1
}
```

We have two keys, `'name'` and `'moons'`. Each of these behaves much in the same way as a variable - they have a unique name, and they store a value. However, they are contained inside of a single larger variable named `planet`.

Just as with regular variables, we need to ensure we are using the correct data types. In the `moons` value of `1` in the example above, we did not include quotes (`' '`) around the number, because we want to use an integer. If we had used `'1'`, Python would see this as a string, which would impact our ability to perform calculations.

Unlike regular variables, key names **do not** need to follow standard naming rules for Python. You can use this to be more descriptive in your code.

## Reading dictionary values

You can read values inside a dictionary. Dictionary objects have a `get` method which can be used to access a value by using its key. If you wanted to print the `name`, you could use the following code:

```python
print(planet.get('name'))

# Displays Earth
```

As you might suspect, accessing values in a dictionary is a common operation. Fortunately, there's a shortcut. You can also pass the key into what's known as or square bracket notation (`[ ]`). This uses less code than `get`, and most programmers use this syntax instead. You could rewrite the example above by using the following:

```python
# planet['name'] is identical to using planet.get('name')
print(planet['name'])

# Displays Earth
```

While the behavior of `get` and the square brackets (`[ ]`) is generally the same for retrieving items, there is one key difference between them. If a key isn't available, `get` will return `None` while `[ ]` will raise a `KeyError`.

```python
wibble = planet.get('wibble') # Returns None
wibble = planet['wibble'] # Throws KeyError
```

## Modifying dictionary values

Values inside a dictionary object can also be modified. You can perform this action by using the `update` method. `update` accepts a dictionary as a parameter, and will update any existing values with the new ones you provide. If you wished to change the `name` for the `planet` dictionary, you could use the following:

```python
planet.update({'name': 'Makemake'})

# name is now set to Makemake
```

Similar to using the square brackets (`[ ]`) to read values, you can also use it to modify values. The key difference in syntax is you use `=` (sometimes called the assignment operator) to provide a new value. To rewrite the example above to change the name, you could use the following:

```python
planet['name'] = 'Makemake'

# name is now set to Makemake
```

The key advantage to using `update` is the ability to modify multiple values in one operation. The two examples below are logically the same while the syntax is different. You are free to use whichever syntax you feel is most appropriate. For updating individual values, most developers will use square brackets.

The example below makes the same edits to our `planet` variable - updating the name and moons. Notice by using `update` this involves a single call to the function, while using square brackets involves two calls.

```python
# Using update
planet.update({
    'name': 'Jupiter',
    'moons': 79
})

# Using square brackets
planet['name'] = 'Jupiter'
planet['moons'] = 79
```

## Adding and removing keys

You are not required to create all keys when initializing a dictionary - in fact you don't need to create any! Whenever you want to create a new key, you assign it just as you would an existing one.

Let's say you want to update `planet` to include the orbital period in days:

```python
planet['orbital period'] = 4333

# planet dictionary now contains: {
#   name: 'jupiter'
#   moons: 79
#   orbital period: 4333
# }
```

> [!IMPORTANT]
> Key names, like everything else in Python, is case sensitive. As a result, `'name'` and `'Name'` would be seen as two separate keys in a Python dictionary.

To remove a key, you use `pop`. `pop` will return the value and remove the key from the dictionary. To remove `orbital period`, you can use the following code:

```python
planet.pop('orbital period')

# planet dictionary now contains: {
#   name: 'jupiter'
#   moons: 79
# }
```

## Complex data types

Dictionaries are able to store any type of a value, including other dictionaries. This allows you to model complex data as needed. Imagine needing to store the diameter for `planet`, which could be measured around its equator or poles. You could create another dictionary inside of `planet` to store this information:

```python
# Add address
planet['diameter (km)'] = {
    'polar': 133709,
    'equatorial': 142984
}

# planet dictionary now contains: {
#   name: 'Jupiter'
#   moons: 79
#   diameter (km): {
#      polar: 133709
#      equatorial: 142984
#   }
# }
```

To retrieve values in a nested dictionary, you chain together square brackets or calls to `get`.

```python
print(f'{planet['name']} polar diameter: {planet['diameter (km)']['polar']}')

# Output: Jupiter polar diameter: 133709
```
