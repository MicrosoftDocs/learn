Now that you're familiar with the basics of VS Code for the Web, let's take a look at how developers at your startup can benefit from these features. At the startup, things move quickly, and you need to be able to browse and make lightweight code changes wherever you are. You can use VS Code for the Web to perform these tasks from any browser-compatible device.

## Browsing repositories

When you want to quickly browse or make lightweight changes, you don't want to wait to locally clone the source code repository. With VS Code for the Web, you can remotely browse and edit a repository from within the editor, without needing to pull code onto your local machine. This functionality is made possible through the [Remote Repositories](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-repositories&ssr=false#overview) extension, which integrates with the GitHub Repositories and Azure Repositories extensions. The Remote Repositories extension is available to install in VS Code Desktop and enabled by default in the VS Code for the Web experience.

:::image type="content" source="../media/4-remote-repositories.png" alt-text="Screenshot of the Remote Repositories extension in VS Code.":::
 
## Virtual file system

Without a repository's files on your local machine, the Remote Repositories extension creates a virtual file system in memory so you can view file contents and make edits. This virtual file system in memory is known as a virtual workspace, which simulates having local files while getting the content from somewhere else, such as GitHub.

## Source control with remote repositories

Having an integrated source control experience is a core component of VS Code, and that same concept is available in the VS Code for the Web experience. With remote repositories, every time you open a repository or branch, you get the up-to-date sources available from GitHub. You don't need to remember to pull to refresh as you would with a local repository. Similarly, you can open a pull request and see the latest changes, review, and leave comments. You can also create a new pull request with your changes directly from the Source Control view. 

While your code doesn't live locally, your edits do. If you want to access your changes in GitHub or on another machine, you can either commit or have Cloud Changes enabled. Your work is saved in the browser's local storage until you commit it. When you commit a change, the changes are pushed directly to the remote repository. We'll explore Cloud Changes later in this module. 

In this next section, you'll open a remote repository, make some small edits, and learn how to create and review PRs, all from within the browser.
