

When you have finished defining a class, you're ready to start creating instances and invoking properties, methods, and any other accessible members on the instances.

##Declaring an Object from a Class

In order to create an object, you must declare a variable of the class type you'll store in the variable.

The following example declares a variable myCustomer of type Customer. The Customer type is based on the Customer class:
```CSharp
Customer myCustomer;
```

##Creating an Instance of a Class

To allocate memory and create an instance of a class, use the new operator followed by the class type that you want to create an instance of. Lastly, you can provide any parameters that you want to pass into the constructor. The constructor returns the new instance of the class.

The general syntax for creating an instance of a class is as follows:
```CSharp
variable-name = new class-name(constructor-parameter-values);
```
For example, the following code instantiates the myCustomer object:
```CSharp
myCustomer = new Customer();
```
You can also declare and instantiate a class in a single line of code. The following example declares the myCustomer object and instantiates the class in one line.
```CSharp
Customer myCustomer = new Customer(param1, param2);
```
Question: Can you call a method in a class after you have finished declaration?