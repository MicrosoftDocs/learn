In this first step of the development process, you review the code provided in the Starter project folder.

## Review the contents of the Program.cs file

The Program.cs file contains a preliminary version of the application that you're working on. The code includes features to generate and display the sample data for the application, and it displays a list of menu options that define the main features of the application.

1. Ensure that you have the **GuidedProject** folder open in Visual Studio Code.

    The **Prepare** unit (the previous unit in this module) includes a Setup section that describes the process for downloading the initial starting point for the guided project and opening the folder Visual Studio Code. If necessary, go back and follow the Setup instructions.

1. In the **EXPLORER** view, expand the **Starter** folder, then select **Program.cs**.

    When you select the Program.cs file, the file contents open in the main Editor area to the right of the EXPLORER.

    If the EXPLORER view isn't open, you can select/open the EXPLORER view from the Activity Bar on the far left side of Visual Studio Code. EXPLORER is the topmost icon on the Activity Bar.

1. Take a few minutes to review the initial variable declarations at the top of the Program.cs file.

    ``` c#
    // #1 the ourAnimals array will store the following: 
    string animalSpecies = "";
    string animalID = "";
    string animalAge = "";
    string animalPhysicalDescription = "";
    string animalPersonalityDescription = "";
    string animalNickname = "";

    // #2 variables that support data entry
    int maxPets = 8;
    string? readResult;
    string menuSelection = "";

    // #3 array used to store runtime data, there is no persisted data
    string[,] ourAnimals = new string[maxPets, 6];
    ```

    First, you see a comment (comment #1) followed by a list of variables. These variables, `animalSpecies` through `animalNickname`, used to hold the values of the pet characteristics within a multidimensional string array named `ourAnimals`, and initialized to contain a zero length string `""`. The `ourAnimals` array declaration is a little further down in the code.

    The next group of variables (under comment #2) are a mix of `string` and `int` variables used to help generate sample data, read user input, and establish exit criteria for the main program loop. Notice the code line `string? readResult;`. You use the `?` character to transform a normally non-nullable variable type (int, string, bool,...) with support for the nullable type.

    > [!NOTE]
    > When reading user entered values with the `Console.ReadLine()` method, it's best to enable a nullable type string using `string?` to avoid the code compiler generating a warning when you build the project.

    The final variable (under comment #3) is the two-dimensional string array named `ourAnimals`.  You initialized the number of rows, defined by maxPets, to 8. The number of characteristics that you're storing initially is six. The six characteristics match the number of string variables that you examined in the sample code, but the number of characteristics needs to expand to add a field for `suggestedDonation`.

1. Scroll down the Program.cs file to examine the `for` loop that contains a `switch` selection construct within its code block.

    The code sample is a shortened version to save space.

    ```csharp
    // #4 create sample data ourAnimals array entries
    for (int i = 0; i < maxPets; i++)
    {
        switch (i)
        {
            case 0:
                animalSpecies = "dog";
                animalID = "d1";
                animalAge = "2";
                animalPhysicalDescription = "medium sized cream colored female golden retriever weighing about 45 pounds. housebroken.";
                animalPersonalityDescription = "loves to have her belly rubbed and likes to chase her tail. gives lots of kisses.";
                animalNickname = "lola";
                break;
    
            case 1:
                animalSpecies = "dog";
                animalID = "d2";
                animalAge = "9";
                animalPhysicalDescription = "large reddish-brown male golden retriever weighing about 85 pounds. housebroken.";
                animalPersonalityDescription = "loves to have his ears rubbed when he greets you at the door, or at any time! loves to lean-in and give doggy hugs.";
                animalNickname = "gus";
                break;
            
            // case 2: deleted for brevity
            // case 3: deleted for brevity
            
            default:
                animalSpecies = "";
                animalID = "";
                animalAge = "";
                animalPhysicalDescription = "";
                animalPersonalityDescription = "";
                animalNickname = "";
                break;
        }
        ourAnimals[i, 0] = "ID #: " + animalID;
        ourAnimals[i, 1] = "Species: " + animalSpecies;
        ourAnimals[i, 2] = "Age: " + animalAge;
        ourAnimals[i, 3] = "Nickname: " + animalNickname;
        ourAnimals[i, 4] = "Physical description: " + animalPhysicalDescription;
        ourAnimals[i, 5] = "Personality: " + animalPersonalityDescription;
    }
    ```

1. Notice that the `for` loop uses the `maxPets` variable to establish an upper bound on the number of iterations following comment # 4.

1. Also notice that the `switch` construct selectively branches the code so that you can define different pet characteristics for the pets in the sample data set.

    You use a `switch` statement to define different values for the first four iterations of the `for` loop. After the sample data processing, all characteristics are empty, or zero-length, string.

    The values of the animal characteristic variables are assigned to the ourAnimals array at the bottom of the `for` loop.

1. Scroll to the bottom of the code file in Visual Studio Code. Examine the code used to display the menu options and capture the input of the user's selection.

    You should observe the following code:

    ```csharp
    // #5 display the top-level menu options
    do
    {
        // NOTE: the Console.Clear method is throwing an exception in debug sessions
        Console.Clear();
    
        Console.WriteLine("Welcome to the Contoso PetFriends app. Your main menu options are:");
        Console.WriteLine(" 1. List all of our current pet information");
        Console.WriteLine(" 2. Display all dogs with a specified characteristic");
        Console.WriteLine();
        Console.WriteLine("Enter your selection number (or type Exit to exit the program)");
    
        readResult = Console.ReadLine();
        if (readResult != null)
        {
            menuSelection = readResult.ToLower();
        }
    
        // use switch-case to process the selected menu option
        switch (menuSelection)
        {
            case "1":
                // list all pet info
                for (int i = 0; i < maxPets; i++)
                {
                    if (ourAnimals[i, 0] != "ID #: ")
                    {
                        Console.WriteLine();
                        for (int j = 0; j < 6; j++)
                        {
                            Console.WriteLine(ourAnimals[i, j]);
                        }
                    }
                }
                Console.WriteLine("\n\rPress the Enter key to continue");
                readResult = Console.ReadLine();
                break;
    
            case "2":
                // Display all dogs with a specified characteristic");
                Console.WriteLine("\nUNDER CONSTRUCTION - please check back next month to see progress.");
                Console.WriteLine("Press the Enter key to continue.");
                readResult = Console.ReadLine();
                break;
    
            default:
                break;
        }
    
    } while (menuSelection != "exit");
    ```

1. Take a minute to review the two `case` statements.

    There are only two menu options working with a limited version of the application. The starter application provides only the capabilities needed for running and testing features prototype.

1. Notice the line of code is `readResult = Console.ReadLine();` is followed by a check for a null value.

    The code using the `Console.ReadLine()` method, has the value set to the nullable string `readResult` to avoid the code compiler generating a warning when you build the project.

## Check your work

1. Test the starter code console app, at the TERMINAL command prompt build & run your project code with one command by entering: `dotnet run`.

    When the code runs, two menu items are displayed.
    - Enter "`1`" to test the "List all of our current pet information" output
    - Enter "`2`" to test the placeholder message "under construction" message

1. Enter `1` followed by pressing the Enter key to "display all pets".

1. Check that the all of the pet information displays.

    As you observe the data on all pets, the last pet displayed should match the following output:

    ```Output
    ID #: c4
    Species: cat
    Age: 3
    Nickname: Lion
    Physical description: Medium sized, long hair, yellow, female, about 10 pounds. Uses litter box.
    Personality: A people loving cat that likes to sit on your lap.
    
    Press the Enter key to continue
    ```

1. Press the Enter key to continue and return to the menu.

1. At the menu prompt, enter `2` followed by pressing the Enter key.

    This choice is a place holder for "Display all dogs with a specified characteristic" functionality.

1. Check that the "UNDER CONSTRUCTION" message displays for "Display all dogs with a specified characteristic" selection.

    You should observe the following output:

    ```Output
    UNDER CONSTRUCTION - please check back next month to see progress.
    Press the Enter key to continue.
    ```

1. Type `exit`, at the app menu, to end the program and then close the terminal panel.

    The program should exit.

Now you're ready to start developing the new features.
