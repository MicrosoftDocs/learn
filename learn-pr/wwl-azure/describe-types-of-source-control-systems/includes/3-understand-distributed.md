:::image type="content" source="../media/distributed-strengths-best-used-143d1739.png" alt-text="Strengths are cross platform, open source, offline support, and history. Best used for small codebases, evolving open course, distributed teams, and Greenfield projects.":::


Over time, so-called "distributed" source control or version control systems (DVCS for short) have become the most important. The three most popular are Git, Mercurial, and Bazaar.

These systems do not necessarily rely on a central server to store all the versions of a project's files.

Instead, every developer "clones" a copy of a repository and has the project's complete history on their hard drive.

This copy (or "clone") has all the metadata of the original.

This method may sound wasteful, but in practice, it is not a problem. Most programming projects consist primarily of plain text files (and maybe a few images).

The disk space is so cheap that storing many copies of a file does not create a noticeable dent in a hard drive's free space. Modern systems also compress the files to use even less space.

The act of getting new changes from a repository is called "pulling."

The act of moving your changes to a repository is called "pushing."

In both cases, you move changesets (changes to file groups as coherent wholes), not single-file diffs.

One common misconception about distributed version control systems is that there cannot be a central project repository. It is not true. Nothing is stopping you from saying, "this copy of the project is the authoritative one."

It means that instead of a central repository required by the tools you use, it is now optional.

## Advantages over centralized source control

The act of cloning an entire repository gives distributed source control tools several advantages over centralized systems:

 -  Doing actions other than pushing and pulling changesets is fast because the tool only needs to access the hard drive, not a remote server.
 -  Committing new changesets can be done locally without anyone else seeing them. Once you have a group of changesets ready, you can push all of them at once.
 -  Everything but pushing and pulling can be done without an internet connection. So, you can work on a plane, and you will not be forced to commit several bug fixes as one large changeset.
 -  Since each programmer has a full copy of the project repository, they can share changes with one or two other people to get some feedback before showing the changes to everyone.

## Disadvantages compared to centralized source control

There are almost no disadvantages to using a distributed source control system over a centralized one.

Distributed systems do not prevent you from having a single "central" repository; they provide more options on top of it.

There are only two major inherent disadvantages to using a distributed system:

 -  If your project contains many large, binary files that cannot be efficiently compressed, the space needed to store all versions of these files can accumulate quickly.
 -  If your project has a long history (50,000 changesets or more), downloading the entire history can take an impractical amount of time and disk space.
