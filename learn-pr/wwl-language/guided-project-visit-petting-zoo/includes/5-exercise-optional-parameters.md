In this step, you'll develop the code to complete another subtask, which is to assign the petting zoo animals to groups. Recall that you referenced a method `AssignGroup()` in your pseudo-code. Let's get started!

## Develop your method

In this task, you'll complete a method that assigns the petting zoo animals to groups. You'll use what you learned about method return types and parameters to create your method. Let's get started!

1. Enter a new blank code line, then define the `assignGroups` method by entering the following code.

    ```c#
    string[,] AssignGroup(int groups) 
    {
        
    }
    ```

    Remember that you decided this method would return a 2D array. The number of groups can also change depending on the size of the visiting school. However, there's a default group size of `6`, so you should make this parameter optional.

1. Change `groups` to an optional parameter by updating the method to the following code:

    ```c#
    string[,] AssignGroup(int groups = 6) 
    {
        
    }
    ```

    Recall that an optional parameter is defined by assigning it a default value. Required parameters should be declared first before any optional ones. Next you'll begin adding logic to your code.

1. Update your method with the following code:

    ```c#
    string[,] AssignGroup(int groups = 6) 
    {
        string[,] result = new string[groups, pettingZoo.Length/groups];
       
        return result;
    }
    ```

    Since your method specifies a return value, you start your method definition by creating a value to return. This allows you to continue adding logic without compile-time errors.

    Notice that you used `[groups, pettingZoo.Length/groups]` to define the array size. `groups` represents the number of animal groups you want to create. `pettingZoo.Length/groups` reflects how many animals are assigned to each group. For example, since `pettingZoo` is a fixed array of 18 elements, the 2D array size for School A is `[6,3]`.

    Next, you'll assign the animals to each group.

1. Update your code with the following nested `for` loop:

    ```c#
    string[,] AssignGroup(int groups = 6) 
    {
        string[,] result = new string[groups, pettingZoo.Length/groups];

        for (int i = 0; i < groups; i++) 
        {
            for (int j = 0; j < result.GetLength(1); j++) 
            {
                
            }
        }

        return result;
    }
    ```

    In this code, the outer `for` loop cycles through each group. The inner `for` loop cycles for the number of animals the group should contain. Next, you need to assign the animals.

1. Update your `for` loop with the following code:

    ```c#
    int start = 0;

    for (int i = 0; i < groups; i++) 
    {
        for (int j = 0; j < result.GetLength(1); j++) 
        {
            result[i,j] = pettingZoo[start++];
        }
    }
    ```

    In this code, you define `start` to represent the starting position of `pettingZoo`. Using this marker allows you to navigate through the `pettingZoo` array one element at a time even though the for-loops have different iterations.

    Now your method assigns the petting zoo animals to the designated number of groups. Now you can uncomment your call to `AssignGroup`.

1. Locate the `AssignGroup()` method call and remove the starting `// ` characters.

    Remember that since you're omitting the optional parameter, the `group` variable will be a 2D array of `[6,3]`.

## Check your work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code to the following to ensure it's correct:

    ```c#
    using System;

    string[] pettingZoo = 
    {
        "alpacas", "capybaras", "chickens", "ducks", "emus", "geese", 
        "goats", "iguanas", "kangaroos", "lemurs", "llamas", "macaws", 
        "ostriches", "pigs", "ponies", "rabbits", "sheep", "tortoises",
    };

    RandomizeAnimals();
    string[,] group = AssignGroup();
    Console.WriteLine("School A");
    // PrintGroup(group);

    void RandomizeAnimals() 
    {
        Random random = new Random();

        for (int i = 0; i < pettingZoo.Length; i++) 
        {
            int r = random.Next(i, pettingZoo.Length);

            string temp = pettingZoo[r];
            pettingZoo[r] = pettingZoo[i];
            pettingZoo[i] = temp;
        }
    }

    string[,] AssignGroup(int groups = 6) 
    {
        string[,] result = new string[groups, pettingZoo.Length/groups];
        int start = 0;

        for (int i = 0; i < groups; i++) 
        {
            for (int j = 0; j < result.GetLength(1); j++) 
            {
                result[i,j] = pettingZoo[start++];
            }
        }

        return result;
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that the expected "School A" message is displayed and that there are no error messages. 

    If your code produces unexpected errors, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.