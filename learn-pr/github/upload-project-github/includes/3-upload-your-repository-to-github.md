You can import repositories to GitHub using GitHub Importer, the command line, or external migration tools.

### About GitHub Importer

If you have source code in Subversion, Mercurial, Team Foundation Version Control (TFVC), or another Git repository, you can move it to GitHub using GitHub Importer. GitHub Importer is a tool that quickly imports source code repositories, including commits and revision history, to GitHub for you.

During an import, depending on the version-control system you're importing from, you can perform some of the following tasks.
Authenticate with your remote repository, update commit author attribution, import repositories with large files, or remove large files if you don't want to use Git Large File Storage.

<!--StartFragment-->

| Import Action | Subversion | Mercurial | TFVC | Git |
| ---- | ---- | ---- | ---- | ---- |
| Authenticate with remote repository | X | X | X | X |
| Update commit author attribution | X | X | X |  |
| Move large files to Git Large File Storage | X | X | X |  |
| Remove large files from your repository | X | X | X |  |

<!--EndFragment-->

### Importing a repository with GitHub Importer

If you have a project hosted on another version control system, you can automatically import it to GitHub using the GitHub Importer tool. GitHub Importer isn't suitable for all imports. For example, if your existing code is hosted on a private network, our tool isn't able to access it. In these cases, we recommend importing using the command line for Git repositories or an external source-code migration tool for projects imported from other version-control systems.

If you'd like to match the commits in your repository to the authors' GitHub user accounts during the import. First, make sure that every contributor to your repository has a GitHub account before you begin the import.

Repositories and individual files are subject to size limits. For more information, check out [About large files on GitHub](https://docs.github.com/repositories/working-with-files/managing-large-files/about-large-files-on-github).

Follow these steps to import a repository:

1. In the upper-right corner of any page, select **+**, and then select **Import repository**.

    :::image type="content" source="../media/1-import-repository.png" alt-text="Screenshot of the import repository button.":::

2. Under "Your old repository's clone URL," type the URL of the project you want to import.

    :::image type="content" source="../media/2-import-url.png" alt-text="Screenshot of the old repository URL textbox.":::

3. Choose your user account or an organization to own the repository, then type a name for the repository on GitHub.

    :::image type="content" source="../media/3-import-repo-owner-name.png" alt-text="Screenshot of the new import repository owner name.":::

4. Specify whether the new repository should be public or private. For more information, check out [Setting repository visibility.](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility)

    :::image type="content" source="../media/4-import-public-or-private.png" alt-text="Screenshot of the new repository public or private options.":::

5. Review the information you entered, then select **Begin import**.

    :::image type="content" source="../media/5-begin-import-button.png" alt-text="Screenshot of the begin import button for a new repository import.":::

6. If your old project was protected by a password, type your sign-in information for that project, then select **Submit**.

    :::image type="content" source="../media/6-submit-old-credentials-importer.png" alt-text="Screenshot of the location to input your old repository credentials importer.":::

7. If there are multiple projects hosted at your old project's clone URL, choose the project you'd like to import, then select **Submit**.

    :::image type="content" source="../media/7-choose-project-importer.png" alt-text="Screenshot of a selection of projects found at the same URL. project importer.":::

8. If your project contains files larger than 100 MB, choose whether to import the large files using [Git Large File Storage](https://docs.github.com/repositories/working-with-files/managing-large-files), then select **Continue**.

    :::image type="content" source="../media/8-select-git-lfs-importer.png" alt-text="Screenshot of files suitable for Git LFS importer.":::

When the repository is fully imported, you receive an email.

### Updating commit author attribution with GitHub Importer

During an import, you can match commits in your repository with the GitHub account of the commit author. GitHub Importer looks for GitHub users whose email addresses match the authors of the commits in the repository you're importing. You can then connect a commit to its author using their email address or the author's GitHub username.

#### Updating commit authors

Follow these steps to update a commit author:

1. After importing your repository, on the import status page, select **Match authors**.

    :::image type="content" source="../media/1-match-authors-button.png" alt-text="Screenshot of the match authors button.":::

1. Next to the author whose information you'd like to update, select **Connect**.

    :::image type="content" source="../media/2-connect-commit-author.png" alt-text="Screenshot of the connect commit author process.":::

1. Type the email address or GitHub username of the author, then press **Enter**.

#### Attributing commits to a GitHub user with a public email address

If an author of a commit in your imported repository has a GitHub account associated with the email address they used to author the commits, and they don't [set their commit email address as private](https://docs.github.com/account-and-profile/setting-up-and-managing-your-github-user-account/managing-email-preferences/setting-your-commit-email-address). Then, GitHub Importer matches the email address associated with the commit to the public email address associated with their GitHub account, and attributes the commit to their GitHub account.

#### Attributing commits to a GitHub user without a public email address

If the author of a commit in your imported repository doesn't set a public email address on their GitHub profile, or [set their commit email address as private](https://docs.github.com/account-and-profile/setting-up-and-managing-your-github-user-account/managing-email-preferences/setting-your-commit-email-address). Then, GitHub Importer might not be able to match the email address associated with the commit with their GitHub account.

The commit author can resolve this issue by setting their email address as private. Their commits are then attributed to `<username>@users.noreply.github.com`, and the imported commits are associated with their GitHub account.

#### Attributing commits using an email address

If the author's email address isn't associated with their GitHub account, they can [add the address to their account](https://docs.github.com/account-and-profile/setting-up-and-managing-your-github-user-account/managing-email-preferences/adding-an-email-address-to-your-github-account) after the import, and the commits will be correctly attributed.

If the author doesn't have a GitHub account, GitHub Importer attributes their commits to the email address associated with the commits.

### Importing a GitHub repository using the command line 

If [GitHub Importer](https://docs.github.com/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer) isn't suitable for your purposes, such as if your existing code is hosted on a private network, then we recommend importing using the command line.

Before you start, make sure you know:

- Your GitHub username
- The clone URL for the external repository, such as `https://external-host.com/user/repo.git` or `git://external-host.com/user/repo.git` (perhaps with a `user@` in front of the `external-host.com` domain name)

For purposes of demonstration, we use:

- An external account named *ext-user*
- An external Git host named `https://external-host.com`
- A GitHub personal user account named ghuser
- A repository on GitHub.com named repo.git

Follow these steps to import your external repository:

1. [Create a new repository on GitHub.](https://docs.github.com/repositories/creating-and-managing-repositories/creating-a-new-repository) You import your external Git repository to this new repository.

1. On the command line, make a "bare" clone of the repository using the external clone URL. This command creates a full copy of the data, but without a working directory for editing files, and ensures a clean, fresh export of all the old data.

    ```bash
    $ git clone --bare https://external-host.com/ext-user/repo.git
    #Makes a bare clone of the external repository in a local directory 
    ```

1. Push the locally cloned repository to GitHub using the "mirror" option, which ensures that all references, such as branches and tags, are copied to the imported repository.

    ```bash
    $ cd repo.git
    $ git push --mirror https://github.com/ghuser/repo.git
    #Pushes the mirror to the new repository on GitHub.com 
    ```

1. Remove the temporary local repository.

    ```bash
    $ cd ..
    $ rm -rf repo.git 
    ```

### Adding locally hosted code to GitHub

If you have existing source code or repositories stored locally on your computer or private network, you can add them to GitHub by typing commands in a terminal. Either by typing Git commands directly, or by using GitHub CLI.

GitHub CLI is an open source tool for using GitHub from your computer's command line. GitHub CLI can simplify the process of adding an existing project to GitHub using the command line. To learn more about GitHub CLI, check out [About GitHub CLI.](https://docs.github.com/github-cli/github-cli/about-github-cli)

#### Adding a local repository to GitHub with GitHub CLI

Follow these steps to add a local repository with GitHub CLI:

1. In the command line, navigate to the root directory of your project.

1. Initialize the local directory as a Git repository.

    ```bash
    git init -b main
    ```

1. Stage and commit all the files in your project.

    ```bash
    git add . && git commit -m "initial commit"
    ```

1. To create a repository for your project on GitHub, use the `gh repo create subcommand`. When prompted, select **Push an existing local repository to GitHub** and enter the desired name for your repository. If you want your project to belong to an organization instead of your user account, specify the organization name and project name with `organization-name/project-name`.

1. Follow the interactive prompts. To add the remote and push the repository, confirm **yes** when asked to add the remote and push the commits to the current branch.

1. Alternatively, to skip all the prompts, supply the path to the repository with the `--source` flag and pass a visibility flag (`--public`, `--private`, or `--internal`). For example, `gh repo create --source=. --public`. Specify a remote with the `--remote` flag. To push your commits, pass the `--push` flag. For more information about possible arguments, reference the [GitHub CLI manual.](https://cli.github.com/manual/gh_repo_create)

#### Adding a local repository to GitHub using Git

Follow these steps to add a local repository using Git:

1. [Create a new repository](https://docs.github.com/repositories/creating-and-managing-repositories/creating-a-new-repository) on GitHub.com. To avoid errors, don't initialize the new repository with README, license, or `gitignore files`. You can add these files after your project is pushed to GitHub.

   :::image type="content" source="../media/1-repo-create.png" alt-text="Screenshot of new repository creation.":::

1. Open Git Bash.

1. Change the current working directory to your local project.

1. Initialize the local directory as a Git repository.

    ```bash
    $ git init -b main
    ```

1. Add the files in your new local repository. This command also stages them for the first commit.

    ```bash
    $ git add .
    # Adds the files in the local repository and stages them for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.
    ```

1. Commit the files that are staged in your local repository.

    ```bash
    $ git commit -m "First commit"
    # Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.
    ```

1. At the top of your repository on GitHub.com's Quick Setup page, select the **Copy** button to copy the remote repository URL.

    :::image type="content" source="../media/7-copy-remote-repository-url-quick-setup.png" alt-text="screenshot copy remote repository url quick setup":::

1. In the Command prompt, [add the URL for the remote repository](https://docs.github.com/get-started/getting-started-with-git/managing-remote-repositories). Your local repository is pushed to this location.

    ```bash
    $ git remote add origin <REMOTE_URL> 
    # Sets the new remote
    $ git remote -v
    # Verifies the new remote URL
    ```

1. [Push the changes](https://docs.github.com/get-started/using-git/pushing-commits-to-a-remote-repository) in your local repository to GitHub.com.

    ```bash
    $ git push origin main
    # Pushes the changes in your local repository up to the remote repository you specified as the origin
    ```

### Source code migration tools 

You can use external tools to move your projects to GitHub. We recommend using [GitHub Importer](https://docs.github.com/get-started/importing-your-projects-to-github/importing-source-code-to-github/about-github-importer) to import projects from Subversion, Mercurial, Team Foundation Version Control (TFVC), or another Git repository. You can also use these external tools to convert your project to Git.

#### Importing from Subversion

In a typical Subversion environment, multiple projects are stored in a single root repository. On GitHub, each of these projects typically map to a separate Git repository for a user account or organization. We suggest importing each part of your Subversion repository to a separate GitHub repository if:

- Collaborators need to check out or commit to that part of the project separately from the other parts
- You want different parts to have their own access permissions

We recommend these tools for converting Subversion repositories to Git:

- [git-svn](https://git-scm.com/docs/git-svn)
- [svn2git](https://github.com/nirvdrum/svn2git)

#### Importing from Mercurial

We recommend [hg-fast-export](https://github.com/frej/fast-export) for converting Mercurial repositories to Git.

#### Importing from TFVC

We recommend [git-tfs](https://github.com/git-tfs/git-tfs) for moving changes between TFVC and Git.

For more information about moving from TFVC (a centralized version control system) to Git, see [Migrate to Git from centralized version control](/devops/develop/git/centralized-to-git).
