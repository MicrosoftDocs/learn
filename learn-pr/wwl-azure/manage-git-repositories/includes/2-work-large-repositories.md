Git is a great version control system widely adopted and recommended, but a few concerns should be made and taken care of when working with large repositories.

While having a local copy of repositories in a distributed version control system is functional, that can be a significant problem when large repositories are in place.

For example, Microsoft discovered this issue when migrating a repository with over 300 GB of data from an internal system to Git.

## Why repositories become large

There are two primary causes for large repositories:

 -  Long history
 -  Large binary files

## Shallow clone

If developers don't need all the available history in their local repositories, a good option is to implement a shallow clone.

It saves both space on local development systems and the time it takes to sync.

You can specify the depth of the clone that you want to execute:

```DOS
git clone --depth [depth] [clone-url]

```

You can also reduce clones by filtering branches or cloning only a single branch.

## VFS for Git

VFS for Git helps with large repositories. It requires a Git LFS client.

Typical Git commands are unaffected, but the Git LFS works with the standard filesystem to download necessary files in the background when you need files from the server.

The Git LFS client was released as open-source. The protocol is a straightforward one with four endpoints similar to REST endpoints.

For more information on large repositories, see: [Working with large files](https://docs.github.com/repositories/working-with-files/managing-large-files) and [Virtual File System for Git: Enable Git at Enterprise Scale](https://github.com/microsoft/VFSForGit).

## Scalar

:::image type="content" source="../media/scalar-5d38de1c.png" alt-text="Screenshot of Scalar icon.":::


Scalar is a .NET Core application available for Windows and macOS. With tools and extensions for Git to allow very large repositories to maximize your Git command performance. Microsoft uses it for Windows and Office repositories.

If Azure Repos hosts your repository, you can clone a repository using the [GVFS protocol](https://github.com/microsoft/VFSForGit/blob/master/Protocol.md#the-gvfs-protocol-v1).

It achieves by enabling some advanced Git features, such as:

 -  *Partial clone:* reduces time to get a working repository by not downloading all Git objects right away.
 -  *Background prefetch:* downloads Git object data from all remotes every hour, reducing the time for foreground git fetch calls.
 -  *Sparse-checkout:* limits the size of your working directory.
 -  *File system monitor:* tracks the recently modified files and eliminates the need for Git to scan the entire work tree.
 -  *Commit-graph:* accelerates commit walks and reachability calculations, speeding up commands like git log.
 -  *Multi-pack-index:* enables fast object lookups across many pack files.
 -  *Incremental repack:* Repacks the packed Git data into fewer pack files without disrupting concurrent commands using the multi-pack-index.

> [!NOTE]
> We update the list of features that Scalar automatically configures as a new Git version is released.

For more information, see:

 -  [microsoft/scalar: Scalar](https://github.com/microsoft/scalar/).
 -  [Introducing Scalar: Git at scale for everyone](https://devblogs.microsoft.com/devops/introducing-scalar/).
