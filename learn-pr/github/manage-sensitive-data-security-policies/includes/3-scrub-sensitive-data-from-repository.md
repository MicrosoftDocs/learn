<!--Manage sensitive data and security policies in GitHub-->

As a GitHub organization administrator, you may need to remove, or *scrub*, sensitive data from a repository. You may also need to take additional security steps, like changing security policies in response to an incident.

You may remember from the scenario in the introduction that some of the most stressful and risky problems can involve sensitive data appearing in the code base. As you administer a new project with unfamiliar collaborators, you know that it is important to prevent these kinds of security risks from happening as much as possible. You also know that these problems will happen sooner or later, and it is important to be prepared, in order to minimize time spent resolving the issue and up-front costs (like paying a ransomware actor).

In this unit, you'll learn about the tools to help prevent committing sensitive data. You'll also learn what to do if there is a security breach, and how to evaluate potential changes to security policies.

## Tools to avoid committing sensitive data

You know that your new software build will need to authenticate with external services in order to test functions. This could lead to the most common type of accidental commission of sensitive data: including login credentials in the code base. 

This section discusses the best way to deal with interactions between sensitive data and your code base: prevention. Prevention is key, because it can form part of a routine, and your team can *automate* routines.

It's possible to automate this process with freely available pre-commit hooks (scripts that Git executes prior to the commit event) that scan for sensitive data.

:::image type="content" source="../media/pre-commit-hooks.png" alt-text="A flowchart of pre-commit hooks from code edit to commit.":::

Some of the most popular pre-commit hooks that serve this purpose include:

- Gitleaks
- pre-commit plugins
  - `detect-aws-credentials`
  - `detect-private-key`
  - `secrets_filename`

## Scrub the repository

This section explains the two primary methods for removing unwanted files from a repository's history: the `git filter-repo` command and the BFG Repo-Cleaner open source tool. It also covers what GitHub support technicians can do if you determine that high-risk data has made its way into a repository.

Suppose a collaborator was testing the software build's interactions with an external service, but the service required an unforeseen method of authentication. What if the user accidentally included credentials in the code base that pre-commit hooks weren't prepared to catch? You would need to take action.

> [!Note]
> Whether you choose `git filter-repo` or the BFG to remove sensitive data from a repository, 
> a user that pushes a commit to GitHub containing sensitive data has already crossed an important 
> line; the organization should consider that data to be compromised, and change it immediately. 

Both `git filter-repo` and the BFG have tradeoffs. `git filter-repo` is powerful, allowing the removal of passwords or renaming of specific files or file sets. However, its syntax is complex and it has strong risk of creating unforeseen problems in a repository's integrity, especially if you're running the Windows operating system. In contrast, the BFG Repo-Cleaner open source tool is extremely efficient and easy to use, because it provides you with a set of default actions to choose from that match many common use cases related to sensitive data. However, the BFG tool is limited in its capabilities to these use cases, giving you little opportunity to customize for unusual circumstances.

[The following material appears in the GitHub Doc "Removing sensitive data from a repository."](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)

The `git filter-repo` command and the BFG Repo-Cleaner rewrite your repository's history, which changes the SHAs for existing commits that you alter and any dependent commits. Changed commit SHAs may affect open pull requests in your repository. We recommend merging or closing all open pull requests before removing files from your repository.

You can remove the file from the latest commit with `git rm`. 

### Use the BFG Repo-Cleaner tool

To remove your file with sensitive data and leave your latest commit untouched, run:

```shell
$ bfg --delete-files YOUR-FILE-WITH-SENSITIVE-DATA
```

To replace all text listed in `passwords.txt` wherever it can be found in your repository's history, run:

```shell
$ bfg --replace-text passwords.txt
```

After the sensitive data is removed, you must force push your changes to GitHub.

```shell
$ git push --force
```

See the [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)'s documentation for full usage and download instructions.

### Use git filter-repo tool

> [!Warning]
> If you run `git filter-repo` after stashing changes, you won't be
> able to retrieve your changes with other stash commands. Before
> running `git filter-repo`, we recommend unstashing any changes
> you've made. To unstash the last set of changes you've stashed,
> run `git stash show -p | git apply -R`

To illustrate how `git filter-repo` works, we'll show you how to remove your file with sensitive data from the history of your repository and add it to `.gitignore` to ensure that it is not accidentally re-committed.

1. Install the latest release of the [git filter-repo](https://github.com/newren/git-filter-repo) tool. You can install `git-filter-repo` manually or by using a package manager. For example, to install the tool with HomeBrew, use the `brew install` command.

    `brew install git-filter-repo`

    For more information, see [INSTALL.md](https://github.com/newren/git-filter-repo/blob/main/INSTALL.md) in the `newren/git-filter-repo` repository.

2. If you don't already have a local copy of your repository with sensitive data in its history, [clone the repository](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository) to your local computer.

    ```
    $ git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
    > Initialized empty Git repository in /Users/YOUR-FILE-PATH/YOUR-REPOSITORY/.git/
    > remote: Counting objects: 1301, done.
    > remote: Compressing objects: 100% (769/769), done.
    > remote: Total 1301 (delta 724), reused 910 (delta 522)
    > Receiving objects: 100% (1301/1301), 164.39 KiB, done.
    > Resolving deltas: 100% (724/724), done.
    ```

3. Navigate into the repository's working directory.

    `$ cd YOUR-REPOSITORY`

4. Run the following command, replacing `PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA` with the path to the file you want to remove, not just its filename. These arguments will:

    - Force Git to process, but not check out, the entire history of every branch and tag
    - Remove the specified file, as well as any empty commits generated as a result
    - Remove some configurations, such as the remote URL, stored in the .git/config file. You may want to back up this file in advance for restoration later.
    - Overwrite your existing tags

    ```
    $ git filter-repo --invert-paths --path PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA
      Parsed 197 commits
      New history written in 0.11 seconds; now repacking/cleaning...
      Repacking your repo and cleaning out old unneeded objects
      Enumerating objects: 210, done.
      Counting objects: 100% (210/210), done.
      Delta compression using up to 12 threads
      Compressing objects: 100% (127/127), done.
      Writing objects: 100% (210/210), done.
      Building bitmaps: 100% (48/48), done.
      Total 210 (delta 98), reused 144 (delta 75), pack-reused 0
      Completely finished after 0.64 seconds.
    ```

    > [!Note]
    > If the file with sensitive data used to exist at any other 
    > paths (because it was moved or renamed), you must run this 
    > command on those paths, as well.

5. Add your file with sensitive data to `.gitignore` to ensure that you don't accidentally commit it again.

    ```
    $ echo "YOUR-FILE-WITH-SENSITIVE-DATA" >> .gitignore
    $ git add .gitignore
    $ git commit -m "Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore"
    > [main 051452f] Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore
    >  1 files changed, 1 insertions(+), 0 deletions(-)
    ```

6. Double-check that you've removed everything you wanted to from your repository's history, and that all of your branches are checked out.

7. Once you're happy with the state of your repository, force-push your local changes to overwrite your GitHub repository, as well as all the branches you've pushed up:

    ```
    $ git push origin --force --all
    > Counting objects: 1074, done.
    > Delta compression using 2 threads.
    > Compressing objects: 100% (677/677), done.
    > Writing objects: 100% (1058/1058), 148.85 KiB, done.
    > Total 1058 (delta 590), reused 602 (delta 378)
    > To https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
    >  + 48dc599...051452f main -> main (forced update)
    ```

8. In order to remove the sensitive file from [your tagged releases](https://docs.github.com/en/github/administering-a-repository/releasing-projects-on-github/about-releases), you'll also need to force-push against your Git tags:

    ```
    $ git push origin --force --tags
    > Counting objects: 321, done.
    > Delta compression using up to 8 threads.
    > Compressing objects: 100% (166/166), done.
    > Writing objects: 100% (321/321), 331.74 KiB | 0 bytes/s, done.
    > Total 321 (delta 124), reused 269 (delta 108)
    > To https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
    >  + 48dc599...051452f main -> main (forced update)
    ```

### Request help from GitHub support

GitHub support technicians can assist you in removing confidential information that poses a security risk to you or your organization from a repository that you or another organization owns. For instance, you might have removed access credentials from your organization's repository, but you need to make sure they don't appear in forks of that repository (you should also change the access credentials to invalidate them as soon as possible).

#### Private information removal requests are appropriate for:

- Access credentials, such as user names combined with passwords, access tokens, or other sensitive secrets that can grant access to your organization's server, network, or domain.
- AWS tokens and other similar access credentials that grant access to a third party on your behalf. You must be able to show that the token does belong to you.
- Documentation (such as network diagrams or architecture) that poses a specific security risk for an organization.
- [Information](https://docs.github.com/en/github/site-policy/github-community-guidelines#doxxing-and-invasion-of-privacy) related to, and posing a security risk to, you as an individual (such as social security numbers or other government identification numbers).

GitHub needs you to fulfill other conditions before asking for the help of support technicians.

- **Ask Nicely First.** When your request to support will affect a repository your organization doesn't own, get in touch with the repository's owner to ask them to remove the data.
- **No Bots.** You should have a trained professional evaluate the facts of every request you send. No party making requests of this type to GitHub support should use automated bots, whether they're direct representatives of your organization or third parties to which you have outsourced the handling of these requests.
- **Send In The Correct Request.** This process works best when you only send requests related to the types of private information listed above, and when they're the only requests from you that GitHub is handling at the time.
- **Processing Time.** If you make a request to GitHub to remove private information, please be patient and send only one request for each discrete issue.

#### Request requirements

When you're ready to make your request, assemble the following information.

1. A working, clickable link to each file containing private information. (Note that we're not able to work from search results, examples, or screenshots.)
2. Specific line numbers within each file containing the private information.
3. A brief description of how each item you've identified poses a security risk to you or your organization. **It is important that you provide an explanation of how the data poses a security risk beyond merely stating that it does.**
4. If you are a third party acting as an agent for an organization facing a security risk, include a statement that you have a legal right to act on behalf of that organization.
5. OPTIONAL: Let us know if your request is particularly urgent, and why. We respond to all private information removal requests as quickly as possible. However, if this request is especially time-sensitive, such as a very recent credential exposure, please explain why.
