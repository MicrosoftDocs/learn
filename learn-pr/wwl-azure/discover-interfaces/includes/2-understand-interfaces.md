An interface is like a to-do list or a contract. It outlines what jobs need to be done, without specifying how these jobs should be done. The contract nature of interfaces allows for multiple classes to accomplish the same tasks in their own unique ways.

### Interfaces are like a contract

Each of them - the car, the person, and the horse - has its own unique way of moving. An interface could be used to define the contract requirement "You need to be able to move," but the interface doesn't define how to move.

### Parts of an interface

In C#, an interface outlines the required properties and methods. An interface doesn't hold any data itself, but it does specify what kind of information should be provided through properties. For instance, in a "Move" interface, 'X' and 'Y' could be properties, representing location coordinates. These properties enable the retrieval or modification of their values.

Additionally, interfaces define methods, which are actions that can be performed. However, they don't provide the implementation for these methods. For example, the "Move" interface could include a contract requiring a "Dance" method. However, what exactly happens when the "Dance" method is called by the objects that use this interface, whether it's a car, person, or horse.

### Use an interface

To utilize an interface, entities like a car, a person, or a horse from the "move" example adopt it as part of their functionality. The car, for instance, needs to understand how to perform all the tasks listed in the interface. This process of adopting an interface by the car is known as 'implementing' the interface. In this process, the car agrees to follow the 'contract' set by the interface, defining its own unique ways to complete the tasks such as moving by "driving." Similarly, the person and the horse would also implement the interface, each defining their own unique ways to 'move' such as "run" or "gallop."

Consider the classes "Person" and "Horse." Both implement the "Move" interface, and it's the responsibility of "Person" and "Horse" classes to define ways to "Move."

In the "Person" class, 'Move' could mean walking, jogging, or running. In the "Horse" class, 'Move' could mean walking, trotting, or galloping. Even though they move in different ways, both classes fulfill the 'Move' job requirement from the "Move" interface.

### Why use an interface?

The properties defined by an interface are useful because they ensure that all classes handle information in the same way. An interface makes your related classes more consistent and easier to work with. As long as they all use the same interface, you can write instructions that work with all kinds of different classes.

Implementing an interface is like signing a contract, agreeing to do certain jobs outlined by the interface. The "contract" enforcement provided by interfaces aids in building complex classes that can be easily maintained and updated.
