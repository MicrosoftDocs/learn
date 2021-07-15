In this exercise, you will learn to build a calculator. A calculator takes input and present the result on the screen.

1. Start the REPL by typing `python`:

   ```python
   python
   ```

    You should see output that looks similar to:

    ```output
    Python 3.5.2 (default, Nov 12 2018, 13:43:14)
    [GCC 5.4.0 20160609] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    ```

1. Copy the following code into the REPL, as is:

   ```python
   first_number = int(input('Type the first number: ')) ;\
   second_number = int(input('Type the second number: ')) ;\
   print("The sum is: ", first_number + second_number)
   ```

   You should see the following output:

   ```python
   >>> first_number = int(input('Type the first number: ')) ;\
   ...    second_number = int(input('Type the second number: ')) ;\
   ...    print("The sum is: ", first_number + second_number)
   Type the first number:
   ```

   The characters `;\`, at the end of the first two statements, signals that there are many lines of code and will let you input all of it, line by line. The code also runs and as you can see, asks you for the first input.

1. Complete the first input by typing first **2** and selecting <kbd>ENTER</kbd>.

   You should see the following output:

   ```output
   Type the first number: 2
   ```

1. Now, complete the second input, by typing **3** and selecting <kbd>ENTER</kbd>.

   You should see the following output:

   ```output
   Type the second number: 3 
   The sum is:  5
   >>> 
   ```

Congratulations, you've created a calculator program.