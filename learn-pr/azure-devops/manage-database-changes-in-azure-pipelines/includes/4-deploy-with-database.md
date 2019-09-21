NOTES:

- create the database
- get connection string
- create app services
- use application settings in App Service to hide connection string
-  In the pipeline:
    - build database project
    - build the application
    - deploy the application

- Make a schema change to a table and the app
    - Run pipeline to see the approval from the DBA
    - 
    - The team has a plan and is ready to begin implementing their release management workflow. You have an Azure DevOps project set up and Azure App Service instances that are ready to receive build artifacts.

------------------

At this point, the team's pipeline has four stages. The first stage produces the build artifact and the second stage deploys the _Space Game_ web application to App Service in the _dev_ environment, ..... Here, you follow along with Andy and Tim as they modify the pipeline to ....

## Fetch the branch from GitHub

Here, you fetch the `database` branch from GitHub and checkout, or switch to, that branch.

This branch serves as your _release_ branch. It contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `database` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream database
    git checkout database
    ```

    The format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. As an optional step, open *azure-pipelines.yml* from Visual Studio Code and familiarize yourself with the initial configuration.

    The configuration resembles the basic one you created in the [Create a release management workflow with Azure Pipelines](/learn/modules/create-a-release-management-workflow?azure-portal=true) module. It builds only the application's Release configuration and deploys the build to _dev_, _test_, and _staging_ environments. For learning purposes, this configuration does not run the quality or security checks that you set up in previous modules.

## Create the database

Here you use [Azure portal](https://portal.azure.com?azure-portal=true) to create the database. In later learning paths you will create your infrastructure using the pipeline.

1. Navigate to your [Azure portal](https://portal.azure.com?azure-portal=true) and create a new resource group for the resources you will create in this and the next exercise.
    1. 

## Create the App Services

1.

## Add the database stage to the pipeline

