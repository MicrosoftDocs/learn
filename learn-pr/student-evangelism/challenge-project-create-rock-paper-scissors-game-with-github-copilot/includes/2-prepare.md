


In this guided project, you'll use Visual Studio Code to develop portions of a C# console application. You'll begin by writing the code that performs various numeric calculations. All calculations must be completed within the existing iteration and selection structures. This Prepare unit provides you with the overall goals of the project and the requirements for your application. The Setup section describes how to set up your development environment, including a "Starter" code project.

> [!IMPORTANT]
> This module includes hands-on activities that require Visual Studio Code. You'll need access to a development environment that has Visual Studio Code installed and configured for C# application development.

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

The current score report lists the student's name followed by the calculated overall grade and letter grade. Here is the existing report format:

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

1. To download a zip file containing the Starter project code, select the following link: [Lab Files](https://github.com/MicrosoftLearning/Challenge-project-foreach-if-array-CSharp/archive/refs/heads/main.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **Challenge-project-foreach-if-array-CSharp-main.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **ChallengeProject** folder to your Windows Desktop folder.

    > [!NOTE]
    > If a folder named **ChallengeProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **ChallengeProject** folder in Visual Studio Code.

    1. Open Visual Studio Code in your development environment.
    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the Windows Desktop folder and locate the "ChallengeProject" folder.
    1. Select **ChallengeProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **ChallengeProject** folder and two subfolders named **Final** and **Starter**.

You're now ready to begin the Challenge project exercises. Good luck!
