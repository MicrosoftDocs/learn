In this step, you'll define the method to display the results of the animal groups. You'll also complete the animal group assignments for the other visiting schools. Let's get started!

## Develop your method

1. Enter a new blank code line. Then define the `PrintGroup` method by entering the following code.

    ```c#
    void PrintGroup(string[,] group) 
    {
        
    }
    ```

    Remember that you decided this method would take a 2D array as input. Now you just need your method to print the contents of the 2D array.

1. Add the following code to the `PrintGroup` method:

    ```c#
    void PrintGroup(string[,] groups)
    {
        for (int i = 0; i < groups.GetLength(0); i++) 
        {
            for (int j = 0; j < groups.GetLength(1); j++) 
            {
                Console.Write($"{groups[i,j]}  ");
            }
        }
    }
    ```

    Here, you use `GetLength(0)` to get the number of rows in the array, and `GetLength(1)` for the number of columns. Then you use `Console.Write` to print the element with some extra spaces between the animals. Next, let's add some helper text and a new line to separate the groups.

1. Update your method with the following code:

    ```c#
    void PrintGroup(string[,] groups) 
    {
        for (int i = 0; i < groups.GetLength(0); i++) 
        {
            Console.Write($"Group {i + 1}: ");
            for (int j = 0; j < groups.GetLength(1); j++) 
            {
                Console.Write($"{groups[i,j]}  ");
            }
            Console.WriteLine();
        }
    }
    ```
    
    Now you have all the code in place to complete the task to prepare for the school visit.

1. Locate the `PrintGroup` method call and remove the starting `// ` characters.

    Next, you'll run your code and observe the results.

1. Save then run your code by entering **dotnet run** tt the Terminal command prompt.

1. To verify that your code is working as expected, check that the output of your application is similar the following output, taking into account the random order of the animals:

    ```
    School A
    Group 1: ducks  emus  rabbits  
    Group 2: lemurs  chickens  geese  
    Group 3: iguanas  macaws  alpacas  
    Group 4: goats  kangaroos  pigs  
    Group 5: capybaras  llamas  tortoises
    Group 6: sheep  ostriches  ponies
    ```

    Consider that you need to perform the same tasks for each school. The differences would be the name of the school and the number of groups. This is a perfect opportunity to use a method with those parameters.

1. Create a new blank code line above the `RandomizeAnimals()` method call. Then create a new method by entering the following code:

    ```c#
    void PlanSchoolVisit(string schoolName, int groups = 6)
    {
        RandomizeAnimals();
        string[,] group = AssignGroup();
        Console.WriteLine("School A");
        PrintGroup(group);
    }
    ```

    With this code, you're able to perform the same tasks for each school. You also set `groups` to the default value of `6`. Next, you'll update your method to use the input values.

1. Update your method with the following code:

    ```c#
    void PlanSchoolVisit(string schoolName, int groups = 6)
    {
        RandomizeAnimals();
        string[,] group = AssignGroup(groups);
        Console.WriteLine(schoolName);
        PrintGroup(group);
    }
    ```

    Now you're ready to call this method for each of the schools.

1. Create a new blank code line above the `PlanSchoolVisit` method. Then enter the following code:

    ```c#
    PlanSchoolVisit("School A");
    PlanSchoolVisit("School B", 3);
    PlanSchoolVisit("School C", 2);
    ```

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

    PlanSchoolVisit("School A");
    PlanSchoolVisit("School B", 3);
    PlanSchoolVisit("School C", 2);

    void PlanSchoolVisit(string schoolName, int groups = 6) 
    {
        RandomizeAnimals(); 
        string[,] group1 = AssignGroup(groups);
        Console.WriteLine(schoolName);
        PrintGroup(group1);
    }

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

    void PrintGroup(string[,] groups) 
    {
        for (int i = 0; i < groups.GetLength(0); i++) 
        {
            Console.Write($"Group {i + 1}: ");
            for (int j = 0; j < groups.GetLength(1); j++) 
            {
                Console.Write($"{groups[i,j]}  ");
            }
            Console.WriteLine();
        }
    }
    ```

1. Save your work using <kbd>Ctrl</kbd> + <kbd>S</kbd> or using the Visual Studio Code File menu.

1. If necessary, open Visual Studio Code's Integrated Terminal panel.

    In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

1. At the Terminal command prompt, enter **dotnet run**

1. Check that the output of your application is similar to the following, taking into account the randomized order of animals: 

    ```Output
    School A
    Group 1: kangaroos  lemurs  pigs  
    Group 2: alpacas  sheep  chickens  
    Group 3: ducks  geese  capybaras  
    Group 4: ponies  iguanas  tortoises  
    Group 5: ostriches  llamas  rabbits  
    Group 6: macaws  goats  emus  
    School B
    Group 1: llamas  ducks  ponies  geese  chickens  goats
    Group 2: iguanas  capybaras  macaws  kangaroos  rabbits  sheep
    Group 3: lemurs  tortoises  alpacas  pigs  emus  ostriches
    School C
    Group 1: sheep  ducks  pigs  macaws  kangaroos  ostriches  rabbits  goats  lemurs
    Group 2: iguanas  capybaras  chickens  emus  tortoises  geese  ponies  alpacas  llamas
    ```

    You should check that School A has six groups, School B has three groups, and School C has two groups. The order of the animals should be randomized for each school.
    
    If your code produces unexpected errors, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.