In this starter code, we have a Langston's Ant simulation implemented in C#. The code includes some object-oriented programming concepts such as interfaces and inheritance. This project currently contains both a console application and a Windows Presentation Foundation (WPF) application. The WPF application is a graphical user interface (GUI) that helps you create visual graphics for the Langston's Ant simulation.

One of the features of the Langston's Ant project is its ability to generate impressive patterns. In previous Learning Paths, console applications helped create and debug the initial implementation of the concept, but it doesn't allow us to really see the beauty of running Langston's Ant for hundreds and thousands or generations. So let's plug in another more visual WPF UI implementation to our classes.

If you completed previous Langston's Ant guided projects, you may already be familiar with the console application. Take a moment to explore the files in the starting project code.

The Console application contains the main program and game logic. Here are some of the key files:

- `Program.cs`: The main entry point of the console application.
- `Game.cs`: Initializes the grid and the ant, and runs the simulation.
- `Ant.cs`: The ant object for the Langston's Ant simulation.
- `GeneralizedAnt.cs`: Extends the ant object to include extra rules.

The WPF application contains the graphical user interface (GUI) for the Langston's Ant simulation. Here are some of the key files:

- `MainWindow.xaml.cs`: The code for the main window form of the application.
- `App.xaml`: The application definition file that defines the startup window.
- `ImageRendering`: A folder containing files responsible for rendering the game state into an image.
- `JSON`: A folder containing utility code for serializing, saving and loading game states.

For this Learning Path, the details of WPF won't be covered. Instead, the focus is on the implementation of saving and loading game states using JSON serialization.
