Although strings in Python appear to be simple and straightforward, it's useful to grasp some of the rules that control what you can and can't do when working with them. Knowing these rules avoids getting surprised by string behavior when modifying values or formatting text.

## Immutability

Strings are immutable, that is, they can't change. This property of the string type can be surprising because Python won't give you errors when altering strings.

In this situation, you have one fact about the moon assigned to a variable. And you need to add another fact (sentence) to it. Using the Python interpreter it _seems_ like adding both would alter them:

```python
>>> fact = "The moon has no atmosphere."
>>> fact + "No sound can be heard on the moon."
'The moon has no atmosphere.No sound can be heard on the moon.'
```

Although it might look like we have modified the variable `fact`, checking the value reveals it maintains the original value:

```python
>>> fact
'The moon has no atmosphere.'
```

The trick here's that you must use the return value. When adding strings, Python doesn't modify any string, but returns a _new_ string as the result. To keep this new result, assign it to a new variable:

```python
>>> two_facts = fact + "No sound can be heard on the moon."
>>> two_facts
'The moon has no atmosphere.No sound can be heard on the moon.'
```

Operations on strings always produce new strings as a result.

## Quotes

Python strings can use single, double, and triple quotes. Although you can use them interchangeably, it's best to keep consistency in a project. For example, using double quotes:

```python
moon_radius = "The Moon has a radius of 1,080 miles"
``` 

However, when a string has quotes within, you can alternate the quotes. For example, in a substring that uses double quotes, use single quotes to surround the string:

```python
'The "near side" is the part of the Moon that faces the Earth'
```

Similarly, if a string is using single quotes, use double quotes to surround the string:

```python
"We only see about 60% of the Moon's surface"
```

Without alternating the quotes in this way, the Python interpreter raises a syntax error:

```python
>>> 'We only see about 60% of the Moon's surface'
  File "<stdin>", line 1
    'We only see about 60% of the Moon's surface'
                                       ^
SyntaxError: invalid syntax
```

When the text has a combination of single and double quotes, you can use triple quotes to prevent problems with the interpreter:

```python
"""We only see about 60% of the Moon's surface, this is known as the "near side". """
```

## Multiline text

There are a few different ways to define multiple lines of text as a single variable, but the most common ones are:

* Using a newline character
* With triple quotes

Using a newline character is achieved by introducing `\n`. Every time that character is used, a newline will show when printing the output:

```python
>>> multiline = "Facts about the Moon:\n There is no atmosphere.\n There is no sound."
>>> print(multiline)
Facts about the Moon:
 There is no atmosphere.
 There is no sound.
```

You can achieve the same result using triple quotes:

```python
>>>
>>> multiline = """Facts about the Moon:
...  There is no atmosphere.
...  There is no sound."""
>>> print(multiline)
Facts about the Moon:
 There is no atmosphere.
 There is no sound
```
