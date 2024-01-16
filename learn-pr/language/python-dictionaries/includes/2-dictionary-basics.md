Variables in Python can store various data types. Previously, you learned you can store strings and numbers:

```python
name = 'Earth'
moons = 1
```

Although this method does work for smaller amounts of data, it can become increasingly complex when you're working with related data. Imagine wanting to store information about the moons of both Earth and Jupiter.

```python
earth_name = 'Earth'
earth_moons = 1

jupiter_name = 'Jupiter'
jupiter_moons = 79
```

Notice how we duplicated variables with different prefixes. This duplication can become unwieldy. Because you'll frequently find yourself working with related sets of data, like average rainfall for different months in different cities, storing those variables as individual values isn't a viable option. Instead, you can use Python dictionaries.

Python dictionaries allow you to work with related sets of data. A *dictionary* is a collection of key/value pairs. Think of it like a group of variables inside of a container, where the key is the name of the variable, and the value is the value stored inside it.

## Create a dictionary

Python uses curly braces (`{ }`) and the colon (`:`) to denote a dictionary. You can either create an empty dictionary and add values later, or populate it at creation time. Each key/value is separated by a colon, and the name of each key is contained in quotes as a string literal. Because the key is a string literal, you can use whatever name is appropriate to describe the value.

Let's create a dictionary to store the name of the planet Earth, and the number of moons Earth has:

```python
planet = {
    'name': 'Earth',
    'moons': 1
}
```

You have two keys, `'name'` and `'moons'`. Each key behaves in much the same way as a variable: they have a unique name, and they store a value. However, they're contained inside of a single, larger variable, named `planet`.

As with regular variables, you need to ensure that you're using the correct data types. In the `moons` value of `1` in the preceding example, you didn't include quotes around the number, because you want to use an integer. If you had used `'1'`, Python would see this variable as a string, which would affect your ability to perform calculations.

Unlike regular variables, key names *don't* need to follow standard naming rules for Python. You can use key names to be more descriptive in your code.

## Read dictionary values

You can read values inside a dictionary. Dictionary objects have a `get` method that you can use to access a value by using its key. If you want to print the `name`, you can use the following code:

```python
print(planet.get('name'))
```

```Output
Earth
```

As you might suspect, accessing values in a dictionary is a common operation. Fortunately, there's a shortcut. You can also pass the key into square bracket notation (`[ ]`). This method uses less code than `get`, and most programmers use this syntax instead. You could rewrite the preceding example by using the following:

```python
# planet['name'] is identical to using planet.get('name')
print(planet['name'])
```

```Output
Earth
```

Although the behavior of `get` and the square brackets (`[ ]`) is generally the same for retrieving items, there's one key difference. If a key isn't available, `get` returns `None`, and `[ ]` raises a `KeyError`.

```python
wibble = planet.get('wibble') # Returns None
wibble = planet['wibble'] # Throws KeyError
```

## Modify dictionary values

You can also modify values inside a dictionary object, by using the `update` method. This method accepts a dictionary as a parameter, and updates any existing values with the new ones you provide. If you want to change the `name` for the `planet` dictionary, you can use the following, for example:

```python
planet.update({'name': 'Makemake'})

# No output: name is now set to Makemake.
```

Similar to using the square brackets (`[ ]`) shortcut to read values, you can use the same shortcut to modify values. The key difference in syntax is that you use `=` (sometimes called the *assignment* operator) to provide a new value. To rewrite the preceding example to change the name, you can use the following:

```python
planet['name'] = 'Makemake'

# No output: name is now set to Makemake.
```

The key advantage to using `update` is the ability to modify multiple values in one operation. The next two examples are logically the same, but the syntax is different. You're free to use whichever syntax you feel is most appropriate. Most developers choose square brackets to update individual values.

The following example makes the same edits to our `planet` variable, updating the name and moons. Notice that by using `update`, you're making a single call to the function, whereas using square brackets involves two calls.

Using update:

```python
planet.update({
    'name': 'Jupiter',
    'moons': 79
})
```

Using square brackets:

```python
planet['name'] = 'Jupiter'
planet['moons'] = 79
```

## Add and remove keys

You're not required to create all keys when you initialize a dictionary. In fact, you don't need to create any! Whenever you want to create a new key, you assign it just as you would an existing one.

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
> Key names, like everything else in Python, are case sensitive. As a result, `'name'` and `'Name'` are seen as two separate keys in a Python dictionary.

To remove a key, you use `pop`. `pop` returns the value and removes the key from the dictionary. To remove `orbital period`, you can use the following code:

```python
planet.pop('orbital period')

# planet dictionary now contains: {
#   name: 'jupiter'
#   moons: 79
# }
```

## Complex data types

Dictionaries are able to store any type of a value, including other dictionaries. This allows you to model complex data as needed. Imagine needing to store the diameter for `planet`, which could be measured around its equator or poles. You can create another dictionary inside of `planet` to store this information:

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

To retrieve values in a nested dictionary, you chain together square brackets, or calls to `get`.

```python
print(f'{planet["name"]} polar diameter: {planet["diameter (km)"]["polar"]}')
```

```Output
Jupiter polar diameter: 133709
```
