You want evaluate OOP by rebuilding the game rock paper scissors. You have the original procedural code to look at for reference but now you need to model it in an OOP format. 

To do so, we will need to apply some fundamental OOP concepts, such as classes, objects and state. This unit will therefore explore the following parts:

- **Important OOP concepts**. To be able to reason in OOP, you need to understand some fundamental concepts like classes and objects and state, what's the difference between them and how they relate to one another.
- **Variables in OO**. How do you deal with variables and how do you add them to your objects.

## What is an Object

The concept of objects has been mentioned a few times already as part of trying to _model_ problem domains. An object is an actor, something that does something within a system and as a result of taking an action, it changes state within itself or other objects.

Lets try to imagine an object in the real world, you are in a car park, what do you see? You are likely to see cars, lots of them, of all shapes, sizes, and colors. To describe a car you can use properties like make, model, color, type of car, like a four-wheel drive and so on. If you assign values to these properties, it quickly becomes clear whether you are talking about red Ferrari or a four-wheel drive Jeep or a yellow Mustang and so on.

New scene, a deck of cards in Vegas. You look at two different cards, two objects and you realize they have some common properties namely suit, e.g clubs, heart, diamonds etc. and what value they are like ace, king, nine etc.

> [!TIP]
> Start looking at your surroundings, see if you can take two similar objects, like two books or two chairs and see if you can find the properties that best describes them and tells them apart.

## What is a class

A class is a data type that acts as a template definition for a particular kind of object.

You've learned that an OOP system has objects and that those objects have properties. There's a concept that's similar to an object namely a class. So what's a class? A class is a blueprint of an object. Where the class is the blueprint of a car, the object is the actual car that you drive around. The class is what you write in code, the object is what you get when you tell the runtime environment to run your code. Here's a table of some example of classes and their resulting objects.

|Class                                 |Object                              |
|--------------------------------------|------------------------------------|
|Blueprint of a car                    | Honda Accord, Jeep Wrangler        |
|Cat                                   | Garfield the cat                   |
|Description of ice cream              | Strawberry, chocolate, or vanilla ice cream  |

The way you go about creating an object from a class is similar to how you would create a car from a blueprint. When you create an object your program asks the operating system for resources, memory, to be able to construct the object. Conversely when a car is made from a blueprint the factory asks for resources like metal, rubber, glass etc. to be able to assemble the car.

## How to create a class

A class in Python is created by using the keyword `class` and give it a name, like in this example:

```python
class Car:
```

### Creating an object from a class

When you create an object from class, you're said to _instantiate_ it. What you're doing is asking the operating system that, given this template (the class), and these starter values, give me enough memory and create an object. Essentially, _instantiate_ is another word for create.

To _instantiate_ an object you add parentheses to the class's name. What you get is an object that you can chose to assign to a variable, like so:

```python
car = Car()
```

The `car` is the variable that holds your object's instance. The moment of instantiation, object creation, is when you call `Car()`.

## Variables in OOP vs variables in procedural programs

From procedural programming, you are used to having variables to hold information and keeping track of state. You can define these variables wherever you need them in your file. A typical variable _initialization_ can look like so:

```python
pi = 3.14
```

You have variables in OOP as well, although they are _attached_ to objects rather than being defined on its own. You refer to variables on an object as attributes. When an attribute is attached to an object, it's used in one of two ways:

- **Describing the object**. An example of _description_ variable is, for example, the color of the car, or the number of spots on a giraffe.
- **Holding the state**. A variable can instead be used to describe an object's state. Example of a state is the floor of an elevator, or whether it's running or not.

## Adding attributes to a class

Knowing what attributes (variables) that should be added to your class is part of modeling. You've learned how to create a class in code, so how do you add an attribute to it? You need to tell the class what attributes it should have at construction time, when an object is being instantiated. There's a special function that's being called, at the moment of creation, called a _constructor_.

### Constructor

Many program languages have the notion of a _constructor_, a special function that's only invoked when the object is first being created. The constructor will be called only once, and in this method, you create the attributes the object should have. Additionally, you assign any starter values to the created attributes.

In Python the constructor has the name `__init()__`.  You also need to pass a special keyword `self` as a parameter to the constructor. The keyword `self` refers to the object's instance. Any assignment to this keyword means that the attribute ends up on the object instance. If you don't add an attribute to `self` it will instead be treated as a temporary variable that will seize to exist once `__init()__` is done executing.

> [!NOTE]
> They keyword `self` will also need to be passed to any methods that needs to refer to anything on the object instance. This will be covered in the next concept unit.

### Add and initialize attributes on a class

Let's see an example of setting up attributes in a constructor:

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

The above example, describes the class `Elevator` with two variables `make` and `floor`. An important takeaway from the code is that `__init__()` is called implicitly. You don't call the `__init__()` method by name, but it's called when the object is created, in this line of code:

```python
elevator = Elevator(1)
```

### Incorrect use of `self`

To emphasize how the keyword `self` works, consider the below code in which two attributes `color` and `make` are being assigned in the constructor `__init__()`:

```python
class Car:
  def __init__():
    self.color = "Red" # ends up on the object
    make = "Mercedes" # becomes a local variable in the constructor

car = Car()
print(car.color) # "Red"
print(car.make) # would result in an error, `make` does not exist on the object
```

If the purpose was to make both `color` and `make` attributes of the class `Car` you would need to modify the code. In the constructor, ensure both attributes are assigned to `self`, like so:

```python
self.color = "Red" # ends up on the object
self.make = "Mercedes"
```

> [!TIP]
> As a home exercise, try creating a class from a book you would read. Think about how you would write its class and what properties it should have.
