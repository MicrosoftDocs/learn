Your team is working on a Bicep template that already contains a website and a database. You've deployed the components to your production environment. Now, you need to update your Bicep template to add your order processing queue.

In this exercise, you'll create a feature branch for your change. You'll also add branch protection to your main branch, and only allow changes to be merged to the main branch after they've been reviewed. Before that, though, you need to make sure that your Azure DevOps environment is set up to complete the rest of this module.

During the process, you'll: 

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.
> * Clone the project's repository to your computer.
> * Add branch protection to your repository's main branch.
> * Create a local feature branch for your change.
> * Try to merge your feature branch to main.

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

## Add branch protection

Configure your Git repository to prevent direct pushes to the *main* branch.

1. In your browser, navigate to **Repos** > **Branches**.

1. Hover over the **main** branch, and select the three dots.

1. Select **Branch policies**.

1. In the Branch policies window, change the setting for **Require a minimum number of reviewers** to **On**.

1. Change the minimum number of reviewers to **1** and select the **Allow requestors to approve their own changes** option.

   > [!NOTE]
   > Here, you enable the _Allow requestors to approve their own changes_ option. In these exercises, you're working on your own, and so you need to both create and approve your changes. But in a real team environment, you might not want to enable this option.

## Create a local feature branch

1. In the Visual Studio Code terminal, run the following statement: 

    ```bash
    git checkout -b add-orders-queue
    ```

    This creates a new feature branch for you to work from.

1. Open the *main.bicep* file in the *deploy* folder.

   (TODO instructions on what to do with the Bicep file)

1. Commit your changes, and push them to your Azure Repos repository, by running the following commands in the Visual Studio Code terminal:

    ```bash
    git add .
    git commit -m "Add orders queue and associated configuration"
    git push -u origin
    ```

    The feature branch is pushed to your repository on Azure Repos.

## Try to merge a feature branch to main

You've learned why it's not advisable to push directly to the *main* branch. Here, you try to break that guideline so you can see how Azure Repos prevens you from accidentally pushing your changes to a protected branch.

1. In the Visual Studio Code terminal, run the following statements to switch to the *main* branch and try to ush your changes:

    ```bash
    git checkout main
    git push
    ```

1. Notice that the push fails with an error message that looks similar to the one below:

    ```bash
    Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
    To https://dev.azure.com/mytoycompany/toy-website-review/_git/toy-website-review
    ! [remote rejected] main -> main (TF402455: Pushes to this branch are not permitted; you must use a pull request to update this branch.)
    error: failed to push some refs to 'https://dev.azure.com/mytoycompany/toy-website-review/_git/toy-website-review'
    ```

    The error message tells you that pushes to the *main* branch aren't permitted, and that you must use a pull request to update the branch.
