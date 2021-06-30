You've learned about how Git enables you to track the changes to your Bicep code. In this unit, you'll learn how Git also enables collaboration with your team members.

## What are GitHub and Azure Repos?

TODO

## Publish a Git repository

- Need an account with GitHub/Azure DevOps first
- Set up repo - this is called a remote
- Configure your local repo to know about the remote repo
- Track branches
- Push your changes to the remote

Can also work with repos that have already been created and published

## Authentication

Need to authenticate
Git Credential Manager handles this on Windows - what about macOS?

## Collaborate with others

Use branches and forks

### Integrate your work with the work of others

Clone, push, pull

### Pull requests

When you start working collaboratively with others by using GitHub or Azure Repos, you gain access to a useful feature called _pull requests_, often shortened to _PRs_.

A pull request is effectively a controlled merge of two branches, and GitHub or Azure Repos can enforce policies about who can merge and what kinds of changes can be merged. A typical team workflow would involve a team member making changes to their code on a branch, then creating a pull request to ask someone else to merge their changes into the **main** branch. Other team members can see the list of changes in the PR, and they can even provide reviews on the changes before they accept them. In the summary for this module, we provide some links to more information about how GitHub and Azure Repos enable you to use pull requests.
