

As previously mentioned, C# is an object-oriented programming language that uses classes and objects. When you create a C# application, you define classes that represent the main data types in your application. You must define a class before you can create objects of that data type.

## What is a class?

To reiterate, a class is a blueprint that you can use to create objects. A class defines the characteristics of an object, such as the data that the object contains, and the operations that the object can perform.

## What is an object?

An object is an instance of a class. If a class is a blueprint, an object is what you create from that blueprint. The class is the definition of an item, while the object is the item itself.

When you write a class definition with methods and perhaps properties as well, you do what is called instantiating that object, or putting it in memory. The process of instantiating an object is often referred to as “newing” an object, as the keyword for creating the in-memory representation of your class uses the word `new`.

```csharp
House house = new House();
```

> [!NOTE] The term "class instance", or just "instance", is often used as an alternative to object.

## Exercise - Try it out

This exercise has you create a House class and instantiate it, initializing the object by passing parameters into the constructor.

## Create a project called Housing Development Project 1

1. Open Visual Studio Community.

1. Create a new project by selecting “Create a new project” on the start page.

1. Select “Console App (.NET Core)” from the list of templates and select “Next”.

1. Name your project *Housing Development Project 1* and choose a location for it, then select next.

1. Select “Create” to create your project.

## Create a new class

6. In the Solution Explorer, right-click on your project and select “Add” > “Class”.

1. Name your class “House” and select “Add”.

## Add a constructor

Add a constructor to initialize a House class variable. Let's begin by creating the variable you want to initialize. 

8. In your House class, add a public `string` variable called `_exteriorColor`.

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    namespace Housing_Development_Project_1
    {
        internal class House
        {
            public string _exteriorColor;

        }
    }
    ```

1. Now create a constructor to initialize your variable.

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    namespace Housing_Development_Project_1
    {
        internal class House
        {
            public string _exteriorColor;

            public House(string houseExteriorColor)
            {
                _exteriorColor = houseExteriorColor;
            }
        }
    }
    ```

## Add a property

Now add a property so that you can retrieve the house color value you initialized the House object with. In addition to a `get` property, let's also greate a `set` property, in case you want to change the value.

10. In your House class, add a public `string` variable called `exteriorColor`.

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    namespace Housing_Development_Project_1
    {
        internal class House
        {
            public string _exteriorColor;

            public House(string houseExteriorColor)
            {
                _exteriorColor = houseExteriorColor;
            }

            public string ExteriorColor
            {
                get { return _exteriorColor; }
                set { _exteriorColor = value; }
            }
        }
    }
    ```

## Add a method

Next you can add a method to calculate the square footage of the house based on the with and length of the house.

11. Add the method `GetSquareFootage`. It should take two `double` parameters and return a `double`, as seen below.

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    namespace Housing_Development_Project_1
    {
        internal class House
        {
            public string _exteriorColor;

            public House(string houseExteriorColor)
            {
                _exteriorColor = houseExteriorColor;
            }

            public string ExteriorColor
            {
                get { return _exteriorColor; }
                set { _exteriorColor = value; }
            }

            public double GetSquareFootage(double height, double width)
            {
                return height * width;
            }
        }
    }
    ```

## Putting it all together

12. In your Program.cs file, create a house object called `myHouse`, initializing the house color variable.

    Be sure to delete any existing placeholder content in the file.

    ```csharp
        using Housing_Development_Project_1 // this statement is automatically generated

        House myHouse = new House("light grey", 2000);
    ```

    > [!NOTE]
    > The namespace is automatically inserted into Program.cs as a "using" statement, meaning that Program.cs is *using* the classes in that namespace. In Visual Studio 2022 the namespace, class, and Main method information is not visible, but exist behind the scene. Because you have already created a class (House) that has this namespace, when you reference it here the namspace is automatically inserted in Program.cs in a *using* statement, letting you know that it is the namespace being used.

1. Use Console.WriteLine to display the house color value you initialized in your object.

    ```csharp
    using Housing_Development_Project_1 // this statement is automatically generated

    House myHouse = new House("light grey", 2000);
    Console.WriteLine("You initialized this object with the following house color:");
    Console.WriteLine("Color: " +  myHouse.ExteriorColor);

    Console.WriteLine("Calculate square feet: " +  myHouse.GetSquareFootage(220.7, 110.5));
    ```

1. Run your code.

    You output should look like the following:

    ![Screenshot showing Visual Studio output.](../media/1-output.jpg)

Congratulations on making it this far! We talk more about constructors and initializing objects in *Class Constructors* later in this course.
