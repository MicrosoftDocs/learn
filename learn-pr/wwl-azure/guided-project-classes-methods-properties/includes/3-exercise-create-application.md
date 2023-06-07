

In this exercise, we get started with our project. We'll create the LangtonsAnt console application and start working on the Program.cs file code. In our Program.cs file, we create a two-dimensional byte array that is our grid and then check our progress.

In the upcoming exercises, we are using the Program.cs file to create an instance of the Game class and run Langton's Ant game simulation in the console.

## Create a new console application

Let's begin by creating a new .NET 6.0 Console Application project with Visual Studio Community, the free community edition of Visual Studio.

1. Launch Visual Studio Community 2022.
1. Select *Create a new project* under Getting Started.
1. Select *Console App*, then select next.
1. Name your console app *LangtonsAnt*, then select next.
1. Verify that you're using the .NET 6.0, then select next.

Now that you have created the basic plumbing for a console application, meaning that your application runs in the little window we call a console, we're ready to add files to it. Let's begin, however, by modifying the Program.cs file.

You'll create a two dimensional (16x16) byte array that represents our grid for the ants. We then display it by creating a nested looping structure that prints characters to the screen showing our cell locations, as well building our vertical axis (or y-axis). The outer loop is creating our horizontal cells (x-axis), while our inner loop is stacking each row as it builds out the vertical axis.

## Create a two dimensional integer array
Open your Program.cs file and add the following code.

`int[,] field = new int[16, 16];`

## Create loops

1. Create outer `for` loop

    ```CSharp
    for(int i = 0; i < field.GetLength(0); i++) {
        // We will put stuff here
    }
    ```

1. Create inner `for` loop
    ```CSharp
    for(int i = 0; i < field.GetLength(0); i++) {
        for(int j = 0; j < field.GetLength(1); j++){
            // We will put stuff here
        }
    }
    ```

1. Add spacing and grid characters
    ```CSharp
    for(int i = 0; i < field.GetLength(0); i++) {
        for(int j = 0; j < field.GetLength(1); j++){
            Console.Write($"{field[i, j]}  ");
    	Console.WriteLine();
        }
    }
    ```

&nbsp;
&nbsp;

## Check your work

Build the project, and launch the application. Make sure it outputs the array you created with each “row” being printed on a separate line.

![Screenshot showing Visual Studio Code installer.](../media/guided-proj-1.jpg)