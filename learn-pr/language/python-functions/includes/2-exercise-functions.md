A function is a block of code with a name. Since it has a name, your program can call it from another location in your code. The execution path flows into that block of code. After the function execution is complete, the execution path returns to the line of code that called the function and continues.

Functions provide a basic building block for creating modular code. Such code is more easily reused across your entire program. As you'll learn later, you can separate functions into modules for greater portability and use in other programs.

## When should I use a function?

When you're just starting a new program, you'll likely write all your code in a single script file. Everyone has written code this way. But after your code grows to 50 lines or more, it becomes difficult to understand and change.

Python functions help lessen some of those challenges.

First, use functions to keep your program understandable. Each function should contain a single task or responsibility in your program. Ideally, each function is short. Some developers suggest a function should be about six lines of code. If the number of lines grows larger, perhaps the function is taking on too much responsibility. Keeping functions short and focused helps you and others understand your code more quickly.

Second, use functions to keep your program manageable. If you need to update some functionality of your program, you find the functions that implement that functionality and update them. Using a good name for each function helps you quickly find the functionality you need among thousands of lines of code.

Third, use functions to keep your program more easily written. To compose an entire app, have that app call functions as needed from a main function in your app's logic. (A main function is sometimes called a controller or manager.) Such design helps you understand the flow of the app's execution path and helps you update your program or add new functionality.

Fourth, use functions to keep parts of your program reusable.

- If you're rewriting a passage of code multiple times in a program, you might want to extract that code into a function. Your program would then call the function from everywhere you need it.
- If the code has a problem or needs some other change, you can update it in one spot rather than search for it everywhere.
- If you're copying and pasting code, you might consider that you have an opportunity to create a function.

So when should you use functions? Anytime you begin to build a nontrivial program. Functions help you encapsulate functionality in one place, compose your program, update your code, and add new features.

## What you'll build in this exercise

In this exercise, you'll learn how to create and call functions, return values from functions, and supply arguments as input parameters to functions.

### Step 1 - Create a new working folder and Python code file

Using the techniques you learned in previous modules, create a new folder named python-functions for your work in this module. Inside that folder, create a new file named exercise1.py for this exercise.

When you're ready to run your code, you can use the integrated Python tools for Visual Studio Code by selecting the green arrow. Or you can use a command in the integrated terminal with techniques you learned in previous modules.

### Step 2 - Add code to the code file to create and call a small function

Add the following code to your new code file. The code defines the simple function `say_hello()` then calls the function.

```python
def say_hello():
  print('Hello World!')

say_hello()
```

Here you created your first function. The function has five parts:

- The `def` keyword.
- A function name. It should follow the same naming rules you use for variables.
- A pair of parentheses symbols (`()`). Input parameters are defined within these parentheses.
- A colon symbol (`:`) to end the function's signature.
- A code block below the signature. This block is the body of the function. It runs when the function is called.

Below the function's code block, the function is called by using its name `say_hello` and the method invocation operator (`()`).

When you run the code, you should see the following output:

```output
Hello World!
```

The other critical part of defining and calling functions is the location of the function definition and the function call. The definition must appear before the call. The following code is trouble because it tries to call the function before defining it:

```python
say_hello()

def say_hello():
  print('Hello World!')
```

If you ran the code, you'd see the following error:

```output
NameError: name 'say_hello' is not defined
```

### Step 3 - Update the code from the previous step and add code to accept an input parameter

Next, create a new version of your function that's a bit more useful. Change the code from the previous step into the following code listing:

```python
def say_hello(name):
  print(f'Hello {name}!')

say_hello('Bob')
```

This version of the function is more useful because it lets the caller specify who to say "Hello" to. To specify a name, the caller passes it as an argument to the `say_hello()` function.

Define the `say_hello()` function as you did before. But between the parentheses (`()`), specify the input parameter `name`. This parameter lets the caller pass an argument to the function. The function then uses that value in its body via the variable `name`.

When called, the function receives the string `'Bob'` that was passed as an argument to the `say_hello()` function.

When you run the code, you should see the following output:

```
Hello Bob!
```

### Step 4 - Modify the function call to leave out the argument

Because of how you defined your function, an argument is required.

Update the code by removing the string that is passed as an argument. The call should now match the following code listing:

```python
say_hello()
```

When you run the code, you should see the following output:

```output
TypeError: say_hello() missing 1 required positional argument: 'name'
```

When you define an input parameter as part of your function, an argument is required. You can make the argument optional by supplying a default value that is used if the caller doesn't pass an argument.

Update the code example again. This time, change the input parameter definition to set a default value, and then add a call to `say_hello()`. The code calls the function both with and without an input parameter. Your code should match the following listing:

```python
def say_hello(name='World'):
  print(f'Hello {name}!')

say_hello()
say_hello('Bob')
```

The first call to `say_hello()` uses the default value of the input parameter, while the second call supplies its own value.

When you run the code, you should see the following output:

```output
Hello World!
Hello Bob!
```

### Step 5 - Update the code example to include a second optional input parameter

Function definitions can have multiple input parameters. To define them, separate each pair of parameters with a comma symbol (`,`).

You can also use the value **None** when defining the default value for an input parameter. This use lets a function check for the value **None** in its body and print an appropriate message.

Update the exercise code to match the following code listing:

```python
def say_hello(name='World', greeting=None):
  if greeting == None:
    print(f'Hello {name}!')
  else:
    print(f'{greeting} {name}!')

say_hello()
say_hello('Bob')
say_hello(greeting='Howdy')
say_hello('Bob', 'Howdy')
```

When you run the code, you should see the following output:

```output
Hello World!
Hello Bob!
Howdy World!
Howdy Bob!
```

Here you added the `greeting` input parameter and set its default value to `None`. This value is a special keyword that represents the **NoneType** object.

Run this line of code:

```python
print(type(None))
```
You should see the following output:

```output
<class 'NoneType'>
```

**None** represents an unknown or indeterminate value. It's not the same as an empty string, the Boolean value **False**, the number zero, or any other value. The value just isn't there. In this case, **None** is the perfect way to represent a value that doesn't exist so that your function can test for it.

In this step, you added two new calls to `say_hello`:

```python
say_hello(greeting='Howdy')
say_hello('Bob', 'Howdy')
```

The first new call skips over `name` and relies on its default value. The call also specifies the parameter name `greeting` and sets its value with the assignment operator (`=`).

The second new call passes both arguments into the function.

As you can see, there are many variations available to create and use input parameters in your functions.

### Step 6 - Comment out the code from the previous steps and add a new function that returns a value

Now that you've learned about defining input parameters, create a function that returns a single value by using the **return** keyword.

Comment out the code from the previous steps and add the following code:

```python
def add_two_numbers(x, y):
    return x + y

add_two_numbers(4, 6)
result = add_two_numbers(5, 7)
print(result)
```

When you run the code, you should see the following output:

```output
12
```

Here you created the new function `add_two_numbers()` that accepts two input parameters. It then does an addition operation on those parameters in the function body and returns the sum.

You call the function twice.  The first time you call it, you pass `4` and `6` as arguments, however you ignore the returned value.  In other words, you do not capture it in a variable, print the value, and so on.  When writing a function call, you can ignore the returned value. (Although in this case, that doesn't seem useful.) 

The second time you call `add_two_numbers()`, you pass `5` and `7` as input parameters.  This time, you capture the return value by assigning it to a variable called `result` which can be used in the remainder of the program.

### Step 7 - Comment out the code from the previous steps and add a new function that returns a list

While you can return only a single value from a function, that value can be a list that contains multiple other values.

Comment out the code from the previous step and add the following code listing:

```python
def create_deck():
  suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
  ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
  deck = []

  for  suit in suits:
    for rank in ranks:
      deck.append(f'{rank} of {suit}')

  return deck

my_deck = create_deck()
print(len(my_deck))
```

You might recognize this code from an earlier module. This code generates 52 cards by combining every suit and rank from a typical deck of cards. As the function generates each combination, it appends the string to an empty list named `deck`. The function returns that list.

When you run the code, you should see the following output:

```output
52
```

### Step 8 - Comment out the code from the previous steps and add a new function that demonstrates variable scope in a function

Scope is a value's accessibility inside and outside a code structure like a function's code block. This step of the exercise will help you understand the scope of variables declared both inside and outside a function.

Comment out the code from the previous step and add the following code listing:

```python
def some_function():
    value = 10

print(value)
```

This first version of your code defines a variable named `value` but doesn't return `value`. Instead, you just want to see if your code can access `value` outside the function's code block.

When you run the code, you should see the following output:

```output
NameError: name 'value' is not defined
```

Your code can't access `value` outside the code block in which it was declared and initialized. The variable is hidden and unavailable outside the code block.

What if your code defines a variable of the same name outside the function's code block and then attempts to use or return it from inside the code block?

Update the exercise code to match the following code listing:

```python
value = 1

def some_function():
    value = 10
    return value

print(value)
```

Here your code sets `value` to `1`. Inside `some_function()`, the code uses the same variable name and sets the value to `10`. You can even try to have the function return the new `value` variable. But what happens when the code prints `value`?

When you run the code, you should see the following output:

```output
1
```

You might think this output makes sense. Because the code never ran `some_function()`, the function's body never had a chance to run.

Continue the experiment. Have the code actually call `some_function()` and see if that changes `value`. Update the exercise code to match the following code listing:

```python
value = 1

def some_function():
    value = 10
    return value

print(value)
some_function()
print(value)
```

Now the code prints `value` before and after it calls `some_function()`.

When you run the code, you should see the following output:

```output
1
1
```

The moral of the story: variables defined outside a function don't affect variables defined inside a function unless your code returns the inside value and then uses it. The scope of a function's variables is sealed off and hidden from code outside the function and the other way around.

## Recap

In this exercise, you learned about functions.

- A function is a code block with a name. You can define your own functions and use them as units of modularity and reusability. Think of a function as having a single responsibility. If a function starts doing more than one job, perhaps you should split the function.
- The **def** keyword defines a function. Create a name for the function using the same naming rules that you learned for variables. Use parentheses to define input parameters.
- A function has zero or more input parameters. Separate input parameters with commas. A parameter is required unless you provide an optional default value.
- The **None** keyword indicates that a variable has an indeterminate or unknowable value.
- Scope is the visibility of a value inside and outside a function's code block. Functions have their own scope that is private and hidden from code outside those functions.
