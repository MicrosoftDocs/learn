You want to start automating the deployment for your toy company's website. As a first step you need to create a basic pipeline in Azure DevOps.

In this exercise, you'll:

> [!div class="checklist"]
> * Create an Azure DevOps organization and project.
> * Create a basic pipeline.
> * Execute your basic pipeline.

## Create a project in Azure DevOps

[!include[Bootstrapping instructions for new toy website Azure DevOps organization and project](../../includes/azure-template-devops-exercise-azdo-org-project.md)]

## Clone the repository

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

1. Create a folder to use for the repository and select **Select Repository Location**.

1. Visual Studio Code prompts you to open the repository location. Select **Open**.

## Create a YAML pipeline definition

Now that you have your organization, project and repository created, you're ready to create a basic pipeline definition.

1. Open **Explorer** in Visual Studio Code.

1. Add a new folder at the root of your current folder structure, and name it _deploy_.

1. In the _deploy_ folder, create a new file named _azure-pipelines.yml_.

1. Copy the following into the file: 

   :::code language="yaml" source="code/3-pipeline.yaml" :::

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

1. Select **Azure Repos Git**.

1. Select the **toy-website** repository.

1. Select **Existing Azure Pipelines YAML file**.

1. In the **Path** field, select _/deploy/azure-pipelines.yml_. Then select **Continue**.

   Your YAML pipeline definition is shown.

   > [!NOTE]
   > The Azure Pipelines web interface provides an editor for managing your pipeline definition. In this module, we work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works, too.

1. Select **Run**.

   Azure Pipelines creates a pipeline.

   > [!NOTE]
   > It can take some time for your pipeline to start. This is because Azure Pipelines needs to wait for an agent to become available.

## Verify the pipeline execution

After the pipeline has run, a page is displayed with information about this execution.

1. Notice the page includes the identifier for the Git commit that the run used. This indicates the version of your repository's content that the pipeline used.

1. Select the **Job**.

   The job information page is displayed, which shows the log of the steps that the pipeline ran for you. Notice that your **Placeholder step** is included.

   Notice the list includes steps that you didn't specify. These are created automatically by Azure Pipelines.

1. Select the **Checkout toy-website@main to s** step.

   The logs for the step provide a lot of detail on exactly what happened. In this case, the repository's contents was downloaded to the agent.

1. Select the **Placeholder step** step.

   The logs for this step show the _Hello world!_ text that our pipeline YAML file specified.

## Inspect how pipeline execution can be linked back to a commit

1. Navigate back to the Repository overview screen by selecting **Repos**. Then, select **Commits**.

   Notice that the commit identifier displayed is the same as the commit identifier you noted from your pipeline run.

1. Select the commit. The list of changes from the commit are displayed.
