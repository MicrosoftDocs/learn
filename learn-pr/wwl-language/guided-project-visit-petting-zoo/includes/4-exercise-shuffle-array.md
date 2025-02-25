In this step, you'll develop the code to complete your first subtask, which is to randomize the petting zoo animals. Recall that you referenced a method `RandomizeAnimals()` in your pseudo-code. Let's get started!

## Shuffle an array

Randomizing the elements of an array can seem like a daunting task. Before you begin, take a moment to consider how you would swap the values of two variables, `a` and `b`. 

If you immediately assign `a = b`, you'll lose the original value of `a` and end up with two variables equal to `b`. You need to use a temporary variable to store the value of `a` before you can overwrite it. Let's use this concept to begin your task.

1. Enter a new blank code line, then define the `RandomizeAnimals` method by entering the following code.

    ```c#
    void RandomizeAnimals() 
    {

    }
    ```

    For this method, you don't need any input parameters since you'll use the existing global `pettingZoo` variable. You also don't need any input parameters for this task. To start this method, let's write some code to swap some elements in the array.

1. Enter the following code in the `RandomizeAnimals()` method:

    ```c#
    int i = 0;
    int r = 1;

    string temp = pettingZoo[i];
    pettingZoo[i] = pettingZoo[r];
    pettingZoo[r] = temp;
    ```

    In this code, you're temporarily using `i` and `r` to represent some random indices in the array. Then you swap the values at the two indices with the help of the `temp` variable. Notice how using `temp` prevents us from losing the original value of `pettingZoo[i]` after it's overwritten. Next, let's set `r` to a random value instead of `1`.

1. Update your code to the following:

    ```c#
    Random random = new Random();

    int i = 0;
    int r = random.Next(pettingZoo.Length);

    string temp = pettingZoo[i];
    pettingZoo[i] = pettingZoo[r];
    pettingZoo[r] = temp;
    ```

    In this step, you initialized a `random` object to help us generate a random number. And you initialized `r` to a random integer between 0 and the length of the `pettingZoo` array. This will ensure you don't go out of bounds of the array. You can apply this code to the entirety of the array to randomize all of the elements.

1. Modify the elements using a for-loop by updating your code to the following:

    ```c#
    Random random = new Random();

    for (int i = 0; i < pettingZoo.Length; i++) 
    {
        int r = random.Next(pettingZoo.Length);

        string temp = pettingZoo[i];
        pettingZoo[i] = pettingZoo[r];
        pettingZoo[r] = temp;
    }
    ```

    Now you cycle through each element in the array, select a random index, and swap it with the current element. However, if you run this code and observe the changes on `pettingZoo`, you might notice an issue. Some elements don't get swapped at all, and some elements are swapped multiple times. 
    
    You can improve the distribution of randomly selected elements by updating the range as you move through the array.

1. Update your code to the following:

    ```c#
    int r = random.Next(i, pettingZoo.Length);
    ```

    Now, as you iterate through the for loop, you update the range of the randomly selected index to exclude values less than `i`. This is because indices at values less than `i` have already been swapped in previous iterations of the loop.

1. Uncomment the call to `RandomizeAnimals()` by removing the starting `// ` characters.

## Check your work

In this task, you'll run your application from the Integrated Terminal and verify your code is working correctly. Let's get started.

1. Compare your code with the following to ensure it's correct:

    ```c#
    using System;

    string[] pettingZoo = 
    {
        "alpacas", "capybaras", "chickens", "ducks", "emus", "geese", 
        "goats", "iguanas", "kangaroos", "lemurs", "llamas", "macaws", 
        "ostriches", "pigs", "ponies", "rabbits", "sheep", "tortoises",
    };

    RandomizeAnimals();
    // string[,] group = AssignGroup();
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
    ```

1. To test the `RandomizeAnimals` method, copy and paste the following code into the editor at the end of the code:

    ```c#
    foreach(string animal in pettingZoo) 
    {
        Console.WriteLine(animal);
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that your code produces the following output:

1. Verify that the expected "School A" message is displayed, followed by a randomized list of the animals. The animals shouldn't appear in alphabetical order. For example:

    ```Output
    School A
    ponies
    iguanas
    goats
    tortoises
    ducks
    rabbits
    lemurs
    alpacas
    capybaras
    emus
    sheep
    llamas
    pigs
    macaws
    kangaroos
    geese
    chickens
    ostriches
    ```

1. Remove the `foreach` loop you added to test your method.