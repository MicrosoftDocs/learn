The end goal of a system is to produce useful output. To get there, you need to process the input. While _processing_, you might need the help of various methods and data to do so. In OOP, your methods and your data are placed on objects. To process the input and produce a result, in OOP, you need methods. 

## Methods in OOP

Methods, regardless of paradigm used, have the ability to carry out an action. That action can be a computation that only relies on inputs or it can change the value of a variable.

Methods on objects, in OOP, come in two flavors, external facing methods, that other objects can invoke, and internal methods that help carry out a task. Regardless of what type of method, they can change the value of the data on an object, its _state_. The notion of state, and who and what can change it, is an important topic, and an important part of designing your classes and object. These questions lead us into our next section, _encapsulation_.

## Encapsulation, protect your data

The general idea of encapsulation is that the data on an object is _internal_, something that only concerns the object. Data is needed for the object and the methods to do its job, to carry out a task. By saying it's internal, you are saying that it should be protected from other outside manipulation, or rather _uncontrolled_ outside manipulation. The question is why?

### Why you need it

Lets explain our reasoning why data shouldn't be directly touched by another object. Here's some examples.

- **You don't need to know the internals**. When you drive a car, you press a pedal to control the clutch or to accelerate or brake. You are operating your car at a higher level, you don't care about what goes on underneath, how the car carries this out. It's the same thing with code, most of the time you don't need to know how an object does something, as long as there's a method you can invoke, that does what you want.

- **You shouldn't know the internals**. Instead of having a pedal to interact with the car, imagine you instead had a screw driver or soldering kit to try to accelerate, sounds scary? It's because it is. Or lets say you have a more concrete example, a square class, with the following code:

   ```python
   class Square:
     def __init__(self):
       self.height = 2
       self.width = 2
     def set_side(self, new_side):
       self.height = new_side
       self.width = new_side

   square = Square()
   square.height = 3 # not a square anymore
   ```

   In the square example, you break the notion of what a square is, by setting the `height` variable. The way the square is coded it, needs you to invoke the method `set_side()`, for the square to function properly. Letting the object take care of its data is therefore considered more safe. You should almost always choose to interact via a method over setting the data explicitly.

### Access levels

So how can you protect your class and your object from unwanted manipulation of data? The answer is _access levels_. You can hide data from the outside world, from other objects, by marking data as well as functions with specific keywords, access modifiers.

The way Python accomplishes data hiding is by adding prefixes to attribute names. One leading underscore `_` is a message to the outside world that you probably shouldn't touch this data. Modifying the square class you end up with this code:

```python
  class Square:
    def __init__(self):
      self._height = 2
      self._width = 2
    def set_side(new_side):
      self._height = new_side
      self._width = new_side

  square = Square()
  square._height = 3 # not a square anymore
```

One leading underscore still allows for data to be modified, in Python referred to as _protected_. Can we do this better? Yes we can, by having two leading underscores `__`, so your square class now looks like this code:

```python
  class Square:
    def __init__(self):
      self.__height = 2
      self.__width = 2
    def set_side(new_side):
      self.__height = new_side
      self.__width = new_side

  square = Square()
  square.__height = 3 # raises AttributeError
```

Great, so we are safe, we have protected our data? Well, not entirely, Python just changes the name of the underlying data. So by typing this code, you can still change its value:

```python
square = Square()
square._Square__height = 3 # is allowed
```

Many other languages implementing data protection solve this differently, Python is a little unique in that data protection is more like levels of suggestion rather than strictly implemented.

### Getters and setters

Now, we've said so far that data in general should not be touched from the outside, they are the concern of the object. As with all rules and strong recommendations there are exceptions, sometimes you need to change that data or it's simpler than having to add a bunch of code. Getters and Setters, also known as _accessors_ and _mutators_, are methods dedicated to reading or changing your data. The Getters plays the part of making your inner data readable to the outside, doesn't sound so bad does it?  Setters on the other hand are methods that can change your data directly. The idea is for these methods to act as a guard so a _bad_ value can't be set. Lets bring up our square class again and see getter and setters in action:

```python
  class Square:
    def __init__(self):
      self.__height = 2
      self.__width = 2
    def set_side(self, new_side):
      self.__height = new_side
      self.__width = new_side
    def get_height(self):
      return self.__height
    def set_height(self, h):
      if h >= 0:
        self.__height = h
      else:
        raise Exception("value needs to be 0 or larger")

  square = Square()
  square.__height = 3 # raises AttributeError
```

The method `set_height()` protects you from setting the value to anything. Python has a more elegant approach to getting and setting data on an object, namely the decorator `@property`. This decorator does two things for you, it saves you from creating the underlying private variable and it allows you to decorate which methods should handle the getting and setting of your data. Lets see an example of this feature:

```python
class Square:
  def __init__(self, w, h):
    self.height = h
    self.__width = w
  
  def set_side(self, new_side):
    self.__height = new_side
    self.__width = new_side

  @property
  def height(self):
    return self.__x

  @height.setter
  def height(self, new_value):
    if new_value >= 0:
      self.__height = new_value
    else:
      raise Exception("Value must be larger than 0")
```

Being able to manipulate the height separate from the width will still cause a problem. So you will need to understand what the class does before you consider allowing getters and setters.
