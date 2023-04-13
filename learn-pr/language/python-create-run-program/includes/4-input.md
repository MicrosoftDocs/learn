So far, you've learned various constructs of the Python programming language. You've also authored a couple of programs. However, programs operate on data, and that data comes from somewhere. In this unit, you'll take a closer look at how to collect input from the command line and from user input.

## Command-line input

When you start a program by using `python3`, you give it the name of the file to start. You can also give it a set of arguments: data that the program will have access to when running. Here's how that can look:

```bash
python3 backup.py 2023-01-01
```

In the preceding code, the string "2023-01-01" can be used as instruction to the program *backup.py* to start a backup from that date. What you gain by using command-line arguments is flexibility. The program can behave differently depending on its outside input.

### Command-line arguments

How are these commands captured on the coding side of things? By using the `sys` module, you can retrieve the command-line arguments and use them in your program. Look at the following code:

```python
import sys

print(sys.argv)
print(sys.argv[0]) # program name
print(sys.argv[1]) # first arg
```

`sys.argv` is an array or a data structure that contains many items. The first position, denoted as `0` in the array, contains the program name. The second position, `1`, contains your first argument. Assume that the program *backup.py* contains the sample code and you run it like this:

```console
python3 backup.py 2023-01-01
```

The program then yields the following result:

```output
['backup.py', '2023-01-01'] 
backup.py
2023-01-01
```

## User input

Another way to pass data to the program is having the user enter the data. You can code it so the program tells the user to enter information. You save that entered data in the program and then act on it.

To capture information from the user, you'll use the `input()` function. Here's an example:

```python
print("Welcome to the greeter program")
name = input("Enter your name: ")
print("Greetings " + name)
```

Assume that the program *input.py* contains the sample code and you run it like this:

```console
python3 input.py
```

Running the program invites you to enter your name, for example:

```output
Welcome to the greeter program
Enter your name: 
```

After you enter a value and press **Enter**, the greeting is returned:

```output
Welcome to the greeter program
Enter your name: Picard
Greetings Picard
```

### Working with numbers

The `input()` function stores a result as a string, so the following code might not do what you want it to:

```python
print("calculator program")
first_number = input("first number: ")
second_number = input("second number: ")
print(first_number + second_number)
```

Running this program invites you to input the first number, let's say `3`:

```output
calculator program
first number: 3
```

After you press **Enter**, you can enter the second number, let's say `4`:

```output
calculator program
first number: 3
second number: 4
```

Pressing **Enter** give you the following result:

```output
calculator program
first number: 3
second number: 4
34
```

You probably meant for this program to answer you with `7` instead of `34`. So what went wrong?

The explanation is that `first_number` and `second_number` are strings. For the calculation to work correctly, you need to change those strings to numbers by using the `int()` function. By modifying the last line of the program to use `int()`, you can resolve the problem:

```python
print(int(first_number) + int(second_number))
```

Rerunning the program with the same values now returns `7` as the response:

```output
calculator program
first number: 3
second number: 4
7
```
