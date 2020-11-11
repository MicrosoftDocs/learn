As a Visual Studio Code user who has authenticated to GitHub, you'll get some improvements to your workflow that are enabled by the editor. One of those is the ability to "publish" a project from your machine directly to GitHub.

## What is publishing?

If you're starting with a new project that you haven't pushed to GitHub yet, the process for _getting_ it up on GitHub looks something like this...

1. Create a GitHub repo on github.com
1. Copy the remote endpoint
1. Run `git init` locally
1. Add the remote endopint
1. Specify which items to push into GitHub with a .gitignore
1. Stage files
1. Add a commit message
1. Push to the repo

It can be even more complex than that sometimes if you initialize your repository with a README. This will put your repo in a state where you have "unrelated histories" and you can't push your code.

In short, it's a lot of steps. Visual Studio Code has a built-in "publish" feature that fully automates this process and allows you to do it right from Visual Studio Code.

## Publishing to GitHub from Visual Studio Code

There are two ways to publish a project to GitHub from VS Code - from the Source Control Management View (SCM View) and from the Command Palette. You must have a folder open in Visual Studio Code to see these options.

### Publishing from the SCM View

If you have not already initialized a repository for your project, you can publish your project directly from the SCM View.

The SCM View can be toggled in Visual Studio Code by selecting the SCM icon in the Visual Studio Code activity bar. You'll see a button that says "Publish to GitHub".

:::image type="content" source="../media/scm-publish.jpg" alt-text="The SCM publish view":::

Clicking this button will initialize the publish process...

1. Specify the name of the repository to create on GitHub.
1. Specify which files should be pushed to GitHub.
   1. Any files that you do not select to be included in the publish will automatically be added to a `.gitignore` file which is created during the publish process.
1. Your code will be staged and committed with the message "first commit".
1. Your code will be pushed to the newly created GitHub repo

### Publishing from the Command Palette

If your project has already been initialized for GitHub locally, you won't see the publish button in the SCM view. In that case, you can still publish your project to GitHub using the "Publish to GitHub" option in the Command Palette.

:::image type="content" source="../media/publish-command.jpg" alt-text="The publish to github command":::

The action will kick off the same workflow as the publish button in the SCM view does and has exactly the same steps, with the exception that you will not be prompted for what items you want to push if your project already contains a .gitignore.

In the next exercise, you'll publish a local project to GitHub and see the workflow in action for yourself.
