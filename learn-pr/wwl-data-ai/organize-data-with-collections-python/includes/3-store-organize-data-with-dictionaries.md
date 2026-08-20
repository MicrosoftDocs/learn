
A **dictionary** stores data as **key-value pairs**. Instead of accessing items by position (like a list), you access them by a meaningful label called a **key**. Dictionaries are perfect for representing something with named properties—a user, a settings profile, a product record.

## Creating a dictionary

Dictionaries use curly braces `{}` with keys and values separated by colons:

```python
user = {
    "name": "Alex",
    "age": 25,
    "email": "alex@example.com"
}
```

Keys are usually strings, but they can also be numbers or other immutable values. Values can be any type—including lists or even other dictionaries.

## Accessing values by key

To read a value, use the key inside square brackets:

```python
print(user["name"])   # Output: Alex
print(user["age"])    # Output: 25
```

If you try to access a key that doesn't exist, Python raises a `KeyError`. To access a value safely, use the `.get()` method, which returns `None` (or a default you specify) if the key is missing:

```python
print(user.get("phone"))               # Output: None
print(user.get("phone", "not listed")) # Output: not listed
```

## Common dictionary operations

| Operation | What it does |
|---|---|
| `dict[key] = value` | Adds a new key or updates an existing one |
| `del dict[key]` | Removes a key-value pair |
| `key in dict` | Returns `True` if the key exists |
| `dict.keys()` | Returns all the keys |
| `dict.values()` | Returns all the values |
| `dict.items()` | Returns key-value pairs |

```python
user = {"name": "Alex", "age": 25}

user["email"] = "alex@example.com"   # Add a new key
user["age"] = 26                     # Update an existing key
del user["age"]                      # Remove a key

print("name" in user)                # Output: True
```

## Iterating over a dictionary

The `.items()` method lets you loop through both keys and values at once:

```python
user = {"name": "Alex", "age": 25, "email": "alex@example.com"}

for key, value in user.items():
    print(f"{key}: {value}")
```

Output:

```output
name: Alex
age: 25
email: alex@example.com
```

## Lists vs. dictionaries

Both are collections, but they solve different problems:

| Use a **list** when... | Use a **dictionary** when... |
|---|---|
| Order matters | Each value has a meaningful label |
| You access items by position | You access values by key |
| You have a sequence of similar items | You have a set of named properties |