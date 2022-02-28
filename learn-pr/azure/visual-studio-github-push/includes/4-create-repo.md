After you've authenticated to GitHub, Visual Studio can improve your GitHub workflow. One of those improvements is the ability to push (also known as publishing) a local project straight to GitHub with a single click.

## What is publishing?

If you're starting with a local project in Visual Studio, the process to put it in GitHub has many steps:

:::image type="content" source="../media/4-create-repo-steps.png" alt-text="Flow diagram that depicts steps for creating a repository.":::

1. Create a repository on GitHub.com.
2. Copy the remote endpoint.
3. Initialize your repository locally.
4. Add the remote endpoint.
5. Add a .gitignore file.
6. Add a .gitattributes file.
7. Stage project files.
8. Commit project files.
9. Push to the remote repository.
10. Verify success.

Visual Studio has built-in functionality that fully automates this process for you.

## Creating a Git repository

When Visual Studio initializes your repository, it first runs a `git init` command. The operation creates a .git subdirectory at the root of your project, which contains all the necessary Git metadata for the new repository. Besides the .git folder, Visual Studio won't alter anything in your project with the initialization.

## Adding .gitignore and .gitattributes files: the first commit

After Visual Studio initializes your repository, it creates the first commit to add the .gitignore and .gitattributes files to the repository.

### The .gitignore file

Not every file created or updated in your code should be committed to Git. Temporary files from your development environment, test outputs, and logs are all examples of files that you create but aren't part of your codebase.

Visual Studio creates a basic .gitignore file for you with custom content tailored to the Visual Studio development environment. You can see the Visual Studio Ignore file in [GitHub's collection of .gitignore file templates](https://github.com/github/gitignore/blob/master/VisualStudio.gitignore). You can use different types of .gitignore file templates, based on the type of project you're creating.

### The .gitattributes file

The .gitattributes file helps Git better understand file types in your repository. It's an optional but important file that Visual Studio creates for you by using its own custom configuration.

The most important line of the .gitattributes file is `* text=auto`, which sets the default behavior to automatically normalize line endings. With this line, the repository is explicit on text handling so that everyone who uses the repository is following the same set of rules. The .gitattributes file also sets common image formats as binary and common merge drivers for Visual Studio extensions.

## Adding project files: the second commit

With the second commit, Visual Studio adds all the files in your project to the repository. The commit includes all the non-hidden files under the root of your project directory and its subdirectories.

## Pushing to GitHub

Through the **Create a repository** dialog in Visual Studio, you can create a repository and push to GitHub at the same time. On the default **GitHub** tab, you can specify which account and owner the new GitHub repository is attributed to. Because you've already signed in to GitHub, these fields should be populated by default.

The repository on GitHub has two primary metadata fields: name and description. The name is a required field and is your local project name by default. You can change the name to be any alphanumeric word. If you add spaces to the name, Visual Studio will replace those spaces with a dash (`-`). The repository description is optional but is useful to explain to others what the purpose of your project is.

All GitHub repositories created through Visual Studio are set to private by default. That means only you can view the repository and commit to it. To change this setting, add contributors to private repositories and manage access via the repository's **Settings** page on GitHub.com. Clearing the checkbox switches the repository to public, which allows anyone on the internet to view your repository and its contents on GitHub.com. But you can still choose who can contribute to it directly.

Apart from pushing to GitHub, you can push to any remote endpoint (such as Azure DevOps) by using the **Existing remote** tab. You can also use the **Local only** tab to initialize the Git repository locally. In the latter case, Visual Studio just adds the .git folder and doesn't make any commits.
