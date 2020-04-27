The first step in writing object-oriented code is writing the classes from which objects will be created. In this unit, you create a class in Python, and then use the class to instantiate an object.

The term "instantiate" is a fancy way of saying that Python uses the class to create an object by allocating memory for the object and copying the object's code and data into memory. Just as you use a blueprint to create a house or a recipe to create a cookie, Python uses classes to create objects.

To run your Python code, you will use Azure Cloud Shell to your right. Python comes preinstalled on Azure Cloud Shell so there's nothing we need to configure.

## Objects in Python

Everything is an object in Python. When you create a variable and assign it a number, Python creates an instance of a built-in class. When you create a variable and assign it a string, Python again creates an instance of a built-in class, although a different one.

Before you begin writing classes of your own, it's helpful to peek under the hood and understand how Python itself uses objects.

First, we will start the Python interpreter in Cloud Shell to look at some objects.

1. In Cloud Shell to the right, enter the following command to start the Python interpreter:

    ```bash
    python3
    ```

1. You should see the following output, which lets you know that the Python interpreter is running:

    ```output
    Python 3.5.2 (default, Oct  8 2019, 13:06:37)
    [GCC 5.4.0 20160609] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    ```

1. Now, enter or paste the following code into the running Python interpreter:

    ```python
    print(type(1))
    print(type("Hello There!"))
    print(type(1.1))
    print(type(True))
    ```

    The `print()` function writes output to the screen. The `type()` function shows an object's underlying class.

1. You should see output that looks like this:

    ```output
    >>> print(type(1))
    <class 'int'>
    >>> print(type("Hello There!"))
    <class 'str'>
    >>> print(type(1.1))
    <class 'float'>
    >>> print(type(True))
    <class 'bool'>
    ```

    The output shows that 1 is an instance of Python's built-in `int` (integer) class. "Hello There!" is a `str` (string).

    Notice that Python uses different classes for 1 and 1.1. 1.1 is a `float`, not an `int`. If something has a truth value, True or False, it relies on the `bool` class.

    You could easily test other kinds of data (feel free to experiment!) but be assured that any sort of data you try has an associated class, whether it's one that is built into Python or one that you have written yourself.

1. All classes have methods associated with them. Enter the following code, and then press Enter:

    ```python
    print(dir(1))
    ```

1. You should see this output:

    ```output
    ['__abs__', '__add__', '__and__', '__bool__',
    '__ceil__', '__class__', '__delattr__', '__dir__',
    '__divmod__', '__doc__', '__eq__', '__float__',
    '__floor__', '__floordiv__', '__format__', '__ge__',
    '__getattribute__', '__getnewargs__', '__gt__',
    '__hash__', '__index__', '__init__', '__int__', 
    '__invert__', '__le__', '__lshift__', '__lt__',
    '__mod__', '__mul__', '__ne__', '__neg__', '__new__',
    '__or__', '__pos__', '__pow__', '__radd__', '__rand__',
    '__rdivmod__', '__reduce__', '__reduce_ex__',
    '__repr__', '__rfloordiv__', '__rlshift__', '__rmod__',
    '__rmul__', '__ror__', '__round__', '__rpow__',
    '__rrshift__', '__rshift__', '__rsub__', '__rtruediv__',
    '__rxor__', '__setattr__', '__sizeof__', '__str__',
    '__sub__', '__subclasshook__', '__truediv__',
    '__trunc__', '__xor__', 'bit_length', 'conjugate',
    'denominator', 'from_bytes', 'imag', 'numerator',
    'real', 'to_bytes']
    ```

    This confusing list is all the `int` object's methods. The `dir()` function provides a list of attributes and methods for whatever you put in the parentheses.

    When you work with Python, you might hear methods referred to as *functions*. In Python, the two terms, *methods* and *functions*, are synonymous. But you can avoid confusion when talking with other people about Python by calling them *methods*.

    All the entries you see in the output list are methods. A method represents an action that you can perform on an object. For example, `to_bytes()` outputs the object value in byte format, which is just a specific way of looking at the data.

    Notice the `__str__` method in the list. This method turns a value into a `str` type. An object's type is simply the class it was created from. So the type of 1 is `int`.

1. Run the following code:

    ```python
    myVar = 1
    print(type(myVar.__str__()))
    ```

    The first line of code is an assignment. You're assigning the value `1` to an object named `myVar`. The `myVar` object now has an attribute: the value 1.

    The second line of code calls the `__str__()` method that is part of the `int` class, and therefore present in the `myVar` object.

    What does the output from the code tell you?

The `__str__()` method created a new object from `myVar` of type `str`. The `myVar` object is still the same, untouched; it's still of type `int`. The new object, which doesn't have a name because you haven't assigned it one, is of type `str`.

## Define a class

Python has several built-in classes, including `int`, `float`, `bool`, and `str`, but you can also define classes of your own. Defining your own classes is the main objective in OOP.

Every Python class you create begins with the word `class`. A class needs a name, and it also needs to do something.

Let's begin with something simple: Tell the user that the class has been created. In the real world, you wouldn't actually create a class like this, but it's helpful for learning incrementally.

Let's open Cloud Shell's built-in code editor to make our first class.

1. First, enter or paste the following code to stop the Python interpreter:

    ```python
    quit()
    ```

1. Now, enter the following code to create a new Python file and open it:

    ```bash
    code MyClass.py
    ```

1. Enter the following code in the open file above Cloud Shell:

    ```python
    class MyClass:
        print('MyClass created!')
    ```

    The command creates the simplest class you can create. It contains the bare essentials needed to create a class:

    - The keyword `class`
    - The class name ("myClass")
    - A colon marking the end of the `class` statement

    Notice that the next line is indented. The indentation is important! Python uses indentation to indicate structure. In this case, the `print()` statement is part of `myClass`.

1. To save your file, select the three dots in the upper-right corner, or press Ctrl+S (or Command+S on a Mac).

    ![Save the file in the Cloud Shell editor](../media/save-file.png)

1. Use this command to run the code you wrote:

    ```bash
    python3 MyClass.py
    ```

1. You should see this output:

    ```output
    MyClass created!
    ```

The output proves that the class was created (not that it was instantiated). The `print()` function executes during the creation process. Normally, you wouldn't use a `print(`) statement this way, but in this case, it helps to see how class creation works.

## Instantiate a class

At this point, you have a basic (and nearly useless) class, but it serves to show how a class is defined. Now, let's create an object from the class.

1. Add the following statement to the bottom of the file:

    ```python
    myVar = MyClass()
    ```

    > [!NOTE]
    > Be sure to use proper Python indentation. This line should not be indented at all. This line is at the same level as `class MyClass:` in the preceding exercise.

    This line creates an object named `myVar` from the class named `myClass`. Notice the parentheses after `myClass`. The parentheses tell Python to create an instance of the class without passing any parameters to it.

1. Now, add the following statements to the end of the file to prove that the object was created:

    ```python
    print(type(myVar))
    print(dir(myVar))
    ```

1. Save the file, and then run your code again by using the same command that you used earlier:

    ```bash
    python3 MyClass.py
    ```

    The output shows that the type of `myVar` is `__main__.myClass`. `__main__` is the scope in which this code is executing.

    A scope is a kind of logical grouping that holds pieces of code together.

    You don't see a scope for the `int` type because `int` is defined outside the scope of the current application. You see `__main__` for `myClass` because you defined `myClass` in the current application. It's the default scope, but you don't need to worry about it for now. The important takeaway, for the moment, is that `myVar` is an instance of the `myClass` class.

Notice that you get default methods with your new class. Python provides a class with these default methods for performing essential tasks. These methods aren't all that important right now, but it's a good idea to know that they exist. As you continue with this module, this information will become more relevant.
