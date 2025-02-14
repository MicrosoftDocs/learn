A repository is where your work history is stored, usually in a git subdirectory.

How should you organize your code repository? Development teams aim to separate concerns in their software and repositories. As time passes, it isn't unusual for code repositories to become cluttered with irrelevant code and artifacts.

When it comes to organizing your repositories, there are two main philosophies: using a single repository (Monorepo) or multiple repositories.

 -  Monorepos is a source control pattern where all source code is kept in one repository. It's easy to give all employees access to everything at once. Clone it, and you're done.
 -  Organizing your projects into separate repositories is referred to as multiple repositories.

The fundamental difference between mono repo and multiple repo philosophies is what enables teams to work together most efficiently. In an extreme scenario, the multiple repos view suggests that each subteam can work in its repository. It allows them to work in their respective areas using the libraries, tools, and development workflows that optimize their productivity.

The cost of consuming anything not developed within a given repository is equivalent to using a third-party library or service, even if it was written by someone sitting nearby.

If you come across a bug in your library, you should address it in the corresponding repository. Once you have published a new artifact, you can return to your repository and make the necessary code changes. However, if the bug is in a different code base or involves different libraries, tools, or workflows, you may need to seek assistance from the owner of that system and wait for their response.

When using the mono repo view, managing complex dependency graphs can increase the difficulty of using a single repository. The benefits of allowing different teams to work independently aren't substantial. Some teams may find an efficient way of working, but this may not be true for all groups. Furthermore, other teams may choose a suboptimal approach, negating any benefits gained by others. Consolidating all your work in a mono repo lets you focus on closely monitoring this single repository.

The hassle of making changes in other repos or waiting for teams to make changes for you is avoided in a mono repo where anyone can change anything.

If you discover a bug in a library, fixing it's as easy as finding a bug in your own code.

> [!NOTE]
> In Azure DevOps, it's common to use a separate repository for each associated solution within a project.
