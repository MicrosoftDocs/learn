


Developers use namespaces to organize classes into logically related hierarchies. Namespaces function as both an internal system for organizing your application and as an external way to avoid name clashes in your code. Name clashes can occur if you have classes with the same name within the same namespace. While you may not use namespaces in your code as a beginner, it's helpful to understand that they exist and how to use them for when you're ready to use them.

## Definition and features of namespaces

Each namespace contains classes that your program uses. Because different classes can have the same name, you should organize your classes into different namespaces. You can use this practice to avoid naming clashes that cause your code to crash.

Namespaces come in two categories: user-defined, and system-defined. System-defined namespaces are the namespaces used to organize the .NET Framework class library. User-defined namespaces are namespaces you define in your code.

## Define a user-defined namespace

You can define a namespace for your classes using the keyword namespace.

In the following code example, you create a `House` class in the `Housing_Development_Project_1` namespace.

```csharp
namespace Housing_Development_Project_1

{
   internal class House
   {
   }

}

```

When you refer to the class in your code, you prefix the class name with the namespace.

```csharp
namespace.Class variableName = new namespace.class(parameters);
```

The following code declares and instantiates an instance of the `House` class in the `Housing_Development_Project_1` namespace, and puts it in a variable called `house`.

```csharp
Housing_Development_Project_1.House house = new Housing_Development_Project_1.House();
```

If you use many classes from the same namespace, or the same class repeatedly, you can import the namespace with the using (Visual C#) or imports statement. When you import a namespace, you no longer need to specify the namespace as a prefix when you declare and instantiate the class.