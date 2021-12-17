So far, you've been taught various constructs of the Python programming language and you've authored a couple of programs. However, programs operate on data and that data comes from somewhere. In this unit, we'll take a closer look at how we can collect input both from the command line and from user input.

## Command-line input

When you start a program, using `python3`, you give it the name of the file to start, but apart from that you can give it a set of arguments, data, that the program will have access to when running. Here's how that can look:

```bash
python3 backup.py 2021-01-01
```

In the code above, the string "2021-01-01" can be used as instruction to the program to start backup from that date. What you gain by using command-line arguments are flexibility, it can behave differently depending on its outside input.

### Use command-line arguments

How are these commands captured on the coding side of things? By using the `sys` module, you can retrieve the command-line arguments and use them in your code. Look at the following code:

```python
import sys

print(sys.argv)
print(sys.argv[0]) # program name
print(sys.argv[1]) # first arg
```

`sys.argv`, is an array, a data structure containing many items. The first position, denoted as '0', in the array, contains the program name. The second position, '1' contain your first argument. Running the program like so:

```bash
python3 cli.py Jupiter
```

yields the following result:

```output
['cli.py', 'Jupiter'] 
cli.py
Jupiter
```

## Work with input

Another way to pass data to the program is having the user type the data. You can code it so the user is told to input information, that you save into the program and then you act upon the entered data. 

To capture information from the user, you use the `input()` function. Here's an example:

```python
print("Welcome to the greeter program")
name = input("Enter your name ")
print("Greetings: " + name)
```

Running the program like so `python3 input.py` gives the following result:

```output
Welcome to the greeter program
Enter your name Picard
Greetings: Picard
```

### Work with numbers

One important thing to know about is that the `input()` function stores the result as a string. So this code might not do what you want it to do:

```python
print("calculator program")
first_number = input("first number: ")
second_number = input("second number: ")
print(first_number + second_number)
```

Running this program `python3 calc.py` give you the following result:

```output
calculator program
first number: 3
second number: 4
34
```

You probably meant for this program to answer you with 7 instead of 34, so what went wrong? The explanation is that `first_number` and `second_number` are strings, and for the calculation to work correctly, they need to be made into numbers, by using the `int()` function. By modifying the last line of the program to use `int()`, you can resolve the issue:

```python
print(int(first_number) + int(second_number))
```

Rerunning the program now yields a 7 as response.
