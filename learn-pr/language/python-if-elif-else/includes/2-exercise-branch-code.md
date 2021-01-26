Using the `if ... elif ... else` statement is a vital part of building virtually any meaningful program. You can use it to automate complicated decision logic so that it can be applied repeatedly and consistently to your user input or data.

When you use the term *code logic* or *decision logic*, you're referring to our ability to imbue your program with the ability to make a decision based on inputs. Based on the decision, you can instruct the Python interpreter to run some code and skip over other code.

In this exercise, to branch the execution of your code depending on a Boolean expression, you'll use the `if` statement, along with optional `elif` and `else` statements.

A *Boolean expression* is any code that returns a *Boolean value*. A Boolean value is either `True` or `False` and is its own data type in Python, just like `str` and `int`.

In this exercise, you'll use a Boolean expression to evaluate whether two values are equal. In the next unit, you'll learn how to create more expressive Boolean expressions and work with functions that return a Boolean value.

Let's start with a simple example of an `if` statement.

### Step 1: Create a new working folder and python code file

Using the techniques you learned in previous modules, create a new folder for your work in this module. For example, you might create a folder named `python-if`.

Inside that folder, create a file for this exercise. For example, you might create a file named `exercise1.py`.

When it's time to run your code, to use the Python Tools for Visual Studio Code integration, select the green arrow. Or, you can use a command in the integrated terminal by using techniques you learned about in previous modules.

### Step 2: Add an `if` statement to the new code file

Add the following code to your code file.

    ```python
    value = '7'
    
    if value == '7':
        print('The value is 7')
    
    print('Finished!')
    ```

There are three parts to the `if` statement:

- The `if` keyword
- The Boolean expression `value == '7'`
- The required colon `:` character

What comes next is just as important. The next line must contain a code block that runs if the Boolean expression evaluates to `True`. In Python, a code block is defined by using indentation. In this case, we used the <kdb>Tab</kbd> key to insert four individual spaces. This indentation tells the Python interpreter that this code *belongs to* the `if` statement and should run when the Boolean expression evaluates to `True`.

If the Boolean expression evaluates to `False`, all of the indented code should be ignored by the Python interpreter.

When you run the code, you should see the following output.

    ```output
    The value is 7
    Finished!
    ```

To see how this code operates when the Boolean expression evaluates to `False`, modify the first line of code setting `value` to the string `'6'`.

    ```python
    value = '6'
    ```

When you run the code, you'll see the following output.

    ```output
    Finished!
    ```

The line of code beneath the `if` statement is ignored because the Boolean expression evaluates to `False`.  The final line of code that prints the term `Finished` runs because it isn't indented beneath the `if` statement.

### Step 3: Add a tab character to the last line of code to understand the importance of indentation

Let's see what happens when you add indentation to the final line of code.

To modify the last line of code, add a tab before the line. Your code should match the following output.

    ```python
    value = '6'
    
    if value == '7':
        print('The value is 7')
    
        print('Finished!')
    ```

When you run the code this time, there's no output. That's because the last line of code is now part of the same code block that belongs to the `if` statement.

Indentation defines a code block in Python. A code block consists of one or more lines of code that are treated as a unit of work. The code block is only executed based on the statement above it, which is the `if` statement in this case. You'll come across code blocks often in Python as you learn about new constructs like loops, functions, classes, and more.

Python is picky when it comes to indentation. All lines must be indented at an equal level. If they're not, Python displays an exception when you run the code. If you remove a single empty space character before the last line of code.

    ```python
    value = '6'
    
    if value == '7':
        print('The value is 7')
    
       print('Finished!')
    ```

And then attempt to run the code again, you'll see the following error.

    ```output
      File "exercise1.py", line 6
        print('Finished!')
                         ^
    IndentationError: unindent does not match any outer indentation level
    ```

### Step 4: Update the code example to include an `else` statement

The `else` statement is an optional part of an `if` statement that can handle the opposite case. In other words, when the Boolean expression in the `if` statement evaluates to `False`, run the code block that belongs to the `else` statement instead.

Update your code to match the following code passage. In addition to adding the `else` statement, notice that you removed the tab from the last line of code.

    ```python
    value = '6'
    
    if value == '7':
        print('The value is 7')
    else:
        print('The value is not 7') 
    
    print('Finished!')
    ```

If you run the code, you'll see the following output.

    ```output
    The value is not 7
    Finished!
    ```

There are two parts to the `else` statement:

- The `else` keyword
- The colon `:` keyboard symbol

As before, the code block following the `else` statement is just as important. All indented lines of code below the `else` statement become part of its code block and are executed with the Boolean expression if the `if` statement evaluates to `False`.


### Step 5: Update the code example to include an `elif` statement

The `elif`, or rather, *else if* statement is another optional statement that can be added below an `if` statement. To test another related Boolean expression, use the `elif`statement. If that Boolean expression evaluates to `True`, the indented code below it runs. All code blocks that belong to other `if`, `elif`, and `else` statements are ignored.

To match the following code listing, modify the following code example.

    ```python
    value = '8'
    
    if value == '7':
        print('The value is 7')
    elif value == '8':
        print('The value is 8')
    else:
        print('The value is not one we are looking for')
    
    print('Finished!')
    ```

Just like the `if` statement, there are three parts to the `elif` statement:

- Must begin with the keyword `elif`.
- Must include a Boolean expression.
- Must terminate by using a colon `:` keyboard symbol.

And just as before, all indented code below the `elif` is part of the code block that runs if the Boolean expression evaluates to `True`.

When you run the code, you'll see the following output.

    ```output
    The value is 8
    Finished!
    ```

You can use as many `elif` statements as you need. If you use an `else` statement, it must come after all `elif` statements.

To include an additional `elif` statement before the `else` statement, modify your code.

    ```python
    value = '8'
    
    if value == '7':
        print('The value is 7')
    elif value == '8':
        print('The value is 8')
    elif value == '9':
        print('The value is 9')
    else:
        print('The value is not one we are looking for')
    ```

After any `if` or `elif` Boolean expression evaluates to `True`, the Python interpreter won't continue evaluating additional Boolean expressions. It exits the entire `if ... elif ... else` structure and continues to process the next line of code that isn't indented.

### Be aware of overlapping Boolean expressions

Consider the following code.

    ```python
    value = '6'
    
    if value < '8':
        print('The value is less than 8')
    elif value < '7':
        print('The value is less than 7')
    else:
        print('The value is greater than 8')
    ```

First, you've introduced a new operator, which you'll learn more about in the next unit. The less-than operator `<` compares two numeric values. If the value on the left is less than the value on the right, the expression evaluates to `True`. Otherwise, it evaluates to `False`.

Can you spot the problem with the `if` and `elif` statements? Look closely and think through how this code will work.

The problem is that the `elif` statement will never execute because any `value` that would be `True` for the `if` statement will also be `True` for the `elif` statement. As a result, the execution path will never get to the `elif`.

This scenario would likely never manifest in a runtime error. If you were expecting to handle these differently, you would have introduced a subtle logic error into your app. You would need to swap the Boolean expressions between the `if` and the `elif` to fix the issue. It's always useful to test your app with multiple inputs to make sure you get the intended result.

### Nested `if` code blocks

Consider the following code example.

    ```python
    first_value = True
    second_value = '6'
    
    if first_value:
        if second_value == '6':
            print('Got here!')
    ```

Here, you evaluate two separate data values. First, you test the value of `first_value`. Because a Boolean expression is any code that equates to `True` and `first_value` equates to `True` already, you don't need to type the entire Boolean expression like so.

    ```Python
    if first_value == True:
    ```

Secondly, and more pertinent to this code example, is the nesting of the second `if` statement inside the code block of the first `if` statement. As a result, the second `if` statement is evaluated only when the first `if` statement evaluates to `True`.

This nesting structure is common when you need to test several related (but different) data values before you perform some operation.

If you remove the proper indentation.

    ```python
    first_value = True
    second_value = '6'
    
    if first_value:
    if second_value == '6':
        print('Got here!')
    ```

... it's likely you would see the following error message.

    ```output
      File "c:/python/numeric-operations-decisions/exercise2.py", line 65
        if second_value == '6':
        ^
    IndentationError: expected an indented block
    ```

## Recap

You learned about some crucial ideas in this unit:

- Use the `if` statement to evaluate a Boolean expression. If the expression evaluates to `True`, the code block beneath the `if` statement runs by the Python interpreter. Otherwise, it's ignored.
- A code block is one or more indented lines of code. The code block *belongs to* the `if` statement and runs or is ignored based on the evaluation of the Boolean expression. Accidentally indenting (or not indenting) lines of code will undoubtedly affect how your code operates and might even produce errors. All indentation must use the same number of space characters or the Python interpreter will raise an error.
- Add an optional `else` statement when you want to execute code that's only relevant if the Boolean expression evaluates to `False`. Otherwise, it's ignored.
- Add an optional `elif` after the `if` statement (but before the `else` statement, if it exists) to evaluate a second and subsequent Boolean expression. Just like the `if` statement, the indented code block beneath it runs if the Boolean expression evaluates to `True`. Otherwise, it's ignored.
- When you use the `if` statement along with one or more `elif` statements and the `else` statement, once a Boolean expression is satisfied, no other statements are evaluated. As a result, the order in which you perform your evaluations could be important.
- You can nest `if` statements if you need to check for related (but different) conditions before you perform some operation.