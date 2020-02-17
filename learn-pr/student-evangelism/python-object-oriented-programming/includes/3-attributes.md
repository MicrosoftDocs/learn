Attributes hold the data that defines an object. For a pink flower, *pink* is an attribute of the flower. If you wrote a `flower` class, you might include an attribute named `color` that describes the flower's color. You might also include an attribute that indicates the flower's type—for example, iris, tulip, or rose. Objects are not required to have attributes but most do.

In this unit, you write a class named `Person` to hold information about a person. You add attributes to the class and learn how to access those attributes. You also learn about an important convention that enables selected members of a class to be marked "for internal use only" so other programmers will steer clear of them.

## Class attributes vs. instance attributes

Attributes come in two varieties: class attributes and instance attributes. A class attribute is an attribute that applies to *all* instances of a class rather than to individual instances (objects created from the class). What's interesting about class attributes is that you don't have to instantiate a class to access them. Class attributes are always available.

A great example of a class attribute is in Python's built-in `math` class. The `math` class has class attributes named `pi` and `e` that contain the values of common mathematical constants. Because you don't have to create a class instance to access a class attribute, you can compute the area of a circle this way in Python:

```python
area = math.pi * radius * radius
```

You could easily write a class of your own that exposes these same values as class attributes:

```python
class constants:
    pi = 3.14159265358979323846264338327950288
    e =  2.71828182845904523536028747135266249
```

Using the constants would then be a matter of referencing class attributes on your own class:

```python
area = constants.pi * radius * radius
```

By contrast, an instance attribute is one that is "instanced" for each and every object you create. A `person` class might have a `name` attribute that holds a person's name. `name` would need to be an instance attribute so that every `person` could be assigned a different name. That class also could have attributes that define additional information about a missing person, such as:

- A photo of the person's face
- A unique ID, such as a social security number
- The person's date of birth

These attributes should be instance attributes because they vary from person to person.
