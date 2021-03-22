<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Azure SQL Database is a great choice for operational, transactional, and hybrid analytical workloads.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
In the bus catching scenario, Azure SQL Database was selected due to it being an enterprise database with modern capabilities, like JSON and geospatial support.

TODO: add your scenario image

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
Here, you will deploy Azure SQL Database using scripts, connect to it in Azure Data Studio, and set up the database for the scenario using T-SQL.

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
    1. Deploy SQL DB
    1. Connect with ADS
    1. Set up the database using T-SQL scripts (includes loading data)
## Deploy Azure SQL Database
In order to set up the database for the bus catching scenario, you'll first need to deploy a database to work with. To do this, you'll use the Azure Cloud Shell which is on the right side of this page. The Azure Cloud Shell is also available through the Azure portal, and allows you to create and manage Azure resources. It comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll leverage Azure PowerShell, but you can accomplish the same tasks with the Azure CLI.

1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Connect with Azure Data Studio
Once your database is deployed, there are many ways that you can connect and interact with it: sqlcmd, Azure Data Studio, SSMS, the query editor in the portal, etc. Here, you'll learn how to connect to the database using Azure Data Studio.

1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Set up the database
Once you're connected to any database, you usually need to deploy the database schema and tailor the database to meet your scenario's requirements. Using a series of T-SQL scripts in Azure Data Studio, you'll configure the database to support your application.

1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "Check your work"
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
