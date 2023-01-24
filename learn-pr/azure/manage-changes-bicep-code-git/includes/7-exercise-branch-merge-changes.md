Back at the toy company, your website developers plan to add a new Azure Cosmos DB database to store data about the toys that the company sells. The developers asked you to update the Bicep code to add the Cosmos DB resources. However, they're not ready to make the changes yet. They just want you to get the changes ready for when they finish the modifications.

In this exercise, you'll add a new Bicep module on a branch of your repository. During the process, you'll:

> [!div class="checklist"]
>
> - Create a branch and switch to it.
> - Change your Bicep code on the branch.
> - Switch back to your main branch.
> - Merge your branch to _main_.

## Create and check out a branch in your repository

1. By using the Visual Studio Code terminal, run the following command to create and check out a new branch:

   ```bash
   git checkout -b add-database
   ```

1. Run the following command to check the status of the repository:

   ```bash
   git status
   ```

   The output looks similar to the following example:

   ```output
   On branch add-database
   nothing to commit, working tree clean
   ```

   The first line of the output tells you that Git is on the _add-database_ branch.

1. In Visual Studio Code, look at the status bar at the bottom, left side of the window. Notice that the branch name changed to _add-database_.

   As with the other Git commands you've run, Visual Studio Code stays up to date with the changes in your Git repository, including when you check out a branch.

## Update a file on your branch

Now that you've created a branch, you'll add a new Bicep module for your website's Azure Cosmos DB account.

1. In the _deploy_ folder's _modules_ subfolder, create a new file named _cosmos-db.bicep_.

1. Open and save the empty _cosmos-db.bicep_ file so that Visual Studio Code loads the Bicep tooling.

1. Copy the following code into _cosmos-db.bicep_:

   :::code language="bicep" source="code/7-module-cosmos-db.bicep" :::

1. Save and close the _cosmos-db.bicep_ file.

1. Open the _main.bicep_ file.

1. Add the following parameter definitions below the `appServiceAppName` parameter definition:

   :::code language="bicep" source="code/7-main.bicep" range="14-15" :::

1. Add the following module definition below the `appService` module definition:

   :::code language="bicep" source="code/7-main.bicep" range="26-33" :::

1. Save and close the _main.bicep_ file.

## Review the differences and commit the changes

After you review the file differences, stage and commit your changes. You can choose whether to use the Git CLI or Visual Studio Code to commit the files. This example uses the Git CLI.

1. Using **Source Control** in Visual Studio Code, look at the differences for both files.

   Notice the changed lines highlighted in the _main.bicep_ file.

1. Review the files that are ready to commit.

   ```bash
   git status
   ```

   The output will look like the following example.

   ```output
   On branch add-database
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            modified:   deploy/main.bicep

    Untracked files:
      (use "git add <file>..." to include in what will be committed)
            deploy/modules/cosmos-db.bicep

    no changes added to commit (use "git add" and/or "git commit -a")
   ```

1. Stage the changes for both files.

   ```bash
   git add .
   ```

   The dot (`.`) stages all files that were changed.

1. Commit the changes.

   ```bash
   git commit --message "Add Cosmos DB module"
   ```

   The output will look like the following example.

   ```output
   [add-database 513f700] Add Cosmos DB module
     2 files changed, 71 insertions(+)
     create mode 100644 deploy/modules/cosmos-db.bicep
   ```

## Switch branches

Now that you've made the changes on your branch, you can verify that the changes are visible only on the _add-database_ branch.

1. Check out the _main_ branch. You can choose either of the following approaches:

    - In the Visual Studio Code terminal window, enter the following command:

      ```bash
      git checkout main
      ```

    - In the Visual Studio Code status bar at the bottom of the window, select the branch name that currently displays _add-database_.

      A list of branches appears. Select the _main_ branch.

1. In the Visual Studio Code **Explorer** pane, open the _main.bicep_ file.

   Notice that none of the Azure Cosmos DB changes you made are included. Now that you've switched to the _main_ branch, the database module isn't there. Don't worry, they're safely stored on your _add-database_ branch.

## Merge your branch

Your website team has tested the changes, and is now ready to launch the updated website with the Azure Cosmos DB database included. You'll merge the _add-database_ branch into the _main_ branch.

1. Verify that you're on the _main_ branch by running `git status` and by looking at the branch name in the status bar.

1. In the Visual Studio Code terminal, enter the following command to merge the changes from the _add-database_ branch onto the _main_ branch:

   ```bash
   git merge add-database
   ```

1. In the Visual Studio Code **Explorer** pane, open the _main.bicep_ file.

   Notice that the database module now appears in the file. You've now updated your known-good Bicep files, on your _main_ branch, to include the changes from your _add-database_ branch.

1. In the Visual Studio Code terminal, enter the following command to delete the _add-database_ branch because you no longer need it:

   ```bash
   git branch -d add-database
   ```
