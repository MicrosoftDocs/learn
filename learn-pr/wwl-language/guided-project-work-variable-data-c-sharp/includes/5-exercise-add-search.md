In this exercise, you add the feature "Display all dogs with a specified characteristic" (menu item #2) to the application. The exercise uses the solution project from the previous exercise that added `suggestedDonation` data.

> [!NOTE]
> This project is a "minimal viable product" (MVP) feature. MVP features are intended to be a basic working prototype of a feature that enables quick and easy delivery. An MVP isn't usually a final product, its purpose is to help you work through an idea, test it, and gather further requirements.

The search feature prompts the user for a single search input term (or phrase) that describes a characteristic desired in a pet to adopt. Then, the descriptions for adoptable dogs are searched for exact matches of the user input. Information about the dogs that match are output to the console. If no matches are identified, then a message *"None of our dogs are a match"* is displayed along with the search term used.

The tasks that you complete during this exercise are:

1. Gather user input for the pet characteristic search term
1. Loop through the animals array and identify "dogs"
1. Search each dog's pet description for a term match
1. Display the dogs that have a term match

 In Visual Studio Code, open the completed Project.cs file from the previous exercise that added the donation information to get started.

## Gather user input for the pet characteristic search

1. Review the menu switch statement following comment #5 in the Project.cs code. You discover the code that displays the *"UNDER CONSTRUCTION"* message.
1. Delete the code `Console.WriteLine("\nUNDER CONSTRUCTION - please check back next month to see progress.");` between `case "2":` and the `Console.WriteLine("Press the Enter key to continue.");` statement so the code matches the following sample:

    ```csharp
    case "2":
        // Display all dogs with a specified characteristic
        Console.WriteLine("Press the Enter key to continue.");
        readResult = Console.ReadLine();
        break; 
    ```

1. Add code to gather user input for the `dogCharacteristic` string. Gather the input requires a `while` loop that continues to prompt the user until they submit an input. The loop instructs the user to `Enter one desired dog characteristic to search for`. Entering an empty string repeats the loop. Place the following code following `case "2:` just before the `break;` statement as shown:

    ```csharp
    case "2":
        // Display all dogs with a specified characteristic
        string dogCharacteristic = "";

        while (dogCharacteristic == "")
        {
            // have the user enter physical characteristics to search for
            Console.WriteLine($"\nEnter one desired dog characteristics to search for");
            readResult = Console.ReadLine();
            if (readResult != null)
            {
                dogCharacteristic = readResult.ToLower().Trim();
            }
        } 
        Console.WriteLine("Press the Enter key to continue.");
        readResult = Console.ReadLine();
        break;
    ```

    Review the added code. The main features of the `case "2":` code include:

    - The code starts with a string declaration `string dogCharacteristic = "";` that is scoped to `case "2":`. You can't utilize `dogCharacteristic` anywhere outside of the case statement code.
    - After `Console.ReadLine()` gathers user input as `dogCharacteristic` it ensures value isn't null, and sets the string to lowercase and trims the surrounding spaces.
    - If `dogCharacteristic` has a null value, then the loop repeats gathering input.

1. Save your code, then compile by using `dotnet build` in the TERMINAL (you can refer to the steps in the previous exercise) and fix any errors.

1. Run the code by using `dotnet run`.

1. To test the search term input functionality of the app, enter `2`, selecting Menu Option `2`, for searching.

1. Press **"Enter"** without entering data at the *"Enter one desired dog characteristic to search for"* prompt. The program should return to the `Enter one desired dog characteristics to search for` prompt.

1. The program should return to the prompt until characters are entered.

1. At the prompt, test search term entry, with `golden` as your entry. The program should return to the menu without error.

1. At the menu, type "Exit" to exit the program.

## Identify which animals are dogs

Now you add a feature to search using the user input `dogCharacteristic` within the dog descriptions following the previous code under `case "2"`. But first you need to identify the dogs.

1. At the end of `case "2"` code, just before the code `Console.WriteLine("\n\rPress the Enter key to continue");`, which is before the `break;`, add the following code:

    ```csharp
    // #6 loop through the ourAnimals array to search for matching animals
    for (int i = 0; i < maxPets; i++)
    {
        if (ourAnimals[i, 1].Contains("dog"))
        {
            // #7 Search combined descriptions and report results
        }
    }
    ```

1. Take a minute to examine the loop added to the end of the `case "2":` code.

    The code filters for "dogs" using `ourAnimals[i,`**`1`**`]`, where `animalSpecies` data is stored. If `animalSpecies` stores *"dog"*  as its value, then the code moves into the brackets of the if statement where the search of the combined descriptions can occur.

1. Compile your code by using `dotnet build` and fix any errors.

## Search the combined description information of dogs

The previous code ensures that you search only dog descriptions. Now you need to search the dog descriptions and output information about matches.

While thinking about the descriptions, you realize there are two descriptions `animalPhysicalDescription` and `animalPersonalityDescription;`. The team discusses the functionality and decides that a combined description is appropriate for the search.

> [!NOTE]
> Some developers refer to the addition of requirements during development as "scope creep." Although combining the descriptions isn't much work, it still adds time and complexity. For this reason, you should let the team know that added requirements often delay the completion of the project.

### Combine the dog descriptions to make it easier to search

You need to declare a string, `dogDescription` to hold the combined data that originated from `animalPhysicalDescription` and `animalPersonalityDescription;`.

1. Declare `dogDescription` just before comment #6 with the following code:

    ```csharp
    string dogDescription = "";
    ```

    Now use the previously declared `dogDescription` string and populate it with the physical and personality descriptions for each animal

1. Populate the `dogDescription` variable with the values for `animalPhysicalDescription` and `animalPersonalityDescription;`.  

    Add the following code after comment # 7:

    ```csharp
    dogDescription = ourAnimals[i, 4] + "\n" + ourAnimals[i, 5];
    ```

## Search the combined descriptions of dogs and display

Now you add the search for `dogCharacteristic` in the combined data of `dogDescription`. You need to add an `if` statement to determine if you have a match for the search for each dog.

1. Update the code following comment #7, after `dogDescription = ourAnimals[i, 4] + "\n" + ourAnimals[i, 5];` with the code:

    ```csharp
    if (dogDescription.Contains(dogCharacteristic))
    {
        Console.WriteLine($"\nOur dog {ourAnimals[i, 3]} is a match!");
        Console.WriteLine(dogDescription);
    }
    ```

    Examine the previous code example, when the `if` statement finds a match for `dogCharacteristic` in `dogDescription` a message about the dog match and description is output to the console. You still need to account for the "no matches found" message.

1. Add the code `noMatchesDog = true`:

    Add the following code just before comment #6:
    
    ```csharp
    bool noMatchesDog = true;
    ```

   Now you can track when no matches are found with this tracking variable. When the default is set to `true` that means "it's true that no dogs match for the search." Now, when a dog is found you can "flip" the `noMatchesDog` from `true` to `false`

1. In the brackets of the `if (dogDescription.Contains(dogCharacteristic))` statement, add the following code:

    ```csharp
    noMatchesDog = false;
    ```

1. Review that your code within the brackets of `if (dogDescription.Contains(dogCharacteristic))` was entered properly.

    You should have the following code:

    ```csharp
        if (dogDescription.Contains(dogCharacteristic))
        {
            Console.WriteLine($"\nOur dog {ourAnimals[i, 3]} is a match!");
            Console.WriteLine(dogDescription);

            noMatchesDog = false;
        }
    ```

    Finally, you need to create code that decides if the "no matches found" message should be written to the console.

1. At the end of `case "2"` code, just before the code `Console.WriteLine("\n\rPress the Enter key to continue");`, which is before the `break;`, add the following code:

    ```csharp
    if (noMatchesDog)
    {
        Console.WriteLine("None of our dogs are a match found for: " + dogCharacteristic);
    }
    
    ```

    This code sample is the final code for this exercise!

1. Save your changes.

## Check your work

1. At the TERMINAL command prompt, to build your project code, enter the following command: `dotnet build`.

    If there are errors you need read the error messages, trouble shoot and make fixes or review the solution code in the "Final" folder.

1. Run your project code in the terminal with `dotnet run`.

Once the code runs, two menu items are displayed.

1. At the menu, enter "`2`" and "Enter" to test the dog search repeatedly.

        - Enter nothing as input to test the null entry behavior
        - Enter "scuba" as input to test the "match not found"
        - Enter "golden" to get two matches
        - Enter "medium" to get one match

    If everything worked as expected in both steps, congratulations! Otherwise, look for the errors by checking the exercise steps. If needed, start over or check the Final folder code for solution code to this exercise.

1. Type `exit`, at the app menu, to end the program and then close the terminal panel.
