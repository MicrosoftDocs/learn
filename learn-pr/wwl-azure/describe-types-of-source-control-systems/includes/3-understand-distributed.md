:::image type="content" source="../media/distributed-strengths-best-used-143d1739.png" alt-text="Strengths are cross platform, open source, offline support, and history. Best used for small codebases, evolving open course, distributed teams, and Greenfield projects.":::


Over time, so-called "distributed" source control or version control systems (DVCS for short) have become the most important.

The three most popular are Git, Mercurial, and Bazaar. These systems don't necessarily rely on a central server to store all the versions of a project's files. Instead, every developer "clones" a repository copy and has the project's complete history on their local storage. This copy (or "clone") has all the original metadata.

This method may sound wasteful but it isn't a problem in practice. Most programming projects consist primarily of plain text files (maybe a few images).

The disk space is so cheap that storing many copies of a file doesn't create a noticeable dent in a local storage free space. Modern systems also compress the files to use even less space; for example, objects (and deltas) are stored compressed, and text files used in programming compress well (around 60% of original size, or 40% reduction in size from compression).

Getting new changes from a repository is called "pulling." Moving your changes to a repository is called "pushing." You move changesets (changes to file groups as coherent wholes), not single-file diffs.

One common misconception about distributed version control systems is that there can't be a central project repository. It isn't true. Nothing stops you from saying, "this copy of the project is the authoritative one."

It means that instead of a central repository required by your tools, it's now optional.

## Advantages over centralized source control

The act of cloning an entire repository gives distributed source control tools several advantages over centralized systems:

 -  Doing actions other than pushing and pulling changesets is fast because the tool only needs to access the local storage, not a remote server.
 -  Committing new changesets can be done locally without anyone else seeing them. Once you have a group of changesets ready, you can push all of them at once.
 -  Everything but pushing and pulling can be done without an internet connection. So, you can work on a plane, and you won't be forced to commit several bug fixes as one large changeset.
 -  Since each programmer has a full copy of the project repository, they can share changes with one, or two other people to get feedback before showing the changes to everyone.

## Disadvantages compared to centralized source control

There are almost no disadvantages to using a distributed source control system over a centralized one.

Distributed systems don't prevent you from having a single "central" repository; they provide more options.

There are only two major inherent disadvantages to using a distributed system:

 -  If your project contains many large, binary files that can't be efficiently compressed, the space needed to store all versions of these files can accumulate quickly.
 -  If your project has a long history (50,000 changesets or more), downloading the entire history can take an impractical amount of time and disk space.
