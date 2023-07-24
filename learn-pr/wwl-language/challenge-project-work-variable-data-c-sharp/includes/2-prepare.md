



Use Visual Studio Code to develop update the Contoso Pets adoption C# console application. The application already creates sample data on pets available for adoption, and is able to display the pet's description information. The application provides searching with a single term within the description data for each dog. The main feature addition is search with multiple terms. The secondary improvement is to the "search status" animation and includes adding a search countdown in the animation.

## Project specification overview

Update the existing Contoso Pets starter application to include multiple term search and improved "search status" animation features:

### Add dog attribute multi-term search

Gather user input for the pet characteristic multiple term search

- Users need to provide search terms separated by commas
- Store the search terms in an array and sort the terms alphabetically

Within the animals array loop that identifies "dogs":

- Iterate through the search terms to search each dog's description
- Search the **combined description** for a term match
- Output each dog's description where there's one or more terms matched

After exiting the "search Animals" array loop that identifies dogs:

- If no dogs were a match for any of the users provided search terms, output a *no dogs matched* message.

### Add "search status" improvements

Update the animation

- Adjust the `searchingIcons` array to resemble a spinning dial
- Adjust the animation loop so the animation shows a numeric countdown from two to zero (`2.., 1.., 0..`)

### Starter code

The starter code project for this challenge project module includes a Program.cs file that provides the following code features:
  
- The code declares variables used to collect and process pet data and menu item selections
- The code declares the ourAnimals array
- The code uses a for loop around an if-elseif-else construct to populate the ourAnimals array with a sample dataset
- The code displays the following main menu options for user selection:
  
  ```output
  1. List all of our current pet information
  2. Display all dogs with a specified characteristic
  
  Enter menu item selection or type "Exit" to exit the program
  ```

- The application menu code reads the user's menu item selection and displays a message echoing their selection
- Case 1: "List all of our current pet information" displays the sample data for all animals (two dogs and two cats)
- Case 2: "2. Display all dogs with a specified characteristic" is the primary area where new functionality code is added
  - Under Case 2, the starter code identifies dogs and searches for a *single* user input term
  - Before you search each dog, the console shows a simple "animation" that simulates a status for searching occurring

Your goal is to update the existing code to develop key features requested by your team:

- Add dog multiple attribute search
- Update search animation

Use Visual Studio Code as your development environment, and test your application at each stage of your development process.

## Setup

Use the following steps to prepare for the Guided project exercises.
1. Download a zip file containing the code folders for the challenge project.
    
    - In a browser, open the link [Challenge-Project-variable-data-in-CSharp-main.zip](https://github.com/MicrosoftLearning/Challenge-project-Work-with-variable-data-in-CSharp/archive/refs/heads/main.zip) to download the zip file (Challenge-Project-variable-data-in-CSharp-main.zip).

1. Unzip the downloaded files locally (or in the sandbox if you aren't using a local dev environment)

    1. On your local machine, navigate to your downloads folder
    1. Right-click the Challenge-Project-variable-data-in-CSharp-main.zip file, and then select **Extract all**
    1. Make note of the extracted files location (the location of the root folder)

1. Open the root GuidedProject folder in Visual Studio Code

    1. Open Visual Studio Code locally (or open MS Learn sandbox and open Visual Studio Code if you aren't using a local dev environment)
    1. In Visual Studio Code, on the **File** menu, select **Open Folder**
    1. Navigate to the folder that contains your extracted files, expand the folder structure to locate the folder named "Challenge-Project-variable-data-in-CSharp-main".
    1. Select **Challenge-Project-variable-data-in-CSharp-main** and then select **Select Folder**

        - The Visual Studio Code EXPLORER view should show two subfolders named **Final** and **Starter**.

## Starter file review

1. In Visual Studio Code, navigate to the challenge project **starter** folder

1. In Visual Studio Code menu Bar, select: "Terminal" > "New Terminal"

1. The Terminal Window should be open to the Starter folder containing the Program.cs file. Build and run the file entering `dotnet run` in the terminal window.

1. The menu should display with two options. Enter `1` as shown in the following terminal example:

    ```Console
    Welcome to the Contoso PetFriends app. Your main menu options are:
      1. List all of our current pet information
      2. Display all dogs with a specified characteristic
    
    Enter your selection number (or type Exit to exit the program)
    1
    ```
  
    The sample data on the current pets should display followed by the message `Press the Enter key to continue`

1. After pressing Enter, the menu should display again. Choose Option `2`, shown in the following example:

    ```Console
    Welcome to the Contoso PetFriends app. Your main menu options are:
     1. List all of our current pet information
     2. Display all dogs with a specified characteristic
    
    Enter your selection number (or type Exit to exit the program)
    2
    
    Enter one desired dog characteristic to search for
    
    ```

1. Enter "large" for the search term and press "Enter."

1. Notice the "searching" message as shown:

    ```Console
    searching our dog Nickname: gus for large ...     
    ```

1. Notice, the message runs before each search of a pet, and the periods (`., .., ...`) at the end change in an *animation*. Run the search again if you missed it.

1. Once the search ends, press enter to return to the menu. Then type "exit" and press "Enter" to close the application.

1. Take a few minutes to become familiar with the Project.cs started code.

    Focus on the areas that require updates, search and the animation.

    Notice that there are some comments left in the code that indicate where to place an update.

You're now ready to begin the Guided project exercises. Good luck!
