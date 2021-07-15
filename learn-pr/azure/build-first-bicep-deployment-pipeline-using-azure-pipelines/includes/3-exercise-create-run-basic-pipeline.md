You want to start automating the deployment for your toy company's website. As a first step you need to create a basic pipeline in Azure DevOps.

In this exercise, you'll:

> [!div class="checklist"]
> * Create an Azure DevOps organization and project.
> * Create a basic pipeline.
> * Execute your basic pipeline.

## Create a project in Azure DevOps

1. In a browser, navigate to [dev.azure.com](https://dev.azure.com?azure-portal=true). Sign in or create a new account.

1. If you're creating a new account, follow the prompts to create an Azure DevOps organization. Azure DevOps then asks you to create a new project. Continue to the next step.

   If you signed in to an existing Azure DevOps organization, select the **New project** button to create a new project.

   :::image type="content" source="../media/TODO-azure-devops-create-project.png" alt-text="Screenshot of the Azure DevOps interface showing the button to create a new project." border="true":::

1. Enter the details of your new project:

   - **Project name**: Use a meaningful but short name. Here, you use `toy-website`.
   - **Visibility**: You can use Azure DevOps to create public and private repositories. Create a private repository, since your toy website's files should only be accessed by people inside your organization. You can grant access to others later.

   After you're done, your project configuration should look like the following:

   :::image type="content" source="../media/TODO-azure-devops-new-project-details.png" alt-text="Screenshot of the Azure DevOps interface showing the configuration for the project to create." border="true":::

1. Select **Create project**.

## Create a repository in Azure Repos

A pipeline is defined as a YAML file and is stored in your repository. Here, you'll initialize a repository for your Azure DevOps project.

1. On the project page that appears, select the **Repos** menu item.

   :::image type="content" source="../media/TODO-azure-devops-repos-menu.png" alt-text="Screenshot of the Azure DevOps interface showing the menu, with the Repos item highlighted." border="true":::

1. Select the **Initialize** button.

   Azure Repos initializes your repository and adds a _README.md_ into it.

1. Make a note of the repository's URL. You'll use this shortly.

   :::image type="content" source="../media/TODO-azure-devops-repo-details.png" alt-text="Screenshot of the Azure Repos interface showing the repository's details, with the repository's URL highlighted." border="true":::

## Clone the repository

1. Open Visual Studio Code.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Enter the following command to clone the repository to your local computer. Make sure you replace `YOUR_REPOSITORY_URL` with the URL that you saved earlier.

   ```bash
   git clone YOUR_REPOSITORY_URL
   ```

1. Enter the following command to change to the repository folder and reopen Visual Studio Code with the folder loaded:

   ```bash
   cd toy-website
   code --reuse-window .
   ```

   Visual Studio Code reloads. If you're prompted to trust the folder, select **Yes, I trust the authors**.

## Create a YAML pipeline definition

Now that you have your organization, project and repository created, you're ready to create a basic pipeline.

1. Open **Explorer** in Visual Studio Code.

1. Add a new folder at the root of your current folder structure, and name it _deploy_.

1. In the _deploy_ folder, create a new file named _pipeline.yml_.

1. Copy the following into the file: 

   ```yaml
   trigger: none
   
   pool:
     vmImage: ubuntu-latest
   
   jobs:
   - job: 
     steps:
     - script: echo Hello world!
       displayName: 'Placeholder step'
   ```

1. Commit and push the file to your Git repository by using the following commands:

   ```bash
   git add .
   git commit -m "Add initial pipeline definition"
   git push
   ```

<!-- TODO below -->

## Trigger the pipeline

1. In your browser, TODO

1. Select the **Save and run** button. 

<TODO: Insert image>

2. In the pop out window you will see that this file and changes will be saved by a commit to your repository. Select **Save and run**.

<TODO: Insert image>


## Inspect pipeline output

Once you hit Save and run in the previous step, you will see the Pipelines - Run screen: 

1. Take note of the commit ID this pipeline run is based on. 

<TODO: Insert image>

1. Select the **Job**.

<TODO: Insert image>

1. This will show you the different steps that got executed as part of your job. Select the **Checkout** step. You will see that as a first step in your pipeline your source code, which in this case only holds the README.md file and your YAML file, will be downloaded to your agent machine. 

> [!NOTE]
> It sometimes can take a little time for your pipeline to start. This is because Azure Pipelines needs to wait for an agent to become available.

<TODO: Insert image>

1. Select the **Run a one line script** step. This will display the output of this step. 

<TODO: Insert image>

1. Select the **Run a multi-line script** step and inspect the output. 

<TODO: Insert image>


## Inspect how pipeline execution can be linked back to a commit

1. Navigate back to the Repository overview screen by selecting the **Repos** option in the right menu.

<TODO: Insert image>

1. In the Repos overview you will see that your YAML file is part of the repository. It got committed and added when you selected Save and run in one of the previous steps. Select your **YAML** file in the file tree to confirm that it contains your pipeline code. 

<TODO: Insert image>

2. Navigate back to the Pipelines overview screen by selecting the **Pipelines** option in the right menu.

<TODO: Insert image>

1. Select the pipeline your just created.

<TODO: Insert image>

1. Select the **Run pipeline** button. 


<TODO: Insert image>

1. Select the **Run** button.

<TODO: Insert image>

1. In the Pipelines - Run screen that appears, take note of the commit number, this is the same hash as previously. There were no new changes in your repository, so the run is started based on the same version and files. 

<TODO: Insert image>

1. Select the **Commit hash**. This will show you the screen with an overview of the changes that are linked to this run. 

<TODO: Insert image>
