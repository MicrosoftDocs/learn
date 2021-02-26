<!-- Guidance on writing the opening to a content/conceptual unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

Once you have authenticated to GitHub, Visual Studio will be able to improve your GitHub workflow. One of those improvements is the ability to push (also known as publishing) a local project straight to GitHub with a single click. 

<!-- 

See here for general guidance on content units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-structure-learning-content?branch=master

-->

## What is publishing?

If you're starting with a local project in Visual Studio, the process to get it up in GitHub is a number of steps:

1. Create a repository on GitHub.com.
2. Copy the remote endpoint.
3. Initialize your repository locally.
4. Add the remote endpoint.
5. Add a .gitignore file.
6. Add a .gitattributes file.
7. Stage project files.
8. Commit project files.
9. Push to the remote repository. 

Visual Studio has built-in functionality that fully automates this process for you.

## Creating a Git repository

When Visual Studio initializes your repository, it first executes a _git init_ command. This creates a .git subdirectory at the root of your project, which contains all of the necessary Git metadata for the new repository. Besides the .git folder, Visual Studio will not alter anything else in your project with the initialization. 

## Adding .gitignore and .gitattributes files - the first commit

After intializing, Visual Studio creates the first commit to add the .gitignore and .gitattributes files to your new repository. 

### The .gitignore file

Not every file created or updated in your code should be committed to Git. Temporary files from your development environment, test outputs, and logs are all examples of files that you create but aren't part of your codebase.

Visual Studio creates a basic .gitignore file for you with custom content tailored to the Visual Studio development environment. You can see Visual Studio's Ignore file in GitHub's collection of .gitignore file templates. There are different types of .gitignore file templates there based on the type of project you are creating. 
https://github.com/github/gitignore/blob/master/VisualStudio.gitignore

### The .gitattributes file

The .gitattributes file helps Git understand file types in your repository better. It is an optional but important file that Visual Studio creates for you using its own custom configuration.

The most important part of the .gitattributes file is _* text=auto_, which sets the default behavior to automatically normalize line endings. With this, the repository is explicit on text handling so that everyone using the repository is following the same set of rules. In addition, the .gitattributes file sets common image formats as binary and common merge drivers for Visual Studio extensions.

## Adding project files - the second commit

With the second commit, Visual Studio adds all the files in your project to the repository. This includes all the non-hidden files under the root of your project directory and its subdirectories.

## Pushing to GitHub

Through the 'Create a repository' dialog in Visual Studio, you can create a repository and push to GitHub at the same time. In the default **GitHub** tab, you can specify which account and owner the new GitHub repository is attributed to. Since you've already signed in to GitHub, these fields should be populated by default. 

The repository on GitHub has two primary metadata fields - the name and description. The name is a required field and is defaulted to your local project name. But you can change this to be any alphanumeric word. If you add spaces to the name, Visual Studio will substitute those spaces with a '-'. The repository description is optional, but is useful to explain to others what the purpose of your project is. 

All GitHub repositories created through Visual Studio are set to private by default. This means that only you can view the repository and commit to it. You can add contributors to private repositories and manage access via the repository's Settings page on GitHub.com. Toggling off the checkbox switches the repository to public. This means that anyone on the internet can view your repository and its contents on GitHub.com. But you can still choose who can contribute to it directly. 

Apart from pushing to GitHub, you can push to any other remote endpoint using the **Existing remote** tab. You can also use the **Local only** tab to initialize the Git repository locally. In this case, Visual Studio just adds the .git folder and doesn't make any commits.