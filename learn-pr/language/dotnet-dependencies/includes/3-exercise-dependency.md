The developers at Tailwind Traders realize that they're about to put extensive resources into developing apps for the .NET platform. These apps are going to display a lot of data to users that are human readable include dates, times, and numbers. .NET has the capabilites to do this, but the developers are certain someone has solved this problem. So they need a framework, and after some seraching, they've found Humanizer in the NuGet package registry. It seems to be widely used and promises to meet all of your .NET needs for manipultating and displaying strings, enums, dates, times, timespans, numbers, and quantities. At this point, they just want you to install Humanizer, write a couple of data manipulations, and run them to see if Noda Time delivers on its promise.

## Setup a new .NET project

1. Open a terminal window.

1. Create a new .NET console application by running this command:

    ```bash
    dotnet new console -n ManipulateData
    ```

1. Go to your files by running this command: 

    ```bash
    cd ManipulateData
    ```
    
    You should now have access to these files:
    ```bash
    -| bin
    -| obj
    -| ManipulateData.csproj
    -| Program.cs
    ```

1. Run the application by typing this command in the terminal:
    
    ```bash
    dotnet run
    ```

    You should see this output:

    ```output
    Hello World
    ```

## Add a NuGet package by ussing the dotnet tool 

1. Open the project in a code editor. If you are using Visual Studio Code, run this command to open the project: 

    ```bash
    code .
    ```

1. Open Program.cs. It should look like this:
    
    ```csharp
    using System;

    namespace ManipulateData
    {
        class Program
        {
            static void Main(string[] args)
            {   
                Console.WriteLine("Hello World");
            }
        }    
    }
    ```

    The preceeding function is run at the start of the application and outputs a string to the console. Let's add Humanizer and manipulate data and write it to the console.

1. Install the Humanizer library by running this command:

    ```bash
    dotnet add package Humanizer --version 2.7.9
    ```


    Open the ManipulateData.csproj file and find the `ItemGroup` section. You should now have an entry that looks like this one:

    ```xml
    <ItemGroup>
        <PackageReference Include="Humanizer" Version="2.7.9 />
    </ItemGroup>
    ```

1. Add the following content at the top of the Program.cs file to initialize Humanize:

    ```csharp
    using Humanizer;
    ```

1. Add the following content to the Program.cs file under the `Program` class

    ```csharp
    static void HumanizeQuantities()
    {
        Console.WriteLine("case".ToQuantity(0));
        Console.WriteLine("case".ToQuantity(1));
        Console.WriteLine("case".ToQuantity(5));
    }

    static void HumanizeDates()
    {
        Console.WriteLine(DateTime.UtcNow.AddHours(-24).Humanize());
        Console.WriteLine(DateTime.UtcNow.AddHours(-2).Humanize());
        Console.WriteLine(TimeSpan.FromDays(1).Humanize());
        Console.WriteLine(TimeSpan.FromDays(16).Humanize());
    }
    ```

1. Update the `Main` method to call the new methods:
    
    ```csharp
    static void Main(string[] args)
    {   
        Console.WriteLine("Quantities:");
        HumanizeQuantities();

        Console.WriteLine("\nDate/Time Manipulation:");
        HumanizeDates();
    }
    ```

1. Run the application by typing this command in the terminal:

    ```bash
    dotnet run
    ```

    You should see the following output:

    ```output
    Quantities:
    0 cases
    1 case
    5 cases

    Date/Time Manipulation:
    yesterday
    2 hours ago
    1 day
    2 weeks
    ```

Congratulations. You've managed to successfully install Humanizer as a dependency and write logic for application code to make data more human readable. Humanizer seems to deliver on its promise, and Tailwind Traders is likely to be happy with this evaluation.


