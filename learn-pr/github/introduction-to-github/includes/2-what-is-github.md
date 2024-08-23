In this unit, we review the following learning objectives:

- Brief overview of the GitHub Enterprise Platform
- How to create a repository
- Adding files to a repository
- How to search for repositories
- Introduction to gists and wikis

## GitHub

:::image type="content" source="../media/github-enterprise-platform.png" alt-text="A conceptual image of the GitHub Platform with layers from top to bottom: AI, Collaboration, Productivity, Security, and Scale." border="false":::

**GitHub** is a cloud-based platform that uses Git, a distributed version control system, at its core. The GitHub platform simplifies the process of collaborating on projects and provides a website, command-line tools, and overall flow that allows developers and users to work together.

As we learned earlier GitHub provides an AI powered developer platform to build, scale, and deliver secure software. Let’s break down each one of the core pillars of the GitHub Enterprise platform, AI, Collaboration, Productivity, Security and Scale. 

### AI

Generative AI is dramatically transforming software development as we speak. 

The GitHub Enterprise platform is enhancing collaboration through AI-powered pull requests and issues, productivity through Copilot, and security by automating security checks faster.

### Collaboration

Collaboration is at the core of everything GitHub does. We know inefficient collaboration results in wasted time and money. We counteract that with a suite of seamless tools that allow collaboration to happen effortlessly.

Repositories, Issues, Pull Requests, and other tools help to enable developers, project managers, operation leaders, and others at the same company to work faster together, cut down approval times, and ship more quickly.

### Productivity

Productivity is accelerated with automation that the GitHub Enterprise Platform provides. With built-in CI/CD tools directly integrated into the workflow, the platform gives users the ability to set tasks and forget them, taking care of routine administration, and speeding up day-to-day work. This gives your developers more time to focus on what matters most: creating innovative solutions. 

### Security

GitHub focuses on integrating security directly into the development process from the start. GitHub Enterprise platform includes native, first-party security features that minimize security risk with a built-in security solution. Plus, your code remains private within your organization, and at the same time you are able to take advantage of security overview and Dependabot. 

GitHub has continued to make investments to ensure that our features are enterprise-ready. We’re backed by Microsoft, trusted by highly regulated industries, and meet compliance requirements globally.

### Scale

GitHub is the largest developer community of its kind. With real-time data on over 100M+ developers, 330M+ repositories, and countless deployments, we’ve been able to understand the shifting needs of developers and make changes to our product to match. 

This has translated into an incredible scale that is unmatched and unparalleled by any other company on the planet. Everyday we are gaining more and more insights from this impressive community and evolving the platform to meet their needs. 

In essence the GitHub Enterprise Platform focuses on the developer experience–it has the scale to provide industry-changing insights, collaboration capabilities for transformative efficiency, the tools for increased productivity, security at every step, and AI to power it all to new heights in a single, integrated platform.

Now let’s get into the backbone of GitHub, repositories.

## Introduction to repositories

Let’s first review:

- What is a repository?
- How to create a repository
- Adding files to a repository
- How to search for repositories
- Introduction to gists, wikis, and GitHub pages

### What is a repository?

A repository contains all of your project's files and each file's revision history. It is one of the essential parts that helps you collaborate with people. You can use repositories to manage your work, track changes, store revision history and work with others. Before we dive too deep, let’s first start with how to create a repository. 

### How to create a repository

You can create a new repository on your personal account or any organization where you have sufficient permissions.

Let’s tackle creating a repository from github.com. 

1. In the upper-right corner of any page, use the drop-down menu, and select **New repository**.

    :::image type="content" source="../media/2-new-repo-option.png" alt-text="A screenshot of the drop-down menu of the plus sign in the top right corner of GitHub.com, with the first option being New repository." border="false":::

1. Use the **Owner** drop-down menu to select the account you want to own the repository.

    :::image type="content" source="../media/2-selecting-repo-owner.png" alt-text="A screenshot of the drop-down menu of who should be the owner of the new repository." border="false":::

1. Type a name for your repository, and an optional description.

    :::image type="content" source="../media/2-repo-name-text-box.png" alt-text="An image of the text box of the repository name highlighted." border="false":::

1. Choose a repository visibility.

    - **Public repositories** are accessible to everyone on the internet.

    - **Private repositories** are only accessible to you, people you explicitly share access with, and, for organization repositories, certain organization members.

1. Select **Create repository** and congratulations! You just created a repository!

Next up, let’s review how to add files to your repository.

### How to add a file to your repository

Files in GitHub can do a handful of things, but the main purpose of files is to store data and information about your project.

Let’s review how to add a file to your repository. 

But before we begin, it is worth knowing in order to add a file to a repository you must first have minimum **Write** access within the repository you want to add a file. 

1. On GitHub.com, navigate to the main page of the repository.
1. In your repository, browse to the folder where you want to create a file.
1. Above the list of files, select the Add file ᐁ drop-down menu, then select **Create new file**. You might also have a **Get started by creating a new file** link. Alternatively, you can select the **plus** icon (**+**) in the file tree view on the left.

    :::image type="content" source="../media/add-file-options.png" alt-text="A screenshot of the two options of adding a file to your new repository highlighted in red. One option is the plus sign in the left hand navigation bar, the second option is the add file button towards the right of the screen." border="false":::

1. In the file name field, type the name and extension for the file. To create subdirectories, type the / directory separator.
1. In the file contents text box, type content for the file.
1. To review the new content, above the file contents, select **Preview**.

    :::image type="content" source="../media/2-preview-option-in-a-file.png" alt-text="Screenshot showing a yml file with the preview button highlighted in the top left." border="false":::

1. Select **Commit changes**.
1. In the **Commit message** field, type a short, meaningful commit message that describes the change you made to the file. You can attribute the commit to more than one author in the commit message.
1. If you have more than one email address associated with your account on GitHub.com, select the email address drop-down menu and select the email address to use as the Git author email address. Only verified email addresses appear in this drop-down menu. If you enabled email address privacy, then [username]@users.noreply.github.com is the default commit author email address.

    :::image type="content" source="../media/2-commit-description-box.png" alt-text="Screenshot showing a commit change with a description box and the drop-down menu of the email to select as the author of the commit." border="false":::

1. Below the **Commit message** fields, decide whether to add your commit to the current branch or to a new branch. If your current branch is the default branch, you should choose to create a new branch for your commit and then create a pull request.

     :::image type="content" source="../media/2-create-a-new-branch.png" alt-text="Screenshot showing creating a new branch from a commit option select with the textbox of the new branch below it." border="false":::

1. Select **Commit changes** or **Propose changes**.

Congratulations, you just created a new file in your repository! You have also created a new branch and made a commit!

But before we review branches and commits in the next unit, let’s quickly review gists, wikis, and GitHub pages because they are similar to repositories. 

### What are gists

Now that we have a good understanding of repositories, we can review gists. Similarly to repositories, gists are a simplified way to share code snippets with others. 

Every gist is a Git repository, which you can fork and clone and can be either public or secret. 

Public gists are displayed publicly where people can browse new ones as they’re created. Public gists are also searchable. 

Conversely, secret gists are not searchable, but they aren’t entirely private. If you send the URL of a secret gist to a friend, they'll be able to see it.

To learn more about gists see the linked article in our Resources section at the end of this module titled, Creating Gists. 

### What are wikis?

Every repository on GitHub.com comes equipped with a section for hosting documentation, called a wiki. 

You can use your repository's wiki to share long-form content about your project, such as how to use it, how you designed it, or its core principles. 

While a README file quickly tells what your project can do, you can use a wiki to provide additional documentation. 

It’s worth a reminder that if your repository is private only people who have at least read access to your repository will have access to your wiki. 
