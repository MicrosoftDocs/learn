There are three common objections I often hear to migrating to Git:

 -  I can overwrite history.
 -  I have large files.
 -  There is a steep learning curve.

## Overwriting history

Git technically does allow you to overwrite history - but like any helpful feature, if misused can cause conflicts.

If your teams are careful, they should never have to overwrite history.

If you are synchronizing to Azure Repos, you can also add a security rule that prevents developers from overwriting history by using the explicit "Force Push" permissions.

Every source control system works best when developers understand how it works and which conventions work.

While you cannot overwrite history with Team Foundation Version Control (TFVC), you can still overwrite code and do other painful things.

## Large files

Git works best with repos that are small and do not contain large files (or binaries).

Every time you (or your build machines) clone the repo, they get the entire repo with its history from the first commit.

It is great for most situations but can be frustrating if you have large files.

Binary files are even worse because Git cannot optimize how they are stored.

That is why [Git LFS](https://git-lfs.github.com/) was created.

It lets you separate large files of your repos and still has all the benefits of versioning and comparing.

Also, if you are used to storing compiled binaries in your source repos, stop!

Use [Azure Artifacts](https://azure.microsoft.com/services/devops/artifacts/) or some other package management tool to store binaries for which you have source code.

However, teams with large files (like 3D models or other assets) can use Git LFS to keep the code repo slim and trimmed.

## Learning curve

There is a learning curve. If you have never used source control before, you are probably better off when learning Git. I have found that users of centralized source control (TFVC or SubVersion) battle initially to make the mental shift, especially around branches and synchronizing.

Once developers understand how Git branches work and get over the fact that they must commit and then push, they have all the basics they need to succeed in Git.
