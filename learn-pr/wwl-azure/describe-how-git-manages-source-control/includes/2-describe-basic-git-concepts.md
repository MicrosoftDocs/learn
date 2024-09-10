Git, as a version and source control technology, functions on a few basic concepts that are important to understand.

Some of the key Git concepts you should know about are:

 -  repositories
 -  distributed systems
 -  cloning and pulling
 -  branching and merging
 -  committing and pushing

## Repositories

The first concept is the repository. A repository (repo) is the top level project or folder that your code or files are organized within. It’s the same as folder structures on your computer. Just like a folder structure on your computer, you can set it up however you want, in whatever order makes the most sense for your project. For example, if you want all of the documentation in one folder, all of the code in a second folder, and media or images in a third folder, you can do that.

## Distributed systems

In some version or source control systems, all of the files reside in a central or core location and you only “check out” the file you’re working on. When you’re done working on the file, you check it back in. If you want to see the version history or any of the notes that have been made during updates, you need to check the central location for that information.

Git functions as a distributed version control system. With a distributed system, everyone connected is able to have a full and complete copy of the repo at the time they downloaded it, including the history and notes associated with it.

## Cloning and pulling

When you’re working with Git as your version and source control choice, you can either “join” an existing repo or you can create your own from scratch. If you’re working with an already existing repo, you’ll need to start by cloning the repo. Cloning the repo makes a complete and exact copy of the repo. By cloning the repo, you’ll get the structure, all of the files, and all of the history associated with the repo.

Because Git works in a distributed manner, it means that you have a complete copy of the repo from whenever you cloned it. You never need to go back to the repo if you aren’t worried about updates others may have made. However, that’s also a downside. If you don’t go back and update your copy of the repo against the source, you’ll be out of synchronization. Pulling is like cloning, but for maintaining continuity after your initial clone.

Both cloning and pulling from repositories will help you get and keep the latest versions, histories, and comments.

## Branching and merging

With a software development project, you might need to have different versions of the code available at the same time. You may need:

 -  a production or live version of the code that represents what’s currently accessible to the public.
 -  a pre-release version of the code that represents the next major update the application will get.
 -  a test version of the code where you test out new features and make updates that may never make it to a public release.
 -  a break/fix version of the code, where the only updates made to the code from the current live version are fixes for errors that come up.

With all of those versions needed, you might think you have to keep four different repositories. However, with branches, you can have all of those, and more, within the same repository. Branches let you create copies of the existing code and then branch-off to work on something that doesn’t impact the main, or live, version of the code.

Later, if you find something you want to incorporate from one of your branches back into the main version of the code, you can easily do that by “merging” the branched code back into the main code. This way you can work on a fix or new feature, and when the new feature is working and has been tested, you can merge it into the live branch and deploy the feature to the public.

Branching and merging are powerful features that let you experiment, patch, or update your code without compromising the live version until everything has been tested and is ready.

If you don't have authority to the main branch of the source repo, you may need to create a Pull Request, a Merge Request, or a Request-Pull. These requests are the same thing with different names depending on the platform you're using. They are simply a request from you, to the authority for the main branch, to incorporate your updates to the main branch.

## Committing and pushing

When you clone a repo to your computer, you’re creating a copy of all of the files, comments, and overall history of the repo. You can then make any changes you want to the files. However, when you make a change to the file, nothing about the repo actually changes. You’ve made an update to a file, but that update isn’t part of your local repo or the original repo that you initially cloned.

When you’re making changes, you can decide if you want to include those changes in your local repo or both your local repo and the original repo. If you want to keep your changes and add them to your local repo, you’ll need to commit the changes. Commit simply tells your local repo to update the file. When you commit, you’ll need to enter a comment letting anyone else who comes across your changes know what you did.

If you want to sync those changes back to the original repo, you’ll need to push the changes back to the original repo after you commit them to your local repo.

A commit saves the updates that you made to your local repo, so you can always revert back to those later. However, only people with access to your local repo will see those updates. If you’re working with other developers, any updates you commit won’t be available to them.

A push sends the committed updates back to the original repo, including any comments or metadata that you include. Any other developers using the same original repo will be able to see your updates and your comments once you complete the push.

### Remotes

You already learned that you can create your own Git repo or you can clone someone else’s repo if you want to collaborate. If you’re using a service like GitHub, it means that when everyone pushes their files, the files are stored in the cloud and safe from a compute failure. While the GitHub repo may be the repo that you initially cloned to collaborate, it’s also a remote repository.
