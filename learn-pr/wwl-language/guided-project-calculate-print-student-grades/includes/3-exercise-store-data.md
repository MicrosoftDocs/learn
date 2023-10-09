

In this exercise, you'll use the assignment scores for each student to calculate their current grade in the class. To perform this calculation, you'll first sum the values of their assignment scores, and then calculate their average score (their current grade). Let's get started.

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise. 

## Create variables to store the sum

In this task, you'll create a variable for each student that will represent the sum of their assignment scores. You'll also display the student's sum along with their name in the console output. Since the assignment scores are represented as Integers, you'll create Integer variables to store the sums.

1. Ensure that you have the .NET Editor open, and that you have the variables instantiated with each student's assignment scores.

    In the Prepare unit for this Guided project module, the Setup instructions have you copy student assignment scores into the editor. If necessary, go back and complete the Setup instructions.

1. Scroll down to the bottom of your code and create a new blank code line.

1. To declare an Integer variable for each student which you can use to sum their scores, enter the following code:

    ```csharp
    int sophiaSum = 0;
    int nicolasSum = 0;
    int zahirahSum = 0;
    int jeongSum = 0;

    ```

    Notice that `0` is assigned to the variables as part of the declaration statement. In other words, the variables are initialized to `0`. Although value assignment isn't required when declaring variables, it can make your code more efficient. The next step is to display the output, and since that output will include a reference to these variables, they must be initialized.

1. To create `Console.WriteLine()` statements that display the student name and the value of their summed assignment scores, enter the following code: 

    ```csharp
    Console.WriteLine("Sophia: " + sophiaSum);
    Console.WriteLine("Nicolas: " + nicolasSum);
    Console.WriteLine("Zahirah: " + zahirahSum);
    Console.WriteLine("Jeong: " + jeongSum);

    ```

    Ultimately, you want to display the student's current overall grade, but for now, let's use these `Console.WriteLine()` statements to display the value of your sum calculations. That way, you can check to see if your code is working correctly at each stage of the development process.

    > [!NOTE]
    > More advanced developer environments, such as Visual Studio Code, provide tools that enable developers to observe the values of application variables while their code is running. Learning how to use those tools saves professional developers lots of time during development. For now though, you can use `Console.WriteLine()` to help verify that your code is working as expected.

1. In the .NET Editor, to run your code, select the green **Run** button.

1. Notice that you have no problem displaying your integer values, all `0` for now, using the same `WriteLine()` method that displays the string literals (student names).

    The current numeric value is automatically retrieved by referencing the variable name.

    Now that you have the `Console.WriteLine()` statements ready to display your results, let's start adding the code that performs your calculations.

    > [!IMPORTANT]
    > You need to write the code that does the calculations above the code that displays the output.
 
1. Locate the following line of code: `int sophiaSum = 0;`

    You'll write the code that calculates the sum value for each student. First, you'll add the students' assignment scores, then assign the value to the "sum" variables. Let's start with Sophia. Remember that Sophia's scores are stored in the following code:

    ```csharp
    int sophia1 = 93;
    int sophia2 = 87;
    int sophia3 = 98;
    int sophia4 = 95;
    int sophia5 = 100;
    ```

1. Update the line of code to the following:

    ```csharp
    int sophiaSum = sophia1 + sophia2 + sophia3 + sophia4 + sophia5;

    ```

1. In the .NET Editor, select **Run**.

    Your output should now show that Sophia's sum is equal to `473`. The others will still be `0`. You'll add similar sum calculations for the rest of the students.

1. Starting on the blank code line that you just created, enter the following code: 

    ```csharp
    int nicolasSum = nicolas1 + nicolas2 + nicolas3 + nicolas4 + nicolas5;
    int zahirahSum = zahirah1 + zahirah2 + zahirah3 + zahirah4 + zahirah5;
    int jeongSum = jeong1 + jeong2 + jeong3 + jeong4 + jeong5;

    ```

## Check your work

In this task, you'll run the code and verify the output is correct.

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

    Console.WriteLine("Sophia: " + sophiaSum);
    Console.WriteLine("Nicolas: " + nicolasSum);
    Console.WriteLine("Zahirah: " + zahirahSum);
    Console.WriteLine("Jeong: " + jeongSum);
    ```

1. In the .NET Editor, select **Run**.

1. Review your output and verify that the sums of the assignment scores are correct:

    ```Output
    Sophia: 473
    Nicolas: 418
    Zahirah: 417
    Jeong: 477
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code in the next exercise.
