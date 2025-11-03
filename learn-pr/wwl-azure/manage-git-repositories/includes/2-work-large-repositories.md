Git is an excellent version control system that many teams use. However, when repositories get very large, you need to use special techniques to keep them working well.

When you have a local copy of a repository on your computer, this usually works great. But when repositories become huge, this can cause problems.

For example, Microsoft found this issue when they moved a repository with over 300 GB of data from their internal system to Git.

## Why repositories become large

There are two main reasons why repositories grow large:

- **Long history** - Many years of changes and commits
- **Large binary files** - Images, videos, or other big files

## Shallow clone

If you don't need all the history in your local repository, you can use a shallow clone. This saves space on your computer and makes syncing faster.

You can choose how much history you want to download:

```DOS
git clone --depth [depth] [clone-url]

```

You can also reduce the download size by filtering branches or cloning only one branch.

## VFS for Git

VFS for Git helps you work with large repositories. It needs a Git LFS client to work.

Your normal Git commands work the same way, but Git LFS works behind the scenes to download files only when you need them from the server.

The Git LFS client is open-source. It uses a simple protocol with four endpoints that work like REST endpoints.

For more information on large repositories, see: [Working with large files](https://docs.github.com/repositories/working-with-files/managing-large-files) and [Virtual File System for Git: Enable Git at Enterprise Scale](https://github.com/microsoft/VFSForGit).

## Scalar

:::image type="content" source="../media/scalar-5d38de1c.png" alt-text="Screenshot of Scalar icon.":::

Scalar is a .NET Core application that works on Windows and macOS. It gives you tools and extensions for Git that help very large repositories work faster. Microsoft uses it for their Windows and Office repositories.

If Azure Repos hosts your repository, you can clone it using the [GVFS protocol](https://github.com/microsoft/VFSForGit/blob/master/Protocol.md#the-gvfs-protocol-v1).

Scalar works by turning on these advanced Git features:

- **Partial clone** - Gets a working repository faster by not downloading all Git objects immediately
- **Background prefetch** - Downloads Git object data from all remotes every hour, making git fetch calls faster
- **Sparse-checkout** - Makes your working directory smaller by only including files you need
- **File system monitor** - Tracks recently changed files so Git doesn't have to scan your entire work tree
- **Commit-graph** - Makes commit walks and reachability calculations faster, speeding up commands like git log
- **Multi-pack-index** - Enables fast object lookups across many pack files
- **Incremental repack** - Repacks Git data into fewer pack files without disrupting other commands

> [!NOTE]
> We update the list of features that Scalar automatically sets up as new Git versions are released.

For more information, see:

- [microsoft/scalar: Scalar](https://github.com/microsoft/scalar/)
- [Introducing Scalar: Git at scale for everyone](https://devblogs.microsoft.com/devops/introducing-scalar/)
