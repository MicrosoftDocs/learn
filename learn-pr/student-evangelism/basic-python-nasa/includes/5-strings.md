Out of all of the variables, strings are one of the most unique. This is because they can take on pretty much any key from your keyboard. Python also has a lot of pre-made code (functions) that you can call to manipulate your strings in various ways.

Lets start by making a string variable in your notebook. Copy the following line of code and click the run button:

```python
astronaut = "Remy Morris"
```

Say that we want to have this astronaut's name in all caps to print on their space suit. Instead of having to make a new variable, we can use the .upper() function to print the name in capital letters. To call a function, type the variable followed by a period, the name of the function, and then parenthesis. Calling this upper function will not change the astronaut variable, since we want to be able to have their name preserved with the correct capitalization. You must set a new variable or current variable equal to the function that you have just called.

```python
upperCase = astronaut.upper()
upperCase
```

>'REMY MORRIS'

In a similar way, we can call astronaut.lower() to make the string lower case.

```python
lowerCase = astronaut.lower()
lowerCase
```

>'remy morris'

Another cool string function we can use is called .capitalize(). This will make the first letter of a sentence capitalized and everything else lower-cased. Try copying the new variable below and calling the capitalize function.

```python
rocketOutput = "rOckEt iS A laUncH!"
rocketOutput.capitalize()
```

>'Rocket is a launch!'

Another neat thing you can do with strings in Python is concatenate or add them together. If you have two string variables, you can add them together by simply using the + sign.

```python
launchLocationCity = "Cape Canaveral, "
launchLocationState = "Florida"

launchLocationCity + launchLocationState
```

>'Cape Canaveral, Florida'

Finally, you can use the * sign to repeat a string multiple times.

```python
artemisRoverSounds = "beep beep "
artemisRoverSounds * 3
```

>'beep beep beep beep beep beep '
