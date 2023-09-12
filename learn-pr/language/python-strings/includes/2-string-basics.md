Although strings in Python appear to be simple and straightforward, there's some complexity in string rules that's important to grasp. Knowing the rules helps you avoid being surprised by string behavior when you're modifying values or formatting text.

## A simple string

In our example for this unit, you have a single fact about the Moon that's assigned to a variable, like this:

```python
fact = "The Moon has no atmosphere."
print(fact)
```

The output shows that the text has been assigned to the variable: `The Moon has no atmosphere.`

## Immutability of strings

In Python, strings are immutable. That is, they can't change. This property of the string type can be surprising, because Python doesn't give you errors when you alter strings.

You need to add another fact (sentence) to the single fact that's assigned to a variable. It *seems* as though adding the second fact would alter the variable, as in the following example:

```python
fact = "The Moon has no atmosphere."
fact + "No sound can be heard on the Moon."
```

You might expect the output to be: `The Moon has no atmosphere.No sound can be heard on the Moon.`

Although it might look as though we've modified the variable `fact`, a quick check of the value reveals that the original value is unchanged:

```python
fact = "The Moon has no atmosphere."
fact + "No sound can be heard on the Moon."
print(fact)
```

Output: `The Moon has no atmosphere.`

The trick is that you must use a return value. When you add strings, Python doesn't modify any string, but it returns a *new* string as the result. To keep this new result, assign it to a new variable:

```python
fact = "The Moon has no atmosphere."
two_facts = fact + "No sound can be heard on the Moon."
print(two_facts)
```

Output: `The Moon has no atmosphere.No sound can be heard on the Moon.`

Operations on strings always produce new strings as a result.

## About using quotation marks

You can enclose Python strings in single, double, or triple quotation marks. Although you can use them interchangeably, it's best to use one type consistently within a project. For example, the following string uses double quotation marks:

```python
moon_radius = "The Moon has a radius of 1,080 miles."
``` 

However, when a string contains words, numbers, or special characters (a *substring*) that are also enclosed in quotation marks, you should use a different style. For example, if a substring uses double quotation marks, enclose the entire string in single quotation marks, as shown here:

```python
'The "near side" is the part of the Moon that faces the Earth.'
```

Similarly, if there are single quotation marks (or an apostrophe, as in *Moon's* in the following example) anywhere within the string, enclose the entire string in double quotation marks: 

```python
"We only see about 60% of the Moon's surface."
```

Failure to alternate single and double quotation marks can cause the Python interpreter to raise a syntax error, as shown here:

```python
'We only see about 60% of the Moon's surface.'
  File "<stdin>", line 1
    'We only see about 60% of the Moon's surface.'
                                       ^
SyntaxError: invalid syntax
```

When the text has a combination of single and double quotation marks, you can use triple quotation marks to prevent problems with the interpreter:

```python
"""We only see about 60% of the Moon's surface, this is known as the "near side"."""
```

## Multiline text

There are a few different ways to define multiple lines of text as a single variable. The most common ways are:

* Use a newline character (`\n`).
* Use triple quotation marks (""").

Newline characters separate the text into multiple lines when you print the output:

```python
multiline = "Facts about the Moon:\n There is no atmosphere.\n There is no sound."
print(multiline)
```

```Output
Facts about the Moon:
 There is no atmosphere.
 There is no sound.
```

You can achieve the same result by using triple quotation marks:

```python
multiline = """Facts about the Moon: There is no atmosphere. There is no sound."""
 print(multiline)
```

