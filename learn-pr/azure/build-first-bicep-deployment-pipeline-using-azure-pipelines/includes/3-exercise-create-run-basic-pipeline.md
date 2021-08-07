You want to automate deployment for your toy company's website. As a first step, you need to create a basic pipeline in Azure DevOps.

In this exercise, you'll:

> [!div class="checklist"]
> * Create an Azure DevOps organization and project.
> * Create a basic pipeline.
> * Execute your basic pipeline.

## Create a project in Azure DevOps

1. In a browser, go to [dev.azure.com](https://dev.azure.com?azure-portal=true). Sign in or create a new account.

1. If you're creating a new account, follow the prompts to create an Azure DevOps organization. Azure DevOps then prompts you to create a new project. Continue to the next step to configure the project.

   If you signed in to an existing Azure DevOps organization, select the **New project** button to create a new project.

   :::image type="content" source="../../includes/media/azure-devops-create-project.png" alt-text="Screenshot of the Azure DevOps interface showing the button to create a new project." border="true":::

1. Enter the details of your new project:

   * **Project name**: Use a meaningful but short name. For this module, enter **toy-website**.
   * **Visibility**: You can use Azure DevOps to create public and private repositories. You choose to create a private repository because your toy company website files should be accessed only by people inside your organization. You can grant access to others later.

   When you're finished, your project configuration should look like this example:

   :::image type="content" source="../../includes/media/azure-devops-new-project-details.png" alt-text="Screenshot of the Azure DevOps interface showing the configuration for the project to create." border="true":::

1. Select **Create project**.

1. On the project page, in the menu, select **Repos**.

   :::image type="content" source="../../includes/media/azure-devops-repos-menu.png" alt-text="Screenshot of the Azure DevOps interface that shows the menu, with the Repos item highlighted." border="true":::

## Generate a Git password

When you work with Azure Repos in Visual Studio Code on macOS, you must use a special password that's different from the password you use to sign in.

> [!NOTE]
> If you're using Windows, skip to the next section, *Clone the repository*.

1. Select the **Generate Git credentials** button.

   Azure Repos creates a random password for you to use.

1. Make a note of the **Password**. You'll use it in the next section.

## Clone the repository

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

   :::image type="content" source="../media/3-clone-visual-studio-code.png" alt-text="Screenshot of the Azure DevOps interface that shows the repository settings, with the Clone in VS Code button highlighted." border="true":::

1. Create a folder to use for the repository, and then select **Select Repository Location**.

1. This is the first time you've used this repository, so you're prompted to sign in.

   If you're using Windows, enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

   If you're using macOS, paste the password that you generated earlier in this exercise.

1. Visual Studio Code prompts you to open the repository location. Select **Open**.

   :::image type="content" source="../media/3-open-cloned-repo.png" alt-text="Screenshot of the Visual Studio Code interface with a prompt to open the cloned repository, and the Open button highlighted." border="true":::

## Install the Azure Pipelines Visual Studio Code extension

Microsoft publishes an Azure Pipelines extension for Visual Studio Code. The extension helps you write pipeline YAML files. It's a good idea to install this extension, so your YAML files are validated as you work.

1. In Visual Studio Code, open **Extensions** by selecting **View** > **Extensions**.

1. In **Search**, enter **Azure Pipelines**, and then find the Azure Pipelines extension published by Microsoft. Select the **Install** button.

   :::image type="content" source="../media/3-visual-studio-code-extension.png" alt-text="Screenshot of the Visual Studio Code Extensions, with the search field displaying 'Azure Pipelines', and the Install button for the Microsoft Azure Pipelines extension highlighted." border="true":::

## Create a YAML pipeline definition

Now that you have your organization, project and repository created, you're ready to create a basic pipeline definition.

1. Open **Explorer** in Visual Studio Code.

1. Add a new folder at the root of your current folder structure, and name it *deploy*.

1. In the *deploy* folder, create a new file named *azure-pipelines.yml*.

   :::image type="content" source="../media/3-visual-studio-code-pipeline-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the deploy folder and the azure-pipelines.yml file shown." border="true":::

1. Copy the following pipeline definition into the file: 

   :::code language="yaml" source="code/3-pipeline.yml" :::

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Commit and push the file to your Git repository by using the following commands:

   ```bash
   git add deploy/azure-pipelines.yml
   git commit -m "Add initial pipeline definition"
   git push
   ```

## Configure the pipeline in Azure Pipelines

You have created a pipeline definition. Here, you register the pipeline with Azure Pipelines.

1. In your browser, select **Pipelines**, then select **Create Pipeline**.

   :::image type="content" source="../media/3-create-pipeline.png" alt-text="Screenshot of the Azure DevOps interface showing the Pipelines page, and the Create Pipeline button highlighted." border="true":::

1. Select **Azure Repos Git**.

   :::image type="content" source="../media/3-create-pipeline-repo-type.png" alt-text="Screenshot of the Azure DevOps interface showing the Create Pipeline flow's Connect step, with the Azure Repos Git option selected." border="true":::

1. Select the **toy-website** repository.

   :::image type="content" source="../media/3-create-pipeline-repo.png" alt-text="Screenshot of the Azure DevOps interface showing the Create Pipeline flow's Select step, with the toy-website repository selected." border="true":::

1. Select **Existing Azure Pipelines YAML file**.

   :::image type="content" source="../media/3-create-pipeline-configure.png" alt-text="Screenshot of the Azure DevOps interface showing the Create Pipeline flow's Configure step, with the Existing Azure Pipelines YAML File option selected." border="true":::

1. In the **Path** field, select */deploy/azure-pipelines.yml*. Then select **Continue**.

   :::image type="content" source="../media/3-create-pipeline-yaml-file.png" alt-text="Screenshot of the Azure DevOps interface 'Select an existing YAML file' page, the Path set to the pipeline file and Continue button highlighted." border="true":::

   Your YAML pipeline definition is shown.

   > [!TIP]
   > The Azure Pipelines web interface provides an editor for managing your pipeline definition. In this module, we work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works, too.

1. Select **Run**.

   :::image type="content" source="../media/3-create-pipeline-run.png" alt-text="Screenshot of the Azure DevOps interface showing the Create Pipeline flow's Review step, with the Run button highlighted." border="true":::

   Azure Pipelines creates the pipeline and starts a first run.

## Verify the pipeline run

1. Once the pipeline run starts, a page is displayed with information about this run.

   :::image type="content" source="../media/3-pipeline-run-queued.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the job in the queued state." border="true":::

   Each pipeline run includes an identifier. You can use this when you need to refer to the pipeline run, and to help find a specific pipeline run.

   Notice the job status initially is displayed as **Queued**. It can take some time for your pipeline to start. Your job is added to a queue for an agent, and once an agent is available, Azure Pipelines assigns the agent and starts the job. The job status then becomes **Running**.

   Also, notice the page includes the branch name, and the identifier for the Git commit that the run used. This indicates the version of your repository's content that the pipeline used.

1. Refresh the page until the job status changes to **Success**. Then, select the **Job**.

   :::image type="content" source="../media/3-pipeline-run-success.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the job in the success state and the job name highlighted." border="true":::

1. The job information page is displayed, which shows the log of the steps that the pipeline ran for you. Notice that your **Placeholder step** is included.

   :::image type="content" source="../media/3-pipeline-job-summary.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline job log, with 'Placeholder step' highlighted." border="true":::

   Notice the list includes steps that you didn't specify. These are created automatically by Azure Pipelines. In some organizations, you might also see steps that your organization automatically includes in all of your pipelines.

1. Select the step named **Checkout toy-website@main to s**.

   :::image type="content" source="../media/3-pipeline-job-checkout-log.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline job log, with the 'Checkout' step highlighted." border="true":::

   The logs for each step provide a lot of detail on exactly what happened. This is helpful if you need to diagnose a problem with a pipeline, since you don't have access to the agent that ran your steps.
   
   In this case, the repository's contents was downloaded from Azure Repos to the agent's file system.

1. Select **Placeholder step**.

   :::image type="content" source="../media/3-pipeline-job-placeholder-log.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline job log, with the 'Placeholder step' highlighted." border="true":::

   The logs for this step include the contents of the script as it was specified in your pipeline's YAML file, and the `Hello world!` text that the script emitted.

## Inspect how pipeline execution can be linked back to a commit

It's good to understand how to cross-reference a pipeline run to the commit that it contained. This can help you to diagnose problems and to trace the history of your deployments. Azure DevOps provides several ways to achieve this. Here, you manually inspect the commit history.

1. Navigate back to the Repository overview screen by selecting **Repos**. Then, select **Commits**.

   :::image type="content" source="../media/3-pipeline-commit.png" alt-text="Screenshot of the Azure DevOps interface showing the commit, with the commit identifier and succeeded state highlighted." border="true":::

   Notice that the commit identifier displayed is the same as the commit identifier you noted from your pipeline run. Also, notice that Azure Pipelines displays the status of the pipeline run associated with the commit.

1. Select the commit. The list of changes from the commit are displayed.
