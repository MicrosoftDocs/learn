Methods tell an object what to do and how to do it. For example, a `Person` class might contain a `show_face()` method for displaying the person's face, and a `get_age()` method that returns the person's age. Methods frequently operate on data stored in attributes. `get_age()`, for example, might subtract a birth date stored in an attribute from today's date to compute a person's age in years. 

Python objects always have methods, even if you don't define any yourself. For example, every object has a `__str__()` method, added by Python, that returns a string representation of the object. The default `__str__()` method works fine for something simple like an `int`, but it does nothing meaningful a `person` object. When you call `__str__()` on a `person` object, you get something like this:

`<__main__.person object at 0x7ff9e91ab978>`

For this reason, Python programmers frequently replace the built-in `__str__()` method with one of their own when they write custom classes to serve an application.

In this unit, you add methods to the `Person` class you wrote in the previous unit to make it a first-class citizen in Python. In addition to adding methods of your own, you will override the `__str__()` method to tailor its output for `Person`. Finally, you will discover that when you pass an object to Python's built-in `str()` function, Python calls the object's `__str__()` method internally.

## Static methods vs. instance methods

Python objects support two types of methods: static methods and instance methods. Static methods apply to all objects of a certain type and can be called without instantiating the class to which the methods belong. Instance methods, on the other hand, apply to a specific object or class instance. A `get_age()` method should be an instance method because one person's age doesn't necessarily equal another person's age.

> [!NOTE]
> Technically speaking, Python supports a third method type called *class methods*. Class methods are similar to static methods, but they work at the class level, not at the object level. Class methods aren't used often, but when they are, they're usually used to create *object factories*. For more information about class methods, see the article [Python's Instance, Class, and Static Methods Demystified](https://realpython.com/instance-class-and-static-methods-demystified/).

Python's `math` class contains several static methods to help you perform mathematical operations. For example, the following statement computes the square root of 4:

```python
root = math.sqrt(4)
```

You could write a similar class named `mathops` containing mathematical operators of your own:

```python
class mathops:
    @staticmethod
    def square(val):
        return val * val
```

Then, you could square a number by calling the static `square` method:

```python
square = mathops.square(2)
```

The keyword `@staticmethod` "decorating" the method tells Python that `square` is a static method, not an instance method.

Only instance methods can access instance attributes. If you stored a person's birth date in an instance attribute, you couldn't read that date from a static method because there is no class instance associated with a static method — and therefore no birth date to read.

## Add instance methods to `Person`

Instance methods are associated with a particular object rather than with the class. They are defined by adding functions to the class that receive `self` as the first parameter. Internally, instance methods are free to access the object's attributes and even other methods.

1. Return to your MissingPersons.py file and replace  a new definition for the `Person` class:

	```python
	import datetime
	
	class mPerson:
	    def __init__(self, name, photo, date_of_birth):
	        self.name = name
	        self.photo = photo
	        self.dob = date_of_birth
	        
	    def get_age(self):
	        return int((datetime.datetime.now() - self.dob).days / 365.25)
	    
	    def show_face(self):
	        plt.axis('off')
	        plt.imshow(self.photo, cmap=plt.cm.gray)
	```

	`mPerson` now contains two instance methods: one named `get_age()` that returns the person's age in years, and another named `show_face` that displays the person's face.

	> [!NOTE]
	> The age computation isn't exact because it provides only rudimentary handling of leap years. The solution to that is a topic for another day.

1. Now run the following statements in a new cell to test these methods:

	```python
	aPerson = mPerson("Adam", faces.images[0], datetime.datetime(1990, 9, 16))
	print(str(aPerson.get_age()))
	aPerson.show_face()
	```

1. Confirm that you see the following output:

	![Output from instance methods](../media/instance-method-output.png)
	
	_Output from instance methods_

Neither of the instance methods you added take arguments (other than `self`, which is required of an instance method), but be aware that instance methods *can* take arguments just like other functions in Python.

## Override the __str__() method

Python supplies a default `__str__()` method that works well with the rather primitive built-in object types. But for custom types, it rarely provides the results you want. The default method tells you the object's name and where the object is located in memory. It would be a lot more useful if it could tell you something specific about the object's content. 

You can replace the built-in `___str__()` method (or any other method, for that matter) by *overriding* it. You don't have to do anything  special to override a method in Python. You just provide a new version of the method in the class.

1. To demonstrate, return to the `mPerson` class in your notebook and add the following method to it:

	```python
	def __str__(self):
	    return self.name + ', age ' + str(self.get_age())
	```

	This method returns a string denoting the person's name and age. The information contained in the string is obtained by reading the object's `name` attribute and calling the object's `get_age()` method.

1. Use the following code to test the new `__str__()` method:

	```python
	print(str(aPerson))
	print(aPerson.__str__())
	print(aPerson)
	```

How do the outputs from the three `print()` statements differ, or do they differ at all? What does this tell you about how Python's `str()` function is implemented inside the Python run-time?
