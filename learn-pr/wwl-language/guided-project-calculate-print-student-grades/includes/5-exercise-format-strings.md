In this exercise, you'll modify the console output from the previous exercise to achieve the reporting format specified by the teacher.

## Format the console output

In this task, you'll update your code to apply the finishing touches to the reported output. You'll start by adding a header row that includes the column labels specified by the teacher. After that, you'll use character escape sequences to add extra padding between the columns of information.

1. In the .NET Editor, locate the Console.WriteLine() statements that are used to display each student's current class score and letter grade.

1. Create a blank code line above the `Console.WriteLine()` statements.

1. On the blank code line that you created, to add a header for the student grades, enter the following code:

    ```csharp
    Console.WriteLine("Student Grade\n");
    ```

    Notice that you're including `\n` at the end of the text. In the "Perform basic string formatting with C#" module, you learned that the `\n` escape character sequence will cause a new line to be created. The location of the escape sequence is important. In this case, the `\n` is at the end of the information that you want to write to the console, so the new line will be added after "Student Grade" is displayed. 

1. To format your output as aligned columns of text, replace the spaces between words with the `\t` escape sequence as follows:
 
    ```csharp
    Console.WriteLine("Student\tGrade\n");
    Console.WriteLine("Sophia:\t" + sophiaScore + "\tA");
    Console.WriteLine("Nicolas:\t" + nicolasScore + "\tB");
    Console.WriteLine("Zahirah:\t" + zahirahScore + "\tB");
    Console.WriteLine("Jeong:\t" + jeongScore + "\tA");
    ```

    The `\t` escape sequence will insert a tab stop between the text items. Adding the tab stops should result in left-aligned columns of information.

1. To view the results of your updates, select **Run**.

1. Compare the output of your application with the following output:

    ```
    Student	Grade

    Sophia: 94.6    A
    Nicolas:    83.6    B
    Zahirah:    83.4    B
    Jeong:  95.4    A
    ```

1. Notice that despite using a tab instead of a space character, some lines still don't have much whitespace between the student's name and their numeric score.

    This difference is due to the way that tab spacing is applied. Tab stop locations are set at four-character intervals, and each tab will advance to the next tab stop location. If you have a string of five characters followed by a tab escape sequence, the escape sequence will advance to the tab stop at the eight-character location, filling the gap with space characters to create whitespace in the output. However, you can advance to the same location if you have a string of seven characters followed by a tab escape sequence. This makes tab escape sequences more noticeable when they occur further from the next tab stop location. 

1. To make the whitespace more noticeable between the first two columns, add another `\t` after the two shorter student names as follows:

    ```csharp
    Console.WriteLine("Student\t\tGrade\n");
    Console.WriteLine("Sophia:\t\t" + sophiaScore + "\tA");
    Console.WriteLine("Nicolas:\t" + nicolasScore + "\tB");
    Console.WriteLine("Zahirah:\t" + zahirahScore + "\tB");
    Console.WriteLine("Jeong:\t\t" + jeongScore + "\tA");
    ```

## Check Your Work

In this task, you'll run the code and verify that the output is correct.

1. Compare your code to the following:

    ```csharp
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

    int sophiaSum = sophia1 + sophia2 + sophia3 + sophia4 + sophia5;
    int nicolasSum = nicolas1 + nicolas2 + nicolas3 + nicolas4 + nicolas5;
    int zahirahSum = zahirah1 + zahirah2 + zahirah3 + zahirah4 + zahirah5;
    int jeongSum = jeong1 + jeong2 + jeong3 + jeong4 + jeong5;

    decimal sophiaScore = (decimal) sophiaSum / currentAssignments;
    decimal nicolasScore = (decimal) nicolasSum / currentAssignments;
    decimal zahirahScore = (decimal) zahirahSum / currentAssignments;
    decimal jeongScore = (decimal) jeongSum / currentAssignments;

    Console.WriteLine("Student\t\tGrade\n");
    Console.WriteLine("Sophia:\t\t" + sophiaScore + "\tA");
    Console.WriteLine("Nicolas:\t" + nicolasScore + "\tB");
    Console.WriteLine("Zahirah:\t" + zahirahScore + "\tB");
    Console.WriteLine("Jeong:\t\t" + jeongScore + "\tA");
    ```

1. To run your code and display the formatted output, select **Run**.

1. To verify that your code is working as expected, compare the output of your application with the following output:

    ```Output
    Student         Grade

    Sophia:         94.6    A
    Nicolas:        83.6    B
    Zahirah:        83.4    B
    Jeong:          95.4    A
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.
    