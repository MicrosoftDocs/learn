<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Babylon.js is a 3D rendering engine which provides a variety of WebXR features and support within its framework.

Recall that the amusement park company wanted the application to be a VR/AR application accessible through the public web. In this exercise, you will add WebXR support and features to the Babylon.js application built so far.

Here, you have a choice of adding support for the VR mode or the AR mode based on your preference. Select the tab of the path that you prefer to continue.

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

## Enable WebXR Support

::: zone pivot="vr"

Let's enable WebXR support for the immersive VR mode in the amusement park application.

1. If you have closed it, open your project folder from the previous exercise in Visual Studio Code.
1. Navigate to *src/index.ts* in your project folder.
1. In the createScene() function, add the following code before the function's return statement:

    ```typescript
    const xr = await scene.createDefaultXRExperienceAsync();
    ```

::: zone-end

::: zone pivot="ar"

Let's enable WebXR support for the immersive AR mode in the amusement park application.

1. If you have closed it, open your project folder from the previous exercise in Visual Studio Code.
1. Navigate to *src/index.ts* in your project folder.
1. In the createScene() function, add the following code before the function's return statement:

    ```typescript
    const xr = await scene.createDefaultXRExperienceAsync({
        uiOptions: {
            sessionMode: "immersive-ar",
        },
    });
    ```

## Add background remover

When users enter the AR session, we want them to use their own surroundings as the background for the dragon-summoning activity. Let's enable the background remover feature to remove the ground and sky meshes only during an AR session.

1. Below the scene.createDefaultXRExperienceAsync() function call, add this line to enable the background remover feature:

    ```typescript
    xr.baseExperience.featuresManager.enableFeature(BABYLON.WebXRBackgroundRemover, 'latest', {
        backgroundMeshes: [env.skybox, env.ground]
    });
    ```

::: zone-end

## Limit speech recognition to WebXR sessions
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Position the dragon
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
