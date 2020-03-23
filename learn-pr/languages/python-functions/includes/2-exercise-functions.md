A function is a block of code with a name. Since it has a name, your program can call it from another location in your code. The execution path flows into that block of code. After the function execution is complete, the execution path returns to the line of code that called the function and continues on.

Functions provide a basic building block for creating modular code. Such code is more easily reused within your entire program. As you'll learn later, functions can be separated into modules for greater portability and use in other programs.

## When should I use a function?

When you're just starting, you likely write all of your code in a single script file. Everyone learning Python has done this. But after your code grows to 50 lines or more, you'll find that it becomes difficult to understand and difficult to change.

Python function help alleviate some of those challenges.

First, use functions to keep your program understandable. Each function should contain a single task or responsibility in your program. Ideally, each function is short. Some developers suggest a function should be about six lines of code. If a function grows larger than that, consider that it might be taking on too much responsibility. Keeping functions short and focused helps you and others understand your code more quickly.

Second, use functions to keep your program manageable. If you need to update some functionality of your program, you simply find the functions that implements that functionality and update them. Using a good name for each function helps you quickly find the functions you need to update in the midst of thousands of lines of code.

Third, use functions to keep your program more easily written. To compose an entire app, have that app call functions as needed from a main function in your app's logic. (A main function is sometimes called a controller or manager.) Such a design helps you both understand the flow of the app's execution path and update your program.

Fourth, use functions to keep parts of your program reusable. If you are rewriting a passage of code multiple times in a program, you might want to extract that code into a function and then have your program call the function from everywhere you need it. If there's a problem in that code or if it needs some other change, you can update the code in one spot rather than searching for it everywhere. If you're copying and pasting code, you might consider that you have an opportunity to create a function.

So when should you use a function? Anytime you begin building a nontrivial program. Functions help you encapsulate functionality in one place, compose your program, update your code, and add new features.

## What you'll build in this exercise

In this exercise, you'll learn how to create and call functions, return values from functions, and supply arguments as input parameters to functions.

### Step 1 - Create a new working folder and Python code file

Using the techniques you learned in previous modules, create a new folder for your work in this module. For example, you might create a folder named python-functions.

Inside that folder, create a file for this exercise. For example, you might create a file named exercise1.py.

When you're ready to run your code, you can use the integrated Python tools for Visual Studio Code by selecting the green arrow. Or you can use a command in the integrated terminal with techniques you learned in previous modules.

### Step 2 - Add code to the code file to create and call a simple function

Add the following code to your new code file. The code creates the simple function `say_hello()` then calls the function.

```python
def say_hello():
  print('Hello World!')

say_hello()
```
Here your created your first function. The function has five parts:

- The `def` keyword
- A function name. The name should follow the same naming rules you use for variables.
- The `()` symbols. Input parameters are defined within these parentheses.
- The `:` symbol to terminate the function's signature.
- A code block below the signature. This block is the body of the function. It is run when the function is called.

Below the function's code block, the function is called by its name `say_hello` and the method invocation operator `()`.

After this code runs, you should see the following output:

```output
Hello World!
```

The other critical part of defining and calling functions is the location of both the definition and the call. The function definition must appear before the function call. The following code is trouble because it tries to call the function before defining it:

```python
say_hello()

def say_hello():
  print('Hello World!')
```

If you run the code, you'll see the following error:

```output
NameError: name 'say_hello' is not defined
```

### Step 3 - Update the code from the previous step and add code to accept an input parameter

Next, create a new version of your function that's a bit more useful. Change the code from the previous step into the following code:

```python
def say_hello(name):
  print(f'Hello {name}!')

say_hello('Bob')
```

This version of the function is more useful because it lets the caller specify who to say `Hello` to. To do this, the caller to passes in a name as an argument to the `say_hello()` function. 

We define the `say_hello()` function as we did before, however between the set of parentheses `()` we specify the input parameter `name`. This allows the caller to pass an argument into our function, then we use that value in the body of our function via the variable `name`.

When calling the method, we input a string `'Bob'` that we pass as an argument into the `say_hello()` function.

When you execute the code, you should see the following output:

```
Hello Bob!
```

### Step 4 - Modify the function call to leave out the argument

The way we've defined our function makes the argument required.

Update the code to modify the function call removing the string that is passed as an argument. The call should now match the following code listing:

```python
say_hello()
```
When you execute the code, you should see the following output:

```output
TypeError: say_hello() missing 1 required positional argument: 'name'
```
When you define an input parameter as part of your function, it is required. However, you can make it optional by supplying a default value that should be used if the caller doesn't pass an argument.

Update the code example again, this time updating the input parameter definition to set a default value, and then add a second call to `say_hello()` to call the function with and without an input parameter. Your code should match the following listing:

```python
def say_hello(name='World'):
  print(f'Hello {name}!')

say_hello()
say_hello('Bob')
```
The first call to `say_hello()` will utilize the default value of the input parameter, while the second call to `say_hello()` supplies its own value.

When you execute the code, you should see the following output:

```output
Hello World!
Hello Bob!
```

### Step 5 - Update the code example to include a second (optional) input parameter

Functions can be defined to allow many input parameters. To define another input parameter, just separate each parameter with a comma symbol `,` .

We can also use the value `None` when defining the default value for an input parameter. This allows us to check for the value `None` in the body of the function to print the message accordingly.

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
When you execute the code, you should see the following output:

```output
Hello World!
Hello Bob!
Howdy World!
Howdy Bob!
```

Here we add the `greeting` input parameter, setting its default value to `None`. This is a special keyword that represents the `NoneType` object. If you were to execute this line of code:

```python
print(type(None))
```
You would see the following output:

```output
<class 'NoneType'>
```
`None` represents an unknown or indeterminate value. It's not the same as an empty string, the Boolean value `False`, the number `0` or any other value. The value just isn't there, and in this case, it's the perfect way to represent a value that doesn't exist so we can modify our function's implementation to adjust to it.

In this step, we added two new calls to `say_hello`:

```python
say_hello(greeting='Howdy')
say_hello('Bob', 'Howdy')
```

The first new call relies on the default value for `name` by skipping over it and instead specifying the parameter name `greeting` and settings its value with the assignment operator `=`.

The second new call passes both arguments into the function.

As you can see, there are many variations you can use to create and utilize input parameters in your functions.

### Step 6 - Comment out the code from the previous steps and add a new function that returns a value

Now that we've learned about defining input parameters, let's create a function that returns a value. In other words, you can return a single value from a function by using the `return` keyword.

Comment out the code from the previous steps and add the following code listing:

```python
def add_two_numbers(x, y):
    return x + y

add_two_numbers(4, 6)
result = add_two_numbers(5, 7)
print(result)
```
When you execute the code, you should see the following output:

```output
12
```
Here we create a new function `add_two_numbers()` that accepts two input parameters. It then performs an addition operation on those two input parameters in the body of the function and returns the sum.

When calling the function, you can choose to ignore the returned value (although in this case, that doesn't seem useful), or you can assign a variable to the value returned by the function. Once you have the returned value, you can use it just like any other variable in your program.

### Step 7 - Comment out the code from the previous steps and add a new function that returns a list

While you can only return a single value from a function, that value could be a list containing other values.

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
You may recognize this code from an earlier module. This code will generate each of 52 cards by combining every suit and rank from a typical deck of cards. After generating each combination of suit and rank, it appends the string to an empty list named `deck` and returns that list.

When you execute the code, you should see the following output:

```output
52
```

### Step 8 - Comment out the code from the previous steps and add a new function that demonstrates variable scope in a function

Scope refers to the accessibility of a value inside and outside of a code structure like a function's code block. This step of the exercise will help us understand the scope of variables declared inside a function as well as a variable outside of a function.

Comment out the code from the previous step and add the following code listing:

```python
def some_function():
    value = 10

print(value)
```
In this first version of our code, we define a variable named `value`, but do not return the value. Instead, we just want to see if we can access `value` outside of the code block.

When you execute the code, you should see the following output:

```output
NameError: name 'value' is not defined
```
When attempting to access `value` outside of the code block in which it was declared and initialized, it is hidden and unavailable outside of the code block.

What if we create a variable of the same name outside of the function's code block, then attempt to use -- even return it -- from inside of the function's code block.

Update the exercise code to match the following code listing:

```python
value = 1

def some_function():
    value = 10
    return value

print(value)
```

Here we set `value` to `1`. Inside `some_function()`, we attempt to use the same variable name and set the value to `10`. We can even try to return the new `value`. What happens when we print `value`?

When you execute the code, you should see the following output:

```output
1
```
You might think this makes sense, since we never executed `some_function()`, it never had a chance to activate. Let's continue the experiment to actually call `some_function()` and see if that changes `value`.

Update the exercise code to match the following code listing:

```python
value = 1

def some_function():
    value = 10
    return value

print(value)
some_function()
print(value)
```
Now we're printing `value` before and after we call `some_function()`.

When you execute the code, you should see the following output:

```output
1
1
```
The moral of the story is that the variables you define outside of a function have no impact on the variables you define inside a function unless you return the value and then use it. In other words, the scope of a function's variables is sealed off and hidden from the code outside of the function, and vice versa.

## Recap

In this exercise, we learned about functions:

- A function is a code block with a name. You can define your own functions and use them as a unit of modularity and reusability in your program. You should think of a function as having a single responsibility in your program, and if it starts doing more than that job, perhaps its time to split the function in two.
- Use the `def` keyword to define a function. Create a name for the function using the same naming rules that you learned for variables. Use a set of parentheses to define input parameters.
- You can define a function with zero to many input parameters. Separate each input parameter with a comma symbol `,`. A parameter is required unless you provide an optional default value.
- Use the `None` keyword to indicate that the variable has an indeterminate or unknowable value.
- Scope is the visibility of a value inside and outside of a code block. Functions have their own scope that is private and hidden from code outside of the function.