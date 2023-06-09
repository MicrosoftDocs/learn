



In this step of the development process, you update the code provided in the starter project folder, adding features for "suggested donation" to the application. The starter project.cs file should be open in Visual Studio Code. Return to the previous prepare unit if you need instructions for getting started.

## Create the "Suggested Donation" features

The added donation features require you to create `suggestedDonation` variable, and to expand the `ourAnimals` array accommodate the new donation data.  Also, you need to add the suggested donation amounts for each animal, and implement a default amount when there suggested donation information is missing.

### Add support for suggested donation data

You need to create a new variable to hold suggested donations and expand the `ourAnimals` array to hold the new data.

1. Notice the code under comment #1 that declares variables used for populating the `ourAnimals` array for each animal.

    You need to declare another `string` for the suggested donation data.

    ```csharp
    // #1 the ourAnimals array will store the following: 
    string animalSpecies = "";
    string animalID = "";
    string animalAge = "";
    string animalPhysicalDescription = "";
    string animalPersonalityDescription = "";
    string animalNickname = "";
    ```

1. Create the `suggestedDonation` variable below the declaration for `animalNickname`.

    The declaration for the `suggestedDonations` is added with the following code:

    ```csharp
    string suggestedDonation = "";
    ```

1. Locate the code to create the `ourAnimals` array following comment # 3.

    The following line of code creates the array:

    >`string[,] ourAnimals = new string[maxPets, `**`6`**`];`

    The sizes defining the two dimensions of the array are the maximum number of pets `maxPets` and the number `6` for the six strings originally defined, but without room for the new `suggestedDonation` data.

1. Update `ourAnimals` array to hold `7` "columns" of data for each animal instead of `6`.

    The following line shows the updated code:

    `string[,] ourAnimals = new string[maxPets, `**`7`**`];`

    You've expanded the `ourAnimals` array to support the added `suggestedDonation` data.

### Add `suggestedDonation` amounts to the sample data

1. Take a minute to review `case 0:` inside the switch statement following comment #4.

    The following code that defines sample data for the first pet before the `suggestDonation` data is created.  It would fit nicely below the `animalNickName`!

    ```csharp
        case 0:
            animalSpecies = "dog";
            animalID = "d1";
            animalAge = "2";
            animalPhysicalDescription = "medium sized cream colored female golden retriever weighing about 45 pounds. housebroken.";
            animalPersonalityDescription = "loves to have her belly rubbed and likes to chase her tail. gives lots of kisses.";
            animalNickname = "lola";
            break;
    ```

1. Insert a `suggestedDonation` value above the `break` statement for `case 0;` through `case 3:` with the following values:

    - Case 0: `suggestedDonation = "85.00";`
    - Case 1: `suggestedDonation = "49.99";`
    - Case 2: `suggestedDonation = "40.00";`
    - Case 3: `suggestedDonation = "";`

    The following code shows `case 0:` code with the addition of 'suggestedDonation':

    ```csharp
        case 0:
            animalSpecies = "dog";
            animalID = "d1";
            animalAge = "2";
            animalPhysicalDescription = "medium sized cream colored female golden retriever weighing about 45 pounds. housebroken.";
            animalPersonalityDescription = "loves to have her belly rubbed and likes to chase her tail. gives lots of kisses.";
            animalNickname = "lola";
            suggestedDonation = "85.00";
            break;
    ```

1. In your project.cs file, locate the following array populated with the pet data from case statements (it's just before comment # 5):

    ```csharp
        ourAnimals[i, 0] = "ID #: " + animalID;
        ourAnimals[i, 1] = "Species: " + animalSpecies;
        ourAnimals[i, 2] = "Age: " + animalAge;
        ourAnimals[i, 3] = "Nickname: " + animalNickname;
        ourAnimals[i, 4] = "Physical description: " + animalPhysicalDescription;
        ourAnimals[i, 5] = "Personality: " + animalPersonalityDescription;
    ```

1. Notice that `suggestedDonation` data isn't included as part of the sample data starter code for populating the array.

    It makes sense to populate the array with a statement like:

    ```csharp
    ourAnimals[i, 6] = "Suggested Donation: "  + suggestedDonation;
    ```

    But, you won't add that code. In the next section you'll use another approach.

### Data validation with `TryParse()`

The variable `suggestedDonation` is intended to be a numeric value, but is collected and stored as a `string`. In the future you may have to validate `suggestedDonation` represents a decimal, and that you can convert it to a decimal so it's available to use for billing calculations. To avoid an error trying to use an entry like `twenty` you need to use `TryParse` validation.

1. Before comment #5, inside the end of the code block, add the code to validate that `suggestedDonation` can be cast as a decimal.

    You add the following:

    ```csharp
    if (!decimal.TryParse(suggestedDonation, out decimalDonation)){
        decimalDonation = 45.00m; // if suggestedDonation NOT a number, default to 45.00
    }
    ```

    If the `suggestedDonation` variable can't be cast as a `decimal` the code assigns a default value `decimalDonation = 45.00m;`. If the cast is successful, the `TryParse` populates `decimalDonation`. Either way, `decimalDonation` represents a proper decimal.

1. Ensure that your validation code is in the right place!

    The two lines you added should appear in the code as the top two lines of the following code :

    ```csharp
        if (!decimal.TryParse(suggestedDonation, out decimalDonation)){
            decimalDonation = 45.00m; // if suggestedDonation NOT a number, default to 45.00
        }
    }

    // #5 display the top-level menu options
    ```

    Note, validation still doesn't work. You can't forget, the need to declare `decimalDonation` to use it in the code.

1. Following the comment #2, declare `decimalDonation`, after `string menuSelection = "";`:

    ```csharp
    decimal decimalDonation = 0.00m;
    ```

    Finally you're ready to populate `suggestedDonation` data for each pet.

1. Above comment #5, immediately after the `TryParse` closing bracket `}` you completed, add the following code:

    ```csharp
    ourAnimals[i, 6] = $"Suggested Donation: {decimalDonation:C2}";
    ```

    You used the `decimalDonation` version of the suggested donation data. You also used string interpolation and currency formatting in the output.

1. Take a minute to review how the suggested donation data finally makes it into the `ourAnimals` array.

     The following code populates the `decimalAnimals` in context of the `TryParse()`:

    ```csharp  
    if (!decimal.TryParse(suggestedDonation, out decimalDonation)){
        decimalDonation = 45.00m; // if suggestedDonation NOT a number, default to 45.00
        }
    ourAnimals[i, 6] = $"Suggested Donation: {decimalDonation:C2}";
    }
    
    // #5 display the top-level menu options
    ```

    Notice that by using the code `{decimalDonation:C2}` the suggested donation, from `decimalDonation`, will display with the local currency symbol and two decimal places as directed by the currency formatting `:C2`.

## Review and update where `ourAnimals` array should be used

The addition of the `suggestedDonation` data created need for further updates. The menu option `"1. List all of our current pet information"` is missing the added data.

1. Notice the code under comment #5, for the menu loop within `case 1`.

    The inner loop "`for (int j = 0; j < `**`6`**`; j++)`" that prints the pet attributes needs to account for  `suggestedDonation` data added.

2. Update the inner loop code exit condition.  Increased the exit condition by "1", so it becomes `j <`**`7`**. Check that your code matches the following:

    ```csharp
    case "1":
    // list all pet info
    for (int i = 0; i < maxPets; i++)
    {
        if (ourAnimals[i, 0] != "ID #: ")
        {
            Console.WriteLine();
            for (int j = 0; j < 7; j++) // increased exit condition
            {
                Console.WriteLine(ourAnimals[i, j]);
            }
        }
    }
    ```

## Testing Overview

With several code additions in place, you need to confirm your code works as expected. The two significant test areas are:

1. The code complies without errors.

1. Selecting menu option 1 all pet information displays:

    - Output includes all of sample pet information, including: ID, species, age, nickname, physical description, and personality description.
    - For each pet, the suggested donation displays with a currency symbol and with two decimal places of precision.

## Check your work

**Build and run to test the code.** Use these steps each time you need to test your code.

1. On the Visual Studio Code **File** menu, select **Save**.

1. In the EXPLORER view, right-click **Starter**, and then select **Open in Integrated Terminal**.

    A TERMINAL panel should open below the code Editor area.

    There are several ways to open Visual Studio Code's integrated terminal. For example, the top menu provides access to the TERMINAL panel from both the **View** menu and the **Terminal** menu. You may also learn keyboard shortcuts that open the TERMINAL panel. Each method is acceptable.

1. Notice that the TERMINAL panel includes a command line prompt, and that the prompt shows the current folder path. For example:

    ```txt
    C:\Users\someuser\Desktop\GuidedProject\Starter>
    ```

    You can use the TERMINAL panel to run Command Line Interface (CLI) commands, such as `dotnet build` and `dotnet run`. The `dotnet build` command compiles your code and display error and warning messages related to your code syntax.

    > [!IMPORTANT]
    > You need to ensure that terminal command prompt is open to the root of your project workspace. In this case, the root of the project workspace is the Starter folder, where the Starter.csproj and Program.cs files are located. When you run commands in the terminal, the commands will try to perform actions using current folder location. If you try to run the `dotnet build` or `dotnet run` commands from a folder location that does not contain the files, the commands will generate error messages.

1. At the TERMINAL command prompt, to build your project code, enter the following command: `dotnet build`  

    After a couple seconds, you should see a message telling you that your build succeeded, and that you have 0 Warning(s) and 0 Error(s).

    ```txt
    Determining projects to restore...
    All projects are up-to-date for restore.
    Starter -> C:\Users\someuser\Desktop\GuidedProject\Starter\bin\Debug\net6.0\Starter.dll

    Build succeeded.
        0 Warning(s)
        0 Error(s)
    ```

    > [!NOTE]
    > Use the above `dotnet build` and `dotnet run` steps each time you need to test your code in the exercises that follow in this module.

1. If you see Error or Warning messages, you need to fix them before continuing.

    Error and Warning messages list the code line where the issue is found. The following message is an example of a `Build FAILED` error message:

    `C:\Users\someuser\Desktop\GuidedProject\Starter\Program.cs(53,18): error CS1002: ; expected [C:\Users\someuser\Desktop\GuidedProject\Starter\Starter.csproj]`

    This message tells you the type of error that was detected and where to find it. In this case, the message tells you that the Program.cs file contains an error - `error CS1002: ; expected`. The `; expected` suggests that you forgot to include a `;` at the end of a statement. The `Program.cs(53,18)` portion of the message tells you the error location, on code line 53, at a position 18 characters in from the left.

    A syntax error like this prevents the Build from succeeding (Build FAILED). Some Build messages provide a "Warning" instead of an "Error", which means there's something to be concerned with, but you can try running the program anyway (Build succeeded).

    Once you've fixed the issues and saved your updates, you can run the `dotnet build` command again. Continue until you have 0 Warning(s) and 0 Error(s).

    If you have trouble resolving an issue on your own, you can examine the Program.cs code in the Final folder that's included as part of the download that you completed during Setup. The Program.cs code in the Final folder represents the conclusion of all exercises in this module, so it includes code that you haven't created yet.

    The solution code may look considerably different than the Program.cs code that you've developed at this point in the Guided project. However, you can try examining the Program.cs code in Final to help you isolate and fix an issue in your code if you need to.

    Try not to limit your use the solution code. Remember that you learn from mistakes and that every developer spends time finding and fixing errors.

1. Test the updated console app, at the TERMINAL command prompt build & run your project code with one command by entering: `dotnet run`. When the code runs two menu items display.
    - Enter "`1`" to test the "display all pets" output
    - Enter "`2`" to test the placeholder message "under construction" message

    The output for menu item #1 should closely match the following sample:

    ```output
    ID #: d1
    Species: dog
    Age: 2
    Nickname: lola
    Physical description: medium sized cream colored female golden retriever weighing about 45 pounds. housebroken.
    Personality: loves to have her belly rubbed and likes to chase her tail. gives lots of kisses.
    Suggested Donation: $85.00
    
    ID #: d2
    Species: dog
    Age: 9
    Nickname: gus
    Physical description: large reddish-brown male golden retriever weighing about 85 pounds. housebroken.
    Personality: loves to have his ears rubbed when he greets you at the door, or at any time! loves to lean-in and give doggy hugs.
    Suggested Donation: $49.99
    
    ID #: c3
    Species: cat
    Age: 1
    Nickname: snow
    Physical description: small white female weighing about 8 pounds. litter box trained.
    Personality: friendly
    Suggested Donation: $40.00
    
    ID #: c4
    Species: cat
    Age:
    Nickname: lion
    Physical description:
    Personality:
    Suggested Donation: $45.00
    ```

    If everything worked as expected, congratulations! Otherwise, look for the error by checking code instruction steps involved.  If needed, start over with a new starter Project.cs file and if you still have issues check the solution folder code for this exercise.

1. Type `exit`, at the app menu, to end the program and then close the terminal panel.
