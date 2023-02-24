
In this guided project, you use Visual Studio Code to develop a C# application that implements arrays, `foreach` statements, and `if` statements. You begin by creating array variables that contain the data for your application. You complete the project by using `foreach` and `if` statements to develop a nested looping and branching structure that implements your application design goals.

## Project overview

You're developing a Student Grading application that automates the calculation of grades for each student in a class. The parameters for your application are:

- Create a C# console application.
- Start with four students. Each student has five exam scores.
- Each exam score is an integer value, 0-100, where 100 represents 100% correct.
- A student's overall exam score is the average of their five exam scores.
- Criteria for extra credit assignments:

    - Include extra credit assignment scores in the student's scores array.
    - Extra credit assignments are worth 10% of an exam score (when calculating the final numeric grade).
    - Add extra credit assignment scores to the student's total exam score before calculating the final numeric grade.

- Your application needs to automatically assign letter grades based on the calculated final score for each student.
- Your application needs to output/display each student’s name and formatted grade.
- Your application needs to support adding other students and scores with minimal impact to the code.

You've already completed an initial version of the application. The Starter code project for this Guided project module includes a Program.cs file that provides the following code features:

- The code declares variables used to define student names and individual exam scores for each student.
- The code includes the variables and algorithms used to sum the exam scores and calculate the average exam score for each student.
- The code includes a hard coded letter grade that the developer must apply manually.
- The code includes Console.WriteLine() statements to display the student grading report.

Your goal is to update the existing code to include the following features:

- Use arrays to store student names and assignment scores.
- Use a `foreach` statement to iterate through the student names as an outer program loop.
- Use an `if` statement within the outer loop to identify the current student name and access that student's assignment scores.
- Use a `foreach` statement within the outer loop to iterate through the assignment scores array and sum the values.
- Use an updated algorithm within the outer loop to calculate the average exam score for each student.
- Use an `if-elseif-else` construct within the outer loop to evaluate the average exam score and assign a letter grade automatically.
- Integrate extra credit scores when calculating the student's final score and letter grade as follows:

    - Your code must detect extra credit assignments based on the number of elements in the student's scores array.
    - Your code must apply the 10% weighting factor to extra credit assignments before adding extra credit scores to the sum of exam scores.

The following list shows the letter grade that corresponds to numeric scores:

```Output
97 - 100   A+
93 - 96    A
90 - 92    A-
87 - 89    B+
83 - 86    B
80 - 82    B-
77 - 79    C+
73 - 76    C
70 - 72    C-
67 - 69    D+
63 - 66    D
60 - 62    D-
0  - 59    F
```

The update application needs to produce a formatted student grading report that appears as follows:

```Output
Student         Grade

Sophia:         92.2    A-
Andrew:         89.6    B+
Emma:           85.6    B
Logan:          91.2    A-
```

## Setup

Use the following steps to prepare for the Guided project exercises.

1. Download a zip file containing the code folders for the LP2 Guided project.

    - In a browser, navigate to [Lab Files](https://github.com/MicrosoftLearning/Guided-project-Develop-foreach-and-if-elseif-else-structures-to-process-array-data-in-CSharp/archive/refs/heads/main.zip) and download the zip file.

1. Unzip the downloaded files locally (or in the sandbox if you aren't using a local dev environment).

    1. On your local machine, navigate to your downloads folder.
    1. Right-click the Guided-project-Develop-foreach-and-if-elseif-else-structures-to-process-array-data-in-CSharp.zip file, and then select **Extract all**.
    1. Use the **Browse** button to specify the Windows Desktop folder as the extract location, and then select **Select Folder**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **GuidedProject** folder to your Windows Desktop folder.

    > [!NOTE]
    > If a folder named **GuidedProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **GuidedProject** folder in VS Code.

    1. Open VS Code locally (or open MS Learn sandbox and open VS Code if you aren't using a local dev environment).
    1. In VS Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the Windows Desktop folder and locate the "GuidedProject" folder.
    1. Select **GuidedProject** and then select **Select Folder**.

    The Visual Studio Code EXPLORER view should show the GuidedProject folder and two subfolders named Final and Starter.

You're now ready to begin the Guided project exercises. Good luck!
