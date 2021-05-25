In your downtime outside of your new job, you've been working on a website that hosts photos of cats. You've been using Git for version control, and it's time to invite collaborators into the project. During a pizza party at your house, your friend and fellow cat lover Alice offers to help bring your vision to fruition, and you eagerly accept.

Alice first needs to make a copy of your Git project. Then, Alice will want to send their changes to you as they make them. This situation is where Git's *distributed* nature shines. Using Git, two or more people can work together on a project without fear of overwriting the other's work. Moreover, you can check Alice's work before merging it with your work. (Alice is talented, but no developer is perfect. Trust but verify.)

In this lesson, you learn how to clone a repository (also called a *repo*) to make it available to other people. You also learn to use one of Git's most important features: pull requests.

## Clone a repository (git clone)

In Git, you copy a repo by *cloning* it using the `git clone` command. You can clone a repo no matter where it's stored, as long as you have a URL or path to point it to.

`git clone` accepts a file system path; an SSH path (for example, `git@example.com:alice/Cats`—you'll be familiar with this form if you've used Rsync or SCP); or a URL, typically one that starts with `file:`, `git:`, or `ssh`. The various forms are described in the documentation for `git clone`. In Unix and Linux, the cloning operation uses hard links, so it's fast and uses minimal space because only the directory entries need to be copied, not the files.

## Remote repositories (git pull)

When Git clones a repository, it creates a reference to the original repo that's called a *remote* by using the name `origin`. It sets up the cloned repo so that the cloned repo will *pull* from, or retrieve data from, the remote repository. (Git also can *push*. You'll learn about pushing in Git later in this module.) `origin` is the default location for Git to pull changes from and push changes to. `git pull` copies changes from the remote repository to the local one. The `git pull` command is very efficient because it copies only *new* commits and objects, and then it checks them into your working tree.

You pull from `origin` by using the `git pull` command. It's useful to compare `git pull` with other methods of copying files. The `scp` command copies everything. (`scp` is similar to the Unix `cp` command, except that the files being copied don't have to be on the same computer.) If there are 10,000 files in the remote directory, `scp` copies them all. A more efficient program called Rsync looks at every file in the local and remote directories and copies only the ones that are different. Rsync often is used for making backups, but it still has to hash every file unless the files have different sizes or creation dates.

Git looks only at commits. It already knows the last commit that it got from the remote repository because it saved the list of commits. Then, Git tells the computer that it's copying from to send everything that changed, including the new commits and the objects they point to. Those commits and objects are bundled up in a file called a *pack* and sent over in one batch. Finally, Git updates the working tree by unpacking all the objects that changed and merging them (if necessary) with the commits and objects in the working tree.

Git pulls or pushes only when you tell it to. That's different from, say, Dropbox, which has to ask the operating system to notify it of any changes you make in its folder and occasionally ask the server whether anyone else has made changes.

## Create pull requests (git request-pull)

After another developer, like Alice, has cloned your repo and made some changes locally, they will want to incorporate those changes back into the original repo. It might seem like pushing those changes to the original repo is the right approach. However, a push to the original repo would fail because other users don't have permission to make changes to your repo. And that's as it should be. For now, you want to review incoming changes before merging them into the main code base.

For now, Alice will have to submit a *pull request* to ask you to pull their changes into the main code base. Alice can do that by using `git request-pull`, which might look like this example:

```bash
git request-pull -p origin/main .
```

Alice refers to the `main` branch on the `origin` remote as `origin/main`.

This pull request is essentially the same thing as a pull request on GitHub (GitHub is a place to store code, which we don't cover in this module). A pull request gives you a chance to review other collaborators' changes before you incorporate their work into the work you're doing on the website. Code reviews are an important part—some would say the most important part—of collaborative programming.

## Create a remote (git remote) and complete the pull request (git pull)

As a project owner, you need to know how to merge pull requests. First, you use the `git remote` command to set up another developer's repo as a *remote*. Then, you use that remote for pulls and pull requests by using the `git pull` command.

Behind the scenes, `git pull` is a combination of two simpler operations: `git fetch`, which gets the changes, and `git merge`, which merges those changes into your repository. In this case, the merge was *fast-forward*, meaning that Alice had your latest commit in their repository, so their commit could be added to the front of your history without any modification.
