Version control tools like Git give you the ability to track and manage changes to your files as you work. You can store multiple versions of the same file, and view the history of the changes you've made. Git is one of the most popular version control tools. In this unit, you'll learn about Git and how it can help when you are writing and working with Bicep code.

## What are version control and Git?

Version control is a practice by which you maintain a history of changes to your files. Many different version control systems exist, but generally they have a few core features:

- Track the changes you make to a file.
- View the history of a file, and go back to an older version if you need to revert a change you've made.
- Work with multiple versions of a file at the same time.

Most version control systems work with all file types, but they're optimized for text files.

Git is an open-source version control system. By using Git, you create _repositories_ that maintain history and track changes. You can use different repositories for each project, or you might choose to use a single repository for all your Bicep code.

## How does Git help with your Bicep code?

Bicep code is maintained in text files, so it's a great fit for many version control systems. Version control helps a lot with some common scenarios you likely face as you write your Bicep code, such as:

- TODO scenario - making changes and needing to undo
- TODO collaborating
- TODO branching - e.g. making a major change but needing to deploy the current template at the same time

## Local and remote repositories

Git is a _distributed_ version control system, which means you can have multiple copies of your Git repository across different computers and servers. This makes Git an excellent choice for collaborating with team members to share and write your Bicep code together, and also means that you can use automated deployment pipelines to access your files from a Git repository.

In this module, we'll focus on local Git repositories, where you're the only person using them. In a future module, you'll learn about how you can distribute your Git repository and work collaboratively by using GitHub and Azure Repos.

## Tools to work with Git

In this module, you'll use two tools to work with your Git repository: Visual Studio Code and Git.

### Visual Studio Code

Visual Studio Code is a text editor for Windows, macOS, and Linux. It provides a lot of powerful features to work with Bicep code, as well as other source code and text files. For example, by installing the [Bicep extension for Visual Studio Code](TODO), you get a great editing experience for Bicep with auto-complete, IntelliSense, and suggestions for how your code can be improved.

You can write Bicep code using another text editor if you want, but Visual Studio Code is a great choice because it has Bicep support and it integrates with Git.

### Git tool

Git is based on a command-line tool, and most of the documentation and examples you'll find online use the Git command-line interface (CLI). However, in this module, we'll use Visual Studio Code to work with Git.

> [!TIP]
> When your use of Git matures, you'll likely need to learn some basic CLI commands. Later in this module we link to some good resources to continue your exploration of Git and its many advanced features.

You need to install Git separately to Visual Studio Code. You'll see how to do this in the next unit. Once you install Git, Visual Studio Code detects it and enables its Git integration automatically.
