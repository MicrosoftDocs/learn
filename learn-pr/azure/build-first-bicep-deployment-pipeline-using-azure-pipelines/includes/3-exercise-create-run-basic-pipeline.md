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

1. On the project page that appears, select the **Repos** menu item.

   :::image type="content" source="../media/TODO-azure-devops-repos-menu.png" alt-text="Screenshot of the Azure DevOps interface showing the menu, with the Repos item highlighted." border="true":::

1. Make a note of the repository's URL. You'll use this shortly.

   :::image type="content" source="../media/TODO-azure-devops-repo-details.png" alt-text="Screenshot of the Azure Repos interface showing the repository's details, with the repository's URL highlighted." border="true":::

## Clone the repository

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

   TODO screenshot

1. Create a folder to use for the repository and select **Select Repository Location**.

1. Visual Studio Code prompts you to open the repository location. Select **Open**.

## Create a YAML pipeline definition

Now that you have your organization, project and repository created, you're ready to create a basic pipeline definition.

1. Open **Explorer** in Visual Studio Code.

1. Add a new folder at the root of your current folder structure, and name it _deploy_.

1. In the _deploy_ folder, create a new file named _azure-pipelines.yml_.

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

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Commit and push the file to your Git repository by using the following commands:

   ```bash
   git add .
   git commit -m "Add initial pipeline definition"
   git push
   ```

## Configure the pipeline in Azure Pipelines

You have created a pipeline definition. Here, you register the pipeline with Azure Pipelines.

1. In your browser, select **Pipelines**, then select **Create Pipeline**.

   TODO ss

1. Select **Azure Repos Git**.

   TODO ss

1. Select the **toy-website** repository.

   TODO ss

1. Select **Existing Azure Pipelines YAML file**.

   TODO ss

1. In the **Path** field, select _/deploy/azure-pipelines.yml_. Then select **Continue**.

   TODO ss

   Your YAML pipeline definition is shown.

   > [!NOTE]
   > The Azure Pipelines web interface provides an editor for managing your pipeline definition. In this module, we work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works, too.

1. Select **Run**.

   TODO ss

   Azure Pipelines creates a pipeline.

   > [!NOTE]
   > It can take some time for your pipeline to start. This is because Azure Pipelines needs to wait for an agent to become available.

## Verify the pipeline execution

After the pipeline has run, a page is displayed with information about this execution.

1. Notice the page includes the identifier for the Git commit that the run used. This indicates the version of your repository's content that the pipeline used.

   TODO ss

1. Select the **Job**.

   TODO ss

   The job information page is displayed, which shows the log of the steps that the pipeline ran for you. Notice that your **Placeholder step** is included.

   Notice the list includes steps that you didn't specify. These are created automatically by Azure Pipelines.

1. Select the **Checkout toy-website@main to s** step.

   TODO ss

   The logs for the step provide a lot of detail on exactly what happened. In this case, the repository's contents was downloaded to the agent.

1. Select the **Placeholder step** step.

   TODO ss

   The logs for this step show the _Hello world!_ text that our pipeline YAML file specified.

## Inspect how pipeline execution can be linked back to a commit

1. Navigate back to the Repository overview screen by selecting **Repos**. Then, select **Commits**.

   TODO ss

   Notice that the commit identifier displayed is the same as the commit identifier you noted from your pipeline run.

1. Select the commit. The list of changes from the commit are displayed.
