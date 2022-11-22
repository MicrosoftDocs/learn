While one of the benefits of Git is its ability to hold long histories for repositories efficiently, there are times when you need to purge data.

The most common situations are where you want to:

 -  Significantly reduce the size of a repository by removing history.
 -  Remove a large file that was accidentally uploaded.
 -  Remove a sensitive file that shouldn't have been uploaded.

If you commit sensitive data (for example, password, key) to Git, it can be removed from history. Two tools are commonly used:

## git filter-repo tool

The git filter-repo is a tool for rewriting history.

Its core filter-repo contains a library for creating history rewriting tools. Users with specialized needs can quickly create entirely new history rewriting tools.

> [!NOTE]
> More details are in the repository [git-filter-repo](https://github.com/newren/git-filter-repo).

## BFG Repo-Cleaner

BFG Repo-Cleaner is a commonly used open-source tool for deleting or "fixing" content in repositories. It's easier to use than the git filter-branch command. For a single file or set of files, use the **--delete-files** option:

```Bash
$ bfg --delete-files file_I_should_not_have_committed

```

The following bash shows how to find all the places that a file called passwords.txt exists in the repository. Also, to replace all the text in it, you can execute the **--replace-text** option:

```Bash
$ bfg --replace-text passwords.txt

```

For more information, see:

[Quickly rewrite git repository history](https://github.com/newren/git-filter-repo/).

[Removing files from Git Large File Storage](https://docs.github.com/repositories/working-with-files/managing-large-files/removing-files-from-git-large-file-storage).

[Removing sensitive data from a repository](https://docs.github.com/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository).

[BFG Repo Cleaner](https://rtyley.github.io/bfg-repo-cleaner).
