There are some terms to know that will help you understand and complete the contribution process. It’s not necessary to know everything that happens under the hood, but a general overview of how contributing works helps you understand why the process works the way it does.
  
## Microsoft Learn and GitHub fundamentals

Microsoft Learn contains thousands of articles, training modules, web pages, and more, which need to be stored and regularly accessed by various contributors. Microsoft Learn uses GitHub to store much of this content. GitHub is a platform that uses Git, a distributed version-control system, to store projects and facilitate collaboration across multiple stakeholders with different project goals and timelines. Git and GitHub software enables you to work in parallel with other contributors on the same project, potentially the exact same content, even at the same time, without unintentionally interfering with others’ work.

Content is stored in files in Git *repositories* (repos) hosted on GitHub. A repository is a storage unit that contains a project’s files and file revision history. Repositories can be public or private, and Microsoft Learn is made up of a mix of both. Anyone can contribute to a public repository once they’ve set up a GitHub account. Private repositories are only available to contributors who are Microsoft employees or who have been given special permission. 

## Make edits to Microsoft Learn content stored in a GitHub repository

For any project, GitHub hosts the main repository and any *forks*. A fork is a copy of the main repo that a contributor makes for their own work. A fork is one of GitHub’s ways of protecting the published content. Instead of directly editing content in the live, published branch of the main repository, GitHub takes a snapshot of that content for your fork, so you can make your changes there. 

GitHub repositories contain one or more *branches*. A branch is a unit of storage that contains the files and folders that make up a project's content set. All repositories, whether it’s the main repository or a fork, contain a default branch (typically named "main") and one or more branches that are destined to be merged back into the default branch. The default branch serves as the current version and "single source of truth" for the project. It's the parent from which all other branches in the repository are created. 
 
:::image type="content" source="../media/github-branches.png" alt-text="Diagram showing a working branch off of the main branch in a GitHub repo. Changes are made in the working branch then merged back to main.":::

Editing a documentation article in a public repository may seem like it begins with the touch of a button, but there are several things happening behind the scenes. When you start the browser-based editing process, a fork of the repository is created (if you didn’t already have one) and used for your changes. You edit within a branch of your fork, which will later be *merged* to the live branch of the main repository so your changes are available for all. 
 
## Create a pull request

How does this merge happen? You need to tell GitHub - specifically, the owners of the main repository and authors of the article - that your edits are finalized and ready for review, publishing, and the world to see! To do this, you create and submit a *pull request*.

A pull request (PR) is a proposal for your changes to be merged from the branch in your fork that you were working in to the default “main” branch of the live repository. When you work in a public repository, your pull requests will always be reviewed by a human reviewer before being merged. There may also be some automated checks, such as merge compatibility and build validation. Once these reviews are completed and any issues resolved, your changes will be merged to the live branch and become available on Microsoft Learn!

## Workflow for minor contributions to documentation
 
In summary, you’ll follow these general steps when making small changes to Microsoft documentation using the web editor in GitHub:

:::image type="content" source="../media/contribution-process-overview.png" alt-text="Diagram of the contribution process for contributing to open source documentation on Microsoft Learn.":::

1. When you open a file in your browser to edit, a fork of the public repository is automatically created for you. A branch in your fork is also created, often called a patch branch. 
1. Make your changes to the file. 
1. Create a pull request to propose that your changes be reviewed and merged. 
1. Your PR must resolve any issues and pass all reviews. 
1. Your PR is merged to the main branch of the live repository and your changes are published on Microsoft Learn.

Next, let’s look at each step more closely to learn how to carry them out. 