In this unit, we review the following learning objectives:

- Brief overview of the GitHub Enterprise Platform
- How to create a repository
- Adding files to a repository
- How to search for repositories
- Introduction to gists and wikis

## GitHub

:::image type="content" source="../media/github-enterprise-platform.png" alt-text="A conceptual image of the GitHub Platform with layers from top to bottom: AI, Collaboration, Productivity, Security, and Scale." border="false":::

**GitHub** is a cloud-based platform that uses Git, a distributed version control system, at its core. The GitHub platform simplifies the process of collaborating on projects and provides a website, command-line tools, and overall flow that allows developers and users to work together.

As we learned earlier, GitHub provides an AI powered developer platform to build, scale, and deliver secure software. Let’s break down each one of the core pillars of the GitHub Enterprise platform, AI, Collaboration, Productivity, Security, and Scale.

### AI

Generative AI is dramatically transforming software development as we speak. The GitHub Enterprise platform is enhancing collaboration through AI-powered pull requests and issues, productivity through Copilot, and security by automating security checks faster.

### Collaboration

Collaboration is at the core of everything GitHub does. We know inefficient collaboration results in wasted time and money. We counteract that with a suite of seamless tools that allow collaboration to happen effortlessly.

Repositories, Issues, Pull Requests, and other tools help to enable developers, project managers, operation leaders, and others at the same company. It enables them to work faster together, cut down approval times, and ship more quickly.

### Productivity

Productivity is accelerated with automation that the GitHub Enterprise Platform provides. With built-in CI/CD (Continuous Integration and Continuous Delivery) tools directly integrated into the workflow, the platform gives users the ability to set tasks and forget them, taking care of routine administration and speeding up day-to-day work. This gives your developers more time to focus on what matters most, creating innovative solutions.

### Security

GitHub focuses on integrating security directly into the development process from the start. GitHub Enterprise platform includes native, first-party security features that minimize security risk with a built-in security solution. Plus, your code remains private within your organization. At the same time, you're able to take advantage of security overview and Dependabot.

GitHub has continued to make investments to ensure that our features are enterprise-ready. Microsoft and highly regulated industries trust GitHub, and we meet global compliance requirements.

### Scale

GitHub is the largest developer community of its kind with real-time data on over 100M+ developers, 330M+ repositories, and countless deployments. We’ve been able to understand the shifting needs of developers and make changes to our product to match.

This has translated into an incredible scale that is unmatched and unparalleled by any other company on the planet. Everyday we're gaining more insights from this impressive community and evolving the platform to meet their needs.

In essence, the GitHub Enterprise Platform focuses on the developer experience. It has the scale to provide industry-changing insights, collaboration capabilities for transformative efficiency, the tools for increased productivity, security at every step, and AI to power it all to new heights in a single, integrated platform.

Now let’s get into the backbone of GitHub, repositories.

## Introduction to repositories

Let’s first review:

- What is a repository?
- How to create a repository
- Adding files to a repository
- How to search for repositories
- Introduction to gists, wikis, and GitHub pages

### What is a repository?

A repository contains all of your project's files and each file's revision history. It's one of the essential parts that helps you collaborate with people. You can use repositories to manage your work, track changes, store revision history, and work with others. Before we dive too deep, let’s first start with how to create a repository.

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

Files in GitHub can do a handful of things, but the main purpose of files is to store data and information about your project. It's worth knowing in order to add a file to a repository that you must first have minimum **Write** access within the repository you want to add a file.

Let’s review how to add a file to your repository.

1. On GitHub.com, navigate to the main page of the repository.
1. In your repository, browse to the folder where you want to create a file by selecting the **creating a new file** link or **uploading an existing file**.
1. Once added, above the list of files select the **Add file ᐁ** drop-down menu. Then select **Create new file**.

    :::image type="content" source="../media/add-file-options.png" alt-text="A screenshot of the option to add a file to your new repository highlighted in red with the add file button towards the right of the screen." border="false":::

1. In the file name field, type the name and extension for the file. To create subdirectories, type the **/** directory separator.
1. In the file contents text box, type **content** for the file.
1. To review the new content, above the file contents, select **Preview**.

    :::image type="content" source="../media/2-preview-option-in-a-file.png" alt-text="Screenshot showing a yml file with the preview button highlighted in the top left." border="false":::

1. Select **Commit changes**.
1. In the **Commit message** field, type a short and meaningful commit message that describes the change you made to the file. You can attribute the commit to more than one author in the commit message.
1. If you have more than one email address associated with your account on GitHub.com, select the email address drop-down menu. Then select the email address to use as the Git author email address. Only verified email addresses appear in this drop-down menu. If you enabled email address privacy, then *[username]@users.noreply.github.com* is the default commit author email address.

    :::image type="content" source="../media/2-commit-description-box.png" alt-text="Screenshot showing a commit change with a description box and the drop-down menu of the email to select as the author of the commit." border="false":::

1. Below the **Commit message** fields, decide whether to add your commit to the current branch or to a new branch. If your current branch is the default branch, you should choose to create a new branch for your commit, and then create a pull request.

     :::image type="content" source="../media/2-create-a-new-branch.png" alt-text="Screenshot showing creating a new branch from a commit option select with the textbox of the new branch below it." border="false":::

1. Select **Commit changes** or **Propose changes**.

Congratulations, you just created a new file in your repository! You have also created a new branch and made a commit.

Before we review branches and commits in the next unit, let’s quickly review gists, wikis, and GitHub pages because they're similar to repositories.

### What are gists?

Gists are a feature of GitHub that allows users to share code snippets, notes, or other small pieces of information in a lightweight and convenient way. They are essentially mini Git repositories, which means you can fork, clone, and version-control them just like a full repository. Gists are particularly useful for sharing quick solutions, configuration files, or examples without the need to create a full repository.

#### Key Features of Gists:
1. **Public and Secret Gists**:
   - **Public Gists**: These are visible to everyone and can be discovered through GitHub's search functionality. They are ideal for sharing code snippets or solutions that you want to make available to the broader community.
   - **Secret Gists**: These are not searchable or publicly listed, but they are not entirely private. Anyone with the URL can access them. They are useful for sharing code with a limited audience, such as collaborators or friends.

2. **Version Control**:
   - Every change made to a gist is tracked, allowing you to view the history of edits. This makes it easy to revert to a previous version or see how the snippet has evolved over time.

3. **Forking and Cloning**:
   - Like repositories, gists can be forked and cloned. This allows others to build upon your work or adapt it to their needs.

4. **Embedding**:
   - Gists can be embedded into websites or blogs, making them a great tool for sharing code examples in tutorials or documentation.

5. **Markdown Support**:
   - Gists support Markdown formatting, which means you can include rich text, headings, links, and even images alongside your code. This is particularly useful for adding context or explanations to your snippets.
   - Code blocks are automatically rendered with syntax highlighting, making your snippets easy to read.

6. **Collaboration**:
   - While gists are typically used for individual snippets, they can also be shared and collaborated on by multiple users. Forking and commenting on gists enable lightweight collaboration.

#### Use Cases for Gists:
- Sharing quick code examples or solutions.
- Storing configuration files or scripts for personal use.
- Creating templates for commonly used code patterns.
- Sharing error logs or debugging information with others.
- Embedding code snippets in blogs, forums, or documentation.

[!IMPORTANT]
> **Never use gists to store sensitive or confidential data, such as passwords, secrets, or API keys—even in scripts or config files.**  
> Gists are not fully private: even secret gists can be accessed by anyone with the link. Always review your content carefully before sharing.

#### Limitations of Gists:
- Gists are not entirely private, even if marked as secret. Anyone with the URL can access them, so they should not be used for sensitive or confidential information.
- They are best suited for small snippets or single files. For larger projects or multi-file structures, a full repository is more appropriate.

To learn more about how to create and manage gists, refer to the GitHub documentation in the Resources section of this module or visit the [GitHub Gists documentation](https://docs.github.com/en/github/writing-on-github/creating-gists).

### Forking and cloning gists

You can fork a gist to create a copy of someone else's gist in your account.

1. Navigate to the gist you want to fork.
2. Select **Fork** at the top-right of the gist page.

To clone a gist locally:

```bash
git clone https://gist.github.com/your-gist-id.git
```

To learn more about gists, see the linked article in our Resources section at the end of this module titled *Creating Gists*.

---

### What are wikis?

Every repository on GitHub.com comes equipped with a section for hosting documentation, called a wiki. You can use your repository's wiki to share long-form content about your project, such as how to use it, how you designed it, or its core principles. While a README file quickly tells what your project can do, you can use a wiki to provide additional documentation.

It’s worth a reminder that if your repository is private, only people who have at least read access to your repository will have access to your wiki.

### Creating, editing, and deleting wiki pages

You can use the GitHub wiki to create and manage documentation for your project.

**To create a wiki page:**

1. Navigate to the repository.
2. Select the **Wiki** tab.
3. Select **Create the first page** if no pages exist, or **New Page** to add a page.
4. Enter a title and content, then select **Save Page**.

**To edit a wiki page:**

1. Navigate to the wiki page you want to edit.
2. Select **Edit** at the top-right.
3. Make changes and select **Save Page**.

**To delete a wiki page:**

- Deleting a wiki page requires using Git. Clone the wiki repository, remove the file, and push the change.

Learn more about managing wikis in [GitHub Docs - Adding or editing wiki pages](https://docs.github.com/en/communities/documenting-your-project-with-wikis/adding-or-editing-wiki-pages).
