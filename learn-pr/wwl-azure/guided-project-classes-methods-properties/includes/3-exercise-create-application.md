In this exercise, you get started with our project. you'll create the LangtonsAnts console application and start working on the Program.cs file code. In our Program.cs file, you create a two-dimensional byte array that is our grid (or playing field) and then check our progress.

In the upcoming exercises, you're using the Program.cs file to create an instance of the Game class and run Langton's Ant game simulation in the console.

## Create a new console application

Let's begin by creating a new VS Code console application project.

1. Open a command prompt on your desktop in the directory of your choosing for the project.

1. Verify that you're using the .NET 6.0 or above by typing `dotnet --version` and pressing enter.

1. Create your project by typing the type of application you want to create, its directory, and name for your application: 'dotnet new console -o LangtonsAnts' and press enter.

1. Type 'cd LangtonsAnts' to change your current directory to your newly created application folder.

1. Open your new project in VS Code by typing: 'code .' and press enter.

VS Code will open the project you created. Now you can launch a terminal window inside VS Code and run your starter 'Hello World' application to make sure you created your console application correctly.

1. From the View menu, select Terminal.

1. To run your application, in the terminal window type 'dotnet run' and press enter.

    >[!NOTE]
    >You can close the default Welcome file that is created for you by VS Code.

Now that you have created the basic plumbing for a console application, meaning that your application runs in the little window called a console, you're ready to add files to it. Let's begin, however, by modifying the Program.cs file that VS Code created for you.

You'll create a two dimensional (16x16) byte array that represents our grid for the ants. You then display it by creating a nested looping structure that prints characters to the screen showing our cell locations. The outer loop is creating our horizontal cells (x-axis), while our inner loop is stacking each row as it builds out the vertical axis.

## Create a two-dimensional integer array

1. Open your Program.cs file and delete the starter code in the file.

1. Next, add the following two dimensional byte array for the grid:
   `int[,] field = new int[16, 16];`

## Create loops

Now you'll need to be able to loop through each position in your two-dimensional array to create the grid or field.

1. First, create the outer `for` loop.

    ```csharp
    for(int i = 0; i < field.GetLength(0); i++) {
        // You will put stuff here
    }
    ```

1. Then create the inner `for` loop.

    ```csharp
    for(int i = 0; i < field.GetLength(0); i++) {
        for(int j = 0; j < field.GetLength(1); j++){
            // You will put stuff here
        }
    }
    ```

1. Now add grid characters and spacing using Console.Write and Console.WriteLine statements to the inner body of the loop so you can see the grid you created.

    ```csharp
    for(int i = 0; i < field.GetLength(0); i++) {
        for(int j = 0; j < field.GetLength(1); j++){
            Console.Write($"{field[i, j]}  ");
        }
        Console.WriteLine();
    }
    ```

1. Save your work by typing Ctrl-S and press enter.

## Check your work

Build the project and launch the application. 

1. Build your project by typing 'dotnet build' in your terminal window and pressing enter.

1. Run the project by typing 'dotnet run' and pressing enter.

![Screenshot showing Visual Studio Code installer.](../media/guided-proj-1.jpg)

You should see a representation of the grid printed to the screen using 0s and spaces, as shown. Make sure it outputs the array you created with each “row” printed on a separate line.
