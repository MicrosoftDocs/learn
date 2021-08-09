Version control tools like Git give you the ability to track and manage changes to your files as you work. You can store multiple versions of the same file, view the history of the changes you've made, and collaborate with others. 

Git is one of the most popular version control tools. In this unit, you'll learn about Git and how it can help when you're writing and working with Bicep code.

## What are version control and Git?

Version control is a practice by which you maintain a history of changes to your files. Many different version control systems exist, but generally they have a few core features:

- Track the changes you make to a file.
- View the history of a file, and go back to an older version if you need to revert a change you've made.
- Work with multiple versions of a file at the same time.
- Collaborate with other team members by sharing your code and changes.

Most version control systems work with all file types, but they're optimized for text files.

> [!NOTE]
> Version control is also sometimes called source code management, or SCM.

Git is an open-source version control system. By using Git, you create _repositories_ that maintain history and track changes. You can use different repositories for each project, or you might choose to use a single repository for all your Bicep code.

## How does Git help with your Bicep code?

Bicep code is maintained in text files, so it's a good fit for many version control systems. Version control helps with common scenarios that you likely face as you write your Bicep code, such as:

- When you make changes to your Bicep files, you often need to undo a change or view the history of a file to see the changes you've made in the past. You could make copies of each file as you change them, but this quickly gets difficult to manage. Git provides features to keep track of your changes to each file.
- You need to make a major change to a Bicep file, which takes some time to prepare and test. At the same time, you need to access the current _known good_ version of the Bicep file so you can continue to deploy it. Git provides features for _branching_ and _merging_ so you can work with multiple versions of a file and quickly switch between them.
- You work with other people on your team who make changes to your Bicep code. You need to track who makes each change. If two changes conflict with each other, you need to have a process to resolve the conflicts. Git provides powerful collaboration features.

## Where is each repository?

Git is a _distributed_ version control system, which means you can have multiple copies of your Git repository across computers and servers. This makes Git an excellent choice for collaborating with team members to share and write your Bicep code together. 

You use online services like GitHub and Azure Repos to work with your team on shared code. By using these services, you can also start to build automated deployment pipelines. You'll learn about those pipelines in a future module.

## How does Git work with folders?

A Git repository is represented as a folder on your computer. When you work with the repository, it's just like working with any other folder with files in it. You can view and edit the files by using any tools you want, although in this module you'll use Visual Studio Code.

Git stores some metadata about the repository in a special hidden folder within your repository's folder. When you first create a repository, you need to _initialize_ the repository to create the metadata. After that, you work with the folder as normal. Git's tools help you maintain the versions of the files in the repository. You'll learn more about Git's commands throughout this module.

## What tools will I need?

In this module, you'll use two tools to work with your Git repository: Visual Studio Code and Git.

### Visual Studio Code

Visual Studio Code is a text editor for Windows, macOS, and Linux. It provides features to work with Bicep code, along with other source code and text files. For example, by installing the [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), you get an editing experience for Bicep that includes autocomplete, IntelliSense, and suggestions for how your code can be improved.

You can write Bicep code by using another text editor if you want, but Visual Studio Code is a great choice because it has Bicep support and it integrates with Git.

### Git

Git is based on a command-line tool, and most of the documentation and examples you'll find online use the Git command-line interface (CLI). In this module, we'll use a mixture of CLI commands and Visual Studio Code to work with Git. Whichever tool you use, you work with the same underlying Git repository.

> [!TIP]
> As your use of Git matures, you'll need to learn some more advanced Git CLI commands. Later in this module, we link to some resources to continue your exploration of Git and its many advanced features.

You need to install Git separately from Visual Studio Code. You'll see how to do this in the next unit. After you install Git, Visual Studio Code detects it and enables its Git integration automatically.
