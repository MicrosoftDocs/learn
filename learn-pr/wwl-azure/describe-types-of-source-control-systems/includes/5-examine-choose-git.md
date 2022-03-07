Switching from a centralized version control system to Git changes the way your development team creates software.

If you are a company that relies on its software for mission-critical applications, altering your development workflow impacts your entire business.

Developers would gain the following benefits by moving to Git.

## Community

In many circles, Git has come to be the expected version control system for new projects.

If your team is using Git, odds are you will not have to train new hires on your workflow because they will already be familiar with distributed development.

:::image type="content" source="../media/git-community-50834e04.png" alt-text="Git community.":::


Also, Git is popular among open-source projects. It is easy to use 3rd-party libraries and encourage others to fork your open-source code.

## Distributed development

In TFVC, each developer gets a working copy that points back to a single central repository. Git, however, is a distributed version control system. Instead of a working copy, each developer gets their local repository, complete with an entire history of commits.

:::image type="content" source="../media/centralized-distributed-version-control-systems-5627b609.png" alt-text="Centralized  and Distributed version control systems.":::


Having a complete local history makes Git fast since it means you do not need a network connection to create commits, inspect previous versions of a file, or do diffs between commits.

Distributed development also makes it easier to scale your engineering team. If someone breaks the production branch in SVN, other developers cannot check in their changes until it is fixed. With Git, this kind of blocking does not exist. Everybody can continue going about their business in their local repositories.

And, like feature branches, distributed development creates a more reliable environment. Even if developers obliterate their repository, they can clone from someone else and start afresh.

## Trunk-based development

One of the most significant advantages of Git is its branching capabilities. Unlike centralized version control systems, Git branches are cheap and easy to merge.

:::image type="content" source="../media/trunk-based-development-fcd6834f.png" alt-text="Trunk-based Development.":::


Trunk-based development provides an isolated environment for every change to your codebase. When developers want to start working on something—no matter how large or small—they create a new branch. It ensures that the master branch always contains production-quality code.

Using trunk-based development is more reliable than directly-editing production code, but it also provides organizational benefits.

They let you represent development work at the same granularity as your agile backlog.

For example, you might implement a policy where each work item is addressed in its feature branch.

## Pull requests

Many source code management tools such as Azure Repos enhance core Git functionality with pull requests.

A pull request is a way to ask another developer to merge one of your branches into their repository.

It makes it easier for project leads to keep track of changes and lets developers start discussions around their work before integrating it with the rest of the codebase.

:::image type="content" source="../media/pull-requests-c8925506.png" alt-text="Pull Requests.":::


Since they are essentially a comment thread attached to a feature branch, pull requests are incredibly versatile.

When a developer gets stuck with a complex problem, they can open a pull request to ask for help from the rest of the team.

Instead, junior developers can be confident that they are not destroying the entire project by treating pull requests as a formal code review.

## Faster release cycle

A faster release cycle is the ultimate result of feature branches, distributed development, pull requests, and a stable community.

These capabilities promote an agile workflow where developers are encouraged to share more minor changes more frequently.

In turn, changes can get pushed down the deployment pipeline faster than the standard of the monolithic releases with centralized version control systems.

:::image type="content" source="../media/product-release-feedback-cb9d5673.png" alt-text="Product release with feedback.":::


As you might expect, Git works well with continuous integration and continuous delivery environments.

Git hooks allow you to run scripts when certain events occur inside a repository, which lets you automate deployment to your heart’s content.

You can even build or deploy code from specific branches to different servers.

For example, you might want to configure Git to deploy the most recent commit from the develop branch to a test server whenever anyone merges a pull request into it.

Combining this kind of build automation with peer review means you have the highest possible confidence in your code as it moves from development to staging to production.
