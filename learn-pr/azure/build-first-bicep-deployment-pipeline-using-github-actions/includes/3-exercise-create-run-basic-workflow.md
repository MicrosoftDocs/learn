You want to start automating the deployment for your toy company's website. As a first step you need to create a basic workflow in GitHub Actions.

In this exercise, you'll:

> [!div class="checklist"]
> * Create a GitHub account and project.
> * Create a basic GitHub Actions workflow.
> * Execute your basic workflow.

## Create an account on GitHub

In case you don't have a GitHub account yet, follow these steps. In case you already have a GitHub account, you can go straight to the next topic of creating a project. (Note to John: instructions taken directly from [here](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account))

1. In a browser, navigate to [GitHub's pricing page](https://github.com/pricing).

1. Read the information about the different products and subscriptions that GitHub offers, then click the upgrade button under the subscription you'd like to choose.

1. Follow the prompts to create your personal account or organization.

## Create a project on GitHub

1. Navigate to your GitHub account. This is typically github.com/<account_name>

1. Select the **Repositories** tab.

:::image type="content" source="../../includes/media/github-repositories.png" alt-text="Screenshot of the GitHub interface showing the repositories tab." border="true":::

1. Select the **New** button.

:::image type="content" source="../../includes/media/github-repository-new.png" alt-text="Screenshot of the GitHub interface showing the new repository button." border="true":::


1. Enter the details of your new repository:

   - **Repository name**: Use a meaningful but short name. Here, you use `toy-website`.
   - **Visibility**: You can use GitHub to create public and private repositories. Create a private repository, since your toy website's files should only be accessed by people you give access. You can grant access to others later.

   After you're done, your project configuration should look like the following:

   :::image type="content" source="../../includes/media/github-new-project-details.png" alt-text="Screenshot of the GitHub interface showing the configuration for the repository to create." border="true":::

1. Select **Create repository**.


## Generate a Git password

When you work with GitHub from Visual Studio Code or on the command line, you need to use a special password that's different from the password you use to sign in.

> [!NOTE]
> In the below walkthrough we will make use of a Personal Access Token (PAT) to authenticate towards GitHub. There is also a way of authenticating through SSH keys. We leave it up to you as a  user to use that way of authenticating in case you prefer SSH authentication and you know how to set it up.

1. In the upper-right corner of any page on github.com, click your profile photo, then click **Settings**.

2. In the sidebar, select **Developer settings**.

3. In the sidebar, select **Personal access tokens**.

4. Select **Generate new token**.

5. Give your token a descriptive name.

6. You will now have to select the scopes, or permissions, you'd like to grant this token. To use your token to access repositories from the command line, select **repo**.

7. Click **Generate token**.

8. Click the **clipboard** icon to copy the token to your clipboard. For security reasons, after you navigate off the page, you will not be able to see the token again.

## Clone the repository


1. On the repository page, select the **clipboard** menu item.

   :::image type="content" source="../../includes/media/github-repository-new-clipboard.png" alt-text="Screenshot of the GitHub interface showing the new empty repository, with clipboard button highlighted." border="true":::

1. Open Visual Studio Code. 

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. navigate in the terminal to the directory where you want to clone the GitHub repository on your local computer. 

1. Type `git clone` and then paste the URL you copied earlier. 

```
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
```

1. This is the first time you've used this repository, so you are prompted to sign in.

   Use youer GitHub username and the Personal Access Token you created as a password. 

1. Visual Studio Code prompts you to open the repository location. Select **Open**.

   :::image type="content" source="../media/3-open-cloned-repo.png" alt-text="Screenshot of the Visual Studio Code interface with a prompt to open the cloned repository, and the Open button highlighted." border="true":::


## Create a YAML workflow definition

Now that you have your account and repository created, you're ready to create a basic workflow definition.

1. Open **Explorer** in Visual Studio Code.

1. Add a new folder at the root of your current folder structure, and name it _.github_.

   > [!NOTE]
   > Make sure you include the period at the start of the folder name. This indicates that this is a hidden folder, and GitHub requires the period for GitHub Actions to detect the workflow definition.

1. In the _.github_ folder create another folder named _workflows_.

1. In the _workflows_ folder, create a new file named _workflow.yml_.

   :::image type="content" source="../media/3-vs-code-workflow-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the .github/workflows folder and the workflow.yml file shown." border="true":::

1. Copy the following into the file: 

   :::code language="yaml" source="code/3-workflow.yml" :::

1. Commit and push the file to your Git repository by using the following commands:

   ```bash
   git add .
   git commit -m "Add initial workflow definition"
   git push
   ```

> [!NOTE]
> We do not use any specific extension in Visual Studio Code to edit the workflow YAML files, however Visual Studio code will help you with proper YAML indentation by showing you on any errors you might make on syntax in your YAML files. 
> Another alternative next to using Visual Studio Code for editing your workflow YAML files, is using the GitHub web user interface. You will notice that when you open your workflow YAML file in your browser, GitHub will show this file in an alternative UI which also helps with YAML syntax and indentation and which contains code snippets for all actions you may want to use. 


## Run the workflow

You have created a workflow definition. GitHub Actions will automatically pick up your workflow file, since it is located in the _.github/workflows_ directory. 

1. In your browser, navigate to your repository. You might want to refresh the page to see the added changes. 

1. Select **Actions** tab.

   :::image type="content" source="../media/3-actions-tab.png" alt-text="Screenshot of the GitHub interface showing the repository page, and the Actions tab highlighted." border="true":::

1. Select the **learn-github-actions** workflow.

   :::image type="content" source="../media/3-workflow-select.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with the learn-github-actions workflow selected." border="true":::

1. Select the **Run workflow** dropdown and click the **Run workflow** button.

   :::image type="content" source="../media/3-run-workflow.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with the Run workflow dropdown and button selected." border="true":::

1. This will start a new run of your workflow. It might take a while, but the page will automatically refresh and show you a queued or running or even already finished workflow run.

   :::image type="content" source="../media/3-workflow-running.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with 1 workflow running." border="true":::

   Notice the run status initially is displayed as **Queued**. It can take some time for your workflow to start. Your job is added to a queue for a runner, and once a runner is available, GitHub Actions assigns the runner and starts the job. The job status then becomes **Executing**.

   Each workflow run includes an identifier. You can use this when you need to refer to the workflow run, and to help find a specific workflow run.

## Verify the workflow run

1. Once the workflow run starts, you can navigate to a page with run details, by clicking on the run.

   :::image type="content" source="../media/3-pipeline-running-click.png" alt-text="Screenshot of the GitHub interface showing the Actions tab, with the run highlighted." border="true":::

1. Refresh the page until the job status changes to **Success**. Then, select the **say-hello Job**.

   :::image type="content" source="../media/3-workflow-run-success.png" alt-text="Screenshot of the GitHub interface showing the workflow run detail, with the job in the success state and the job name highlighted." border="true":::

   Also, notice the page includes an identifier for the Git commit that the run used. This indicates the version of your repository's content that the workflow used.

1. The job information page is displayed, which shows the log of the steps that the workflow ran for you. Notice that your **Placeholder step** is included.

   :::image type="content" source="../media/3-workflow-job-summary.png" alt-text="Screenshot of the GitHub interface showing the workflow run log, with 'Placeholder step' highlighted." border="true":::

   Notice the list includes steps that you didn't specify. These are created automatically by GitHub Actions. 

1. Select the **Placeholder step** step.

   :::image type="content" source="../media/3-workflow-run-placeholder-log.png" alt-text="Screenshot of the GitHub interface showing the workflow run log, with the 'Placeholder step' highlighted." border="true":::

   The logs for this step include the contents of the command as it was specified in your pipeline's YAML file, and the _Hello world!_ text that the script emitted.

## Inspect how workflow execution can be linked back to a commit

It's good to understand how to cross-reference a workflow run to the commit that it contained. This can help you to diagnose problems and to trace the history of your deployments. 

1. Click on the **commit SHA** in the workflow run detail screen.

   :::image type="content" source="../media/3-commit-SHA.png" alt-text="Screenshot of the GitHub interface showing the workflow run detail, with the commit SHA highlighted." border="true":::

   This will lead you to the page of the commit details. It will show you the workflow.yml file was added in this commit. 
