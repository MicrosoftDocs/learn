

You'll be using Visual Studio Code to develop the initial version of a C# console application. You will be writing code that evaluates boolean expressions, implements various selection and iteration statements (branching and looping structures), and declares variables within code blocks at the appropriate scoping level for the app. Here, we'll discuss the overall goals of the project and how you'll build and test your application. We'll also cover how to set up your development environment, including a "Starter" code project.

## Project overview

The design specification for the Contoso Pets application identifies the following:

- The application will be a C# console application.
- The application data will be accessible from a multidimensional string array named ourAnimals.
- The ourAnimals array will include the following "pet characteristics" for each animal:

    - Pet ID #.
    - Pet species (cat or dog).
    - Pet age (years).
    - A description of the pet's physical condition/characteristics.
    - A description of the pet's personality.
    - The pet's nickname.

- The application will load a sample dataset that represents dogs and cats currently in your care.
- The application will present a list of menu options that enable an app user to access the main features of the application.
- The application will include the following features:

    - List the pet information for all animals in the ourAnimals array.
    - Add new animals to the ourAnimals array (the following conditions apply):

        - An animal's age and some physical characteristics for a pet may be unknown until a veterinarian's examination (for example: breed, neutered/spayed status).
        - An animal's nickname and personality may be unknown when a pet first arrives.
        - The pet species (dog or cat) must be entered when a new animal is added to the ourAnimals array.
        - A pet ID must be programmatically generated when a new animal is added to the ourAnimals array.

    - Ensure animal ages and physical descriptions are complete (this action can occur after a veterinarian's examination).
    - Ensure animal nicknames and personality descriptions are complete (this action can occur after the team gets to know a pet).
    - Edit an animal’s age (if a pet's birth date is known and the pet has a birthday while in our care).
    - Edit an animal’s personality description (a pet may behave differently after spending more time in our care).
    - Display all cats that meet user specified physical characteristics.
    - Display all dogs that meet user specified physical characteristics.

Some initial code development has already been completed. The Starter code project for this Guided project module includes a Program.cs file that provides the following code features:

- The code declares variables used to collect and process pet data and menu item selections.
- The code declares the ourAnimals array.
- The code uses a for loop around an if-elseif-else construct to populate the ourAnimals array with a sample dataset.
- The code displays the following main menu options for user selection:

    1. List all of our current pet information.
    1. Assign values to the ourAnimals array fields.
    1. Ensure animal ages and physical descriptions are complete.
    1. Ensure animal nicknames and personality descriptions are complete.
    1. Edit an animal’s age.
    1. Edit an animal’s personality description.
    1. Display all cats with a specified characteristic.
    1. Display all dogs with a specified characteristic.

    Enter menu item selection or type "Exit" to exit the program

- The code reads the user's menu item selection and displays a message echoing their selection.

Your goal is to update the existing code, and then develop app features in support of the first two menu options shown above. The key tasks that you'll need to accomplish are:

1. Update the code that's used to create the sample data for the app.
1. Construct a loop around the main menu and create a selection statement that establishes a code branch for each menu option.
1. Write the code to display all ourAnimals array data (menu option 1).
1. Build a loop for entering new ourAnimals array data (menu option 2 - part 1).
1. Write code to read and save new ourAnimals array data (menu option 2 - part 2).

You will use Visual Studio Code as your development environment, and you will test your application at each stage of your development process.

## Setup

Use the following steps to prepare for the Guided project exercises.

1. Download a zip file containing the code folders for the LP2 Guided project.

    - In a browser, navigate to [Lab Files](https://github.com/MicrosoftLearning/Guided-project-Develop-conditional-branching-and-looping-structures-in-CSharp/archive/refs/heads/main.zip) and download the zip file.

1. Unzip the downloaded files locally (or in the sandbox if you aren't using a local dev environment).

    1. On your local machine, navigate to your downloads folder.
    1. Right-click the Guided-project-Develop-conditional-branching-and-looping-structures-in-CSharp.zip file, and then select **Extract all**.
    1. Use the **Browse** button to specify the Windows Desktop folder as the extract location, and then select **Select Folder**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Open the extracted **GuidedProject** folder in VS Code.

    1. Open VS Code locally (or open MS Learn sandbox and open VS Code if you aren't using a local dev environment).
    1. In VS Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the folder that contains your extracted files, expand the folder structure to locate the folder named "GuidedProject".
    1. Select **GuidedProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **GuidedProject** folder and two sub-folders named **Final** and **Starter**.

You are now ready to begin the Guided project exercises. Good luck!
