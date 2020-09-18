Methods tell an object what to do and how to do it. For example, a `Person` class might contain a `show_face()` method for displaying the person's face and a `get_age()` method that returns the person's age. Methods frequently operate on data that is stored in attributes. `get_age()`, for example, might subtract a birth date that's stored in an attribute from today's date to compute a person's current age in years. 

Python objects always have methods, even if you don't define any yourself. For example, every object has a `__str__()` method added by Python that returns a string representation of the object. The default `__str__()` method works fine for something simple like an `int`, but it does nothing meaningful to a `person` object. When you call `__str__()` on a `person` object, you get something like this:

`<__main__.person object at 0x7ff9e91ab978>`

For this reason, Python programmers frequently replace the built-in `__str__()` method with one of their own when they write custom classes to serve an application.

In this unit, you add methods to the `Person` class you wrote in the preceding unit to make it a first-class citizen in Python. In addition to adding methods of your own, you will override the `__str__()` method to tailor its output for `Person`. Finally, you will discover that when you pass an object to Python's built-in `str()` function, Python calls the object's `__str__()` method internally.

## Static methods vs. instance methods

Python objects support two types of methods: static methods and instance methods. Static methods apply to all objects of a certain type and can be called without instantiating the class to which the methods belong. Instance methods apply to a specific object or class instance. A `get_age()` method should be an instance method because one person's age doesn't necessarily equal another person's age.

> [!NOTE]
> Technically speaking, Python supports a third method type called *class methods*. Class methods are similar to static methods, but they work at the class level, not at the object level. Class methods aren't used often, but when they are, they're usually used to create *object factories*. For more information about class methods, see [Python's Instance, Class, and Static Methods Demystified](https://realpython.com/instance-class-and-static-methods-demystified/).

Python's `math` class contains several static methods to help you perform mathematical operations. For example, the following statement computes the square root of 4:

```python
root = math.sqrt(4)
```

You could write a similar class named `mathops` to contain mathematical operators of your own:

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

The keyword `@staticmethod` that "decorates" the method tells Python that `square` is a static method and not an instance method.

Only instance methods can access instance attributes. If you stored a person's birth date in an instance attribute, you couldn't read that date from a static method because there is no class instance associated with a static method, and therefore, no birth date to read.
