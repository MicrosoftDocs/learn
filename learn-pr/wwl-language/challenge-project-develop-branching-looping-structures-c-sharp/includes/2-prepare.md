
You'll be using Visual Studio Code to develop portions of a C# console application. You will be writing code that evaluates boolean expressions, implements various selection and iteration statements (branching and looping structures), and declares variables within code blocks at the appropriate scoping level for the app. Here, we'll discuss the overall goals of the project and how you'll build and test your application. We'll also cover how to set up your development environment, including a "Starter" code project.

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

- The code uses a for loop around a select-case construct to populate elements of the ourAnimals array.
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
> New animals must be added to the ourAnimals array when the y arrive. However, an animal's age and some physical characteristics for a pet may be unknown until after a veterinarian's examination. In addition, an animal's nickname and personality may be unknown when a pet first arrives. The new features that you have volunteered to develop will be used to ensure that we have a completed dataset for each animal in the ourAnimals array.

To complete the feature that ensures animal ages and physical descriptions are complete, your code will need to:

    - Assign a valid numeric value to petAge for any animal that has been assigned data in the ourAnimals array but has not been assigned an age.
    - Assign a valid string to petPhysicalDescription for any animal that has been assigned data in the ourAnimals array but has not been assigned a physical description.
    - A valid physical description cannot be null and cannot have zero characters, any further requirement is up to you.

To complete the feature that ensures animal nickname and personality descriptions are complete, your code will need to:

    - Assign a valid string to petNickname for any animal that has been assigned data in the ourAnimals array but has not been assigned a nickname.
    - Assign a valid string to petPersonalityDescription for any animal that has been assigned data in the ourAnimals array but has not been assigned a personality description.
    - A valid nickname or personality description cannot be null and cannot have zero characters, any further requirement is up to you.

## Setup

Use the following steps to prepare for the Challenge project exercises.

1. Download a zip file containing the code folders for the LP2 Challenge project.

    - In a browser, navigate to [Lab Files](https://github.com/MicrosoftLearning/Challenge-project-Develop-branching-and-looping-structures-in-CSharp/archive/refs/heads/main.zip) and download the zip file.

1. Unzip the downloaded files locally (or in the sandbox if you aren't using a local dev environment).

    1. On your local machine, navigate to your downloads folder.
    1. Right-click the Challenge-project-Develop-branching-and-looping-structures-in-CSharp.zip file, and then select **Extract all**.
    1. Use the **Browse** button to specify the Windows Desktop folder as the extract location, and then select **Select Folder**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Open the extracted **ChallengeProject** folder in VS Code.

    1. Open VS Code locally (or open MS Learn sandbox and open VS Code if you aren't using a local dev environment)
    1. In VS Code, on the **File** menu, select **Open Folder**
    1. Navigate to the folder that contains your extracted files, expand the folder structure to locate the folder named "ChallengeProject".
    1. Select **ChallengeProject** and then select **Select Folder**

        The Visual Studio Code EXPLORER view should show the **ChallengeProject** folder and two sub-folders named **Final** and **Starter**.

You are now ready to begin the Challenge project exercises. Good luck!
