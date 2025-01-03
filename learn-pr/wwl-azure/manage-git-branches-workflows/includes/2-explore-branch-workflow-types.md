## What is a successful Git branch workflow?

When evaluating a workflow for your team, you must consider your team's culture. You want the workflow to enhance your team's effectiveness and not be a burden that limits productivity. Some things to consider when evaluating a Git workflow are:

 -  Does this workflow scale with team size?
 -  Is it easy to undo mistakes and errors with this workflow?
 -  Does this workflow impose any new unnecessary cognitive overhead on the team?

## Common branch workflows

Most popular Git workflows will have some sort of centralized repo that individual developers will push and pull from.

Below is a list of some popular Git workflows that we'll go into more detail about in the next section.<br>These comprehensive workflows offer more specialized patterns about managing branches for feature development, hotfixes, and eventual release.

### Trunk-based development

Trunk-based development is a logical extension of Centralized Workflow.

The core idea behind the Trunk-based Development Workflow is that all development work takes place directly on the main branch (often called "trunk" or "master"). This approach emphasizes continuous integration, with developers frequently committing small, incremental changes to the main branch. Continuous integration and automated testing play a crucial role in maintaining code quality and stability.

### Feature branch workflow

The Feature Branch Workflow emphasizes encapsulating each new feature or change in its dedicated branch separate from the main branch. Developers create a new branch for each feature or issue they are working on, develop and test the changes in isolation, and then merge the feature branch back into the main branch once it's complete and tested. This approach allows for parallel development of multiple features, facilitates code review, and ensures that the main branch remains stable.

### Release branch workflow

In the Release Branch workflow, a dedicated branch is created from the main branch when preparing for a release. This branch is used to stabilize the code, address any last-minute bugs or issues, and perform final testing before deploying the release to production. Once the release is considered to be ready, it is merged back into the main branch, and potentially into other long-lived branches such as development or feature branches. This strategy allows for a controlled and organized release process while keeping the main branch stable for ongoing development work.

### Forking workflow

The Forking Workflow is fundamentally different from the other workflows discussed in this tutorial. Instead of using a single server-side repository to act as the "central" codebase, it gives every developer a server-side repository. It means that each contributor has two Git repositories: a private local one and a public server-side one. This approach promotes a high degree of parallel development and collaboration among contributors while maintaining a clean and organized codebase.
