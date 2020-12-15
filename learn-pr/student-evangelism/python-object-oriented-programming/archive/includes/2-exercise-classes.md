The first step in writing object-oriented code is to define the classes from which objects are created. In this unit, you create a class in Python, and then use the class to instantiate an object.

The term *instantiate* is a fancy way of saying that Python uses the class to create an object. Python allocates memory for the object and then copies the object's code and data into memory. Just as you use a blueprint to create a house, or a recipe to create a cookie, Python uses classes to create objects.

To run your Python code, you use Azure Cloud Shell to your right. Python comes preinstalled on Azure Cloud Shell so there's nothing we need to configure.

## Objects in Python

Everything is an object in Python. When you create a variable and assign it a number value, Python creates an instance of a built-in class. If you create a variable and assign it a string value, Python again creates an instance of a built-in class, although a different one. 

Before you start to write classes of your own, it's helpful to peek under the hood and understand how Python itself uses objects.

First, we'll start the Python interpreter in Cloud Shell to look at some objects.

1. In Cloud Shell to the right, enter the following command to start the Python interpreter:

    ```bash
    python3
    ```

1. You should see the following output, which lets you know that the Python interpreter is running:

    ```output
    Python 3.5.2 (default, Jul 17 2020, 14:04:10)
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

    The `print()` method writes output to the screen. The `type()` method shows the class type for an object.

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

    The output shows that "1" is an instance of Python's built-in `int` (integer) class. "Hello There!" is an instance of the `str` (string) class.

    Notice that Python uses different classes for the numbers 1 and 1.1. A number with a decimal value like 1.1 is an instance of the `float` class, not an `int`. If something has a truth value: True or False, then it relies on the `bool` class.

    You can easily test other kinds of data--feel free to experiment! Whether the class is built into Python or you create your own class definition, all data has an associated class.

1. All classes have methods associated with them. Run the following code:

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

    This seemingly confusing list is actually the methods for the `int` class.
    
    The `dir()` method shows the list of attributes and methods for the object that you provided in the parentheses. In this example, we entered "1" as the object. The number 1 is an instance of the `int` class, so the code `dir(1)` is the list of attributes and methods for the `int` class.

    When you work with Python, you might hear methods referred to as *functions*. In Python, the two terms, *methods* and *functions*, are synonymous. You can avoid confusion when talking with other people about Python by calling them *methods*.

    A method represents an action that you can perform on an object. For example, the `to_bytes()` method displays the object value in byte format, which is just a specific way of looking at the data.

    Notice the `__str__` method in the list. This method converts a value into a `str` (string) type. 

1. Run the following code:

    ```python
    myVar = 1
    print(type(myVar.__str__()))
    ```

    The first line of code is an assignment. The value 1 is assigned to a variable named `myVar`. This assignment creates an object named `myVar` with one attribute, the value 1.

    The class type for the `myVar` object is determined by the class type of the value. The value 1 is an integer, so the `myVar` object is of type `int`.
    
    You can use any method for the `int` class with your `myVar` object. The second line of code calls the `__str__()` method.

    What does the output from the code tell you?

The `__str__()` method creates a new object from the `myVar` object. The new object is of type `str`. The `myVar` object is untouched--it continues to be of type `int`.

## Define a class

Python has several built-in classes, including `int`, `float`, `bool`, and `str`, but you can also define classes of your own. Defining your own classes is the main objective in object-oriented programming.

Every Python class needs a name, and it also needs to do something.

Let's begin with something simple: Tell the user that the class has been created. In the real world, you wouldn't actually create a class like this, but it's helpful for learning incrementally.

Let's open the Cloud Shell code editor to make our first class.

1. First, enter (or copy and paste) the following code to stop the Python interpreter:

    ```python
    quit()
    ```

1. Now, enter the following command to create a new Python file to store the class definition.

    We'll use the same name for the file as our new class, **MyClass**, and we'll include the Python file extension **.py**:

    ```bash
    code MyClass.py
    ```
    
    The Cloud Shell `code` command creates a new file with the name **MyClass.py** and opens the file in the Cloud Shell editor above the command pane.

1. In the code editor, enter the following code:

    ```python
    class MyClass:
        print('MyClass created!')
    ```

    The bit of code creates the simplest class you can make. It contains the bare essentials needed to create a class:

    - The keyword `class`.
    - The class name **MyClass**.
    - A colon to mark the end of the `class` statement.
    
    Notice that the next line of code is indented. The indentation is important! Python uses indentation to indicate structure. In this case, the indentation informs Python that the `print()` method is part of the `MyClass` class definition.

1. To save your file, select the ellipsis (three dots) at the top right, or select Ctrl+S (or Command+S on a Mac).

    ![Screenshot that shows how to save the class definition file in the Cloud Shell editor.](../media/save-file.png)

    After you save the class definition file, you can reopen the file later with the same `code MyClass.py` command to make changes. Because the **MyClass.py** file already exists, the command will now open the file.

1. In the command pane below the editor, enter the following command to run the code in your new class:

    ```bash
    python3 MyClass.py
    ```

1. You should see this output:

    ```output
    MyClass created!
    ```

The output proves that the class was created or *defined*. The output **doesn't** prove that an object was instantiated from the class--we'll do that next. The `print()` method executes during the class creation process. Normally, you wouldn't use a `print(`) method this way, but in this case, it helps to show how class creation works.

## Instantiate a class

At this point, you have a basic class that shows how a class is defined. Let's create an object from this class.

> If you closed your **MyClass.py** file, you can reopen it with the command `code MyClass.py`.

1. In the code editor, add the following code at the end of your **MyClass.py** file:   

    ```python
    myVar = MyClass()
    ```

    > [!NOTE]
    > Be sure to use proper Python indentation! Don't indent this new code. This code should be left-adjusted to the margin at the same level as the code `class MyClass:` that we added in the preceding exercise.

    This new code creates an object named `myVar` from the class named `MyClass`. Notice the parentheses after `MyClass`. The parentheses tell Python to create an instance of the class without passing any parameters to it.

1. Now, add the following code at the end of the file to prove that the object was created:

    ```python
    print(type(myVar))
    print(dir(myVar))
    ```

    Save the file. 

1. In the command pane, run your code again by using the same command from the preceding exercise:

    ```bash
    python3 MyClass.py
    ```

    The output shows that the class type of `myVar` is `__main__.MyClass`. The output `__main__` shows the scope in which this code is executing.

    A scope is a kind of logical grouping that holds pieces of code together.

    You don't see a scope for the `int` class type because `int` is defined outside the scope of the current application. You see the scope `__main__` for the class `MyClass` because you defined `MyClass` in the current application. It's the default scope, but you don't need to worry about this concept yet. The important takeaway is that the `myVar` object is an instance of the `MyClass` class.

Notice that you get default methods with your new class. Python provides each class with these default methods so you can do essential tasks. These methods aren't necessary right now, but it's helpful to know they exist. As you continue with this module, this information will become more relevant.
