## What is object-oriented programming?

Legendary programmer named Alan Kay originally conceived of object-oriented programming (OOP) as a way to help create computer simulations. He envisioned an "object" as having:

- **Attributes**. Attributes define characteristics, such as a person's name or the color of their hair.
- **Methods**. Methods instruct the object to perform tasks, such as render a photo or record information in a database.
- **Events**. Events fire when something happens to an object; for example, when a missing person is found.

By modeling a simulation as a series of objects performing a series of actions, Kay made the concept of writing code easier to think about. The goals of OOP are to:

- **Simplify your life**. Make it possible for you to communicate what you want the computer to do in a manner that you use naturally, but the computer can understand.

- **Define ideas consistently**. Find a common way to express what you want to do so that others understand. For example, we all know that cats and dogs belong to the animal kingdom and that animals have common characteristics. So you might start by defining an animal object. You then create cat and dog objects starting with the animal object using an OOP feature called inheritance.

- **Specify the manner used to create objects**. Each object defines attributes, methods, and events using specific techniques. You obtain repeatable results by defining each object in an application, library, or other code group using a specific standard. Understanding how one object is constructed makes it possible to create others using like techniques and to understand any object using those techniques with greater ease.

- **Write code with less effort**. Creating an animal object means that you only have to specify all the things that make animals different from other objects once. To create a cat or a dog object, all you need to define is what makes a cat or a dog unique. Using the animal object as the basis for the cat and dog objects is called *code reuse*.

OOP doesn't reduce programming to a trivial undertaking, but it adds structure to the way programs are laid out and reduces complex tasks to smaller and more manageable series of tasks performed on objects that know what to do and how to do it.

## Classes vs. objects

Objects combine code and data into a single entity so you can work with them as a unit. The basis for an object is a *class*, which defines the object's attributes, methods, and events. Python classes don't include native support for events, so the remainder of this module focuses on attributes and methods.

A common analogy from architecture is that you start with a blueprint, which contains a parts list (the data) and instructions (the code) for building a house. Another example is a a recipe. If you want to repeat that fabulous chocolate chip cookie experience, then you need a recipe that contains a list of ingredients (the data) and baking instructions (the code) to do it. This blueprint or recipe is called a class.

Yet a blueprint isn't a house and a recipe isn't a cookie. You must obtain the materials and follow the instructions provided by the blueprint or recipe to build a house or bake a batch of cookies. 

A house is an *instance* of a blueprint. You can build as many houses as you like by following the blueprint; it doesn't wear out. Likewise, you can bake as many cookies as you want from the same recipe. In OOP, to create an object, you create an instance of a class.

In the next unit, you will write a simple class in Python and then instantiate it. The object created from that class won't do a lot, but in subsequent units, you will embellish it by adding methods and attributes. You will learn how to call methods and access attributes on the objects that you create. You will even learn how to create classes that inherit methods and attributes from other classes and then add methods and attributes of their own to extend their functionality.
