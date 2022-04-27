Git is a great version control system and widely adopted, but it has limitations. One of the long-standing issues has related to large repositories.

While having a local copy of repositories in a distributed version control system is functional, that can be a significant problem when large repositories are in place.

For example, Microsoft discovered this issue when migrating a repository with over 300 GB of data from an internal system to Git.

## Why repositories become large

There are two primary causes for large repositories:

 -  Long history
 -  Large binary files

## Shallow clone

If developers don't need all the available history in their local repositories, a good option is to implement a shallow clone.

It saves both spaces on local development systems and the time it takes to sync.

You can specify the depth of the clone that you want to execute:

```DOS
git clone --depth [depth] [clone-url]

```

You can also reduce clones by filtering branches or cloning only a single branch.

## VFS for Git

VFS for Git helps with large repositories. It requires a Git LFS client.

Typical Git commands are unaffected, but the Git LFS works with the standard filesystem to download necessary files in the background when you need files from the server.

The Git LFS client was released as open-source. The protocol is a straightforward one with four endpoints similar to REST endpoints.

For more information on large repositories, see: [Working with large files](https://docs.github.com/repositories/working-with-files/managing-large-files), and [Virtual File System for Git: Enable Git at Enterprise Scale](https://github.com/microsoft/VFSForGit).
