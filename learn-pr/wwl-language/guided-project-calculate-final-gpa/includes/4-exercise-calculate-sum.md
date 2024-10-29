

In this exercise, you'll calculate and store the total number of credit hours and the total grade points earned for each course. These values will later be used to calculate the GPA. Since both the credit hours and grade values are represented as whole numbers, you'll store the sums using the Integer data type.

## Create variables to store the average

Recall that to calculate a student's GPA, you need the total number of credit hours, and the total number of grade points earned. The grade points earned for a course is equal to the product of the number of credit hours for that course and numeric grade value earned. For example:

```
Course          Credit  Credit Hours    Grade Points
English 101     4		3               12
``` 

In this task, you'll create the variables to store values that are needed to calculate the GPA. You'll create a variable to store the sum of the total credit hours for each course, and another variable to store the sum of the grade points the student earned for each course.

1. In the .NET Editor, locate the `Console.WriteLine()` statements that are used to display the course information.

1. Create a blank code line above the `Console.WriteLine()` statements.

1. On the blank code line that you created, to create a variable that will store the total number of credit hours, enter the following code:

    ```csharp
    int totalCreditHours = 0;

    ```

    Notice that the total is initialized to `0`. This initialization allows you to increment the sum while keeping your code organized.

1. To increment the sum to represent the total number of credit hours, enter the following code: 

    ```csharp
    totalCreditHours += course1Credit;
    totalCreditHours += course2Credit;
    totalCreditHours += course3Credit;
    totalCreditHours += course4Credit;
    totalCreditHours += course5Credit;

    ```

    Recall that the `+=` operator is shorthand notation to add a value to a variable. These lines of code have the same result as adding each `courseCredit` variable on one line, for example: 

    ```csharp
    totalCreditHours = course1Credit + course2Credit + course3Credit + course4Credit + course5Credit;
    ```

1. To create a variable that will store the total number of grade points earned for each course, enter the following code:

    ```csharp
    int totalGradePoints = 0;

    ```

1. To increment the sum by the grade points earned for the first course, enter the following code:

    ```csharp
    totalGradePoints += course1Credit * course1Grade;

    ``` 

    Recall that the grade points earned for a course is equal to the course credit hours multiplied by the earned grade. In this line of code, you use the compound assignment operator to add the product of `course1Credit * course1Grade` to `totalGradePoints`. 

1. To increment the sum by the grade points earned for the remainder of the courses, enter the following code:

    ```csharp
    totalGradePoints += course2Credit * course2Grade;
    totalGradePoints += course3Credit * course3Grade;
    totalGradePoints += course4Credit * course4Grade;
    totalGradePoints += course5Credit * course5Grade;

    ``` 

1. Take a minute to review your code.

    Notice that the code you wrote breaks down the problem into manageable pieces rather than trying to calculate the GPA in one large operation. First, you initialized and calculated the value of `totalCreditHours`. Then you initialized and calculated the value of `totalGradePoints`. Afterwards, you'll use these values in your final calculation.

    Now that your code is calculating a value for `totalGradePoints`, let's verify that your calculations are correct before continuing. It's important to stop and check your work periodically. Checking your work early in the development process will make it easier to locate and fix any errors in your code.

1. To display the values of `totalGradePoints` and `totalCreditHours`, enter the following code:

    ```csharp
    Console.WriteLine($"{totalGradePoints} {totalCreditHours}");
    ```

    You'll remove this `WriteLine()` statement later since it isn't needed in the final output.

## Check Your Work

In this task, you'll run the code and verify that the output is correct.

1. Check that your code is similar to the following:

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

    int gradeA = 4;
    int gradeB = 3;

    int course1Grade = gradeA;
    int course2Grade = gradeB;
    int course3Grade = gradeB;
    int course4Grade = gradeB;
    int course5Grade = gradeA;

    int totalCreditHours = 0;
    totalCreditHours += course1Credit;
    totalCreditHours += course2Credit;
    totalCreditHours += course3Credit;
    totalCreditHours += course4Credit;
    totalCreditHours += course5Credit;

    int totalGradePoints = 0;
    totalGradePoints += course1Credit * course1Grade;
    totalGradePoints += course2Credit * course2Grade;
    totalGradePoints += course3Credit * course3Grade;
    totalGradePoints += course4Credit * course4Grade;
    totalGradePoints += course5Credit * course5Grade;

    Console.WriteLine($"{totalGradePoints} {totalCreditHours}");

    Console.WriteLine($"{course1Name} {course1Grade} {course1Credit}");
    Console.WriteLine($"{course2Name} {course2Grade} {course2Credit}");
    Console.WriteLine($"{course3Name} {course3Grade} {course3Credit}");
    Console.WriteLine($"{course4Name} {course4Grade} {course4Credit}");
    Console.WriteLine($"{course5Name} {course5Grade} {course5Credit}");
    ```

1. To run your code and display the current values of `totalGradePoints` and `totalCreditHours`, select **Run**.

1. Verify that your application's output matches the following output:

    ```Output
    57 17
    English 101 4 3
    Algebra 101 3 3
    Biology 101 3 4
    Computer Science I 3 4
    Psychology 101 4 3
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far. You'll build on this code in the next exercise.