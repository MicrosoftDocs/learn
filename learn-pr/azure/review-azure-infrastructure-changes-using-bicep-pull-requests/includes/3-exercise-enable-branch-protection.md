After speaking to your team you have decided to build in better confidence in what code makes it to the main branch of your repository by requireing pull requests. In this exercise you will add branch protection to your main branch and only allow new code to be merged to the main branch once it has gone through a review process.

<!--
Suppose you are working on a Bicep template that already contains a website and a database. You've deployed the components to your production environment. Now, you need to add a *message queue*, so that your website can post messages to a queue whenever a customer places an order. An Azure Function will pick up these messages and process them asynchronously.

This is a new feature that needs to be added to the existing template. So, you create a new branch for adding these changes. These changes might include:

- Add a queue to your Bicep template.
- Update the website's definition in the template so that it has the connection information for the queue.
- Add the new Azure Function application to the template.

By making these changes on a separate feature branch, you can iterate on them without affecting the code on the main branch. You can work in small batches, making each update with separate commits or merges, so the work is divided and easily managed. But because these updates all happen against your feature branch, they don't affect anything that happens on the main branch, and you'll have no incomplete work on the main branch. Later in this module, you'll see how you can test your changes in an environment completely separate from your development, QA or production environments.
-->

During the process, you'll: 

> [!div class="checklist"]
> * Add required reviewers for pushes to your main branch.
> * Try to merge a feature branch to main.
> * Create a pull request to merge the feature branch.
> * Review and approve the pull request.

## Add required reviewers for pushes to your main branch

First you will set up branch protection for the main branch.

1. In your browser, navigate to **Repos** > **Branches**.

1. Hover over the **main** branch, and select the three dots.

1. Select **Branch policies**.

1. In the Branch policies window, change the setting for **Require a minimum number of reviewers** to **On**.

1. Change the minimum number of reviewers to **1** and select the **Allow requestors to approve their own changes** option.

> [!NOTE]
> We are setting the _Allow requestors to approve their own changes_ option since in these exercises it will be only you who has access to the project. We need this setting so you can advance through the exercises. In a team environment you probably don't want to set this option.

## Try to merge a feature branch to main

Now that the main branch has branch protection turned on, you will first try to directly merge a branch to the main branch.

1. In the Visual Studio Code terminal execute the following statements: 

    ```bash
    git merge origin/feature1 main
    ```

    This will merge the feature1 branch into the main branch.

1. TODO

    ```bash
    git push
    ```

    This will push your local main branch with the changes of feature1 to the remote main branch.
    You will notice that this last statement will be unsuccessful because of the branch protection you enabled: 

    ```bash
    Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
    To https://dev.azure.com/yourorg/bicepdevopslearn/_git/bicepdevopslearn
    ! [remote rejected] main -> main (TF402455: Pushes to this branch are not permitted; you must use a pull request to update this branch.)
    error: failed to push some refs to 'https://dev.azure.com/yourorg/bicepdevopslearn/_git/bicepdevopslearn'
    ```

## Create a pull request to merge the feature branch

Since you are unable to push changes to main directly, you will now try and merge the changes through a pull request.

1. In your browser, navigate to **Repos** > **Files**.

1. Select the **Feature1** branch.

1. You will notice a banner on top indicating there are changes in the feature1 branch and that you can create a pull request for them. Select **Create a pull request**.

1. Take note of the title and the description and the extra info you can indicate. We will leave them as is. Select **Create**.
