You want to automate deployment of updates to your toy company's website. As a first step, you create a basic workflow in GitHub Actions.

In this exercise, you'll:

> [!div class="checklist"]
> * Create a GitHub account and repository.
> * Create a basic workflow.
> * Execute your basic workflow.

## Create a repository in GitHub

1. In a browser, go to [GitHub](https://www.github.com?azure-portal=true). Sign in by using your GitHub account, or create a new account if you don't have one.

1. Select the **+** icon in the upper right of the window, and then select **New repository**.

   :::image type="content" source="../media/3-github-new-repository-menu.png" alt-text="Screenshot of the GitHub interface that shows the menu for creating a new repository." border="true":::

1. Enter the details of your new repository:

   - **Repository name**: Enter a meaningful but short name. For this module, use `toy-website-workflow`.
   - **Description**: Include a description to help others understand what the repository is for.
   - **Private**: You can use GitHub to create public and private repositories. Create a private repository, because only people inside your organization should access your toy website's files. You can grant access to others later.
   - Leave the repository initialization checkboxes cleared.

   After you're done, your repository configuration should look like the following screenshot:

   :::image type="content" source="../media/3-github-new-project-details.png" alt-text="Screenshot of the GitHub interface showing the configuration for the repository to create." border="true":::

1. Select **Create repository**.

## Clone the repository

In Visual Studio Code, clone your repository.

1. On the repository page, select the copy button to copy the URL to your Git repository.

   :::image type="content" source="../media/3-github-repository-new-clipboard.png" alt-text="Screenshot of the GitHub interface showing the new empty repository, with the repository URL copy button highlighted." border="true":::

1. Open Visual Studio Code. 

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Navigate in the terminal to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the _toy-website-workflow_ folder, run the following command:

   ```bash
   cd toy-website-workflow
   ```

1. Type `git clone` and then paste the URL you copied earlier, which looks something like this:

   ```bash
   git clone https://github.com/mygithubuser/toy-website-workflow
   ```

1. This is the first time you've used this repository, so you are prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You may need to sign in to GitHub again. Select **Authorize**.

1. Reopen Visual Studio Code in the repository folder by running the following command:

   ```bash
   code -r toy-website-workflow
   ```

> [!TIP]
> You can also edit your GitHub Actions workflow definitions by using the GitHub web user interface. When you open a workflow definition, GitHub helps you with YAML file syntax and indentation, and provides example code snippets for the actions you might want to use. In this module, you work with the definition file in Visual Studio Code, but you can explore the GitHub editor to see how it works.

## Create a YAML workflow definition

Now that you've created and cloned your repository, you're ready to create a basic workflow definition.

1. In Visual Studio Code, open the Explorer.

1. At the root of your current folder structure, create a new folder named *.github*.
   > [!NOTE]
   > Make sure you include the period at the start of the folder name. This indicates that this is a hidden folder, and GitHub requires the period for GitHub Actions to detect the workflow definition.

1. In the *.github* folder, create another folder named *workflows*.

1. In the *workflows* folder, create a new file named *workflow.yml*.

   :::image type="content" source="../media/3-visual-studio-code-workflow-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the .github/workflows folder and the workflow.yml file shown." border="true":::

1. Copy the following workflow definition into the file: 

   :::code language="yaml" source="code/3-workflow.yml" :::

1. Commit and push the file to your Git repository by using the following commands:

   ```bash
   git add .
   git commit -m "Add initial workflow definition"
   git push
   ```

> [!TIP]
> Visual Studio Code helps you with the indentation for your YAML file. Look out for squiggly lines that indicate syntax errors, or select **View** > **Problems** to view a list of problems in your file.

## Run the workflow

You have created a workflow definition. GitHub Actions automatically detects your workflow file because it's located in the *.github/workflows* directory.

1. In your browser, navigate to your repository. You might need to refresh the page to see your changes.

1. Select the **Actions** tab.

   :::image type="content" source="../media/3-actions-tab.png" alt-text="Screenshot of the GitHub interface showing the repository page, and the Actions tab highlighted." border="true":::

1. Select the **toy-website-deployment** workflow.

   :::image type="content" source="../media/3-workflow-select.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with the toy-website-deployment workflow selected." border="true":::

1. Select the **Run workflow** dropdown and click the **Run workflow** button.

   :::image type="content" source="../media/3-run-workflow.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with the Run workflow dropdown and button selected." border="true":::

1. This will start a new run of your workflow. It might take a few moments, but the page will automatically refresh and show you a queued or running or even already finished workflow run.

   :::image type="content" source="../media/3-workflow-running.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with one workflow running." border="true":::

   Notice the run status initially is displayed as **Queued**. It can take some time for your workflow to start. Your job is added to a queue for a runner, and once a runner is available, GitHub Actions assigns the runner and starts the job. The job status then becomes **Executing**.

   Each workflow run includes an identifier. You can use this when you need to refer to the workflow run, and to help find a specific workflow run.

## Verify the workflow run

1. Once the workflow run starts, select the run to view the run's details. Refresh the page until the job status displays **Success**.

   :::image type="content" source="../media/3-workflow-run-details.png" alt-text="Screenshot of the GitHub interface showing the details of the run, with the status and commit identifier highlighted." border="true":::

   Also, notice the page includes an identifier for the Git commit that the run used. This indicates the version of your repository's content that the workflow used.

1. In the list of jobs, select **say-hello**.

   :::image type="content" source="../media/3-workflow-run-job-list.png" alt-text="Screenshot of the GitHub interface showing the run details menu, with the say-hello job highlighted." border="true":::

1. The job information page is displayed, which shows the log of the steps that the workflow ran for you. Notice that your **Placeholder step** is included.

   :::image type="content" source="../media/3-workflow-job-summary.png" alt-text="Screenshot of the GitHub interface showing the workflow run log, with 'Placeholder step' highlighted." border="true":::

   Notice the list includes steps that you didn't specify. These are created automatically by GitHub Actions. 

1. Select the **Placeholder step** step.

   :::image type="content" source="../media/3-workflow-run-placeholder-log.png" alt-text="Screenshot of the GitHub interface showing the workflow run log, with the placeholder step log shown." border="true":::

   The logs for this step include the contents of the command as it was specified in your workflow's YAML file, and the _Hello world!_ text that the script emitted.

## Link workflow execution to a commit

It's good to understand how to cross-reference a workflow run to the commit the run contained. Linking workflow execution to a commit can help you trace the history of your deployments and diagnose problems.

1. Select **Summary** to return to the run summary.

1. Select the commit identifier. GitHub displays the details of the commit that triggered the workflow run.
