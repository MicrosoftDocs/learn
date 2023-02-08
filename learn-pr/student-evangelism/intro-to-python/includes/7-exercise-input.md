In this exercise, you'll learn to build a calculator. A calculator takes input and presents the result on the screen. After activating the sandbox, **refresh the page** to restart the Cloud Shell console.

1. Start the REPL by typing `python` in the Cloud Shell console:

   ```python
   python
   ```

    You should see output that looks similar to:

    ```output
    Python 3.9.14 (main, Oct 29 2022, 22:18:10)
    [GCC 11.2.0] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    ```

1. Copy and paste the following code into the REPL:

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

   The characters `;\`, at the end of the first two statements signal that there are many lines of code. Using these characters lets you input all of the code, line by line. The code also runs, and as you can see, asks you for the first input.

1. Complete the first input by typing **2** and pressing <kbd>ENTER</kbd>.

   You should see the following output:

   ```output
   Type the first number: 2
   Type the second number:
   ```

1. Now, complete the second input by typing **3** and pressing <kbd>ENTER</kbd>.

   You should see the following output:

   ```output
   Type the second number: 3 
   The sum is:  5
   >>> 
   ```

Congratulations, you've created a calculator program.
