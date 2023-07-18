

When you have finished defining a class, you're ready to start creating instances and invoking its properties and methods.

## Declare an object from a class

In order to create an object, you must declare a variable of the class type you'll store in the variable.

The following example declares a variable myCustomer of type Customer. The Customer type is based on the Customer class:

```csharp
Customer myCustomer;
```

>[!Note] It is important to note here the difference between declaring a variable and creating an instance of a class. When you declare a variable you are earmarking memory to be allocated for that object, but not actually using that memory. When you both declare an object and instantiate it at the same time you are both creating an object and putting it in your variable of that type.

## Create an instance of a class

To allocate memory and create an instance of a class, use the `new` keyword followed by the class type that you want to create an instance of. Lastly, you can provide any parameters that you want to pass into the constructor to initialize your object. The constructor returns the new instance of the class.

The general syntax for creating an instance of a class is as follows:

```csharp
variable-name = new class-name(constructor-parameter-values);
```

For example, the following code instantiates the myCustomer object:

```csharp
myCustomer = new Customer();
```

Here is an example of both declaring and then instantiating a class in a single line of code. The following example declares the myCustomer object and instantiates the class in one line. Declaring and instantiating you objects in a single line is typically how objects are instantiated.

```csharp
Customer myCustomer = new Customer(param1, param2);
```

&nbsp;