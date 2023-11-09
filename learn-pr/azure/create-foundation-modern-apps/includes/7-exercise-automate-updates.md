GitHub Actions is a way to automate CI/CD pipelines for many different services, including Azure SQL Database.

Recall in the bus-catching scenario, you'll build the foundation of your application with your database. When you want to update the database, or deploy the same configurations automatically to a new database, you can use GitHub Actions.

In order to automate updates, you'll need to configure GitHub secrets and a yaml file. Once those are set up, new commits that are pushed trigger workflows that will in turn update your Azure SQL Database or other services.

## Configure secrets securely with GitHub

GitHub secrets introduce a way to securely store secrets, keys, and other sensitive information in GitHub. In this section, you'll create a new GitHub secret that includes your Azure SQL Database connection string.

1. In a text file, notepad, or on paper, determine the connection string for your Azure SQL Database. It will be something like `Server=<server-name>.database.windows.net,1433;Initial Catalog=bus-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. Navigate to your repository for this module on GitHub (make sure you're signed in). It will be something like `https://github.com/<your-git-username>/serverless-full-stack-apps-azure-sql`.

1. Select **Settings** for the repository.

1. Select **Secrets and variables** > **Actions** > **New repository secret** and enter the following information:
    1. *Name*: **AZURE_SQL_CONNECTION_STRING**
    1. *Secret*: **Connection string from prior step**

1. Select **Add secret**.

## Configure yaml file for GitHub Actions

There are several template yaml files available in the code repository. For this module, you'll only use the workflow file for Azure SQL Database. If you decide to complete future modules of this learning path, you'll learn how to automate deployment for other services.

1. In Visual Studio Code, select the **Explorer** icon on the left-hand taskbar to view the repository files. If you don't see them, select **File** > **Open folder** and navigate to the location where you cloned the repository.

1. Under the folder `.github\workflows`, rename **`azuresqldatabase.yml.template`** to **`azuresqldatabase.yml`**.

1. Review the template and seek to understand what the workflow will do and how it'll update the database.

## Push commits and monitor results using Visual Studio Code and GitHub

Now that your GitHub secret and workflow file are configured, you're ready to push your commits and observe the workflow.

1. Select the **Source Control** icon on the left-hand taskbar.

1. In the *Message* box, enter "Enable database yaml" or some other message.

1. Select the **checkmark**.

1. Select the **...** > **Push**. This pushes your updates to your repository hosted on GitHub, and it kicks off any GitHub Actions.

    > [!IMPORTANT]
    > If you're prompted to log in, you must use your GitHub username and obtain a personal access token to supply **instead of your GitHub password**. You can do this by going to https://github.com/settings/tokens/new. Add a note `VSCode`, check all the boxes, and select **Generate token**. Copy the token text and store in a secure location. Back in Visual Studio Code, use the token as your password/token to log in to GitHub.

1. Navigate to your GitHub repository for this module and select **Actions**.

1. Observe the contents of the workflow that is running (or has completed). Notice how the Azure SQL Action uses the `.dacpac` file in your repository to deploy the final state of the database to your Azure SQL Database.
