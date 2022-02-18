Your team is working on a Bicep template that already contains a website and a database. You've deployed the components to your production environment. Now, you need to update your Bicep template to add your order processing queue.

In this exercise, you'll create a feature branch for your change. You'll also protect your main branch, and only allow changes to be merged to the main branch after they've been reviewed. Before that, though, you need to make sure that your Azure DevOps environment is set up to complete the rest of this module.

During the process, you'll: 

::: zone pivot="github"

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.
> * Clone the project's repository to your computer.
> * Add branch protection to your repository's main branch.
> * Create a local feature branch for your change.
> * Try to merge your feature branch to main.

::: zone-end

::: zone pivot="azurerepos"

> [!div class="checklist"]
> * Set up a GitHub repository for this module.
> * Clone the repository to your computer.
> * Add branch policies to your repository's main branch.
> * Create a local feature branch for your change.
> * Try to merge your feature branch to main.

::: zone-end

::: zone pivot="github"

## Get the GitHub repository

Here you make sure that your GitHub repository is set up to complete the rest of this module. You set it up by creating a new repository based on a template repository. The template repository contains the files you need to get started for this module. 

### Start from the template repository

Run a template that sets up your GitHub repository.

> [!div class="nextstepaction"]
> [Run the template](https://github.com/MicrosoftDocs/mslearn-review-azure-infrastructure-changes-using-bicep-pull-requests?azure-portal=true)

On the GitHub site, follow these steps to create a repository from the template:

1. Select **Use this template**. 

   :::image type="content" source="../media/4-template.png" alt-text="Screenshot of the GitHub interface showing the template repo, with the 'Use this template' button highlighted.":::

1. Enter a name for your new project, such as *toy-website-review*.

1. Select the **Public** option.

   When you create your own repositories, you might want to make them private. In this module, you'll work with some features of GitHub that only work with public repositories and with GitHub Enterprise accounts.

1. Select **Create repository from template**. 

   :::image type="content" source="../media/4-repo-settings.png" alt-text="Screenshot of the GitHub interface showing the repo creation page.":::

## Clone the repository

You now have a copy of the template repository in your own account. You will now clone this repository locally so you can start work in it. 

1. Select **Code** and select the copy icon.

   :::image type="content" source="../media/4-github-repository-clipboard.png" alt-text="Screenshot of the GitHub interface showing the new repository, with the repository U R L copy button highlighted.":::

1. Open Visual Studio Code. 

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Navigate in the terminal to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the _toy-website-review_ folder, run the following command:

   ```bash
   cd toy-website-review
   ```

1. Type `git clone` and then paste the URL you copied earlier, which looks something like this:

   ```bash
   git clone https://github.com/mygithubuser/toy-website-review.git
   ```

1. Reopen Visual Studio Code in the repository folder by running the following command in the Visual Studio Code terminal:

   ```bash
   code -r toy-website-review
   ```

::: zone-end

::: zone pivot="azurerepos"

## Get the Azure DevOps project

Here you make sure that your Azure DevOps organization is set up to complete the rest of this module. You set it up by running a template that creates a project in Azure DevOps.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=testbicep&azure-portal=true)
<!-- TODO -->

> [!CAUTION]
> This isn't working yet :)

On the Azure DevOps Demo Generator site, follow these steps to run the template:

1. Select **Sign In** and accept the usage terms.

1. On the **Create New Project** page, select your Azure DevOps organization. Then enter a project name, such as **toy-website-review**.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="Screenshot that shows creating a project through the Azure DevOps Demo Generator.":::

1. Select **Create Project**.

    The template takes a few moments to run. It automatically creates a pipeline and Bicep file for you to work with in the subsequent exercises.

1. Select **Navigate to project** to go to your project in Azure DevOps.

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu, with Files highlighted.":::

1. Select **Clone**.

   :::image type="content" source="../media/4-clone.png" alt-text="Screenshot of Azure DevOps that shows the repository, with the Clone button highlighted.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials** and copy the displayed username and password to somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/4-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the button for cloning in Visual Studio Code highlighted.":::

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

    If you're using Windows, enter the same credentials that you used to sign in to Azure DevOps earlier in this exercise.

    If you're using macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

::: zone-end

::: zone pivot="github"

## Add branch protections

Configure your Git repository to prevent direct pushes to the *main* branch.

1. In your browser, select **Settings**.

   TODO image

1. Select **Branches**.

   TODO image

1. Select **Add rule**.

   TODO image

1. In the **Branch name pattern** text box, enter **main**.

1. Select **Require a pull request before merging**.

1. Select **Include administrators**. By selecting this option, you enforce the rule on yourself, too.

   Leave the other configuration options with their default values.

   TODO image

1. Near the bottom of the page, select **Create**.

   TODO image

   GitHub might ask you to sign in again to confirm your identity.

::: zone-end

::: zone pivot="azurerepos"

## Add branch policies

Configure your Git repository to prevent direct pushes to the *main* branch.

1. In your browser, navigate to **Repos** > **Branches**.

1. Hover over the **main** branch, and select the three dots.

1. Select **Branch policies**.

1. In the Branch policies window, change the setting for **Require a minimum number of reviewers** to **On**.

1. Change the minimum number of reviewers to **1** and select the **Allow requestors to approve their own changes** option.

   > [!NOTE]
   > Here, you enable the _Allow requestors to approve their own changes_ option. In these exercises, you're working on your own, and so you need to both create and approve your changes. But in a real team environment, you might not want to enable this option.

::: zone-end

## Create a local feature branch

1. In the Visual Studio Code terminal, run the following statement: 

    ```bash
    git checkout -b add-orders-queue
    ```

    This creates a new feature branch for you to work from.

1. Open the *main.bicep* file in the *deploy* folder.

1. Near the top of the *main.bicep* file, add a new variable for the name of the queue:

   :::code language="bicep" source="code/3-main-end.bicep" range="11-12" highlight="2" :::

1. Within the storage account resource, add the queue as a nested child resource:

   :::code language="bicep" source="code/3-main-end.bicep" range="14-32" highlight="12-18" :::

1. In the `appService` module definition, add the storage account and queue names as parameters.

   :::code language="bicep" source="code/3-main-end.bicep" range="34-43" highlight="6-7" :::

   This enables the application to find the queue to send messages to.

1. Save the *main.bicep* file.

1. Open the *appService.bicep* file in the *deploy/modules* folder.

1. Near the top of the *appService.bicep* file, add new parameters for the storage account and queue names:

   :::code language="bicep" source="code/3-appservice-end.bicep" range="1-4" highlight="3-4" :::

1. Update the `appServiceApp` resource to propagate the storage account and queue names to the application's environment variables:

   :::code language="bicep" source="code/3-appservice-end.bicep" range="23-42" highlight="7-18" :::

::: zone pivot="github"

Commit your changes, and push them to your GitHub repository, by running the following commands in the Visual Studio Code terminal:

::: zone-end

::: zone pivot="azurerepos"

Commit your changes, and push them to your Azure Repos repository, by running the following commands in the Visual Studio Code terminal:

::: zone-end

```bash
git add .
git commit -m "Add orders queue and associated configuration"
git push -u origin
```

The feature branch is pushed to your remote repository.

## Try to merge the feature branch to main

::: zone pivot="github"

You've learned why it's not advisable to push directly to the *main* branch. Here, you try to break that guideline so you can see how GitHub prevents you from accidentally pushing your changes to a protected branch.

1. In the Visual Studio Code terminal, run the following statements to switch to the *main* branch and merge the *add-orders-queue* branch to it:

   ```bash
   git checkout main
   git merge add-orders-queue
   ```

   The command worked, and you merged the *add-orders-queue* branch to your *main* branch. But, this only affects your local Git repository.

1. Run the following statement to try to push your changes to GitHub:

    ```bash
   git push
   ```

   Notice that your push fails with an error message that looks similar to the one below:

   :::code language="output" source="code/3-merge-error-github.txt" highlight="8-9" :::

   The error message tells you that pushes to the *main* branch aren't permitted, and that you must use a pull request to update the branch.

1. Undo the merge by running the following statement:

   ```bash
   git reset --hard HEAD~1
   ```

   This command tells your local Git repository to reset the state of the *main* branch to what it was before the last commit was merged in.

::: zone-end

::: zone pivot="azurerepos"

You've learned why it's not advisable to push directly to the *main* branch. Here, you try to break that guideline so you can see how Azure Repos prevents you from accidentally pushing your changes to a protected branch.

1. In the Visual Studio Code terminal, run the following statements to switch to the *main* branch and merge the *add-orders-queue* branch to it:

   ```bash
   git checkout main
   git merge add-orders-queue
   ```

   The command worked, and you merged the *add-orders-queue* branch to your *main* branch. But, this only affects your local Git repository.

1. Run the following statement to try to push your changes to Azure Repos:

    ```bash
   git push
   ```

   Notice that your push fails with an error message that looks similar to the one below:

   :::code language="output" source="code/3-merge-error-azure-repos.txt" highlight="3" :::

   The error message tells you that pushes to the *main* branch aren't permitted, and that you must use a pull request to update the branch.

1. Undo the merge by running the following statement:

   ```bash
   git reset --hard HEAD~1
   ```

   This command tells your local Git repository to reset the state of the *main* branch to what it was before the last commit was merged in.

::: zone-end
