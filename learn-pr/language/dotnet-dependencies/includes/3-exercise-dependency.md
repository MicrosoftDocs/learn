The developers at Tailwind Traders realize that they're about to put extensive resources into developing apps for the .NET platform. These apps are going to display human-readable data to users, including dates, times, and numbers. 

.NET has the capabilities to do this, but the developers are certain someone has solved this problem. They need a framework. After some searching, they've found Humanizer in the NuGet package registry. It seems to be widely used and promises to meet all of their .NET needs for manipulating and displaying strings, enumerations, dates, times, timespans, numbers, and quantities.

At this point, the developers want you to install Humanizer, write a couple of data manipulations, and run them to see if Humanizer delivers on its promise.

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet6-sdk-version.md)]

## Create a sample .NET project

To set up a .NET project to work with dependencies, we'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **DotNetDependencies** in the location of your choice, and then select **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new console -f net6.0
    ```

    This command creates a **Program.cs** file in your folder with a basic "Hello World" program already written, along with a C# project file named **DotNetDependencies.csproj**.

    You should now have access to these files.

    ```bash
    -| obj
    -| DotNetDependencies.csproj
    -| Program.cs
    ```

1. In the terminal window, copy and paste the following command to run the "Hello World" program.

    ```dotnetcli
    dotnet run
    ```

The terminal window displays "Hello World!" as output.

:::image source="../media/new-dotnet-project.png" alt-text="Screenshot of Visual Studio Code with a new console application.":::

## Set up Visual Studio Code for .NET debugging

Open Program.cs. The first time you open a C# file in Visual Studio Code, you'll get a prompt to install recommended extensions for C#. Select the **Install** button in the prompt.

:::image source="../media/install-recommended-extensions.png" alt-text="Screenshot of the Visual Studio Code prompt for recommended extensions.":::

Visual Studio Code installs the C# extension. It shows an additional prompt to add required assets to build and debug your project. Select **Yes**.

:::image source="../media/install-required-assets.png" alt-text="Screenshot of the Visual Studio Code prompt for required assets.":::

You can close the **Extension: C#** tab to focus on the code we'll be writing.

## Add a NuGet package by using the .NET Core tool

1. Open **Program.cs**. It should look like this:

    ```csharp
    Console.WriteLine("Hello, World!");
    ```

    The preceding function is run at the start of the application and outputs a string to the console. Let's add Humanizer and manipulate data and write it to the console.

1. Install the Humanizer library by running the following command:

    ```dotnetcli
    dotnet add package Humanizer --version 2.7.9
    ```

    Open the **DotNetDependencies.csproj** file and find the `ItemGroup` section. You should now have an entry that looks like this one:

    ```xml
    <ItemGroup>
        <PackageReference Include="Humanizer" Version="2.7.9" />
    </ItemGroup>
    ```

1. Add the following content at the top of the Program.cs file to initialize Humanizer:

    ```csharp
    using Humanizer;
    ```

    Your **Program.cs** should now look like this:

    ```csharp
    using Humanizer;

    Console.WriteLine("Hello, World!");
    ```

1. Add the following content to the Program.cs file to the bottom of file under the `Console.WriteLine("Hello, World!");`:

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

1. Replace the `Console.WriteLine("Hello, World!");` with the following code:

    ```csharp
    Console.WriteLine("Quantities:");
    HumanizeQuantities();

    Console.WriteLine("\nDate/Time Manipulation:");
    HumanizeDates();
    ```

1. Save the file (**File** > **Save** or <kbd>CTRL + S</kbd>). Run the application by running the following command in the terminal:

    ```dotnetcli
    dotnet run
    ```

    You should get the following output:

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

Congratulations. You've successfully installed Humanizer as a dependency and written logic for application code to make data more human-readable. Humanizer seems to deliver on its promise, and Tailwind Traders is likely to be happy with this evaluation.
