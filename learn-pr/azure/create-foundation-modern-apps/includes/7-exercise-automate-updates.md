<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
GitHub Actions is a way to automate CI/CD for many different services, including Azure SQL Database.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Recall in the bus catching scenario you have build the foundation with your database. In the case you want to update the database or deploy the same configurations automatically ti a new database, you can leverage GitHub Actions.

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
In order to automate updates, you'll need to configure GitHub secrets and a yaml file. Once those are set up, new commits that are pushed trigger workflows that will in turn update your Azure SQL Database or other services.

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
## Configure GitHub secrets

GitHub secrets introduce a way to securely store secrets, keys, and other sensitive information in GitHub. In this section, you'll create a new GitHub secret which includes your Azure SQL Database connection string.

1. In a text file, notepad, or on paper, determine the connection string for your Azure SQL Database. It will be something like `Server=<server-name>.database.windows.net,1433;Initial Catalog=bus-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. Navigate to your repository for this module on GitHub (make sure you are signed in). It will be something like `https://github.com/<your-git-username>/serverless-full-stack-apps-azure-sql`.

1. Select **Settings** for the repository.

1. Select **Secrets** > **New repository secret** and enter the following:
    1. *Name*: **AZURE_SQL_CONNECTION_STRING**
    1. *Value*: **Connection string from prior step**

## Configure yaml file

There are several template yaml files available in the code repository. For this module, you will only use the workflow file for Azure SQL Database. In future modules of this learning path, you will learn how to automate deployment for multiple other services.

1. In Visual Studio Code, select **Explorer** icon on the left-hand taskbar to view the repository files. If you do not see them, select **File** > **Open folder** and navigate to the location where you cloned the repository.

1. Under the folder `.github\workflows`, rename **`azuresqldatabase.yml.template`** to **`azuresqldatabase.yml`**.

1. Review the template and seek to understand what the workflow will do.

## Push commits and monitor results

Now that your GitHub secret and workflow file are configured, you are ready to push your commits and observe the workflow.

1. Select the **Source Control** icon on the left-hand taskbar.

1. In the *Message* box, enter "Enable database yaml" or some other message.

1. Select the **checkmark**.

1. Select the **...** > **Push**.

> [!IMPORTANT]
> If you are prompted to log in, you must use your GitHub username and obtain a personal access token to supply **instead of your GitHub password**. You can do this by going to https://github.com/settings/tokens/new. Add a note `VSCode`, check all the boxes, and select **Generate token**. Copy the token text and store in a secure location. Back in Visual Studio Code, use the token as your password/token to log in to GitHub.

1. Navigate to your GitHub repository for this module and select **Actions**.

1. Observe the contents of the workflow that is running (or has completed). Notice how the Azure SQL Action leverages the dacpac file in your repository to deploy the final state of the database to your Azure SQL Database.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->