
You'll be using Visual Studio Code to develop portions of a C# console application. You will be writing the code that performs various numeric calculations within a series of iteration and selection statements. The values must be calculated within the existing iteration and selection structures. In this Prepare unit, you'll review the overall goals of the project and how you'll build and test your application. You'll also complete a Setup section that describes how to set up your development environment, including a "Starter" code project.

## Project specification

The Starter code project for this module is a C# console application that implements the following code features:

- Uses arrays to store student names and assignment scores.
- Uses a `foreach` statement to iterate through the student names as an outer program loop.
- Uses an `if` statement within the outer loop to identify the current student's name and access that student's assignment scores.
- Uses a `foreach` statement within the outer loop to iterate through the assignment scores array and sum the values.
- Uses an algorithm within the outer loop to calculate the average exam score for each student.
- Use an `if-elseif-else` construct within the outer loop to evaluate the average exam score and assign a letter grade automatically.
- Integrates extra credit scores when calculating the student's final score and letter grade as follows:

    - Detects extra credit assignments based on the number of elements in the student's scores array.
    - Applies a 10% weighting factor to extra credit assignments before adding extra credit scores to the sum of exam scores.

Your goal in this challenge is to implement the coding updates required to produce the teacher's requested score report.

The current score report lists the student's name followed by the calculated overall grade and letter grade. The existing report is formatted as follows:

```Output
Student         Grade   Letter Grade

Sophia          95.6    A
Andrew          91.6    A-
Emma            89.2    B+
Logan           93      A
```

In addition to the student's final numeric score and letter grade, the teacher wants the updated report to include the exam score and the impact that extra credit work has on the student's final grade. The format of the updated score report should appear as follows:

```Output
Student         Exam Score      Overall Grade   Extra Credit

Sophia          92.2            95.88   A       92 (3.68 pts)
Andrew          89.6            91.38   A-      89 (1.78 pts)
Emma            85.6            90.94   A-      89 (5.34 pts)
Logan           91.2            93.12   A       96 (1.92 pts)
```

## Setup

Use the following steps to prepare for the Challenge project exercises:

1. Download a zip file containing the code folders for the LP2 Challenge project

    - In a browser, navigate to [Lab Files](https://github.com/MicrosoftLearning/Challenge-project-Develop-foreach-and-if-elseif-else-structures-to-process-array-data-in-CSharp/archive/refs/heads/main.zip) and download the zip file.

1. Unzip the downloaded files locally (or in the sandbox if you aren't using a local dev environment).

    - On your local machine, navigate to your downloads folder.
    - Right-click the Challenge-project-Develop-foreach-and-if-elseif-else-structures-to-process-array-data-in-CSharp.zip file, and then select **Extract all**.
    - Use the **Browse** button to specify the Windows Desktop folder as the extract location, and then select **Select Folder**.
    - Select **Show extracted files when complete**, and then select **Extract**.
    - Make note of the extracted folder location.

1. Copy the extracted **GuidedProject** folder to your Windows Desktop folder.

    This helps to ensure the folder path doesn't exceed path length limits (when you open the project in Visual Studio Code).

    > [!NOTE]
    > If a folder named **GuidedProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **GuidedProject** folder in VS Code.

    - Open VS Code locally (or open MS Learn sandbox and open VS Code if you aren't using a local dev environment).
    - In VS Code, on the **File** menu, select **Open Folder**.
    - Navigate to the Windows Desktop folder and locate the "GuidedProject" folder.
    - Select **GuidedProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **ChallengeProject** folder and two subfolders named **Final** and **Starter**.

You're now ready to begin the Challenge project exercises. Good luck!
