You'll be using the .NET Editor as your code development environment. You'll be writing code that uses string and numeric variables, performs calculations, and displays results to a console.

## Project overview

You're developing a Student Grading application that automates the calculation of current grades for each student in a class. The parameters for your application are:

- You're given a short list of four students and their five assignment grades.
- Each assignment grade is expressed as an integer value, 0-100, where 100 represents 100% correct.
- Final scores are calculated as an average of the five assignment scores.
- Your application needs to perform basic math operations to calculate the final grades for each student.
- Your application needs to output/display each student’s name and final score.

Currently, the teachers grade book shows the graded assignments for each student as follows: 

```
Sophia: 93, 87, 98, 95, 100

Nicolas: 80, 83, 82, 88, 85

Zahirah:   84, 96, 73, 85, 79

Jeong:  90, 92, 98, 100, 97
```

The teacher requires that the calculated grades for each student are displayed as follows:

```
Student     Grade
Sophia      94.6  A
Nicolas     83.6  B
Zahirah     83.4  B
Jeong       95.4  A
```

## Setup

A C# code editor is available to use directly in the browser: [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor?azure-portal=true). This editor provides a lightweight environment for writing, running, and testing C# code without needing to install any software on your local computer.

Use the following steps to prepare for the Guided project exercises:

1. Open the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor?azure-portal=true) in a new browser window or tab.

    You can position the browser windows side-by-side so that you can refer to these instructions while you work in the C# Code Editor.

1. Copy and paste the following code into the C# Code Editor. These values represent the graded assignments for each student.

    ```csharp
    // initialize variables - graded assignments 
    int currentAssignments = 5;

    int sophia1 = 93;
    int sophia2 = 87;
    int sophia3 = 98;
    int sophia4 = 95;
    int sophia5 = 100;

    int nicolas1 = 80;
    int nicolas2 = 83;
    int nicolas3 = 82;
    int nicolas4 = 88;
    int nicolas5 = 85;

    int zahirah1 = 84;
    int zahirah2 = 96;
    int zahirah3 = 73;
    int zahirah4 = 85;
    int zahirah5 = 79;

    int jeong1 = 90;
    int jeong2 = 92;
    int jeong3 = 98;
    int jeong4 = 100;
    int jeong5 = 97;
    ```

Now you're ready to begin the Guided project exercises. Good luck!