`for` loops, `if-else` statements, and methods all represent different types of code blocks. Each code block has its own 'scope'. 'Scope' is the region of a program where certain data is accessible. Variables declared inside a method, or any code block, are only accessible within that region. As programs become more complicated, this pattern helps programmers consistently use clearly named variables and maintain easy to read code.

In this exercise, you'll learn more about method scope by working with different types of methods and variables.

### Test variable scope

Statements declared outside of any code block are called top-level statements. Variables declared in top-level statements are called 'global variables'. Global variables aren't restricted to any scope, and can be used anywhere throughout the program. Global variables can be useful for different methods that need to access the same data. However, it's important to pay attention to variable names in different scopes.

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Enter the following code into the Visual Studio Code Editor:

    ```c#
    string[] students = {"Jenna", "Ayesha", "Carlos", "Viktor"};

    DisplayStudents(students);
    DisplayStudents(new string[] {"Robert","Vanya"});

    void DisplayStudents(string[] students) 
    {
        foreach (string student in students) 
        {
            Console.Write($"{student}, ");
        }
        Console.WriteLine();
    }
    ```

    In this code, you create a global `students` array, and a method `DisplayStudents` that accepts a parameter with the same name.

1. Save and run the code to observe the following output:

    ```Output
    Jenna, Ayesha, Carlos, Viktor, 
    Robert, Vanya, 
    ```

    Notice that the method parameter `student` takes precedence over the global `student` array. It's important to be deliberate about what global variables you want your methods to use.

1. Delete the previous code.

1. Enter the following code into the Editor:
    
    ```c#
    PrintCircleArea(12);

    void PrintCircleArea(int radius)
    {
        double pi = 3.14159;
        double area = pi * (radius * radius);
        Console.WriteLine($"Area = {area}");
    }
    ```

    This code calculates and displays the area of a circle.

1. Attempt to reference the variables inside of the `PrintCircleArea` method by updating your code as follows:

    ```c#
    PrintCircleArea(12);
    double circumference = 2 * pi * radius;
    ```

    Error messages appear informing you that the names `pi` and `radius` don't exist in the current scope. Those variables only exist within the `PrintCircleArea` method scope.

1. Delete the incorrect code and add the following code:

    ```c#
    void PrintCircleCircumference(int radius)
    {
        double pi = 3.14159;
        double circumference = 2 * pi * radius;
        Console.WriteLine($"Circumference = {circumference}");
    }
    ```

    Since the variable `pi` is set to the same fixed value and used in both methods, this value is a good candidate for a global variable. In this example, `radius` isn't a global variable so that you can call the methods with different values of `radius` without updating a variable each time.

1. Update your code to the following:

    ```c#
    double pi = 3.14159;

    void PrintCircleArea(int radius)
    {
        double area = pi * (radius * radius);
        Console.WriteLine($"Area = {area}");
    }

    void PrintCircleCircumference(int radius)
    {
        double circumference = 2 * pi * radius;
        Console.WriteLine($"Circumference = {circumference}");
    }
    ```

    Now both methods can reference the same value of `pi` without needing to define it. You might have already guessed that methods can call other methods. Generally, as long as a method is defined within the scope of your program, it can be called anywhere.

1. Add a new method to your code as follows:

    ```c#
    double pi = 3.14159;
    PrintCircleInfo(12);
    PrintCircleInfo(24);

    void PrintCircleInfo(int radius) 
    {
        Console.WriteLine($"Circle with radius {radius}");
        PrintCircleArea(radius);
        PrintCircleCircumference(radius);
    }
    ```

    In this code, you create a new method `PrintCircleInfo` to call the existing methods. The value of `radius` is also passed down to each method. Creating modularized methods can help keep your code organized and easy to read.

1. Save and run the code to observe the following output:

    ```Output
    Circle with radius 12
    Area = 452.38896
    Circumference = 75.39815999999999
    Circle with radius 24
    Area = 1809.55584
    Circumference = 150.79631999999998
    ```

## Recap

Here's what you've learned about method scope so far:

- Variables declared inside of a method are only accessible to that method.
- Variables declared in top-level statements are accessible throughout the program.
- Methods don't have access to variables defined within different methods.
- Methods can call other methods.