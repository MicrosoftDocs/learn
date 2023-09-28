


When creating methods, you'll often want to provide some information for the method to use. Information consumed by a method is called a parameter. You can supply as many parameters as needed to accomplish its task, or none at all.

The terms 'parameter' and 'argument' are often used interchangeably. However, 'parameter' refers to the variable in the method signature. The 'argument' is the value passed when the method is called.

## Add parameters to methods

Parameters in a method work similar to variables. A parameter is defined by specifying the data type followed by the name of the parameter. Parameters are declared in the method signature, and the values for the parameters are provided by the method caller instead of being initialized inside the method itself. Consider the following code:

	```c#
	CountTo(5);

	void CountTo(int max) 
	{
		for (int i = 0; i < max; i++)
		{
			Console.Write($"${i}, ");
		}
	}
	```

In this example, the method `CountTo` accepts an integer parameter named `max`. The parameter is referenced in the `for` loop of the method. When `CountTo` is called, the integer `5` is supplied as an argument.

In this exercise, you'll learn how to create and use your own method parameters.

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

## Create a method with parameters

In this task, you'll create a method that adjusts scheduled times to a different GMT time zone. The method should accept a list of times, the current time zone, and the new time zone. Let's get started!

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    int[] schedule = {800, 1200, 1600, 2000};
    ```

1. To create a method with parameters, enter the following code on a new blank line:

    ```c#
    void DisplayAdjustedTimes(int[] times, int currentGMT, int newGMT) 
    {
        
    }
    ```

    Notice that parameters are declared similar to the way you declare variables, using the data type followed by the variable name. You can use parameters of any data type, such as `string`, `bool`, `int`, arrays, and more! Multiple parameters in a method are always comma separated.

1. Enter the following code in the `DisplayAdjustedTimes` method:

    ```c#
    int diff = 0;
    if (Math.Abs(newGMT) > 12 || Math.Abs(currentGMT) > 12)
    {
        Console.WriteLine("Invalid GMT");
    }
    ```

    Notice how you don't have to declare the variables `newGMT` and `currentGMT` since they're already declared in the method signature. You also don't initialize the variables since the method assumes the caller supplies those arguments with assigned values.

    In this step, you create `int diff` to store the time difference and then check to see that the provided GMT values are between -12 and 12. Using `Math.Abs` gives you the absolute value of a number, so the GMT values are invalid if they're greater than 12.

1. To calculate the time difference, update the `DisplayAdjustedTimes` method as follows:

    ```c#
    int diff = 0;
    if (Math.Abs(newGMT) > 12 || Math.Abs(currentGMT) > 12)
    {
        Console.WriteLine("Invalid GMT");
    }
    else if (newGMT <= 0 && currentGMT <= 0 || newGMT >= 0 && currentGMT >= 0) 
    {
        diff = 100 * (Math.Abs(newGMT) - Math.Abs(currentGMT));
    } 
    else 
    {
        diff = 100 * (Math.Abs(newGMT) + Math.Abs(currentGMT));
    }
    ```

    In this code, you check to see whether you need to add or subtract the absolute values of the GMT time zones to get the difference in hours. If the GMT values share the same sign (both positive or both negative), then the hours difference is equal to the difference between the two numbers. If the GMT values have opposite signs, then the difference is equal to the sum of the two numbers. Since hours are represented in hundreds, you multiply the result by 100.

1. To display the results, enter the following code at the end of the `DisplayAdjustedTimes` method:

    ```c#
    for (int i = 0; i < times.Length; i++) 
    {
        int newTime = ((times[i] + diff)) % 2400;
        Console.WriteLine($"{times[i]} -> {newTime}");
    }
    ```

1. To call your method, enter the following code after the `int[] schedule` variable declaration:

    ```c#
    DisplayAdjustedTimes(schedule, 6, -6);
    ```

    Notice that both variables and literals can be supplied as arguments to a method. By using input parameters, the method isn't restricted to using the values of global variables.

## Check Your Work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

    ```Output
    800 -> 2000
    1200 -> 0
    1600 -> 400
    2000 -> 800
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

## Recap

Here's what you've learned about parameters so far:

- Information can be passed to methods in the form of parameters.
- Parameters are declared in the method signature.
- Multiple parameters are separated by commas.
- Methods can accept variable or literal arguments.