

You use namespaces to organize classes into logically related hierarchies. They function as both an internal system for organizing your application and as an external way to avoid name clashes in your code. Name clashes can occur if you have classes with the same name within the same namespace. While you may not use namespaces in your code as a beginner, it's helpful to understand that they exist and how to use them for when you're ready to use them.

## Definition and features of namespaces

Each namespace contains classes that your program uses. Because different classes can have the same name, you should organize your classes into different namespaces. You can use this practice to avoid naming clashes that cause your code to crash.

## User-defined namespaces

Namespaces come in two categories: user-defined, and system-defined. System-defined namespaces are the namespaces used to organize the .NET Framework class library. User-defined namespaces are namespaces you define in your code.

Defining a User-Defined Namespace

You can define a namespace for your classes using the keyword namespace.

In the following code example, you create a Shipping class in the Inventory namespace.
```CSharp
namespace HomeStyle
{
    class House(string style, int sqrFootage)
    {
        // members of House class
    }
}
```

When you refer to the class in your code, you prefix the class name with the namespace.
```CSharp
namespace.Class variableName = new namespace.class(parameters);
```

The following code declares and instantiates an instance of the House class in the HouseStyle namespace, and puts it in a variable called house.
```CSharp
HomeStyle.House house = new HomeStyle.House();
```

If you use many classes from the same namespace, or the same class repeatedly, you can import the namespace with the using (Visual C#) or imports statement. When you import a namespace, you no longer need to specify the namespace as a prefix when you declare and instantiate the class.

&nbsp;
## Check your knowledge

## Multiple choice
How do you access a class that is in another namespace?
( ) Provide a link to the other namespace. {{Incorrect. You do not create links to other namespaces to access them.}}
( ) You don't need to do anything, namespaces are global and their contents are available everywhere. {{Incorrect. This answer is incorrect, as namespaces are not global.}}
(x) Prefix your object with the name of the namespace it belongs to. {{Correct! The way you access objects in another namespace is prefix the name of your object with the name of the class that belongs to it.}}

Why would two classes be in the same namespace?
( ) To avoid collisions. {{Incorrect. Although classes are put in separate namespaces to avoid crashes, classes are not put in the same namespace to avoid crashes (class naming conflicts).}}
( ) Because they are of the same type. {{Incorrect. Classes of the same name/type are put in different namespaces to avoid name conflicts.}}
(x) Because they perform related functionality. {{Correct! Classes are put in namespaces to avoid name conflicts and because they share related functionality.}}
