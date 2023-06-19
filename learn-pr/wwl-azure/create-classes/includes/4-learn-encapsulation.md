

Encapsulation is about hiding the internal state and functionality of an object and only allowing access through a public set of functions. It prevents your code from inadvertently allowing access to data and methods in your objects. It's a way of keeping things clean, so to speak, only allowing the things you want to be available to your other objects and methods. Encapsulation controls the visibility and accessibility of data and implementation details in your application.

## What is encapsulation?

In a nutshell, encapsulation is the ability of an object or class to hide its internal data and implementation details, making only the intended parts of the object or class available.

## Benefits of encapsulation

You can use encapsulation to hide information. When you hide information, such as an object’s internal state and implementation information, external code focuses on only the useful characteristics of the object. Encapsulation helps to protect the data in an object; external code can interact with the data in an object only through the members of the object that it has access to.

## Contents of a class

The following are examples of class members that can be encapsulated within a class:
- Variables used to store values
- Methods containing code blocks and that represent an action that an object or class can perform
- Properties allowing you to read, write, or compute the values stored in  within the class
- Constructors, methods that are used to create an instance of an object

>[!NOTE]
>The important thing here is that encapsulation is about hiding the data members that users of a class do not need and that might only cause confusion if they were directly accesible. Data members are encapsulated, or hidden, using the `private' accessor keyword. Access to hidden variables can then be controlled using either properties and methods, but the hidden data members themselves can't be accessed.
