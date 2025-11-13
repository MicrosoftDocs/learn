

You'll be using the .NET Editor as your code development environment. You'll be writing code that uses string and numeric variables, performs calculations, then formats and displays the results to a console.

## Project overview

You're developing a Student GPA Calculator that will help calculate students' overall Grade Point Average. The parameters for your application are:

- You're given the student's name and class information.
- Each class has a name, the student's grade, and the number of credit hours for that class.
- Your application needs to perform basic math operations to calculate the GPA for the given student.
- Your application needs to output/display the student’s name, class information, and GPA.

To calculate the GPA:
- Multiply the grade value for a course by the number of credit hours for that course.
- Do this for each course, then add these results together.
- Divide the resulting sum by the total number of credit hours.

You're provided with the following sample of a student's course information and GPA:

```output
Student: Sophia Johnson

Course          Grade   Credit Hours	
English 101         4       3
Algebra 101         3       3
Biology 101         3       4
Computer Science I  3       4
Psychology 101      4       3

Final GPA:          3.35
```

## Setup

A C# code editor is available to use directly in the browser: [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor/). This editor provides a lightweight environment for writing, running, and testing C# code without needing to install any software on your local computer.

Use the following steps to prepare for the Guided project exercises:

1. Open the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor/) in a new browser window or tab.

    You can position the browser windows side-by-side so that you can refer to these instructions while you work in the C# Code Editor.

1. Copy and paste the following code into the C# Code Editor. These values represent the student's name and course details.

    ```csharp
    string studentName = "Sophia Johnson";
    string course1Name = "English 101";
    string course2Name = "Algebra 101";
    string course3Name = "Biology 101";
    string course4Name = "Computer Science I";
    string course5Name = "Psychology 101";

    int course1Credit = 3;
    int course2Credit = 3;
    int course3Credit = 4;
    int course4Credit = 4;
    int course5Credit = 3;
    ```

Now you're ready to begin the Guided project exercises. Good luck!