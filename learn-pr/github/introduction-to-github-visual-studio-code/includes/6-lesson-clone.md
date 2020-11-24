Imagine that you want to contribute to another project that you've come across on GitHub. You'll want to bring this remote repository down to your local computer so that you can start playing around with it. You'll also want to explore the repository and understand how it works so that you can make a meaningful contribution.

## What is cloning?

When you clone a repository from GitHub, a copy of that repository is downloaded to your machine. If you do the clone via the Git CLI, you have to enter your GitHub credentials. You also have to set the local repository's remote URL. The remote URL is required so Git knows where to push your changes.

## Cloning from Visual Studio Code

You can clone a repository from GitHub using the Visual Studio Code file explorer or the Command Palette. If you have a new window with no folder open, you can toggle the File Explorer from the activity bar or by clicking on View -> Explorer. You'll see a button to "Clone repository".

:::image type="content" source="../media/4-clone.png" alt-text="The clone repository option in Visual Studio Code explorer view":::

If you have a folder open in Visual Studio Code, you won't see the "Clone Repository" button but you can still clone a repository from the Command Palette, by entering "Git: Clone".

When you select "Git: Clone", you will see an option to enter the url of a repository or select "Clone from GitHub". You will see a list of repositories you've created on GitHub.com and you can even search for other repositories across GitHub.com from here. When you choose the repository you want to clone, Visual Studio Code will clone it over HTTPS and once it's done, prompt you to open the folder. Visual Studio Code sets up the remote URL so you don't have to worry about configuring anything.

## I cloned a repository. Now what?

Often when you want to contribute to a project, you will start with browsing the files to understand what's happening and the history of the project. To help you easily see project history, Visual Studio Code provides a Timeline view that shows you all the previous commits made to each file. This is helpful when you want to gain context of the repository, see who contributed to it, and understand how old or recent the changes to the project are.

Visual Studio Code will open up a diff editor when you select commits in the Timeline. The diff editor is a convenient way to compare changes between the current version and the specific commit and understand a file's history. By viewing the commits in the Timeline, you can quickly get an idea of the parts of the project that need to be updated or maintained.
