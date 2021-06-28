In the previous exercise, you initialized a Git repository for your toy company's website and you added a Bicep file, but you didn't commit it. In this exercise you'll commit the file. You'll then make some more changes to your Bicep code to see how Git and Visual Studio Code help you to track and manage the changes you're making.

During the process, you'll:

> [!div class="checklist"]
> * Commit the file you created in the previous exercise.
> * Add a new Bicep module, and compare the differences in your Bicep code by using Git.
> * Commit the updated Bicep code.
> * View the commit history and the main Bicep file's history.

## Commit the Bicep file to your Git repository

1. Using the Visual Studio Code terminal, execute the following command to stage the _main.bicep_ file:

   ```bash
   git add deploy/main.bicep
   ```

1. Run the following command to commit the staged changes and provide a commit message:

   ```bash
   git commit --message "Add first version of Bicep template."
   ```

## Add a Bicep module

Here you add a Bicep module, and reference it from your _main.bicep_ file.

1. In the _deploy_ folder, create a subfolder named _modules_.

1. In the _modules_ folder, create a new file named _app-service.bicep_.

1. Open and save the empty _app-service.bicep_ file so that Visual Studio Code loads the Bicep tooling.

1. Copy the following code into *app-service.bicep*.

   :::code language="bicep" source="code/5-module-app-service.bicep" :::

1. Save and close the _app-service.bicep_ file.

1. Open the _main.bicep_ file.

1. Underneath the parameter declarations, add the following module definition:

   :::code language="bicep" source="code/5-main.bicep" :::

1. Save and close the _main.bicep_ file.

## Compare the difference

Now that you've made a change to the _main.bicep_ file, let's inspect the difference. It's a good idea to review the difference in each file you're about to stage and commit, to ensure you don't accidentally commit any changes you don't want.

1. In Visual Studio Code, select **View** and then **SCM**, or press <kbd>Ctrl+Shift+G</kbd>.

   The **Source Control** panel opens.

1. Double-click the _main.bicep_ file in the **Source Control** panel.

   A file difference opens.

   TODO screenshot

   Notice that Visual Studio Code shows you the changes you have made. The original file is on the left, and the changed file is on the right. Additions to the file are displayed in green, and anything you've removed from the file is displayed in red.

1. Open the difference for the _app-service.bicep_ file.

   Notice that there's nothing on the left side of the difference, since this file is new and wasn't already added to the repository.

## Commit the updated Bicep code by using Visual Studio Code

Now that you've reviewed the changes and are satisfied with it, you commit the update to the file. This time, you commit using Visual Studio Code.

1. At the top of the the **Source Control** panel, enter a descriptive commit message, like:

   _Add App Service module._

1. Select the checkmark icon above the commit message text box.

   TODO screenshot

   Visual Studio Code commits the two changes. Since you didn't explicitly stage them, Visual Studio Code automatically staged both files before it committed them.

## View the commit history by using the Git CLI

1. In the Visual Studio Code terminal, enter the following command to view the repository's commit history:

   ```bash
   git log --pretty=oneline
   ```

   The output looks similar to the following:

   ```output
   TODO
   ```

1. Inspect the output. Notice you see both of your commits in the commit history.

## View a file's history by using Visual Studio Code

You can also view the history of a single file, the state of the file from that commit, and the change that the commit applied.

1. Open the **Explorer** pane in Visual Studio Code.

1. Right-click the _main.bicep_ file and select **Open Timeline**.

   TODO screenshot

   The timeline pane opens, showing both commits.

   TODO screenshot

1. Double-click the bottom commit in the list to view the state of the file at that point in time.

   TODO screenshot
