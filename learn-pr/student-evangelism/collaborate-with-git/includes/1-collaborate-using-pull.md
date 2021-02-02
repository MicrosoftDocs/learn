You've been working on a Web site for cat pictures on your own, using Git for version control. It's time to invite collaborators onto the project. During a pizza party at your house, your friend and fellow cat-lover Alice offers to help bring your vision to fruition, and you eagerly agree. Alice needs to make a copy of your project, and she will want to send her changes to you as she makes them.

This situation is where Git's _distributed_ nature comes in. It permits two or more people to work together on a project without fear of overwriting one another's work. Moreover, it allows you to check Alice's work before merging it with yours. Alice is talented, but no developer is perfect. Trust but verify.

In this lesson, you learn how to clone a repository to make it available to other people. You also learn to use one of Git's most important features: pull requests.

## Cloning a repository with `git clone`

The proper way to copy a repo is to *clone* it with the `git clone` command. You can clone a repo stored anywhere, as long as you have a URL or path to point it to.

`git clone` accepts a file-system path, an SSH path (for example, `git@example.com:alice/Cats` — you'll be familiar with this form if you've used `rsync` or `scp`); or a URL, typically starting with `file:`, `git:`, or `ssh`. The various types are described in the documentation for `git clone`. On Unix and Linux, the cloning operation uses hard links, which are fast and takes up minimal space because only the directory entries need to be copied, not the files.

## Remote repositories and `git pull`

When Git clones a repository, it creates a reference to the original repo called a _remote_, with the name "origin," and sets it up so that it will _pull_, or take data from, from the remote repository. (Git can also "push"; you'll learn about that in another lesson.) Origin is the default location for Git to pull changes from and push changes to. Pull, specifically, copies changes from the remote repository to the local one. It's very efficient because it only copies _new_ commits and objects, and then checks them into your working tree.

You pull from origin with the `git pull` command. It's useful to compare `git pull` with other methods of copying files. The `scp` command (which is like the Unix `cp` command except that the files being copied don't have to be on the same computer) copies everything. If there are 10,000 files in the remote directory, `scp` copies them all. A more efficient program called `rsync` looks at every file in the local and remote directories, and only copies the ones that are different. It's often used for making backups, but `rsync` still has to hash every file unless they have different sizes or creation dates.

Git only has to look at commits. It already knows (because it saved the list) the last commit that it got from the remote repository. It then tells the computer from which it's copying to send everything that changed: the new commits and the objects they point to. Those commits and objects get bundled up in a file called a _pack_ and sent over in one batch. Finally, Git updates the working tree by unpacking all the objects that changed, and merging them (if necessary) with the ones in the working tree.

Git only pulls or pushes when you tell it to. That's different from, say, Dropbox, which has to ask the operating system to notify it of any changes you make in its folder, and occasionally ask the server whether anyone else has made changes.

## Create pull requests with the `git request-pull` command

Once another developer, like Alice, has cloned your repo and made some changes locally, they will want to incorporate those changes back into the original repo. It may seem like pushing those changes to the original repo is the right approach. However, a push to the original repo would fail because other users don't have permission to modify your repo. And that's as it should be. For now, you want to review incoming changes before folding them into the main code base.

For now, Alice would have to submit a *pull request* asking you to pull her changes. Alice can do that with `git request-pull`, which might look like this:

```bash
git request-pull -p origin/main .
```

`origin/main` is Alice's way of referring to the "main" branch on the "origin" remote.

This pull request is essentially the same thing as a pull request on GitHub - which is a place to store code, that we do not cover in this module. A pull request gives you a chance to review others' changes before you incorporate their work into the Web site. Code reviews are an important part — some would say the most important part — of collaborative programming.

## Create a remote with `git remote` and complete the pull request with `git pull`

As a project owner, you need to know how to merge in pull requests. The way to do that using just Git is to set up the other developer's repo as a _remote_ using the `git remote` command. You will then use that remote for pulls and pull requests, accomplished with the `git pull` command.

Behind the scenes, `git pull` is a combination of two simpler operations: `git fetch`, which gets the changes, and `git merge`, which merges those changes into your repository. In this case, the merge was _fast-forward_, meaning that Alice had your latest commit in her repository, so her commit could be added to the front of your history without any modification.
