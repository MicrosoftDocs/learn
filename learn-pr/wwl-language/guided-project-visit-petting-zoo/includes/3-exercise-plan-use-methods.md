In this first step of your development process, you'll begin planning your application through pseudo-code. You'll identify the steps and methods that are needed to complete the task. You also need to consider the input and output of these methods as well. Preparing methods via pseudo-code is a helpful step in any coding task, and can help you develop bug-free code quickly.

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

## Convert tasks into pseudo-code

In this task, you'll turn the steps defined in the application specification into pseudo-code. By preparing pseudo-code, developing the full application becomes an easier task. Let's get started!

1. Take a moment to consider the design specification:

    ```Output
    - There will be three visiting schools
        - School A has six visiting groups (the default number)
        - School B has three visiting groups
        - School C has two visiting groups

    - For each visiting school, perform the following tasks
        - Randomize the animals
        - Assign the animals to the correct number of groups
        - Print the school name
        - Print the animal groups

    ```

    To get started, you'll focus on writing the pseudo-code for just one school. When you figure out the code for one school, you can easily apply the same logic to the others.

1. Enter a new blank code line below the `pettingZoo` array initialization.

1. The first task is to randomize the animals. Create a pseudo-code method to randomize the petting zoo animals by entering the following code into the editor:

    ```c#
    // RandomizeAnimals();
    ```

    You won't fill in any logic to randomize the animals yet. For now, you'll focus on planning the application as a whole. You can assume that this `RandomizeAnimals()` method exists and will correctly randomize the `pettingZoo` array.

1. Next, create a pseudo-code method to assign the animal groups. Enter the following code into the editor:

    ```c#
    // AssignGroup();
    ```

    Like before, you can assume that this method correctly assigns the animals to a subset group and continue to the next task.

1. You can easily print the school name using `Console.Write`. Enter the following code into the editor:

    ```c#
    Console.WriteLine("School A");
    ```

1. Lastly, you'll need to print the animal groups. Enter the following code into the editor:

    ```c#
    // PrintGroup(group);
    ```

    Notice that you added a parameter to this method. You know that you need to print different groups of animals several times, so you use a method to perform this task with the group as the input parameter. Take a moment to consider where you can initialize the `group` argument in your pseudo-code.

1. Assign the `group` argument by updating the `AssignGroup` line of code to the following:

    ```c#
    // var group = AssignGroup();
    ```

1. Since you have completed pseudo-code for the general tasks, you can take a moment to consider what data type to assign to the `group` variable.

    You want School A to have animals assigned into six groups. And you know that there are 18 animals. You also know that the animals are represented using `string`. So you can use a 2D array that  contains six groups of three animals each.

1. Assign the `group` data type by updating the `AssignGroup` line of code to the following:

    ```c#
    // string[,] group = AssignGroup();
    ```

    You don't add any arguments to the `AssignGroup` method the default group value is six.

## Check your work

In this task, you'll check that your pseudo-code performs the general tasks listed for each school. You'll also run the code to ensure there are no issues.

1. Compare your code to the following:

    ```c#
    using System;

    string[] pettingZoo = 
    {
        "alpacas", "capybaras", "chickens", "ducks", "emus", "geese", 
        "goats", "iguanas", "kangaroos", "lemurs", "llamas", "macaws", 
        "ostriches", "pigs", "ponies", "rabbits", "sheep", "tortoises",
    };

    // RandomizeAnimals();
    // string[,] group = AssignGroup();
    Console.WriteLine("School A");
    // PrintGroup(group);
    ```

1. At the Terminal command prompt, enter **dotnet run**

1. Verify that the "School A" message is displayed.