

In programming we call constants (values that do not change), variables, methods, and properties the data members, or members, of a class. To access a member on an instance, use the name of the instance, followed by a period, followed by the name of the member. The following rules and guidelines apply when you access a member on an instance:

## Using Properties

To access a property, use the property name as if it were a public field in the class. The compiler implicitly understands you want either the get accessor or the set accessor on the instance, depending on whether you're getting or setting the property value.

The following code sets the `name` property of the myCustomer object to “Sasha”. Setting the name of the property implicitly calls the `set` accessor. The next line of code *gets* (retrieves) the `name` text property, which implicitly calls the `get` accessor.
```CSharp
myCustomer.name="Sasha";

return myCustomer.name ;
```
## Using Methods

To access a method, use parentheses after the name of the method. Within the parentheses, pass the values for any parameters required by the method. If the method is overloaded, the compiler uses the number and types of your parameters to determine which version of the overloaded method to invoke.
The following example calls the calcDiscount method that accepts no parameters and returns no values.
```CSharp
myCustomer.calcDiscount();
```
The following example calls the calcDiscount method that passes back an integer value that specifies the customer discount:
```CSharp
int dsct = myCustomer.calcDiscount();
```

**Note**: Both methods and properties can be designed to accept reference types.

&nbsp;
## Check your knowledge

When are the get and set methods for a property called?
( ) At the begining of a foot race...ready...get set...go! {{Incorrect. This is a nonsense answer.}}
( ) When you don't have time to create a method. {{Incorrect. This is not a real reason you would choose to create a property.}}
(x) When you want to get or set the state of your object. {{Correct! They are used to get basic state or status information in and/or out of an object.}}
