In the previous exercise, you initialized a Git repository for your toy company's website. You added a Bicep file, but you didn't commit it.

In this exercise, you'll:

> [!div class="checklist"]
>
> - Commit the file that you created in the previous exercise.
> - Add a new Bicep module, and compare the differences in your Bicep code by using Git.
> - Commit the updated Bicep code.
> - View the commit history and the main Bicep file's history.

The process of making more changes to your Bicep code will show you how Git and Visual Studio Code help you track and manage changes.

## Commit the Bicep file by using the Git CLI

1. By using the Visual Studio Code terminal, run the following command to stage the _main.bicep_ file:

   ```bash
   git add deploy/main.bicep
   ```

1. Run the following command to commit the staged changes and provide a commit message:

   ```bash
   git commit --message "Add first version of Bicep template"
   ```

## Add a Bicep module

Here you add a Bicep module and reference it from your _main.bicep_ file.

1. In the _deploy_ folder, create a subfolder named _modules_.

1. In the _modules_ folder, create a new file named _app-service.bicep_.

1. Open and save the empty _app-service.bicep_ file so that Visual Studio Code loads the Bicep tooling.

1. Copy the following code into _app-service.bicep_:

   :::code language="bicep" source="code/5-module-app-service.bicep" :::

1. Save and close the _app-service.bicep_ file.

1. Open the _main.bicep_ file.

1. Under the parameter declarations, add the following parameter declaration and module definition:

   :::code language="bicep" source="code/5-main.bicep" range="11-21" :::

1. Save and close the _main.bicep_ file.

## Compare the differences

Now that you've made a change to the _main.bicep_ file, let's inspect the differences. It's a good idea to review the differences in each file you're about to stage and commit. You do the review to verify that your changes are correct.

1. In Visual Studio Code, select **View** > **Source Control**, or select <kbd>Ctrl+Shift+G</kbd> on the keyboard.

1. On the **Source Control** panel that opens, select the _main.bicep_ file.

   A view of file differences opens.

   :::image type="content" source="../media/5-vscode-diff.png" alt-text="Screenshot of Visual Studio Code that shows the differences between the current main.bicep file and the modified version." border="true":::

   Notice that Visual Studio Code shows you the changes you've made. The original file is on the left, and the changed file is on the right. Additions to the file are displayed in green. When you edit a file and remove content, the deletions are displayed in red.

1. Open the differences for the _app-service.bicep_ file.

   Notice that there's nothing on the left side of the difference view, because this file is new and wasn't already added to the repository.

## Commit the updated Bicep code by using Visual Studio Code

Now that you've reviewed the changes and are satisfied with it, you commit the update to the file. This time, you use Visual Studio Code.

1. Open **Source Control**.

   Two changed files should appear. If you don't see them, select the refresh button so that Visual Studio Code scans for changes.

   :::image type="content" source="../media/5-vscode-refresh.png" alt-text="Screenshot of Visual Studio Code that shows Source Control, with the Refresh toolbar icon highlighted." border="true":::

1. Select each of the two changed files and stage them. You can select the plus (**+**) icon on each file, or you can select and hold (or right-click) each file and select **Stage Changes**.

   :::image type="content" source="../media/5-vscode-stage.png" alt-text="Screenshot of Visual Studio Code that shows Source Control, with the main.bicep context menu displayed and the Stage Changes menu item highlighted." border="true":::

1. At the top of **Source Control**, enter a descriptive commit message, like:

   ```plaintext
   Add App Service module
   ```

1. Select the check-mark icon above the text box for the commit message. Or you can select **Commit**.

   :::image type="content" source="../media/5-vscode-commit.png" alt-text="Screenshot of Visual Studio Code that shows Source Control, with the commit icon highlighted." border="true":::

   Visual Studio Code commits the two changes.

## View the commit history by using the Git CLI

1. In the Visual Studio Code terminal, enter the following command to view the repository's commit history:

   ```bash
   git log --pretty=oneline
   ```

   The output looks similar to the following example:

   ```output
   238b0867f533e14bcaabbade31b9d9e1bda6123b (HEAD -> main) Add App Service module
   9e41f816bf0f5c590cee88590aacc977f1361124 Add first version of Bicep template
   ```

1. Inspect the output. Notice that both of your commits appear in the commit history.

## View a file's history by using Visual Studio Code

You can also view the history of a single file, the state of the file from that commit, and the change that the commit applied.

1. Open **Explorer** in Visual Studio Code.

1. Select and hold (or right-click) the _main.bicep_ file, and then select **Open Timeline**.

   :::image type="content" source="../media/5-vscode-timeline-menu.png" alt-text="Screenshot of Visual Studio Code that shows the Explorer panel, with the shortcut menu displayed for the main.bicep file and the Timeline menu item highlighted." border="true":::

   The timeline opens and shows both commits.

   :::image type="content" source="../media/5-vscode-timeline.png" alt-text="Screenshot of Visual Studio Code that shows the timeline for the main.bicep file, with two commits listed." border="true":::

1. Select each commit in the list to view the state of the file at that point in time.
