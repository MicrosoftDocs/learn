There are different types of version control systems (VCS), but generally they can be categorized as centralized and distributed. In recent years (partially due to the growing popularity of DevOps), the latter category gained significant popularity, with Git becoming the de facto standard in modern software development. This particular VCS would be the most suitable choice for the organization in our sample scenario, especially considering its intention to use GitHub as the target platform for its DevOps transition. In this unit, explore the use of Git as version control.

:::image type="content" source="../media/3-distributed-centralized.png" alt-text="Screenshot of a table comparing centralized and distributed version control systems benefits.":::

## Centralized vs. Distributed Version Control

Both centralized version control systems (CVCS) and distributed version control systems (DVCS) offer the ability to manage and track changes in software development projects. The primary differences between them are related to the way they implement repositories and collaboration. In particular:

- **Repository location**: In centralized systems, there's a single, centralized instance of the repository containing the full history of the project. In distributed systems, each team member would typically have one, fully functional local copy of the entire repository, potentially including its full version history.
- **Network connectivity**: In centralized systems, access to the centralized instance of the repository is required to perform many actions, including updates and history retrieval. In distributed systems, all activities can be performed against the local copy of the repository.
- **Collaborative model**: In centralized systems, developers check out files from the centralized instance of the repository while connected to it over a network before making modifications and committing the changes. This prevents changes to be checked out files by others. In distributed systems, developers make and commit changes to their local copy of the repository, which, at some point later, are synchronized with other copies.
- **Branching and merging model**: In centralized systems, branching and merging typically requires coordination with others. In distributed systems, branches can be created independently in local copies and merged afterwards.

It's worth noting that, while the distributed model doesn't rely on having a central repository (in the traditional sense), it's common to implement one copy of the repository, which is hosted by services such as GitHub, GitLab, or Bitbucket. This instance serves as the focal point of collaboration and synchronization.

:::image type="content" source="../media/3-centralized-distributed.png" alt-text="Screenshot of centralized and distributed version control systems repositories and collaboration.":::

## Git terminology

In order to become proficient in working with Git, it's important to become familiar with its terminology. Some of the concepts are unique to Git, distinguishing it from other DVCS. The most fundamental Git terms include:

- **Working tree**: a directory structure that contains all of the project's files.
- **Repository** (commonly referred to as **repo**): the directory located at the top level of a working tree, hosting all of the project's files along with the version history of these files.
- **Clone**: the action of creating a copy of a remote repository on a local machine to work on a project to which you have access.
- **Fork**:  the action of creating a GitHub-hosted copy of a remote repository to work on a project to which you don't have access. A fork is typically used if you intend to contribute to someone else's project or create your own version of such project. While you don't have write access to the original repository, you can fully manage your fork.
- **Commit**: a snapshot of the changes made to the files in a repository at a specific point in time. Commits are used to record and save changes.
- **Staging area** an intermediate location (which isn't part of the repository) where changes to files in the working tree are prepared before they're committed. It allows developers to select changes they intend to commit.
- **Branch**: a named series of linked commits. In simple terms, a branch represents a distinct version of a project. This enables working on different parts of a project at the same time without affecting its main version. The most recent commit within a branch is called the *head*. The default branch generated automatically when you initialize a repository is called *main* or *master*.
- **Merge**: the process of combining changes from one branch (or commit) into another. This integrates changes from one branch into another.
- **Object**: one of four types of entities available in a repo. These entities include *blobs* representing individual files, a *tree* representing a working tree, a *commit* representing a specific version of the working tree, and a *tag, which is a label assigned to an individual commit.
- **Hash**: an automatically generated, unique, fixed-length identifier that represents the contents of an object. Whenever that object changes, its hash changes as well. This allows Git to determine which content within a repo has been updated.
- **Remote**: a reference to another repository (other than the local one), typically pointing to the service-hosted instance of the repo. This serves as the default for push and pull operations.
- **Pull**: the action that fetches changes from a remote repository and merges them into the current branch.
- **Push**: the action that sends local commits to a remote repository, updating it with the changes made locally.
- **Fetch**: the action that retrieves changes from a remote repository without automatically merging them. This allows for their review before applying a merge.
- **Pull request**:  a feature in Git-based hosting platforms (such as GitHub) that allows developers to propose changes and request for them to be merged into a target branch.

Git also has an extensive set of commands, which provide the ability to fully implement and manage version control through command shell such as Linux Bash or Windows Command Prompt. Alternatively, you can manage Git through desktop applications such as GitHub Desktop. Git-based hosting platforms provide a web interface that facilitates interaction with service-side repositories.

## Git vs. GitHub

As described earlier, Git is a multi-platform, open-source DVCS that facilitates collaboration by using local repositories, which can be synchronized with remote repositories. GitHub is a cloud-based service that provides a hosting platform for Git repositories. It extends the range of Git capabilities by including support for:

- **Remote repositories**: facilitating interaction among distributed teams.
- **Collaboration tools**: delivering such features as issues, discussions, pull requests, notifications, labels, actions, forks, wikis, and projects.
- **Web-based interface**: minimizing the need to use Git commands
- **Branch protection**: enforcing conditions that must be satisfied before a merge can take place (such as, for example, completed pull request reviews).
