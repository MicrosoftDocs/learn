[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

You want to automate deployment of updates to your toy company's website. As a first step, you create a basic pipeline in Azure DevOps.

In this exercise, you'll:

> [!div class="checklist"]
>
> - Create an Azure DevOps organization and project.
> - Create a basic pipeline.
> - Execute your basic pipeline.

## Create a project in Azure DevOps

1. In a browser, go to [dev.azure.com](https://dev.azure.com). Sign in or create a new account.

1. If you created a new account, follow the prompts to create an Azure DevOps organization. Azure DevOps then prompts you to create a new project. Continue to the next step to set up the project.

    If you signed in to an existing Azure DevOps organization, select **New project** to create a new project.

    :::image type="content" source="../../includes/media/azure-devops-create-project.png" alt-text="Screenshot of Azure DevOps with new project button highlighted.":::

1. In the **Create a project to get started** pane, enter the following details for your new project:

    - **Project name**: Use a meaningful but short name. For this exercise, enter _toy-website_.
    - **Description**: Enter a description of the project's purpose. For this exercise, enter _Toy company website.
    - **Visibility**: You can use Azure DevOps to create public and private repositories. In this case, the repository should be private because your company website files should be accessed only by people within your organization. You can grant access to other users later.

    Your project configuration should look like this example:

    :::image type="content" source="../../includes/media/azure-devops-new-project-details.png" alt-text="Screenshot of Azure DevOps Create a project to get started pane that shows project name and visibility options highlighted.":::

1. Select **Create**.

## Clone the repository

1. In the Welcome pane, or on the resource menu, select **Repos**.

    :::image type="content" source="../../includes/media/azure-devops-repos-menu.png" alt-text="Screenshot of Welcome pane that shows the Repos icons highlighted on pane and in resource menu.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials** and copy the username and password displayed to somewhere safe.

1. In the **Clone to your computer** section, select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/3-clone-visual-studio-code.png" alt-text="Screenshot showing repository settings with the Clone in VS Code button highlighted.":::

1. If a dialog box appears, prompting you to allow an extension to open the repository URI, select **Open**.

1. Create a folder on your local device to use for this repository, and then select **Select as Repository Location**.

1. If you're using this repository for the first time, you're prompted to sign in.

    For Windows, enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

    For macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

    :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code dialog box to open the cloned repository, with the Open button highlighted.":::

## Install the Azure Pipelines extension

Microsoft publishes an Azure Pipelines extension for Visual Studio Code. The extension can help you write pipeline YAML files. It's a good idea to install this extension, so your YAML files are validated as you work.

1. In Visual Studio Code, select **View** > **Extensions** (shortcut is <kbd>Ctrl+Shift+x</kbd>).

1. In the **Search** box, enter **Azure Pipelines**, and then select the Azure Pipelines extension published by Microsoft. Select **Install**.

    :::image type="content" source="../media/3-visual-studio-code-extension.png" alt-text="Screenshot of Visual Studio Code Extensions menu with 'Azure Pipelines' extension by Microsoft and the Install button highlighted.":::

## Create a YAML pipeline definition

Now that you've created your organization, project, and repository, you're ready to create a basic pipeline definition.

1. In Visual Studio Code, open the Explorer.

1. In **Explorer**, hover over your **TOY-WEBSITE** project folder, and select **New Folder**. Name that folder _deploy_.

1. Select the _deploy_ folder, and in the **TOY-WEBSITE** project select **New File** icon. Name that file _azure-pipelines.yml_.

    :::image type="content" source="../media/3-visual-studio-code-pipeline-file.png" alt-text="Screenshot of Visual Studio Code Explorer showing the deploy folder and the azure-pipelines dot Y M L file that was just created.":::

1. The YML file is open in the main panel. Paste the following pipeline definition code into the file:

    :::code language="yaml" source="code/3-pipeline.yml":::

1. Save your changes to the file.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**.

   A terminal window opens, usually in the lower half of your screen.

1. To commit and push the _azure-pipelines.yml_ file to your Git repository, paste this code in the terminal panel, and then press <kbd>Enter</kbd>.

    ```bash
    git add deploy/azure-pipelines.yml
    git commit -m "Add initial pipeline definition"
    git push
    ```

## Set up the pipeline in Azure Pipelines

You've created a pipeline definition. Next, register the pipeline with Azure Pipelines.

1. In the resource menu of your Azure DevOps session, select **Pipelines**, and in the **Create your first Pipeline** pane, select **Create Pipeline**.

    :::image type="content" source="../media/3-create-pipeline.png" alt-text="Screenshot of create your first pipeline pane with Pipelines highlighted in resource menu Create Pipeline button highlighted.":::

1. On the **Connect** tab's **Where is your code?** pane, select **Azure Repos Git**.

    :::image type="content" source="../media/3-create-pipeline-repo-type.png" alt-text="Screenshot of Where is your code pane with Azure Repos Git option selected.":::

1. On the **Select** tab's **Select a repository** pane, select **toy-website**.

    :::image type="content" source="../media/3-create-pipeline-repo.png" alt-text="Screenshot that shows Configure your pipeline tab with the toy-website repository selected.":::

1. On the **Configure** tab's **Configure your pipeline** pane, select **Existing Azure Pipelines YAML file**.

    :::image type="content" source="../media/3-create-pipeline-configure.png" alt-text="Screenshot that shows Existing Azure Pipelines YAML File option highlighted.":::

1. On the **Select an existing YAML file** pane's **Path** dropdown, select _/deploy/azure-pipelines.yml_, and then select **Continue**.

    :::image type="content" source="../media/3-create-pipeline-yaml-file.png" alt-text="Screenshot of the Azure DevOps 'Select an existing YAML file' pane, with Path set to the pipeline file and the Continue button highlighted.":::

    The Review tab's **Review your Pipeline YAML** pane shows your YAML pipeline definition as a new pipeline.

    > [!TIP]
    > The Azure Pipelines web interface provides an editor that you can use to manage your pipeline definition. In this module, you work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works.

1. Select **Run**.

    :::image type="content" source="../media/3-create-pipeline-run.png" alt-text="Screenshot that shows the Create Pipeline flow's Review step, with the Run button highlighted.":::

    Azure Pipelines creates the pipeline and starts a first run.

## Verify the pipeline run

> [!IMPORTANT]
> If this is your first time using pipelines in this Azure DevOps organization, you might see an error saying:
>
> > _No hosted parallelism has been purchased or granted._
>
> In order to protect against misuse, Azure DevOps requires that new organizations be approved before they can use Microsoft-hosted pipeline agents without a charge.
>
> [To request that your Azure DevOps organization be granted access to free pipeline agents, complete this form.](https://aka.ms/azpipelines-parallelism-request)

1. When the pipeline run starts, a page displays information about the run.

    :::image type="content" source="../media/3-pipeline-run-queued.png" alt-text="Screenshot that shows the pipeline, with the job in the queued state.":::

    Each pipeline run includes an identifier. You can use this identifier to help you find a specific pipeline run.

    The job status initially is displayed as **Queued**. Your pipeline might not start immediately. Your job is added to a queue for an agent. When an agent is available, Azure Pipelines assigns the agent and starts the job. The job status then becomes **Running**.

    The page includes the branch name and the identifier for the Git commit the run used. This information indicates the version of your repository's content the pipeline used.

1. Refresh the page until the job status changes to **Success**. Then, under **Jobs**, select **Job**.

    :::image type="content" source="../media/3-pipeline-run-success.png" alt-text="Screenshot that shows the pipeline, with the job with a Success status and the job name highlighted.":::

1. The job information page shows the log of the steps that the pipeline ran. Your **Placeholder step** is listed in the steps in the left menu.

    :::image type="content" source="../media/3-pipeline-job-summary.png" alt-text="Screenshot that shows the pipeline job log, with the 'Placeholder step' highlighted.":::

    The list of steps in the job includes steps that you didn't create. These steps are created automatically by Azure Pipelines. In some organizations, you might also see steps that your organization automatically includes in all its pipelines. You can select any step to view the log file of that step.

1. Select the **Checkout toy-website@main to s**.

    :::image type="content" source="../media/3-pipeline-job-checkout-log.png" alt-text="Screenshot that shows the pipeline job log, with the 'Checkout' step highlighted.":::

    The log for each step provides details about exactly what happened during the pipeline run. Log information is helpful if you need to diagnose a problem with a pipeline. You don't have direct access to the agent that ran your steps.

    In this case, the repository's contents were downloaded from Azure Repos to the agent's file system.

1. Select **Placeholder step**.

   :::image type="content" source="../media/3-pipeline-job-placeholder-log.png" alt-text="Screenshot that shows the pipeline job log, with the 'Placeholder step' step highlighted and details shown.":::

   The log for this step includes the contents of the script as you created it in your pipeline's YAML file and the `Hello world!` text output from running the script.

## Link pipeline execution to a commit

It's good to understand how to cross-reference a pipeline run to the commit that the run contained. Linking a pipeline run to a commit can help you trace the history of your deployment and diagnose problems. Azure DevOps provides several ways to link a pipeline run to a commit. In this procedure, you manually inspect the commit history.

1. To return to the repository overview, in the DevOps resource menu, select **Repos** > **Commits**.

   :::image type="content" source="../media/3-pipeline-commit.png" alt-text="Screenshot that shows the commits pane, with the commit identifier and succeeded state highlighted.":::

    The commit identifier is the same as the commit identifier you noted from your pipeline run. Also, Azure Pipelines displays the status of the pipeline run that's associated with the commit.

1. Select the commit. The list of files that were changed and the changes from the commit is shown highlighted in green, indicated all the text is new.
