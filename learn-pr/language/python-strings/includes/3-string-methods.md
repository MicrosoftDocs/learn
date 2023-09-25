String methods are one of the most common method types in Python. You'll often need to manipulate strings to extract information or fit a certain format. Python includes several string methods that are designed to do the most common and useful transformations.

String methods are part of the `str` type. This means that the methods exist as string variables, or part of the string directly. For example, the method `.title()` returns the string in initial caps and can be used with a string directly:

```python
print("temperatures and facts about the moon".title())
```

Output: `Temperatures And Facts About The Moon`

The same behavior and usage happens on a variable:

```python
heading = "temperatures and facts about the moon"
heading_upper = heading.title()
print(heading_upper)
```

## Split a string

A common string method is `.split()`. Without arguments, the method will separate the string at every space. This would create a list of every word or number that's separated by a space:

```python
temperatures = "Daylight: 260 F Nighttime: -280 F"
temperatures_list = temperatures .split()
print(temperatures_list)
```

Output: `['Daylight:', '260', 'F', 'Nighttime:', '-280', 'F']`

In this example, you're dealing with multiple lines, so the (implicit) newline character can be used to split the string at the end of each line, creating single lines:

```python
temperatures = "Daylight: 260 F\n Nighttime: -280 F"
temperatures_list = temperatures .split('\n')
print(temperatures_list)
```

Output: `['Daylight: 260 F', 'Nighttime: -280 F']`

This type of splitting becomes handy when you need a loop to process or extract information, or when you're loading data from a text file.

## Search for a string

Some string methods can look for content before processing, without using a loop. Let's assume that you have two sentences that discuss temperatures on various planets and moons. However, you're interested only in temperatures that are related to our Moon. That is, if the sentences aren't talking about the Moon, they shouldn't be processed to extract information.

The simplest way to discover whether a given word, character, or group of characters exists in a string is to use the `in` operator:

```python
print("Moon" in "This text will describe facts and challenges with space travel")
```

Output: `False`

```python
print("Moon" in "This text will describe facts about the Moon")
```

Output: `True`

An approach to finding the position of a specific word in a string is to use the `.find()` method:

```python
temperatures = """Saturn has a daytime temperature of -170 degrees Celsius, while Mars has -28 Celsius."""
print(temperatures.find("Moon"))
```

Output: `-1`

The `.find()` method returns a `-1` when the word isn't found, or it returns the index (the number representing the place in the string). This is how it would behave if you're searching for the word *Mars*:

```python
temperatures = """Saturn has a daytime temperature of -170 degrees Celsius, while Mars has -28 Celsius."""
print(temperatures.find("Mars"))
```

Output: `64`

`64` is the position where `"Mars"` appears in the string.

Another way to search for content is to use the `.count()` method, which returns the total number of occurrences of a certain word in a string:

```python
temperatures = """Saturn has a daytime temperature of -170 degrees Celsius, while Mars has -28 Celsius."""
print(temperatures.count("Mars"))
print(temperatures.count("Moon"))
```

```Output
1
0
```

Strings in Python are case-sensitive, which means that *Moon* and *moon* are considered different words. To do a case-insensitive comparison, you can convert a string to all lowercase letters by using the `.lower()` method:

```python 
print("The Moon And The Earth".lower())
```

Output: `the moon and the earth`

Similar to the `.lower()` method, strings have an `.upper()` method that does the opposite, converting every character to uppercase:

```python
print("The Moon And The Earth".upper())
```

Output: `THE MOON AND THE EARTH`

> [!TIP]
> When you're searching for and checking content, a more robust approach is to lowercase a string so that casing doesn't prevent a match. For example, if you're counting the number of times the word *the* appears, the method wouldn't count the times where *The* appears, even though they're both the same word. You can use the `.lower()` method to change all characters to lowercase.

## Check content

There are times when you'll process text to extract information that's irregular in its presentation. For example, the following string is simpler to process than an unstructured paragraph:

```python
temperatures = "Mars Average Temperature: -60 C"
```

To extract the average temperature on Mars, you can do well with the following methods:

```python
temperatures = "Mars Average Temperature: -60 C"
parts = temperatures.split(':')
print(parts)
print(parts[-1])
```

```Output
['Mars average temperature', ' -60 C']
' -60 C'
```

The preceding code trusts that everything after the colon (`:`) is a temperature. The string is split at `:`, which produces a list of two items. Using `[-1]` on the list returns the last item, which is the temperature in this example.

If the text is irregular, you can't use the same splitting methods to get the value. You must loop over the items and check to see whether the values are of a certain type. Python has methods that help check the type of string:

```python
mars_temperature = "The highest temperature on Mars is about 30 C"
for item in mars_temperature.split():
    if item.isnumeric():
        print(item)
```

Output: `30`

Like the `.isnumeric()` method, `.isdecimal()` can check for strings that look like decimals.

> [!IMPORTANT]
> It might be surprising to learn that `"-70".isnumeric()` would return `False`. This is because all characters in the string would need to be numeric, and the dash (`-`) isn't numeric. If you need to check negative numbers in a string, the `.isnumeric()` method wouldn't work.

There are extra validations that you can apply on strings to check for values. For negative numbers, the dash is prefixed to the number, and that can be detected with the `.startswith()` method:

```python
print("-60".startswith('-'))
```

Output: `True`

Similarly, the `.endswith()` method helps with verifying the last character of a string:

```python
if "30 C".endswith("C"):
print("This temperature is in Celsius")
```

Output: `This temperature is in Celsius`

## Transform text

There are other methods that help in situations where text needs to be transformed into something else. So far, you've seen strings that can use *C* for *Celsius* and *F* for *Fahrenheit*. You can use the `.replace()` method to find and replace occurrences of a character or group of characters:

```python
print("Saturn has a daytime temperature of -170 degrees Celsius, while Mars has -28 Celsius.".replace("Celsius", "C"))
```

Output: `Saturn has a daytime temperature of -170 degrees C, while Mars has -28 C.`

As mentioned earlier, `.lower()` is a good way to normalize text to do a case-insensitive search. Let's quickly check to see whether some text discusses temperatures:

```python
text = "Temperatures on the Moon can vary wildly."
print("temperatures" in text)
```

Output: `False`

```python
text = "Temperatures on the Moon can vary wildly."
print("temperatures" in text.lower())
```

Output: `True`

You might not need to do case-insensitive verification all the time, but lowercasing every letter is a good approach when the text uses mixed casing.

After you've split the text and performed the transformations, you might need to put all the parts back together again. Just as the `.split()` method can separate characters, the `.join()` method can put them back together.

The `.join()` method requires an iterable (such as a Python list) as an argument, so its usage looks different from other string methods:

```python
moon_facts = ["The Moon is drifting away from the Earth.", "On average, the Moon is moving about 4cm every year."]
print(' '.join(moon_facts))
```

Output: `The Moon is drifting away from the Earth. On average, the Moon is moving about 4cm every year.`

In this example, `' '` is used to join every item in the list.
