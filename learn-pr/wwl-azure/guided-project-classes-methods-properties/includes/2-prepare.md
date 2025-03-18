You use the VS Code Editor as your code development environment. You create a console application and write code to create a class that has a constructor and properties. The class also reads user input.

## Project overview

You’re developing an application that demonstrates Langton’s Ant, which is based on the concept of a universal Turing machine invented by mathematician Alan Turing. The application showcases the computation logic that Mr. Turing came up with. To create the demonstration, you need to create an ant and define its movement rules using inputs from the grid. Mr. Turing’s universal machine is still used as a model for how computers work today from a logical standpoint.

The application simulates ants on a grid and their movements. Along the way, you create classes, methods, and properties that model your application.

In the upcoming exercises, you're using the Program.cs file to create an instance of the Game class and run the Langton's Ant game simulation in the console.

A few things to keep in mind:

- Squares on a plane are colored variously either black or white.
- You arbitrarily identify one square as the "ant".
- The ant can travel in any of the four cardinal directions at each step it takes.

The "ant" moves according to these rules:

- At a white square, turn 90° clockwise, flip the color of the square, move forward one unit.
- At a black square, turn 90° counter-clockwise, flip the color of the square, move forward one unit.

## Setup

You are just embarking on writing the Langton's Ant code, therefore, there is no previous code that needs to be set up.

You need to be sure that you are using the latest version of VS Code and that you are using .NET version 7 or above.