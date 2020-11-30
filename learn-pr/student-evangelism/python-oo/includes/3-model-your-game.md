You are tasked with building the game rock paper scissors. There's existing procedural code to look at for reference but you've been asked to build said game in OOP. For that to be possible you first need to learn some OOP fundamentals. Then you need to start analyzing the game and _model_ said game using OOP methodologies, so you can eventually build it.

In the previous unit, you learned that modeling your problem domain is a an important part of _doing_ OOP. You came to a point where you were able to identify various artifacts that made up your system.

However, in OOP there are constructs you should be using to take it to the next level, to turn your model into code. This unit will therefore focus on explaining the OOP concepts you need and start applying those to your main task, your game. This unit will therefore explore the following parts:

- **OO concepts**. To be able to reason in OOP you need to understand some fundamental concepts like classes and objects and state, what's the difference between them and how they relate to one another.
- **Analyzing a game for OO concepts**. As part of building a game in OOP you need to learn to recognize the OOP parts, what parts does a game consist of and what parts of these game parts are the actors and the state?

## OOP concepts, classes and objects

The concept of objects has been mentioned a few times already as part of trying to _model_ problem domains. An object is an actor, something that does something within a system and as a result of taking an action, it changes state within itself or other objects.

Lets try to imagine an object in the real world, you are in a car park, what do you see? You are likely to see cars, lots of them, of all shapes, sizes and colors. To describe a car you can use properties like make, model, color, type of car, like a four wheel drive and so on. If you assign values to these properties it quickly becomes clear whether you are talking about red Ferrari or a four wheel drive Jeep or a yellow Mustang and so on.

New scene, a deck of cards in Vegas. You look at two different cards, two objects and you realize they have some common properties namely suit, e.g clubs, heart, diamonds etc and what value they are like ace, king, nine etc.

> [!TIP]
> Start looking at your surroundings, see if you can take two similar objects, like two books or two chairs and see if you can find the properties that best describes them and tells them apart.

### Classes

You've learned that an OOP system has objects and that those objects have properties. There's a concept that's very similar to an object namely a class. So what's a class? A class is a blueprint of an object. Where the class is the blueprint of a car, the object is the actual car that you drive around. The class is what you write in code, the object is what you get when you tell the runtime environment to run your code. Here's a table of some example of classes and their resulting objects.

|Class                                 |Object          |
|--------------------------------------|----------------|
|Blueprint of a car                    | The car        |
|An description of an ice cream cone and its ingredients | The ice cream  |

The way you go about creating an object from a class is very similar to how you would create a car from a blueprint. When you create an object your program asks the operating system for resources, memory, to be able to construct the object. Conversely when a car is made from a blueprint the factory asks for resources like metal, rubber, glass etc to be able to assemble the car.

A class in Python is created by using the keyword `class` and give it a name, like in this example:

```python
class Car:
```

To create an object from this class you _instantiate_ an object from it, by its name and parenthesis, like so:

```python
car = Car()
```

The `car` is the variable that holds your object instance. The moment of instantiation, object creation, is when you call `Car()`. This place in the code is where the runtime asks the operating system, _can I please have enough memory to create this car?_

## Variables in OOP

From procedural programming you are used to having variables to hold information and keeping track of state. You can define these variables wherever you need them in your file. A typical variable _initialization_ can look like so:

```python
pi = 3.14
```

You have variables in OOP as well, although they are _attached_ to objects rather than being defined on its own. When a variable is attached to an object, it's used to either describe the object or to keep track of a state in the object. An example of _description_ variable is for example the color of car. The floor of an elevator, or wether it's running or not, is an example of a variable instead used to describe an object's state.

### Adding properties at object creation

To add variables to an object you need to create them when the object is being created. When you ask to create an object, a special function on the object is being invoked called ``__init()__``. Inside of the `__init__()` method you can now create the variables supporting the object. Let's see an example of how this initialization can be done:

```python
class Elevator:
  def __init__(self, starting_floor):
    self.make = "The elevator company"
    self.floor = starting_floor

# To create the object

elevator = Elevator(1)
print(elevator.make) # "The Elevator company"
print(elevator.floor) # 1
```

The above example, describes the class `Elevator` with two variables `make` and `floor`. It's common to refer to variables, on an object, as _properties_, so we will call variables, properties, henceforth. An important takeaway from the code is that `__init__()` is called implicitly. It's a special method that's referred to as an object's _constructor_ and is only called during its creation. There's also a concept `self` being used. `self` is a special keyword that refers to the object instance itself. You need to use `self` when you refer to the object to change for example its data or correctly call its methods. Consider the following code for correct usage of `self`:

```python
class Car:
  def __init__():
    self.color = "Red" # ends up on the object
    make = "Mercedes" # becomes a local variable in the constructor

car = Car()
print(car.color) # "Red"
print(car.make) # would result in an error, `make` does not exist on the object
```

> [!TIP]
> As a home exercise, try creating a class from a book you would read. Think about how you would write its class and what properties it should have.
