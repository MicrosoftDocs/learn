


Developers use namespaces to organize classes into logically related hierarchies. Namespaces function as both an internal system for organizing your application and as a way to avoid name clashes in your code. Name clashes can occur if you have classes with the same name within the same namespace.

Although your IDE will create a namespace for you based on the name of your project initially, as a beginner, you may not have a need to create your own namespace(s). It's helpful, however, to know what they are and how they are used. One day you may find a need to organize your own code into namespaces. Also, at some point, you will definitely want to include code from the .NET library and you will need to know the namespace the code is in to be able to access it.

## Definition and features of namespaces

There are two kinds of namespaces, user-defined namespaces and system-defined namespaces. Each namespace contains classes that your program uses. System-defined namespaces are the namespaces used to organize the .NET Framework class library, so you can find pieces of functionality you might need in your application. User-defined namespaces are similarly used to organize classes, but they are namespaces you define in your code. The first example of a user-defined namespace shows you the keyword `namespace` followed by the name of the namespace you are using. You can create and modify the code in the namespaces that you create, but system-defined namespaces are only used so that you can include code from the .NET Framework libraries in your code.

>[!Note]Because different classes can have the same name, you can organize your classes into different namespaces. You can use this practice to avoid naming clashes that cause your code to crash.


### User defined namespaces
This example demonstrates that you create a namespace using the `namespace` keyword. The code in your namespace can then be accessed from any another namespace by prefixing the namespace name followed by the "." operator and class name to access the classes in the namespace.
```csharp
namespace Housing_Development_Project_1
{
   // The classes in your namespace go here
}
```

### System defined namespaces
This example show how both the system-defined and user-defined namespaces are used in an application. They are listed at the top of your file in what are called `using` statements. Any library you want to access that is not a part of your current namespace must be included in a `using` statement, including any user-defined namespaces you create. In this example you see several using statements for the `System` namespace, as well as a user-defined namespace. Finally, you can see that those system and user defined namespaces are ready to be accessed from within the `Another_namespace_here` namespace. 
```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Housing_Development_Project_1

namespace Another_namespace_here
{
   // Code goes here
}
```

## Define a user-defined namespace

You can define a namespace for your classes using the keyword namespace.

In the following code example, you see a `House` class in the `Housing_Development_Project_1` namespace.

```csharp
namespace Housing_Development_Project_1
{
   internal class House
   {       
   }
}
```

When you refer to the class in your code, you can prefix the class name with the namespace to access the classes in that namespace.

```csharp
namespace.Class variableName = new namespace.class(parameters);
```

The following code declares and instantiates an instance of the `House` class in the `Housing_Development_Project_1` namespace, and puts it in a variable called `house`.

```csharp
Housing_Development_Project_1.House house = new Housing_Development_Project_1.House();
```

As previously mentioned, if you use many classes from the same namespace, you can import the namespace with the `using` statement. When you import a namespace with a `using` statement, you no longer need to specify the namespace as a prefix when you declare and instantiate the class.