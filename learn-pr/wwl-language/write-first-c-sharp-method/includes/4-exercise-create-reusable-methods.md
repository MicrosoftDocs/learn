


As you develop applications, you may find yourself writing code to do the same thing over and over again. Instead of writing duplicate code, using a method to perform the same task shortens your code and helps you develop applications faster. In this exercise, you'll identify repeated code and replace it with a reusable method. Let's get started!

### Identify duplicated code

In this task, you'll take a look at an application that tracks medication times across different time zones. The user enters their current time zone and their destination time zone. Their medication schedule is displayed and then adjusted for the new time zone.

1. In the Visual Studio Code Editor, delete any existing code from the previous exercises.

1. Copy and paste the following code into the Visual Studio Code Editor:

    ```c#
    using System;

    int[] times = {800, 1200, 1600, 2000};
    int diff = 0;
    
    Console.WriteLine("Enter current GMT");
    int currentGMT = Convert.ToInt32(Console.ReadLine());
    
    Console.WriteLine("Current Medicine Schedule:");
    
    /* Format and display medicine times */
    foreach (int val in times)
    {
        string time = val.ToString();
        int len = time.Length;

        if (len >= 3)
        {
            time = time.Insert(len - 2, ":");
        }
        else if (len == 2)
        {
            time = time.Insert(0, "0:");
        }
        else
        {
            time = time.Insert(0, "0:0");
        }

        Console.Write($"{time} ");
    }

    Console.WriteLine();

    Console.WriteLine("Enter new GMT");
    int newGMT = Convert.ToInt32(Console.ReadLine());

    if (Math.Abs(newGMT) > 12 || Math.Abs(currentGMT) > 12)
    {
        Console.WriteLine("Invalid GMT");
    }
    else if (newGMT <= 0 && currentGMT <= 0 || newGMT >= 0 && currentGMT >= 0) 
    {
        diff = 100 * (Math.Abs(newGMT) - Math.Abs(currentGMT));

        /* Adjust the times by adding the difference, keeping the value within 24 hours */
        for (int i = 0; i < times.Length; i++) 
        {
            times[i] = ((times[i] + diff)) % 2400;
        }
    } 
    else 
    {
        diff = 100 * (Math.Abs(newGMT) + Math.Abs(currentGMT));

        /* Adjust the times by adding the difference, keeping the value within 24 hours */
        for (int i = 0; i < times.Length; i++) 
        {
            times[i] = ((times[i] + diff)) % 2400;
        }
    }

    Console.WriteLine("New Medicine Schedule:");

    /* Format and display medicine times */
    foreach (int val in times)
    {
        string time = val.ToString();
        int len = time.Length;

        if (len >= 3)
        {
            time = time.Insert(len - 2, ":");
        }
        else if (len == 2)
        {
            time = time.Insert(0, "0:");
        }
        else
        {
            time = time.Insert(0, "0:0");
        }

        Console.Write($"{time} ");
    }

    Console.WriteLine();
    ```

1. Notice that there's several `for`-loops that are repeated with identical code. 

    There are two `foreach` loops that format and display the medicine times. There are another two  `for` loops that adjust the times according to the time zone difference. 

    As you write code, you may find yourself repeating blocks of code to do the same task. That's a perfect opportunity to consolidate your code by using a method to perform the task instead. Let's practice!

### Create methods to perform the repeated tasks

Now that you've identified repeated code, you can create a method to contain the code and remove the duplicates. Using methods has the added bonus of shortening your code and improving readability! The `foreach` loops format and display the time values, so you can give the method a name that clearly reflects that task. You can do the same with the `for` loop that adjusts the times. Let's get started!

1. Enter a new blank code line at the end of the previous code.

1. On the new blank code line, create a method signature by entering the following code:

    ```c#
    void DisplayTimes() 
    {
        
    }
    ```

1. To define the method body, update the `DisplayTimes` method by copy and pasting the `foreach` block as follows:

    ```c#
    void DisplayTimes() 
    {
        /* Format and display medicine times */
        foreach (int val in times)
        {
            string time = val.ToString();
            int len = time.Length;

            if (len >= 3)
            {
                time = time.Insert(len - 2, ":");
            }
            else if (len == 2)
            {
                time = time.Insert(0, "0:");
            }
            else
            {
                time = time.Insert(0, "0:0");
            }

            Console.Write($"{time} ");
        }

        Console.WriteLine();
    }
    ```

    In this method, you include the call to `Console.WriteLine` at the end to append a new line after the times are displayed. Next, you'll create another method to adjust the times according to the time zone difference.

1. Enter a new blank code line at the end of the previous code.

1. On the new blank code line, create a method signature by entering the following code:

    ```c#
    void AdjustTimes() 
    {
        
    }
    ```

1. Update the `AdjustTimes` method by copy and pasting the `for` loop as follows:

    ```c#
    void AdjustTimes() 
    {
        /* Adjust the times by adding the difference, keeping the value within 24 hours */
        for (int i = 0; i < times.Length; i++) 
        {
            times[i] = ((times[i] + diff)) % 2400;
        }
    }
    ```

### Step 3: Call the methods

In this task, you'll delete the repeated blocks of code and replace them with calls to the methods you created.

1. Locate the first instance of the repeated `foreach` loop under the comment "Format and display medicine times":

    ```c#
    Console.WriteLine("Current Medicine Schedule:");

    /* Format and display medicine times */
    foreach (int val in times)
    {
        ...
    }

    Console.WriteLine();

    Console.WriteLine("Enter new GMT");
    ```

1. Replace the code you identified with a call to the `DisplayTimes` method. The replacement should result in the following code:

    ```c#
    Console.WriteLine("Current Medicine Schedule:");
    DisplayTimes();

    Console.WriteLine("Enter new GMT");
    ```

    Next, you'll replace the second instance of the repeated code.

1. Locate the second instance of the `foreach` loop under the comment "Format and display medicine times":

    ```c#
    Console.WriteLine("New Medicine Schedule:");

    /* Format and display medicine times */
    foreach (int val in times)
    {
        ...
    }
    
    Console.WriteLine();
    ```

1. Replace the code you identified with a call to the `DisplayTimes` method. The replacement should result in the following code:

    ```c#
    Console.WriteLine("New Medicine Schedule:");
    DisplayTimes();
    ```

    Notice how using a method in place of a large block of code provides more clarity and makes the code easier to understand. Let's do the same with the `AdjustTimes` method you created.

1. Locate the following code with the duplicated `for`-loops:

    ```c#
    else if (newGMT <= 0 && currentGMT <= 0 || newGMT >= 0 && currentGMT >= 0) 
    {
        diff = 100 * (Math.Abs(newGMT) - Math.Abs(currentGMT));

        /* Adjust the times by adding the difference, keeping the value within 24 hours */
        for (int i = 0; i < times.Length; i++) 
        {
            times[i] = ((times[i] + diff)) % 2400;
        }
    } 
    else 
    {
        diff = 100 * (Math.Abs(newGMT) + Math.Abs(currentGMT));

        /* Adjust the times by adding the difference, keeping the value within 24 hours */
        for (int i = 0; i < times.Length; i++) 
        {
            times[i] = ((times[i] + diff)) % 2400;
        }
    }
    ```

1. Replace the instances of repeated code under the comment "Adjust the times by adding the difference" with calls to your `AdjustTimes` method. The replacement should result in the following code:

    ```c#
    else if (newGMT <= 0 && currentGMT <= 0 || newGMT >= 0 && currentGMT >= 0) 
    {
        diff = 100 * (Math.Abs(newGMT) - Math.Abs(currentGMT));
        AdjustTimes();
    } 
    else 
    {
        diff = 100 * (Math.Abs(newGMT) + Math.Abs(currentGMT));
        AdjustTimes();
    }
    ```

    Now all of the duplicated code has been replaced by your new method. Notice how much more readable and concise your code looks!

## Check Your Work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code with the following to ensure it's correct:

    ```c#
    int[] times = {800, 1200, 1600, 2000};
    int diff = 0;

    Console.WriteLine("Enter current GMT");
    int currentGMT = Convert.ToInt32(Console.ReadLine());

    Console.WriteLine("Current Medicine Schedule:");
    DisplayTimes();

    Console.WriteLine("Enter new GMT");
    int newGMT = Convert.ToInt32(Console.ReadLine());

    if (Math.Abs(newGMT) > 12 || Math.Abs(currentGMT) > 12)
    {
        Console.WriteLine("Invalid GMT");
    }
    else if (newGMT <= 0 && currentGMT <= 0 || newGMT >= 0 && currentGMT >= 0) 
    {
        diff = 100 * (Math.Abs(newGMT) - Math.Abs(currentGMT));
        AdjustTimes();
    } 
    else 
    {
        diff = 100 * (Math.Abs(newGMT) + Math.Abs(currentGMT));
        AdjustTimes();
    }

    Console.WriteLine("New Medicine Schedule:");
    DisplayTimes();

    void DisplayTimes()
    {
        /* Format and display medicine times */
        foreach (int val in times)
        {
            string time = val.ToString();
            int len = time.Length;

            if (len >= 3)
            {
                time = time.Insert(len - 2, ":");
            }
            else if (len == 2)
            {
                time = time.Insert(0, "0:");
            }
            else
            {
                time = time.Insert(0, "0:0");
            }

            Console.Write($"{time} ");
        }
        Console.WriteLine();
    }

    void AdjustTimes() 
    {
        /* Adjust the times by adding the difference, keeping the value within 24 hours */
        for (int i = 0; i < times.Length; i++) 
        {
            times[i] = ((times[i] + diff)) % 2400;
        }
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

    Enter -6 and +6 for the GMT prompts.

1. Verify that your code produces the following output:

    ```Output
    Enter current GMT
    -6
    Current Medicine Schedule:
    8:00 12:00 16:00 20:00 
    Enter new GMT
    +6
    New Medicine Schedule:
    20:00 0:00 4:00 8:00
    ```

    If your code displays different results, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.
