You want to browse and edit code for your startup in the browser-based editor. You'll need to work with remote repositories in VS Code for the Web.

In this exercise, we'll open the [Microsoft VS Code repo](https://github.com/microsoft/vscode) so you can practice opening a remote repository, making lightweight changes, and viewing the integrated source control experience.

## Open the repository

First, you'll open the remote repository to browse the files.

1. On https://vscode.dev, on the Explorer view, click the "Open Remote Repository" button. 

    :::image type="content" source="../media/5-open-remote-repository.png" alt-text="Screenshot highlighting the Open Remote Repository feature in the Explorer view of VS Code for the Web.":::

2. Select the option for Open Repository from GitHub. If prompted, log in to your GitHub account.

    :::image type="content" source="../media/5-open-remote-repository.png" alt-text="Screenshot showing the Open Repository from GitHub prompt in the Command Palette.":::

3. Type microsoft/vscode in the dialog box and select the first option.

    :::image type="content" source="../media/5-vscode-repo.png" alt-text="Screenshot highlighting the microsoft/vscode repo listed in the Open Remote Repository prompt, after searching for microsoft/vscode.":::

4. The repository will load in just a few moments, without any code being locally cloned. You can now browse and edit the code like you normally would!

Alternatively, you can also open a remote repository quickly by prepending the repository URL with https://vscode.dev/github/. For example, you could type https://vscode.dev/github/microsoft/vscode in the browser to open this repository!

## Edit code 

Now that the repository is open, you can make any edits to the code and see the edits reflected in source control.

1. In any file, make a small change. Notice that your change is automatically saved, which is the default experience of VS Code for the Web.
2. Navigate to the Source Control Explorer in the side bar. Notice that the change you made in the previous step is showing as a pending change.

    :::image type="content" source="../media/5-source-control-explorer.png" alt-text="Screenshot showing the Source Control Explorer view in VS Code for the Web.":::
    
3. The Source Control Explorer experience is similar in the browser compared to the desktop application. You can commit and push changes, switch branches, and create a pull request, for example.
4. Because you're browsing a GitHub Repo, you can also view GitHub pull requests. Navigate to the GitHub view on the sidebar, where you'll see a list of pull requests available for review.

    :::image type="content" source="../media/5-github-pull-requests.png" alt-text="Screenshot showing a list of active pull requests for the repo in the GitHub view.":::
 
    This functionality is powered by the [GitHub Pull Requests and Issues extension](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github), which also works in VS Code Desktop! This extension is enabled by default once you're logged into your GitHub account in VS Code for the Web.    

You've successfully opened a remote repository, made edits, and familiarized yourself with the integrated source control! One of the main benefits of using VS Code for the Web is the set of features it provides instantly in a lightweight, browser-based editor.

In the next section, you'll learn how to go from the lightweight capabilities of VS Code for the Web to the full feature set of VS Code Desktop, with one basic command.
