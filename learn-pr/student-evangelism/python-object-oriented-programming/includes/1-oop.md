Legendary programmer Alan Kay originally conceived of object-oriented programming (OOP) as a way to help create computer simulations. Kay envisioned an "object" as having:

- **Attributes**. Attributes define characteristics, such as a person's name or the color of their hair.
- **Methods**. Methods instruct the object to perform tasks, such as render a photo or record information in a database.
- **Events**. Events fire when something happens to an object, for example, when a missing person is found.

By modeling a simulation as a series of objects that perform a series of actions, Kay made the concept of writing code easier to think about. The goals of OOP are to:

- **Simplify your life**. OOP helps make it possible for you to communicate what you want the computer to do in a way that the computer can understand.

- **Define ideas consistently**. OOP creates a common way to express what you want to do so that others will understand. For example, we all know that cats and dogs belong to the animal kingdom, and that animals have common characteristics. You might start by defining an animal object. Then, starting with the animal object and using an OOP feature called *inheritance*, you create cat and dog objects.

- **Specify the manner used to create objects**. Each object uses specific techniques to define attributes, methods, and events. You obtain repeatable results by defining each object in an application, library, or other code group by using a specific standard. Understanding how one object is constructed makes it possible to create other objects by using similar techniques. You can also understand any object by using a common set of techniques.

- **Write code with less effort**. Creating an animal object means that you specify the things that make animals different from other objects only once. To create a cat or dog object, you need to define only what makes a cat or a dog unique. Using the animal object as the basis for the cat and dog objects is called *code reuse*.

OOP doesn't reduce programming to a trivial undertaking, but it adds structure to the way programs are laid out. OOP also reduces complex tasks into smaller and more manageable series of tasks that are performed on objects that know what to do and how to do it.

## Classes vs. objects

Objects combine code and data in a single entity, so you can work with them as a unit. The basis for an object is a *class*, which defines the object's attributes, methods, and events. Python classes don't include native support for events, so the remainder of this module focuses on attributes and methods.

A common analogy from architecture is that you start with a blueprint, which contains a parts list (the data) and instructions (the code) for building a house. Another example is a recipe. If you want to repeat that fabulous chocolate chip cookie experience, you need a recipe that contains a list of ingredients (the data) and baking instructions (the code) to do it. A blueprint or a recipe is a class.

Yet, a blueprint isn't a house and a recipe isn't a cookie. You must obtain the materials and follow the instructions provided by the blueprint or recipe to build a house or bake a batch of cookies. A house is an *instance* of a blueprint. You can build as many houses as you like by following the blueprint; it doesn't wear out. Likewise, you can bake as many cookies as you want from the same recipe. In OOP, to create an object, you create an instance of a class.

In the next unit, you will write a basic class in Python and then instantiate it. The object created from that class won't do a lot, but in later units, you will embellish it by adding methods and attributes. You will learn how to call methods and access attributes on the objects that you create. You will even learn how to create classes that inherit methods and attributes from other classes, and then add methods and attributes of their own to extend their functionality.
