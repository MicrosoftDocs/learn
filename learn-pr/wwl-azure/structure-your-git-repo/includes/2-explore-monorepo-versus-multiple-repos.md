A repository is simply a place where the history of your work is stored. It often lives in a .git subdirectory of your working copy.

However, what's the best way to organize your code repository? Software development teams start with the best intentions to keep a clear separation of concerns in both the software being developed and their code repositories.

It's not uncommon for the code repositories to be bloated with unrelated code and artifacts over time.

There are two philosophies on organizing your repos: Monorepo or Multiple repos.

 -  Monorepos is a source control pattern where all the source code is kept in a single repository. It's super simple to give all your employee's access to everything in one shot. Just clone it down and done.
 -  Multiple repositories refer to organizing your projects each into their separate repository.

The fundamental difference between the monorepo and multiple repos philosophies boils down to a difference about what will allow teams working together on a system to go fastest.

The multiple repos view, in extreme form, is that if you let every subteam live in its repo.

They have the flexibility to work in their area however they want, using whatever libraries, tools, development workflow, and so on, will maximize their productivity.

The cost is that anything not developed within a given repo must be consumed as if it was a third-party library or service. It would be the same even if it were written by the person sitting one desk over.

If you find a bug in a library you use, you must fix it in the appropriate repo. Get a new artifact published, and then return to your repo to change your code.

You must deal with a different code base, various libraries, and tools, or even a different workflow in the other repo.

Or maybe you must ask someone who owns that system to make the change for you and wait for them to get around to it.

The monorepo view the friction, especially when dealing with more complicated dependency graphs, is much more costly than multiple repos advocates recognize.

The productivity gains to be had by letting different teams go their way aren't that significant.

While some teams may find a locally optimal way of working, it may be the case. It's also likely that other teams will offset their gains by choosing a suboptimal way of working.

By putting all your eggs in the one basket of the monorepo, you can then afford to invest in watching that basket carefully.

The friction of having to make changes in other repos. Or, worse, having to wait for other teams to make changes for you. It's primarily avoided in a mono repo because anyone can (and is encouraged) to change anything.

If you find a bug in a library, you can fix it and get on with your life. It's no more friction than if you had found a bug in your code.

## Azure DevOps project repositories

In Azure DevOps, a project can contain multiple repositories. It's common to use one repository for each associated solution.
