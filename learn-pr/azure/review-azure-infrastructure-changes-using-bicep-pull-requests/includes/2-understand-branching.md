When you build Bicep templates and work within a Git repository, all of your team's changes are eventually merged into the main branch of your repository. It's important to protect your main branch so that no unwanted changes are deployed to your production environment. However, you also want your contributors to be able to work and collaborate flexibly, and to be able to try out ideas easily.

In this unit, you'll learn about branching strategies and branch protection. You'll also learn how you can set up a review process for your branches.

## Why do you want to protect your main branch?

Your main branch is the source of truth for what gets deployed to your Azure environments. For many solutions, you'll have multiple environments such as *Development*, *Quality Assurance (QA)*, and *Production*. In other scenarios, you might only have a *Production* environment. Regardless of how many environments you use, your main branch is the branch that your team members contribute to. Their changes ultimately land on the main branch.

A typical process might be the following: 

1. A team member clones your repository.
1. They make local changes on a branch in their own local copy of the repository.
1. When they are finished with their changes, they merge these changes in their local repository's main branch.
1. They push these changes to the remote repository's main branch.
1. In some scenarios, the remote repository's push triggers an automated pipeline to verify, test and deploy the code. You'll learn more about pipelines in other Microsoft Learn modules.

Suppose the changes that the team member made introduced a subtle bug. After the complete process runs, the bug is now in the main branch of the project. This is the branch that gets deployed to production. You might not discover it until you try to deploy it and get an error. Or, for other types of bugs, the deployment might succeed but cause subtle problems later.

In another scenario, suppose a team member is working on a feature and pushes half of the finished work of the feature to your main branch. You now have changes on your main branch that are not completely finished. These probably should not be deployed to your production environment, because the work is not completely done and might not even be tested. Deployments to production might need to be blocked until the feature is finished. This means that, if there are other newly finished features in your main branch, they might not be able to be deployed and used by your customers.

> [!TIP]
> These problems are particularly difficult for large teams, where multiple people contribute to the same code. But, the guidance in this module is also valuable as soon as you collaborate with more than one person - or even when it is just you working on a project and work on multiple separate features at the same time.

## Changing your process

A better way of working is to have another team member review any changes before they're merged into the main branch of your team's shared repository. This process helps your team to make an informed decision on the change before you approve it to be merged. This review and automated validation process can be achieved by using *pull requests* and *branch protection*, which you'll learn about soon.

Branch protection is extra configuration you can add to certain branches in your project and that helps you build confidence on the changes that make it into these branches. <!-- TODO maybe move this later -->

## Feature branches

A *feature branch* indicates a new piece of work you are starting, like a change to the configuration of a resource defined in your Bicep file, or a new set of resources you need to deploy. Every time you start a new piece of work, you create a new feature branch.

You create a feature branch from the main branch. By doing this, you ensure that you're starting from the current state of your Azure environment. Then, you make all of the changes that you need to implement the change. Because all of the code changes are committed to the feature branch, they won't interfere with the main branch of the repository. And, if somebody else on your team needs to make an urgent change to your main branch, they can do that on another feature branch, independent of yours.

You can collaborate on feature branches, too. By publishing and pushing your feature branch to a shared repository, you and your team members can work together on a change. Or, you can hand over a feature to someone else to complete when you go on vacation.

### Update your feature branches

While your feature branch is underway, other features might be merged to the main branch of your repository. This means that your feature branch and the main branch of your project will drift apart. The further they drift apart, the harder it will be to merge the two branches again at a later point in time and the more merge conflicts you may encounter.

It's a good idea to update your feature branch regularly so that you incorporate any changes that have made to the main branch of the repository. It's also a good idea to update your feature branch before you start to merge the feature branch back into the main branch. This way, you make sure that your new changes are able to be merged into the main branch easily.

> [!TIP]
> It's a good idea to merge the main branch into your feature branch often.

### Use small, short-lived branches

It's a good idea to aim for short-lived feature branches. This helps you to avoid merge conflicts by reducing the amount of time that your branches might get out of sync.

Its also good to keep your feature branches small and easy to understand, and to avoid doing large changes in a single branch. Split up large pieces of work into multiple smaller pieces and create new feature branches for each one. The bigger the feature the longer someone will need to work on it and the longer the feature branch will live. You can deploy the smaller changes to production as you merge each feature branch, and gradually build up the feature you're building towards.

> [NOTE]
> It can sometimes be challenging to keep your features small.
>
> When you build software, it can be useful to consider *feature flags*. A feature flag turns a feature on or off in production. While the feature is under development, the feature flag is turned off. After the feature is ready, you turn it on.
>
> This way, the code for the feature can be merged into your main branch and deployed to production, but the feature itself isn't visible.
>
> You can use feature flags to support releasing your changes at a certain time, like if you have an announcement. At the release time, you can turn on all of the feature flags by changing your system's configuration.
>
> In Bicep code, it's not common to work with feature flags. But when you build a solution that includes custom software, consider using feature flags to disable the parts of your software that aren't yet ready.

<!-- TODO maybe conditions could be used for this? -->

## Merging feature branches

When you've finished working on a feature branch, you need to merge it into your repository's main branch. It's a good practice to review the changes that were made on the feature branch before merging.

A *pull request* is a *request* from you, the developer of a feature, to the maintainer of the main branch. You ask the maintainer to *pull* your changes into the main branch of the repository.

In Azure DevOps you can configure *branch protections*, or *branch policies*, for your main branch. Branch protections enforce rules like *no change can be merged to the main branch except through a pull request*. A pull request will start a review process of the changes you made, before these are merged into the main branch.

You'll learn more about pull requests later in this module.

## Branching strategies

When you collaborate on your Bicep code, there are different branching strategies you can use. Each branching strategy has its own benefits and drawbacks.

The process you've learned about so far is called the  *trunk-based development* strategy. In this branching strategy, work is done on short-lived feature branches, and is then merged to a single main branch. You might automatically deploy the contents of your main branch to production every time a change is merged. Or, you might batch changes and release them on a schedule, like every week. Trunk-based development is easy to understand, and it enables collaboration without much overhead.

Some teams separate the work that they've completed from the work that they've deployed to production. They use a long-lived *development* branch as the target for merging their feature branches, and they merge the *development* branch to their *main* branch when they release changes to production.

Some other branching strategies require you to create 8release branches*. When you have a set of changes are ready to deploy to production, you create a release branch with the changes to release. These strategies can make sense when you release changes on a regular cadence, or when you are integrating your changes with many other teams.

Other branching strategies you might come across include GitFlow, GitHub Flow, and GitLab Flow. Some teams use GitHub Flow or GitLab Flow because it enables separating work from different teams, as well as separating urgent bug fixes from other changes. These processes can also enable you to separate your commits into different releases of your solution, which is called *cherry picking*. However, they require more management to ensure that your changes are compatible with each other. We provide links to more information on these branching strategies in the summary of this module.

The branching strategy that's right for your team depends on the way your team works, collaborates, and releases your changes. It's a good idea to start from a simple process, like trunk-based development. If you find your team isn't able to work effectively by using this process, gradually introduce additional layers of branching, or adopt a branching strategy. But be aware that as you add more branches, it'll become more complex to manage your repository.

> [!TIP]
> Regardless of the branching strategy you use, it's good to use branch policies to protect your main branch. Other branching strategies also introduce other important branches that you should protect.
>
> Also, however you branch, it's a good idea to use pull requests to review your code.

In this module we use the trunk-based development because it's easy to understand and use.
