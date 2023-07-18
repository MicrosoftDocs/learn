

A parameterized constructor simply means a constructor that takes parameters. If the class you're instantiating has a parameterized constructor, you can call the parameterized constructor by specifying values for the parameters when you instantiate the class.

## Instantiate a class with a parameterized constructor

Some classes accept parameters to their constructor methods, so that properties are set as soon as the object is instantiated. If the constructor method of the class accepts parameters, you pass those parameters to the constructor method when you instantiate the class.

```csharp
myCustomer = new Customer("Sasha");
```

Below is an example of a constructor that takes multiple parameters.

```csharp
myCustomer = new Customer(fname, lname, age, occupation);
```

As with constructors generally, constructors are used to provide your object with any initial data they might need at the time the object is created. Not all object will need any initial data to do their job, but some objects you create might require some initial data to get started.