# Title

Introduction to using GitHub in Visual Studio Code

## Role(s)

- Developer, Student

## Level

- Beginner

## Product(s)

- Visual Studio Code, GitHub

## Prerequisites

- Git
- A basic understanding of Git concepts and commands, please see [Using Git version control tools in Visual Studio Code](https://docs.microsoft.com/en-us/learn/modules/use-git-from-vs-code/)
- Visual Studio Code
- GitHub account

## Summary

Interact with your repositories and commits on GitHub from inside Visual Studio Code.

## Learning objectives

1. Authenticate with your GitHub account to access your repositories. 
2. Clone repositories and publish new ones all from VS Code.
3. See previous commit history using the built-in Timeline view.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Sign into VS Code and publish a repo | It enables users to easily push their existing work to GitHub once they've signed into VS Code | Exercise | 1 and 2 | No |
| Search for repositories and clone one | Getting a copy of a GitHub repo locally from VS Code | Exercise | 2 | No |
| View file history from the Timeline | Gaining context on code changes | Exercise | 3 | No |

## Outline the units


1. **Introduction**

    Visual Studio Code is a lightweight and free coding editor used by many software developers around the world. GitHub is a version control platform that software developers use to host their projects. Visual Studio Code provides an integrated GitHub experience, making it easy to manage your projects from inside your coding editor. 

    Imagine that you want to start contributing to project hosted on GitHub. You would have to get a copy of the repository locally and spend time browsing the files of code and the history on GitHub to gain context of why a code change was made, who made it, and how long that code has been there for. Instead of switching between your editor and GitHub online, you can get that directly from Visual Studio Code and have a more focused experience. 
    
    In this module, you'll use the GitHub integration inside Visual Studio Code to initialize a new repository on GitHub, clone existing repositories, and gain context of each file's history - all without leaving your editor.

    By the end of this module, you will gain an introduction on how to easily start leveraging GitHub inside of Visual Studio Code.

2. **Lesson: Authenticate with your GitHub Account**

    - Authorize VS Code to gain access to your GitHub account
        - Choose which VS Code extensions can use your authenticated GitHub account. Choosing "GitHub" will enable VS Code to provide you options when you've opened a new folder or when you want to search for GitHub repositories. 
    - Initializing and publishing a repository
        - When you want to create a new Git repository, you have to first initalize it. It can take an existing folder and convert it to a Git repository or initialize an empty repository.
        - When you create a new repository on Github, it will ask you for details such as the name of the repository, if you want it to be public or private, and if you want to initalize it.
        - Because you've signed into GitHub already, when you open a folder or workspace of your project, you will see an option to "Publish to GitHub" which will initialize your Git repository and publish it to GitHub in one step.
   
3. **Exercise: Sign into VS Code with your GitHub account.**

    1. Install the latest version of VS Code.
    2. From the "account" icon on the bottom left of the Activity Bar, sign into your GitHub account.
    3. This will open a page in your browser where you can authorize VS Code. Then you will be redirected back to VS Code.

4. **Exercise: Initialize a new repository and publish it.**

    1. Create a new folder on your local computer and open it in VS Code.
    2. Add a file to this folder in VS Code.
    3. In the File Explorer view, click on "Publish Repository".
    4. Choose if you want it to be a public repository or private repository. 
    5. Choose the file you previously created. This will initalize the repo and push the files you've created with the commit "first commit". *If you do not select any files in this step, you will still have to initialize the repository after it's been created on GitHub.*
    6. You will then see a prompt to view the created repository on Github. 

5.  **Lesson: Clone a repository and gain context**

    - You can also easily search for and clone repositories
        - If you see a project on GitHub that you want to contribute to, you can clone it. Cloning a repository means to creating a local copy of the repository on your computer so that you can make changes to it. 
        - VS Code will clone over HTTPS and set up your remote repositories to point to the repository you cloned from.
    - Get context about the repository
        - When you clone a repository, you'll typically start at the README to learn about the project and then start browsing the files. You can see a history of all the commits and the commits per file, but it's a lot of clicking around.
  
6. **Exercise: Search for and clone an existing repository **

    1. Open a new window. From the Explorer View, you can click on "Clone Repository". You should see an option to clone from GitHub. 
    2. You will see a list of your repositories. You can also search for any repository on GitHub from here. Search for this *insert repository name*.
    3. Create a new terminal and enter the command `git remote -v` to confirm that VS Code set up your remote repositories branches correctly.
    4. Use `Ctrl + P` to navigate to this file *insert name of file* and open it up. You can expand the tab called "Timeline" and you should be able to see *X* number of commits. This lets you see how long ago the commits were made and by whom. Clicking on one will open a diff view so you can see all the changes associated with the commit. The Timeline updates as you browse through and open new files.

7. **Summary**

    In this module, you signed into VS Code with your GitHub account and created a new repository and were able to search for and clone existing repositories from GitHub.

## Notes

[More Git version control tips in VS Code](https://code.visualstudio.com/docs/editor/versioncontrol)

[GitHub Pull Request and Issues extension tips](https://code.visualstudio.com/docs/editor/github)
