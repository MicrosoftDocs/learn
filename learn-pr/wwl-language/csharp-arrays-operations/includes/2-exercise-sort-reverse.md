




The `Array` class contains methods that you can use to manipulate the content, arrangement, and size of an array. In this exercise, you'll write code that performs various operations on an array of pallet identifiers. Your code could be the start of an application to track and optimize the usage of pallets for the company.

### Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities will help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

1. Open Visual Studio Code.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. On the Visual Studio Code **File** menu, select **Open Folder**.

1. In the **Open Folder** dialog, navigate to the Windows Desktop folder.

    If you have different folder location where you keep code projects, you can use that folder location instead. For this training, the important thing is to have a location that’s easy locate and remember.

1. In the **Open Folder** dialog, select **Select Folder**.

    If you see a security dialog asking if you trust the authors, select **Yes**.

1. On the Visual Studio Code **Terminal** menu, select **New Terminal**.

    Notice that a command prompt in the Terminal panel displays the folder path for the current folder. For example:  

    ```dos
    C:\Users\someuser\Desktop>
    ```

    > [!NOTE]
    > If working on your own PC, rather than in a sandbox or hosted environment, and you have completed other Microsoft Learn modules in this C# series, you may have already created a project folder for code samples. If that's the case, you can skip over the next step, which is used to create a console app in the TestProject folder.

1. At the Terminal command prompt, to create a new console application in a specified folder, type **dotnet new console -o ./CsharpProjects/TestProject** and then press Enter.

    This .NET CLI command uses a .NET program template to create a new C# console application project in the specified folder location. The command creates the CsharpProjects and TestProject folders for you, and uses TestProject as the name of the `.csproj` file.

1. In the EXPLORER panel, expand the **CsharpProjects** folder.

    You should see the TestProject folder and two files, a C# program file named Program.cs and a C# project file named TestProject.csproj.

1. In the EXPLORER panel, to view your code file in the Editor panel, select **Program.cs**.

1. Delete the existing code lines.

    You'll be using this C# console project to create, build, and run code samples during this module.

1. Close the Terminal panel.

### Create an array of pallets, then sort them

1. Ensure that you have Visual Studio Code open and Program.cs displayed in the Editor panel.

    > [!NOTE]
    > Program.cs should be empty. If if isn't, select and delete all code lines.

1. Type the following code into the Visual Studio Code Editor:

    ```csharp
    string[] pallets = { "B14", "A11", "B12", "A13" };

    Console.WriteLine("Sorted...");
    Array.Sort(pallets);
    foreach (var pallet in pallets)
    {
        Console.WriteLine($"-- {pallet}");
    }

    ```

1. Take a minute to review the `Array.Sort(pallets);` line from the previous code you added.

    Here you're using the `Sort()` method of the `Array` class to sort the items in the array alphanumerically.

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

    You should see the following output:

    ```Output
    Sorted...
    -- A11
    -- A13
    -- B12
    -- B14

    ```

### Reverse the order of the pallets

1. To reverse the order of the pallets using the `Array.Reverse()` method, update your code as follows:

    ```csharp
    string[] pallets = { "B14", "A11", "B12", "A13" };

    Console.WriteLine("Sorted...");
    Array.Sort(pallets);
    foreach (var pallet in pallets)
    {
        Console.WriteLine($"-- {pallet}");
    }

    Console.WriteLine("");
    Console.WriteLine("Reversed...");
    Array.Reverse(pallets);
    foreach (var pallet in pallets)
    {
        Console.WriteLine($"-- {pallet}");
    }

    ```

1. Focus on the line of code `Array.Reverse(pallets);` line from the previous code you added.

    Here, you're using the `Reverse()` method of the `Array` class to reverse the order of items.

1. Save your code file, and then use Visual Studio Code to run your code. You should see the following output:

    ```Output
    Sorted...
    -- A11
    -- A13
    -- B12
    -- B14

    Reversed...
    -- B14
    -- B12
    -- A13
    -- A11

    ```

## Recap

Here's a few important ideas that you covered in this unit:

- The Array class has methods that can manipulate the size and contents of an array.
- Use the `Sort()` method to manipulate the order based on the given data type of the array.
- Use the `Reverse()` method to flip the order of the elements in the array.