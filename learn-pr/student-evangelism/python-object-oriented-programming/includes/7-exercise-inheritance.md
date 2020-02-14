Inheritance, also known as *subclassing*, is one of the fundamental principles of object-oriented programming. It lets you define new classes that inherit the attributes and methods of other classes. OOP programmers often speak of "is-a" relationships. You might have an `animal` class that defines the basic characteristics and behavior of an animal. But cats and dogs are different, so you could use inheritance to define new classes named `cat` and `dog`. A cat is an animal, and a dog is an animal. In the `cat` and `dog` classes, you are free to add attributes and methods that differentiate a cat from a dog. The `cat` class could have a `meow()` method, for example, while the `dog` class could have a `bark()` method. Meanwhile, both `cat` and `dog` would share attributes and methods inherited from `animal`.

Inheritance promotes *code reuse*. If you want to write a class to represent missing persons, you don't have to copy-and-paste the code for a class representing persons. You simply inherit from the `person` class and add attributes and methods that are unique to missing persons. Now if you make a change to the `person` class, also known as the *base class* or *super class*, those changes automatically propagate down to the missing-person class.

In this unit, you will see inheritance at work by writing a new class named `MissingPerson` that inherits from `Person` but adds attributes and methods of its own. You also learn how to invoke methods in the base class, and how to remove inherited attributes that don't make sense in the subclass.

## Create a class to represent missing persons

One characteristic that differentiates a missing person from a normal person is the date that the person went missing. Let's write a missing-person class that includes a `missing_since` attribute and a `get_years_missing()` method that computes the number of years the person has been missing.

1. Return to your **MissingPersons.py** file and enter the following class definition beneath the definition of `Person`. Feel free to remove the print statements and definition of `aPerson` at the bottom of the file.

    ```python
    class MissingPerson(Person):
        def __init__(self, name, photo, date_of_birth, date_missing):
            # Construct the base object
            Person.__init__(self, name, photo, date_of_birth)

            # Add a missing_since attribute
            self.missing_since = date_missing

        # Add a get_years_missing() method
        def get_years_missing(self):
            return int((datetime.datetime.now() - self.missing_since).days / 365.25)
    ```

    You just defined a new class (subclass) named `MissingPerson` that inherits from `Person`. When created, an `MissingPerson` object creates an `Person` object by calling the latter's `__init__()` method. Then it defines an instance attribute of its own (`missing_since`) and a method that subtracts the date the person went missing from today's date to compute how long that person has been missing.

1. Use the following code to create an `mMissingPerson` object and show how long the person has been missing:

    ```python
    aPerson = mMissingPerson("Adam", faces.images[0], datetime.datetime(1990, 9, 16), datetime.datetime(2016, 1, 1))
    print(aPerson.name + ' has been missing for ' + str(aPerson.get_years_missing()) + ' years')
    ```

    Observe that the `mMissingPerson` object contains the `name` attribute inherited from `mPerson` as well as the `get_years_missing()` method it added itself. When creating an `mMissingPerson` object, you must provide the date that the person went missing as well as a name, a photo, and a date of birth. That comes from `mMissingPerson`'s `__init__()` method, which serves the same purpose in an inherited class as it does in a base class.

If you'd like, use a `print(dir(aPerson))` statement to list the object's methods and attributes and confirm that the list includes members defined in `mPerson` as well as members defined in `mMissingPerson`. 

## Override an inherited method

Occasionally it is useful to override a method inherited from the base class to modify the way it works in the subclass. You have already seen how to override methods: simply implement a method of the same name in the subclass. But what if you need to call the base class's version of the method from the inherited class?

In South Korea, babies are considered to be 1 year old when they are born. Consequently, they turn 2 on their first birthday, 3 on their second birthday, and so on. Suppose you wanted to create a special version of the `mMissingPerson` class named `mMissingSKPerson` that adds 1 to the integer returned by the `get_age()` method. That's what Python's `super()` method is for.

1. Add the following class definition to the notebook and run it:

    ```python
    class mMissingSKPerson(mMissingPerson):
        def __init__(self, name, photo, date_of_birth, date_missing):
            mMissingPerson.__init__(self, name, photo, date_of_birth, date_missing)
    
        # Override the get_age() method
        def get_age(self):
            return super().get_age() + 1
    ```

    Notice that `get_age()` is overridden in the inherited class, but rather than duplicate the code for the base class's `get_age()` method and add 1 to the result, it invokes the base class's `get_age()` method and adds 1.

1. Now perform a test by executing the following statements:

    ```python
    date_birth = datetime.datetime(1990, 9, 16)
    date_missing = datetime.datetime(2016, 1, 1)
    face = faces.images[0]
    name = "Adam"
    
    aPerson = mPerson(name, face, date_birth)
    print(str(aPerson.get_age()))
    
    aPerson = mMissingPerson(name, face, date_birth, date_missing)
    print(str(aPerson.get_age()))
    
    aPerson = mMissingSKPerson(name, face, date_birth, date_missing)
    print(str(aPerson.get_age()))
    ```

Can you predict what the output from the three `print()` statements will be before you run the code?

## Remove an inherited attribute

Suppose you defined a new class named `mAnonymousPerson` that inherits from `mPerson`. In that case, you might want to remove the `name` attribute so that an anonymous person remains — well — anonymous.

You can include calls to Python's `delattr()` function in a class definition to remove attributes inherited from the base class. Here's how an `mAnonymousPerson` class might look:

```python
class mAnonymousPerson(mPerson):
    def __init__(self, photo, date_of_birth):
        mPerson.__init__(self, '', photo, date_of_birth)
        delattr(self, 'name')
```

And here's how an instance would be created:

```python
aPerson = mAnonymousPerson(faces.images[0], datetime.datetime(1990, 9, 16))
```

The `name` attribute doesn't exist in the subclass. An attempt to access it on an `mAnonymousPerson` object would generate a run-time error.

In case you wondered, you can't delete methods inherited from a base class. You can, however, override them and change the way they work (or simply have them raise an error or do nothing).
