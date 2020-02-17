Instance methods are associated with a particular object rather than with the class. Instance methods are defined by adding functions to the class that receive `self` as the first parameter. Internally, instance methods are free to access the object's attributes, and even other methods.

1. Return to your MissingPersons.py file and replace your definition of the `Person` class with a new one:

    ```python
    class Person:
        def __init__(self, name, photo, date_of_birth):
            self.name = name
            self.photo = photo
            self.dob = date_of_birth

        def get_age(self):
            return int((datetime.datetime.now() - self.dob).days / 365.25)
    ```

    `Person` now contains an instance method  named `get_age()` that returns the person's age in years.

    > [!NOTE]
    > The age computation isn't exact because it provides only rudimentary handling of leap years. The solution to that is a topic for another day.

1. Now replace your print statement at the bottom of your file with this command:

    ```python
    print(str(aPerson.get_age()))
    ```

1. Save the file, and then run your code to confirm that it outputs an age that seems correct:

    ```bash
    python3 MissingPersons.py
    ```

The instance method you added doesn't take arguments (other than `self`, which is required of an instance method). Instance methods *can* take arguments, though, just like other functions in Python.

## Override the __str__() method

Python supplies a default `__str__()` method that works well with the rather primitive built-in object types. But for custom types, it rarely provides the results you want. The default method tells you the object's name and where the object is located in memory. It would be a lot more useful if it could tell you something specific about the object's content. 

You can replace the built-in `___str__()` method (or any other method) by *overriding* it. To override a method in Python, just provide a new version of the method in the class.

1. To demonstrate, return to the `Person` class and add the following method to the class using the correct indentation:

    ```python
    def __str__(self):
        return self.name + ', age ' + str(self.get_age())
    ```

    The method returns a string that denotes the person's name and age. The information contained in the string is obtained by reading the object's `name` attribute and calling the object's `get_age()` method.

1. Add the following code to the end of your file and run it again to test the new `__str__()` method:

    ```python
    print(str(aPerson))
    print(aPerson.__str__())
    print(aPerson)
    ```

How do the outputs from the three `print()` statements differ, or are they different at all? What does the output tell you about how Python's `str()` function is implemented inside Python?
