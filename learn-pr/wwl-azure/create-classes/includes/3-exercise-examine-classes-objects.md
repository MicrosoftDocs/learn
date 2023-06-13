

As previously mentioned, C# is an object-oriented programming language that uses classes and objects. When you create a C# application, you define classes that represent the main data types in your application. You must define a class before you can create objects of that data type.

## What is a class?

To reiterate, a class is a blueprint that you can use to create objects. A class defines the characteristics of an object, such as the data that the object contains, and the operations that the object can perform.

## What is an object?

An object is an instance of a class. If a class is a blueprint, an object is what you create from that blueprint. The class is the definition of an item, while the object is the item itself. 

When you write a class definition with methods and perhaps properties as well, you do what is called instantiating that object, or putting it in memory. The process of instantiating an object is often referred to as “newing” an object, as the keyword for creating the in-memory representation of your class uses the word `new`.

```csharp
House house = new House();
```

>[!Note] The term instance is often used as an alternative to object.

## Exercise - Try it out

This exercise has you create a House class and instantiate it, initializing the object by passing parameters into the constructor.

1.	Open Visual Studio Community.

2.	Create a new project by selecting “Create a new project” on the start page.

3.	Select “Console App (.NET Core)” from the list of templates and select “Next”.

4.	Name your project *Housing Development Project 1* and choose a location for it, then select next.

5.	Select “Create” to create your project.

6.	In the Solution Explorer, right-click on your project and select “Add” > “Class”.

7.	Name your class “House” and select “Add”.

8.  In your House class, add a public `string` variable called `exteriorColor`.

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
            public string exteriorColor;

        }
    }
    ```
9.  Now add a public `int` variable called `sqrFeet`.

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
            public string exteriorColor;
            public int sqrFeet;

        }
    }
    ```

10. Create a constructor to initialize your object, as pictured.

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
            public string exteriorColor;
            public int sqrFeet;

            public House(string houseExteriorColor, int houseSquareFeet)
            {
                exteriorColor = houseExteriorColor;
                sqrFeet = houseSquareFeet;
            }
        }
    }
    ```

11.	In your Program.cs file, create a house object called 'myHouse', passing in a color and square feet. Delete any existing placeholder content in the file.

    ```csharp
        using Housing_Development_Project_1 // this statement is automatically generated

        House myHouse = new House("light grey", 2000);
    ```

>[!Note]
>The namespace is automatically inserted into Program.cs as a "using" statement, meaning that Program.cs is *using* the classes in that namespace. In Visual Studio 2022 the namespace, class, and Main method information is not visible, but exist behind the scene. Because you have already created a class (House) that has this namespace, when you reference it here the namspace is automatically inserted in Program.cs in a *using* statement, letting you know that it is the namespace being used.


12.	Use Console.WriteLine to display the values you initialized in your object.

    ```csharp
        using Housing_Development_Project_1 // this statement is automatically generated

        House myHouse = new House("light grey", 2000);
        Console.WriteLine("You initialized this object with the following values:");
        Console.WriteLine("Color: " +  myHouse.exteriorColor + "  Square feet: " + myHouse.sqrFeet);
    ```

Your code should look like this.

#### House.cs

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
        public string exteriorColor;
        public int sqrFeet;

        public House(string houseExteriorColor, int houseSquareFeet)
        {
            exteriorColor = houseExteriorColor;
            sqrFeet = houseSquareFeet;
        }
    }
}
```

#### Program.cs

```csharp
using Housing_Development_Project_1 // this statement is automatically generated

House myHouse = new House("light grey", 2000);
Console.WriteLine("You initialized this object with the following values:");
Console.WriteLine("Color: " +  myHouse.exteriorColor + "  Square feet: " + myHouse.sqrFeet);
```

13. Run your code. The output should look like this.

![Screenshot showing Visual Studio output.](../media/1-output.jpg)

Congratulations on making it this far! We talk more about constructors and initializing objects in *Class Constructors* later in this course.
