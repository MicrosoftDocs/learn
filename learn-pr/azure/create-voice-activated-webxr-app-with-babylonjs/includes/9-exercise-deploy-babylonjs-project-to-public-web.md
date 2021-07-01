Azure Blob Storage allows developers to serve static content on the web by storing the source files in the *$web* container.

Recall that in the scenario of the amusement park application, we need to make the Babylon.js WebXR application available on the public web.

In this exercise, you''ll use Azure Blob Storage to serve the amusement park application as a public static website.

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

## Build the web project

Before jumping into hosting the website, we must first package our Node.js web project into a folder of static files.

1. If you don't already have a terminal open in VSCode, select **Terminal** in the menu of Visual Studio Code, and then select **New Terminal** to create a new terminal.
1. Within the terminal, make sure that you are in the root folder of the repository.
1. Run `npm run-script build` in the terminal to package the project into static files.
1. After the command finishes running, you should see a folder named *dist* created in the root folder of the project.

## (Chunk 2 heading)
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## (Chunk n heading)
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

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
