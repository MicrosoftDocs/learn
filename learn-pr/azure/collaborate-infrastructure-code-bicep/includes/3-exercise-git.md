Throughout this module, you'll modify the original template. It's a good practice to use version control to keep copies of the changes you make.

TODO instructions to run git init etc


## Check your development environment

First, let's check your development environment. At the beginning of this learning module, there was a list of **prerequisites** you should have available. Now it's time to validate, if you environment is ready for the task.

On **Windows 10** computer:

1. Open **PowerShell console**. You can use either "Windows PowerShell" or "PowerShell 7 (x64)".
2. Depending if you installed **Visual Studio Code** stable or Insiders build, run one of these commands:
   1. Stable build: `code --version`
   2. Insiders build: `code-insiders --version`

   The command should return three lines, similar to:

      ```plaintext
      1.57.0
      b4c1bd0a9b03c749ea011b06c6d2676c8091a70c
      x64
      ```

3. Check if you have the **Bicep extension** by running one of these commands:
   1. Stable build: `$(code --list-extensions) -match 'ms-azuretools.vscode-bicep'`
   2. Insiders build: `$(code-insiders --list-extensions) -match 'ms-azuretools.vscode-bicep'`.

   The command should return: `ms-azuretools.vscode-bicep`

4. Check if you have **Git** installed by running `git --version` command. It should return a similar output: `git version 2.32.0.windows.1`
5. Depending if you installed **Azure CLI** or **Azure PowerShell**, run one of these commands:
   1. For Azure CLI: `az --version`.
   2. For Azure PowerShell: `Get-Module -Name Az -ListAvailable`

### New workspace and Git repository

Now when we checked we have all important tools available, it's time to initialize a new Git repository using VS Code.

1. Open **Visual Studio Code** using the Start menu (or any other way you're used to).
2. Select **File** - **Open Folder** from the menu, and create a new empty folder in your filesystem, for example in `C:\git\learn-bicep\`.
3. VS Code might prompt you to validate, if you "trust the authors of the files in this folder". It's a recently added security feature. Since we've created this folder, it's safe to select **Yes, I trust ...** button.

   :::image type="content" source="../media/5-vscode-trust.png" alt-text="A screen in VS Code prompting for trusting the content in the folder recently opened.":::

4. Select **View** - **SCM** from the menu. You should see a similar screen:

   :::image type="content" source="../media/5-vscode-initialize.png" alt-text="A VS Code window in SCM view with an option to initialize Git repository.":::

5. Click **Initialize Repository** button. This command will enable Git in your newly created folder, so you can start tracking changes you make in your code.

### Commit original template

Before we start making changes to our template, we need to establish a reference point we could always go back to. Since we know the original template is working, we can commit it directly to our `main` branch.

1. Select **View - Explorer** from the menu.
2. Use **Ctrl - N** keyboard shortcut to create a new file. This will open a new empty window in the editor.
3. Open the Command palette using **Ctrl + Shift + P** keyboard shortcut, start typing 'change lang` and select **Change language mode** from the drop-down menu. Select **Bicep** and press Enter to confirm it.
4. Hold the **Ctrl** key and click on this [link](/learn/modules/collaborate-infrastructure-code-bicep/2-review-existing-template/). This should open a new tab in your browser with 'Review existing Bicep template' unit.
5. Click **Copy** button at the top of the first code block in the 'Review the entire template' section. The code will be copied to your clipboard.
6. Switch to VS Code, click to the empty window we've opened and use **Ctrl + V** shortcut to paste the code from your clipboard.
7. Use **Ctrl - S** shortcut to save the file. A dialogue box should appear, prompting you to provide a file name. Save the file as `mainTemplate.bicep`.
8. Select **View - SCM** from the menu. You should see a similar view.

   :::image type="content" source="../media/5-vscode-scm.png" alt-text="A VS Code in SCM view with one file changed.":::

9. Use **Ctrl - Shift - P** to open the Command palette again. Start typing `git commit` and select **Git: Commit** from the drop-down menu. A dialogue box should appear, informing you "There are no staged changes to commit". Click **Yes** button and type `Add original template` in the dialogue box that appears at the top. Confirm by pressing Enter.

   :::image type="content" source="../media/5-vscode-commit-original.png" alt-text="VS Code with a dialogue to provide commit message.":::

> [!NOTE]
> If you have never used Git on your machine, you might get an error about a missing configuration (username and e-mail address). Follow the [instructions](https://git-scm.com/docs/git-commit#_commit_information) on Git website to fix it.
