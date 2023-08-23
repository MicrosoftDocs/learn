


Typically, a method is created to perform a specific task. In this exercise, you'll create a method that generates and displays five random numbers. Let's get started!

## Prepare your coding environment

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

## Create a method to display random numbers

To create a method, first create a method signature and then add the method body. To create the method signature, you declare the return type, method name, and parameters. Create the method body by using brackets `{}` that contain the code.

1. Enter the following code into the Visual Studio Code editor:

    ```c#
    void DisplayRandomNumbers();
    ```

    In this case, the method just needs to generate and display information, so the return type is `void`. For now, you don't need to include any parameters.

1. To create the method body, remove the semicolon `;` and update your code to the following:

    ```c#
    void DisplayRandomNumbers() 
    {
        Random random = new Random();
    }
    ```

    Here, you create a `Random` object that is used to generate the numbers.

1. To display five random integers, add a `for` loop to your method:

    ```c#
    void DisplayRandomNumbers() 
    {
        Random random = new Random();

        for (int i = 0; i < 5; i++) 
        {
            Console.Write($"{random.Next(1, 100)} ");
        }
    }
    ```

    In this code, you generate a number between 1 and 99 (inclusive). You also add a space after the number is printed. Next, you'll display a new line before the method terminates.

1. Update your method with the following code:

    ```c#
    void DisplayRandomNumbers() 
    {
        Random random = new Random();

        for (int i = 0; i < 5; i++) 
        {
            Console.Write($"{random.Next(1, 100)} ");
        }

        Console.WriteLine();
    }
    ```

    Now your method will add a new line after displaying the numbers.

### Call your method

1. Enter a new blank code line above the `DisplayRandomNumbers` method.

1. Enter the following code on the new blank code line:

    ```c#
    Console.WriteLine("Generating random numbers:");
    DisplayRandomNumbers();

    ```

1. Compare your code with the following to ensure it's correct:

    ```c#
    Console.WriteLine("Generating random numbers:");
    DisplayRandomNumbers();

    void DisplayRandomNumbers() 
    {
        Random random = new Random();

        for (int i = 0; i < 5; i++) 
        {
            Console.Write($"{random.Next(1, 100)} ");
        }

        Console.WriteLine();
    }
    ```

    Notice how using a method makes the code easy to understand. Rather than spending time trying to decipher the `for` loop on its own, you can quickly read the method name to learn that this code displays random numbers.

## Check Your Work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. To verify that your code is working as expected, check that the output of your application is similar to the following output (taking into account the randomly generated numbers):

    ```Output
    17 29 46 36 3 
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

## Recap

Here's what you've learned about methods so far:

- Create a method by declaring the return type, name, input parameters, and method body.
- Method names should clearly reflect the task the method performs.
- Use a method by calling its name and including parentheses `()`.