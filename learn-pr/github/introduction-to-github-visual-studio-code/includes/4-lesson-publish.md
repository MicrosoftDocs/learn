As a Visual Studio Code user who has authenticated to GitHub, you'll get some improvements to your GitHub workflow. One of those improvements is the ability to "publish" a project from your machine directly to GitHub.

## What is publishing?

If you're starting with a new project you haven't yet pushed to GitHub, the process for _getting_ it up on GitHub has quite a few steps.

1. Create a GitHub repo on github.com
1. Copy the remote endpoint
1. Run `git init` locally
1. Add the remote endpoint
1. Specify which items to push into GitHub with a .gitignore
1. Stage files
1. Add a commit message
1. Push to the repo

That's a lot of steps. A lot of steps means a lot of work.

Visual Studio Code has a built-in "publish" feature that fully automates this process and allows you to do it right from Visual Studio Code.

## Publishing to GitHub from Visual Studio Code

There are two ways to publish a project to GitHub from Visual Studio Code - from the Source Control Management View (SCM View) and from the Command Palette. You must have a folder open in Visual Studio Code to see these options.

> [!TIP]
> You can always use the Git from the built-in terminal in Visual Studio Code as well (<kbd>Ctrl</kbd> + <kbd>`</kbd>). Just because you're using Visual Studio Code's visual source control tools doesn't mean that you have to completely forgo your beloved command line!

### Publishing from the SCM View

If you haven't already initialized a repository for your project, you can publish your project directly from the SCM View.

The SCM View can be toggled in Visual Studio Code by selecting the SCM icon in the Activity Bar. You'll see a button that says "Publish to GitHub".

:::image type="content" source="../media/source-control-management-publish.jpg" alt-text="The source control management publish view in visual studio code with the publish to GitHub button outlined":::

Clicking this button will initialize the publish process...

1. Specify the name of the repository to create on GitHub.
1. Specify which files should be pushed to GitHub. Any files that you don't select will be automatically added to a `.gitignore` file which is created during the publish process.
1. Your code will be staged and committed with the message "first commit".
1. Your code will be pushed to the newly created GitHub repo

### Publishing from the Command Palette

If your project has already been initialized for GitHub locally, you won't see the publish button in the SCM view. You can still publish your project to GitHub using the "Publish to GitHub" option in the Command Palette.

:::image type="content" source="../media/publish-command.jpg" alt-text="The Visual Studio Code Command Palette showing the Publish to GitHub option":::

The action will kick off the same workflow as the publish button in the SCM view does and has exactly the same steps. You won't be prompted for what items you want to push if your project already contains a `.gitignore`.
