Besides text transformations and basic operations like matching and searching, formatting is essential when presenting information. The simplest way to present text information with Python is using the `print()` function. You'll find that it's critical to get information in variables and other data structures int a string that `print()` can use. 

There are several valid ways to include variable values in a text with Python. 

## % formatting

The placeholder is `%s` and the variable is passed onto the text after the `%` character outside of the string. Here is how to format using the `%` character:

```python
>>> mass_percentage = "1/6"
>>> print("On the Moon, you would weight about %s of your weight on Earth" % mass_percentage)
On the Moon, you would weight about 1/6 of your weight on Earth
```

Using multiple values changes the syntax by requiring parentheses surrounding the variables passed in:

```python
>>> print("""Both sides of the %s get the same amount of sunlight,
... but only one of them is seen from %s because
... the %s rotates around its own axis when orbiting %s.""" % ("Moon", "Earth", "Moon", "Earth"))
Both sides of the Moon get the same amount of sunlight,
but only one of them is seen from Earth because
the Moon rotates around its own axis when orbiting Earth.
```

> [!TIP]
> Although this method is still a valid way to format strings it can lead to errors and decreased clarity in code when dealing with multiple variables. Any of the other two formatting options described in this module will be better suited.

## format() method

The `.format()` method uses curly brackets ( `{ }` ) for placeholders within a string, and uses variable assignment for replacing. 

```python
>>> mass_percentage = "1/6"
>>> print("On the Moon, you would weight about {} of your weight on Earth".format(mass_percentage))
On the Moon, you would weight about 1/6 of your weight on Earth
```

You don't need to assign repeated variables multiple times, making it less verbose since fewer variables need to be assigned:

```python
>>> print("""You are lighter on the {0}, because on the {0} 
... you would weight about {1} of your weight on Earth""".format("Moon", mass_percentage))
You are lighter on the Moon, because on the Moon you would weight about 1/6 of your weight on Earth
```

Instead of empty curly brackets the substitution is using numbers. The `{0}` means to use the first (index of zero) argument to `.format()`, which in this case is `Moon`. For simple repetition `{0}` works well, but reduces readability. To improve readability, use keyword arguments in `.format()` and then reference those same arguments within curly brackets:

```python
>>> print("""You are lighter on the {moon}, because on the {moon} 
... you would weight about {mass} of your weight on Earth""".format(moon="Moon", mass=mass_percentage))
You are lighter on the Moon, because on the Moon you would weight about 1/6 of your weight on Earth
```

## f-strings 

Since Python version 3.6 it's possible to use f-strings. These strings look like templates with the same named variables as those in code. The previous example with f-strings would look like this:

```python
>>> print(f"On the Moon, you would weight about {mass_percentage} of your weight on Earth")
On the Moon, you would weight about 1/6 of your weight on Earth
```

Variables go within curly brackets ( `{ }` ) and the string _must_ use the `f` prefix.

Aside from being less verbose than any other formatting option, it's possible to use expressions within the curly brackets. These expressions can be functions or direct operations. For example, if you want to represent the `1/6` value as a percentage with one decimal place you can use the `round()` function directly:

```python
>>> round(100/6, 1)
16.7
```

With f-strings, you don't need to assign a value to a variable beforehand:

```python
>>> print(f"On the Moon, you would weight about {round(100/6, 1)}% of your weight on Earth")
On the Moon, you would weight about 16.7% of your weight on Earth
```

Using an expression doesn't require a function call. Any of the string methods are valid as well. For example, the string could enforce a specific casing for creating a title:

```python
>>> subject = "interesting facts about the moon"
>>> f"{subject.title()}
'Interesting Facts About The Moon'
```
