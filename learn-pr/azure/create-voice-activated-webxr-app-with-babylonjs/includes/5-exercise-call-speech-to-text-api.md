The Azure Speech JavaScript SDK allow developers to integrate Azure Speech services into their applications more efficiently.

In the amusement park application, we need to use a speech-to-text service to recognize a magical spell. Once the spell is recognized, the application needs to render the dragon 3D models to create the experience of "summoning the dragon."

Here, you will use the Azure Speech JavaScript SDK to integrate the Azure Speech-to-text service into the amusement park application.

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

## Clone the Github Repository

Recall that your teammate has already set up a Babylon.js project with all of the necessary assets imported into the Babylon.js scene. You have to clone the repository that contains their work so far.

1. Goto [this Github repository](https://github.com/JING1201/learn-magic-template) and select the **Code** dropdown.

    (screenshot)
1. Copy the **URL of the repository** under the **HTTPS** tab.
1. Open Visual Studio Code in a new window.
1. Select the Settings button in the bottom left of the window, and then select **Command Palette** from the options.
1. After the Command Palette pops up, type in "git" and select the **Git: Clone** command.
1. Paste the URL of the Github repository.
1. Select the folder where you would like to save the repository. The root folder of the repository becomes a subdirectory in the folder you select.
1. Select open the repository after cloning finishes.

## Install dependencies

You might have noticed that this project is organized to be used with *webpack*, a Javascript module bundler. All of the required dependencies are listed in the *package.json* file. Let's use *npm* to install all of them.

1. Select **Terminal** in the menu of Visual Studio Code, and then select **New Terminal** to create a new terminal.
1. Within the terminal, make sure that you are in the root folder of the repository.
1. Use `npm install` to install all dependencies for the project.
1. You should see a folder named node_modules created in the repository folder.

## Import dependencies

The next thing that you might have noticed is that the source files in this repository have the *.ts* extension, which means that the files are written in TypeScript instead of Javascript. While TypeScript and JavaScript are very similar in nature, TypeScript requires types to be clear for every variable and function parameters.

As a result, you'll need to import every class that is used as a variable or as a function parameter:

1. Navigate to **src/index.ts** in your VSCode window.
1. Add this import statement at the top of the file:

    ```typescript
    import { 
        SpeechConfig, 
        AudioConfig, 
        Recognizer, 
        SpeechRecognizer, 
        PhraseListGrammar, 
        SpeechRecognitionEventArgs, 
        SpeechRecognitionCanceledEventArgs, 
        ResultReason, 
        CancellationReason, 
    } from 'microsoft-cognitiveservices-speech-sdk';
    ```

1. <!-- Step n -->

## Create Speech Recognizer

## Render dragon when spell is recognized

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "## Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
