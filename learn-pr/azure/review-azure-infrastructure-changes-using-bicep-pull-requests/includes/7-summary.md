Your team wanted a way to protect the Bicep code on your main branch, to avoid anyone making accidental changes that could affect your production Azure resources. You wanted to review any Bicep code before it's merged into your main branch.

In this module, you learned how to use feature branches to separate your team's in-progress work from the Bicep code that you use for your real Azure environments. You also learned how to use pull requests so that your team can review your Bicep code changes before they're merged and deployed.

Now, you have increased your team's confidence in your Bicep development process, and you've reduced the chance of faulty Bicep code being deployed to your production environment.

## References

- Branching
    - [Merge strategies and squash merge](/azure/devops/repos/git/merging-with-squash)
    - [Trunk Based Development](https://trunkbaseddevelopment.com/)
    - [Gitflow](https://nvie.com/posts/a-successful-git-branching-model/)
    - [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
    - [GitLab flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html)
    - [Patterns for Managing Source Code Branches](https://martinfowler.com/articles/branching-patterns.html)
- Pull requests on Microsoft Learn
    - [Manage repository changes by using pull requests on GitHub](xref:learn.github.manage-changes-pull-requests-github)
    - [Collaborate with pull requests in Azure Repos](xref:learn.wwl.collaborate-pull-requests-azure-repos)
- Bicep best practices
    - [Structure your Bicep code for collaboration](xref:learn.azure.structure-bicep-code-collaboration)
    - [Best practices for Bicep](/azure/azure-resource-manager/bicep/best-practices)