You'll be using Visual Studio Code to develop an application that relies on different methods to perform a task. Some methods use optional parameters and return values. Here, you'll find the overall goals of the project and how you'll build and test your application. You'll also set up your development environment using some Starter code.

## Project overview

You're developing an application for the Contoso Petting Zoo that coordinates school visits. The Contoso Petting Zoo is home to 18 different species of animals. At the zoo, visiting students are assigned to groups, and each group has a set of animals assigned to it. After visiting their set of animals, the students will rotate groups until they've seen all the animals at the petting zoo. 

By default, the students are divided into 6 groups. However, there are some classes that have a small or large number of students, so the number of groups must be adjusted accordingly. The animals should also be randomly assigned to each group, so as to keep the experience unique.

The design specification for the Contoso Petting Zoo application is as follows:

- There are currently three visiting schools
    - School A has six visiting groups (the default number)
    - School B has three visiting groups
    - School C has two visiting groups

- For each visiting school, perform the following tasks
    - Randomize the animals
    - Assign the animals to the correct number of groups
    - Print the school name
    - Print the animal groups

## Setup

Use the following steps to prepare for the Guided project exercises.

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
    > If you're working on your own PC rather than in a sandbox or hosted environment and you have completed other Microsoft Learn modules in this C# series, you may have already created a project folder for code samples. If that's the case, you can skip over the next step, which is used to create a console app in the TestProject folder.

1. At the Terminal command prompt, to create a new console application in a specified folder, type **dotnet new console -o ./CsharpProjects/TestProject** and then press Enter.

    This .NET CLI command uses a .NET program template to create a new C# console application project in the specified folder location. The command creates the CsharpProjects and TestProject folders for us, and uses TestProject as the name of our `.csproj` file.

1. In the EXPLORER panel, expand the **CsharpProjects** folder.

    You should see the TestProject folder and two files, a C# program file named Program.cs and a C# project file named TestProject.csproj.

1. In the EXPLORER panel, to view your code file in the Editor panel, select **Program.cs**.

1. Delete the existing code lines.

    You'll be using this C# console project to create, build, and run code samples during this module.

1. Close the Terminal panel.

1. Copy and paste the following code into the Visual Studio Code Editor. These values represent the different species at the petting zoo.

    ```c#
    using System;

    string[] pettingZoo = 
    {
        "alpacas", "capybaras", "chickens", "ducks", "emus", "geese", 
        "goats", "iguanas", "kangaroos", "lemurs", "llamas", "macaws", 
        "ostriches", "pigs", "ponies", "rabbits", "sheep", "tortoises",
    };
    ```

You're now ready to begin the Guided project exercises. Good luck!
