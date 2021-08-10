You want to automate deployment of updates to your toy company's website. As a first step, you create a basic pipeline in Azure DevOps.

In this exercise, you'll:

> [!div class="checklist"]
> * Create an Azure DevOps organization and project.
> * Create a basic pipeline.
> * Execute your basic pipeline.

## Create a project in Azure DevOps

1. In a browser, go to [dev.azure.com](https://dev.azure.com?azure-portal=true). Sign in or create a new account.

1. If you created a new account, follow the prompts to create an Azure DevOps organization. Azure DevOps then prompts you to create a new project. Continue to the next step to set up the project.

    If you signed in to an existing Azure DevOps organization, select **New project** to create a new project.

    :::image type="content" source="../../includes/media/azure-devops-create-project.png" alt-text="Screenshot of Azure DevOps that shows the button to create a new project.":::

1. Enter the details of your new project:

    * **Project name**: Use a meaningful but short name. For this exercise, enter **toy-website**.
    * **Visibility**: You can use Azure DevOps to create public and private repositories. You create a private repository because your toy company website files should be accessed only by people inside your organization. You can grant access to other users later.

    When you're finished, your project configuration should look like this example:

    :::image type="content" source="../../includes/media/azure-devops-new-project-details.png" alt-text="Screenshot of Azure DevOps that shows the configuration for the project to create.":::

1. Select **Create project**.

1. On the project page, in the left menu, select **Repos**.

    :::image type="content" source="../../includes/media/azure-devops-repos-menu.png" alt-text="Screenshot of Azure DevOps that shows the menu, with the Repos menu item highlighted.":::

## Generate a Git password (macOS)

When you work with Azure Repos in Visual Studio Code on macOS, you use a special password that's different from the password you use to sign in.

> [!NOTE]
> If you're using Windows, skip to the next section, *Clone the repository*.

1. On a computer running macOS, in Azure DevOps, select **Generate Git credentials**.

    Azure Repos creates a random password for you to use.

1. Copy the **Password** value somewhere safe. You'll use the password in the next section.

## Clone the repository

In Visual Studio Code, clone your repository.

1. In **Clone to your computer**, select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/3-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the Clone in VS Code button highlighted.":::

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

    If you're using Windows, enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

    If you're using macOS, paste the password that you generated earlier in this exercise.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

    :::image type="content" source="../media/3-open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

## Install the Azure Pipelines extension

Microsoft publishes an Azure Pipelines extension for Visual Studio Code. The extension can help you write pipeline YAML files. It's a good idea to install this extension, so your YAML files are validated as you work.

1. In Visual Studio Code, select **View** > **Extensions**.

1. In **Search**, enter **Azure Pipelines**, and then find the Azure Pipelines extension published by Microsoft. Select **Install**.

    :::image type="content" source="../media/3-visual-studio-code-extension.png" alt-text="Screenshot of the Visual Studio Code Extensions, with the search field displaying 'Azure Pipelines' and the Install button for the Microsoft Azure Pipelines extension highlighted.":::

## Create a YAML pipeline definition

Now that you've created your organization, project, and repository, you're ready to create a basic pipeline definition.

1. In Visual Studio Code, open the Explorer.

1. At the root of your current folder structure, create a new folder named *deploy*.

1. In the *deploy* folder, create a new file named *azure-pipelines.yml*.

    :::image type="content" source="../media/3-visual-studio-code-pipeline-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the deploy folder and the azure-pipelines dot Y M L file shown.":::

1. Copy the following pipeline definition into the file:

    :::code language="yaml" source="code/3-pipeline.yml":::

1. To open the Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. To commit and push the *azure-pipelines.yml* file to your Git repository, run this code:

    ```bash
    git add deploy/azure-pipelines.yml
    git commit -m "Add initial pipeline definition"
    git push
    ```

## Set up the pipeline in Azure Pipelines

You've created a pipeline definition. Next, register the pipeline with Azure Pipelines.

1. In Azure DevOps in your browser, select **Pipelines** > **Create Pipeline**.

    :::image type="content" source="../media/3-create-pipeline.png" alt-text="Screenshot of Azure DevOps that shows the Pipelines page and the Create Pipeline button highlighted.":::

1. Select **Azure Repos Git**.

    :::image type="content" source="../media/3-create-pipeline-repo-type.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Connect step, with the Azure Repos Git option selected.":::

1. Select **toy-website**.

    :::image type="content" source="../media/3-create-pipeline-repo.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Select step, with the toy-website repository selected.":::

1. Select **Existing Azure Pipelines YAML file**.

    :::image type="content" source="../media/3-create-pipeline-configure.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Configure step, with the Existing Azure Pipelines YAML File option selected.":::

1. In **Path**, select */deploy/azure-pipelines.yml*. Then, select **Continue**.

    :::image type="content" source="../media/3-create-pipeline-yaml-file.png" alt-text="Screenshot of the Azure DevOps 'Select an existing YAML file' pane, with Path set to the pipeline file and the Continue button highlighted.":::

    Your YAML pipeline definition is shown.

    > [!TIP]
    > The Azure Pipelines web interface provides an editor that you can use to manage your pipeline definition. In this module, you work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works.

1. Select **Run**.

    :::image type="content" source="../media/3-create-pipeline-run.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Review step, with the Run button highlighted.":::

    Azure Pipelines creates the pipeline and starts a first run.

## Verify the pipeline run

1. When the pipeline run starts, a page displays information about the run.

    :::image type="content" source="../media/3-pipeline-run-queued.png" alt-text="Screenshot of Azure DevOps that shows the pipeline, with the job in the queued state.":::

    Each pipeline run includes an identifier. You can use this identifier to help you find a specific pipeline run.

    The job status initially is displayed as **Queued**. Your pipeline might not start immediately. Your job is added to a queue for an agent. When an agent is available, Azure Pipelines assigns the agent and starts the job. The job status then becomes **Running**.

    The page includes the branch name and the identifier for the Git commit the run used. This information indicates the version of your repository's content the pipeline used.

1. Refresh the page until the job status changes to **Success**. Then, under **Jobs**, select **Job**.

    :::image type="content" source="../media/3-pipeline-run-success.png" alt-text="Screenshot of Azure DevOps that shows the pipeline, with the job with a Success status and the job name highlighted.":::

1. The job information page shows the log of the steps that the pipeline ran. Your **Placeholder step** is included.

    :::image type="content" source="../media/3-pipeline-job-summary.png" alt-text="Screenshot of Azure DevOps that shows the pipeline job log, with the 'Placeholder step' step highlighted.":::

    The list of steps inside the job includes steps that you didn't create. These steps are created automatically by Azure Pipelines. In some organizations, you might also see steps that your organization automatically includes in all its pipelines.

1. Select the step named **Checkout toy-website@main to s**.

    :::image type="content" source="../media/3-pipeline-job-checkout-log.png" alt-text="Screenshot of Azure DevOps that shows the pipeline job log, with the 'Checkout' step highlighted.":::

    The logs for each step provide details about exactly what happened during the pipeline run. The information is helpful if you need to diagnose a problem with a pipeline. You don't have direct access to the agent that ran your steps.

    In this case, the repository's contents were downloaded from Azure Repos to the agent's file system.

1. Select **Placeholder step**.

   :::image type="content" source="../media/3-pipeline-job-placeholder-log.png" alt-text="Screenshot of Azure DevOps that shows the pipeline job log, with the 'Placeholder step' step highlighted and details shown.":::

   The logs for this step include the contents of the script as you created it in your pipeline's YAML file and the `Hello world!` text that the script emitted.

## Link pipeline execution to a commit

It's good to understand how to cross-reference a pipeline run to the commit the run contained. Linking pipeline execution to a commit can help you trace the history of your deployments and diagnose problems. Azure DevOps provides several ways to link a pipeline run to a commit. In the option described here, you manually inspect the commit history.

1. To return to the repository overview, select **Repos** > **Commits**.

   :::image type="content" source="../media/3-pipeline-commit.png" alt-text="Screenshot of Azure DevOps that shows the commit, with the commit identifier and succeeded state highlighted.":::

    The commit identifier is the same as the commit identifier you noted from your pipeline run. Also, Azure Pipelines displays the status of the pipeline run that's associated with the commit.

1. Select the commit. The list of changes from the commit is shown.
