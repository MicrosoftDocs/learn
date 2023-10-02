
## What is a successful Git branch workflow?

When evaluating a workflow for your team, you must consider your team's culture. You want the workflow to enhance your team's effectiveness and not be a burden that limits productivity. Some things to consider when evaluating a Git workflow are:

 -  Does this workflow scale with team size?
 -  Is it easy to undo mistakes and errors with this workflow?
 -  Does this workflow impose any new unnecessary cognitive overhead on the team?

## Common branch workflows

Most popular Git workflows will have some sort of centralized repo that individual developers will push and pull from.

Below is a list of some popular Git workflows that we'll go into more detail about in the next section.

These comprehensive workflows offer more specialized patterns about managing branches for feature development, hotfixes, and eventual release.

## Trunk-based development

Trunk-based development is a logical extension of Centralized Workflow.

The core idea behind the Feature Branch Workflow is that all feature development should take place in a dedicated branch instead of the main branch.

This encapsulation makes it easy for multiple developers to work on a particular feature without disturbing the main codebase.

It also means the main branch should never contain broken code, which is a huge advantage for continuous integration environments.

## Forking workflow

The Forking Workflow is fundamentally different than the other workflows discussed in this tutorial.

Instead of using a single server-side repository to act as the "central" codebase, it gives every developer a server-side repository.

It means that each contributor has two Git repositories:

 -  A private local one.
 -  A public server-side one.
