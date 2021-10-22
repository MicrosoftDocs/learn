<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Packaging our Razor Class library delivers a binary deliverable that can be referenced by Blazor projects and the contained components can be used in those projects.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->

Previously, we created a Razor Class Library that contains a `Modal` component that delivers a modal dialog window for Blazor applications.  If we would like to share that component for use in other applications, we need to package and place it in a repository or a folder where other developers can acquire it.

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->

In this unit, we are going to update that project and generate a NuGet package.  Finally, we will deploy that NuGet package to our Blazor server application.

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

## Add package properties to FirstClassLibrary

We will first update the FirstClassLibrary project with properties that will allow it to be packaged for deployment as a NuGet package.  

1. Open the project file for the MyClassLibrary project by either double-clicking on the project in the Visual Studio Solution Explorer or opening `MyClassLibrary.csproj` in Visual Studio Code
1. In the section near the top of the file with the `<PropertyGroup>` tag, add the following content before the closing `</PropertyGroup>` tag:

    ```xml
        <PackageId>My.FirstClassLibrary</PackageId>
        <Version>0.1.0</Version>
        <Authors>YOUR NAME HERE</Authors>
        <Company>YOUR COMPANY NAME</Company>
        <Description>This is a razor component library with a cool Modal window component.</Description>
      </PropertyGroup>
    ```

1. This defines our Razor Class Library as having package name "My.FirstClassLibrary" and a version of 0.1.0.  You can set your own name and company name appropriately in those two fields.

## Package the Library for reuse

Next, let's run the .NET command at the command line to package the Razor Class Library so that other applications outside of our solution can reference it.  You could run these same steps in your continuous integration process to package a library and deploy it to NuGet.org, a GitHub repository, or another location for your organization to share.

1. From the command line, in the same folder as the `MyClassLibrary.csproj` file, execute the following:

    ```dotnetcli
    dotnet pack
    ```

1. This will write a file called `My.FirstClassLibrary.0.1.0.nupkg` into your `bin/Debug` folder.

## Add a reference to the NuGet package in the MyServer application

We already referenced the FirstClassLibrary project in our MyServer application since it was in the same folder structure as the web application.  Let's undo that project reference and add a reference to the NuGet package we created.  

These steps are NOT a typical configuration. Library projects residing in the same folders or solution as the applications that want to reference them can reference the project directly as we saw in the previous exercise.  

1. Open the `MyServer.csproj` file by double-clicking on the MyServer project name in Visual Studio or opening that file in Visual Studio Code.
1. Remove the line `<ProjectReference Include="..\FirstClassLibrary\FirstClassLibrary.csproj" />`
1. On the command line, in the same folder as `MyServer.csproj` execute the following:

    ```dotnetcli
    dotnet add package My.FirstClassLibrary -s ..\FirstClassLibrary\bin\Debug
    ```

    This grabs the NuGet package created in the last step and installs a copy in our local NuGet package cache.  It then adds a reference to that package inside of `MyServer.csproj`

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

Did our new package install properly?  Can we start the FirstServer application and see a modal window when the application starts?

1. Start the MyServer application by pressing F5 in Visual Studio or at the command line in the MyServer folder execute `dotnet run`
1. Navigate a browser to the home page of the MyServer application (typically `https://localhost:5000`)
1. Do you see the 'My first Modal dialog'?  If so, congratulations! You've successfully packaged and deployed the FirstClassLibrary correctly. Applications everywhere can now use your modal window component by referencing your new NuGet package.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
