



In this challenge project, you'll use Visual Studio Code to develop portions of a C# console application. You'll use boolean expressions, selection statements, and iteration statements to implement the features of a design specification. As you develop the application, you'll need to scope variables at the appropriate level.

## Project specification

The Starter code project for this module includes a Program.cs file with the following code features:

- The code declares variables used to collect and process pet data and menu item selections
- The code declares the ourAnimals array that includes the following information for each animal in the array:

    - Pet ID #.
    - Pet species (cat or dog).
    - Pet age (years).
    - A description of the pet's physical appearance.
    - A description of the pet's personality.
    - The pet's nickname.

- The code uses a for loop around a switch-case construct to populate elements of the ourAnimals array.
- The code includes a loop around a main menu that terminates when the user enters "exit". The main menu includes:

    1. List all of our current pet information.
    1. Assign values to the ourAnimals array fields.
    1. Ensure animal ages and physical descriptions are complete.
    1. Ensure animal nicknames and personality descriptions are complete.
    1. Edit an animal’s age.
    1. Edit an animal’s personality description.
    1. Display all cats with a specified characteristic.
    1. Display all dogs with a specified characteristic.

    Enter menu item selection or type "Exit" to exit the program

- The code reads the user's menu item selection and uses a switch statement to branch the code for each menu item number.
- The code includes implementation for menu options 1 and 2.
- The code displays an "under construction" message for menu options 3-8.  

Your goal in this challenge is to create the app features aligned with menu options 3 and 4.

> [!NOTE]
> New animals must be added to the ourAnimals array when they arrive. However, an animal's age and some physical characteristics for a pet may be unknown until after a veterinarian's examination. In addition, an animal's nickname and personality may be unknown when a pet first arrives. The new features that you're developing will ensure that a complete dataset exists for each animal in the ourAnimals array.

To ensure that animal ages and physical descriptions are complete, your code must:

- Assign a valid numeric value to petAge for any animal that has been assigned data in the ourAnimals array but has not been assigned an age.
- Assign a valid string to petPhysicalDescription for any animal that has been assigned data in the ourAnimals array but has not been assigned a physical description.
- Verify that physical descriptions have an assigned value. Assigned values cannot have zero characters. Any further requirement is up to you.

To ensure that animal nicknames and personality descriptions are complete, your code must:

- Assign a valid string to petNickname for any animal that has been assigned data in the ourAnimals array but has not been assigned a nickname.
- Assign a valid string to petPersonalityDescription for any animal that has been assigned data in the ourAnimals array but has not been assigned a personality description.
- Verify that nicknames and personality descriptions have an assigned value. Assigned values cannot have zero characters. Any further requirement is up to you.

## Setup

Use the following steps to prepare for the Challenge project exercises:

1. To download a zip file containing the Starter project code, select the following link: [Lab Files](https://github.com/MicrosoftLearning/Challenge-project-branching-looping-CSharp/archive/refs/heads/main.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **Challenge-project-branching-looping-CSharp.main.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **ChallengeProject** folder to your Windows Desktop folder.

    > [!NOTE]
    > If a folder named **ChallengeProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **ChallengeProject** folder in Visual Studio Code.

    1. Open Visual Studio Code in your development environment.
    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the Windows Desktop folder and locate the "ChallengeProject" folder.
    1. Select **ChallengeProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **ChallengeProject** folder and two subfolders named **Final** and **Starter**.

You're now ready to begin the Challenge project exercises. Good luck!
