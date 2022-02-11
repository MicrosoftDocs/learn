As you build Bicep templates and work within a Git repository, all of your team's changes are eventually merged into the main branch of your repository. It's important to protect your main branch so that no unwanted changes are deployed to your production environment. However, you also want your contributors to be able to work and collaborate flexibly, and to be able to try out ideas without interfering with others.

In this unit you'll learn about branching strategies and branch protection and how you can set up a review process for your branches.

## Why do you want to protect your main branch?

Your main branch is the source of truth for what gets deployed to your development, QA and production environments. Your main branch is the branch that people collaborate on. A typical process might be the following: 

1. A team member clones your repository.
1. They make local changes on a branch in their own local copy of the repository.
1. When they are finished with their changes, they merge these changes in their local repository's main branch.
1. They push these changes to the remote main branch.
1. This push results in triggering an automated pipeline. The pipeline verifies the code, tests it, and if all goes well, it deploys the changes to non-production environments and then to your production environment.

Suppose the changes that were made introduce a subtle bug. Steps 4 and 5 in the above process mean that the bug is introduced in the main branch of the project. This is the branch that gets deployed to production. You might have failsafes in your deployment pipeline, like tests and approval gates, to prevent these changes to be deployed on your production environment. However, the bug is now in your main repository branch, and this might cause you other problems. To be able to recover from this bug, you need to make an additional change on the main branch and hope this fixes the bug that was accidentally introduced.

A better way of working would be to have another team member review any changes before they're merged into the main branch of your team's shared repository. Even better, it'd be good to have an automated process that gives you feedback on these changes. This process helps you make an informed decision on the change before you approve it to be merged. This review and automated validation process can be achieved by using *pull requests* and *branch protection*.

Branch protection is an extra configuration you can add to certain branches in your project and that helps you build confidence on the changes that make it into these branches.

### Risks involved with directly pushing to your main branch

You've already learned about how you might inadvertently introduce bugs in your main branch. There are other scenarios that also need you to be careful about how the main branch of your repository is managed:

- **Incomplete features**: A contributor might be working on a feature and push half of the finished work of the feature to your main branch. You now have changes on your main branch that are not completely finished. These probably should not be deployed to your production environment, since the work is not completely done and might not even be tested. Deployments to production might need to be blocked until the feature is finished. This means that, if there are other newly finished features in your main branch, they might not be able to be deployed and used by your customers.
- **Untested features**: Even though the development of a feature might be completed, you might still need to test this feature thoroughly. While testing out the feature in your QA environment, you might discover some flaws and need to make additional changes. When you're in this process of testing out the feature and applying additional changes to it, you can't promote the main branch's code to the production environment.
- **Rollback of changes**: Suppose your team is working on three features in parallel. They first push some changes to main for feature 1, followed by some changes for feature 2, with again some changes for feature 1, next followed by some changes for feature 3. It might be hard to undo or remove the changes made for just one of the features because all of the changes are intertwined on the main branch with the other features' changes.

> [NOTE]
> These problems have a big impact on large teams with multiple collaborators on the same code base and where teams are working on multiple features at the same time. But, the guidance in this module is valuable as soon as you collaborate with more than one person - or even when it is just you working on a project and you have multiple features you are working on at the same time.

## Working with feature branches

One easy improvement you can already make to working directly on your main branch is using feature branches. A feature branch indicates a new body of work you are starting, like a new feature you want to add to your code base. Each time you start this new body of work, you create a new branch from the main branch for this body of work. This branch will now contain all the changes you need to implement the new feature. All changes will happen on this feature branch, without interfering with the main branch of the repository.

Suppose you are working on a Bicep template that already contains a website and a database. You've deployed the components to your production environment. Now, you need to add a *message queue*, so that your website can post messages to a queue whenever a customer places an order. An Azure Function will pick up these messages and process them asynchronously.

This is a new feature that needs to be added to the existing template. So, you create a new branch for adding these changes. These changes might include:

- Add a queue to your Bicep template.
- Update the website's definition in the template so that it has the connection information for the queue.
- Add the new Azure Function application to the template.

By making these changes on a separate feature branch, you can iterate on them without affecting the code on the main branch. You can work in small batches, making each update with separate commits or merges, so the work is divided and easily managed. But because these updates all happen against your feature branch, they don't affect anything that happens on the main branch, and you'll have no incomplete work on the main branch. Later in this module, you'll see how you can test your changes in an environment completely separate from your development, QA or production environments.

If someone needs to make an urgent bug fix to your main branch, they can do so without needing to wait for your change to be ready.

You can collaborate on feature branches, too. By publishing and pushing your feature branch to a shared repository, you and your team members can work together on a feature. Or, you can hand over a feature to someone else to complete when you go on vacation.

### Update your feature branches

While your feature branch is underway, other features might be merged to the main branch of your repository. This means that your feature branch and the main branch of your project will drift apart. The further they drift apart, the harder it will be to merge the two branches again at a later point in time and the more merge conflicts you may encounter.

It's a good idea to update your feature branch regularly so that you incorporate any changes that have made it to the main branch of the repository. You should at least update your feature branch with any new changes in the main branch before you merge the feature branch back into the main branch. This way you make sure that your new changes are able to be merged into the main branch easily.

> [!TIP]
> It's a good idea to merge the main branch into your feature branch often.

### Use short-lived branches

It's a good idea to aim for short-lived feature branches. This helps you to avoid merge conflicts by reducing the amount of time that your branches might get out of sync.

Its also good to keep your feature branches small and comprehensible, and avoid doing large changes in a single branch. Split up large pieces of work into multiple smaller pieces and create new feature branches for each one. The bigger the feature the longer someone will need to work on it and the longer the feature branch will live. You can deploy the smaller changes to production as you merge each feature branch, and gradually build up the feature you're building towards.

> [NOTE]
> It can sometimes be challenging to keep your features small.
>
> When you build software, it can be useful to consider _feature flags_. A feature flag turns a feature on or off in production. While the feature is under development, the feature flag is turned off. After the feature is ready, you turn it on.
>
> This way, the code for the feature can be merged into your main branch and deployed to production, but the feature itself isn't visible.
>
> You can use feature flags to support releasing your changes at a certain time, like if you have an announcement. At the release time, you can turn on all of the feature flags by changing your system's configuration.
>
> In Bicep code, it's not common to work with feature flags. But when you build a solution that includes custom software, consider using feature flags to disable the parts of your software that aren't yet ready.

## Pull requests

When you've finished working on a feature branch, you need to merge it into your repository's main branch. It's a good practice to review the changes that were made on the feature branch before merging.

A *pull request* is a *request* from you, the developer of a feature, towards the maintainer of the main branch, to *pull* your changes into the main branch of the repository.

In Azure DevOps you can configure *branch protection*, or *branch policies*, for your main branch.  Branch protections enforce rules like *no change can be merged to the main branch except through a pull request*. A pull request will start a review process of the changes you made, before these are merged into the main branch.

On a pull request you can configure how many people at least need to review the changes in the pull request and you can include specific people or a group of people who need to perform the review. You might for instance include the project leads or the project architects as reviewers for all pull requests.

You may also require that in pull requests at least 1 work item is linked for the pull request to be valid. In case you are using Azure Boards as well, this will give you full traceability from the work item containing the feature request, over the code that implements this feature all the way to the deploy of this feature in production.

### Actions you can perform on pull requests

When you create a pull request, you can provide a descriptive a name and a longer description. In the description it is possible to mention specific people or to refer to work items. You can also indicate which people you would like to review the pull request.

You can mark a pull request as draft. Reviewers will know that you're still working on the changes. Your reviewers can still provide feedback but it's clear that the changes aren't ready to merge yet. When you're satisfied with your changes, you can remove the draft status.

After a pull request is created, you can track comments the reviewers may have, any automated checks that may run, and you can link work items to the pull request.

Reviewers can easily see the files that were changed. They can comment on the entire pull request or comment on specific parts of the files that were changed. This makes collaborating on a pull request a very interactive experience.

Even after you've created a pull request, you can keep making changes to the code on you feature branch. These  changes become part of the pull request.

After the pull request is approved, it can be completed, which means the contents of the pull request are merged into the main branch.

## Branching strategies

When you collaborate on your Bicep code, there are different branching strategies you can use. Each branching strategy has its own benefits and drawbacks.

The process you've learned about so far is the  _trunk based development_ strategy. In this branching strategy all developers collaborate on a single branch, which for us has been the main branch. Work is done on short-lived feature branches.

You might automatically deploy the contents of your main branch to production every time a change is merged. Or, you might batch changes and release them on a schedule, like every week.

Some other branching strategies require you to create _release branches_. When you have a set of changes are ready to deploy to production, you create a release branch with the changes to release.

The pro of trunk based development is that it is an easy to understand process. It allows for collaboration without too much overhead.

Other branching strategies you may come across are:

- [Gitflow]: This is one of the first mature branching strategies. It defines a quite elaborate branching model and is since its conception surpassed by other branching strategies that are easier to manage, comprehend and integrate with CI/CD. The main con for the Gitflow branching strategy is that it uses a develop branch for developers to create feature branches of. This makes it more cumbersome for developers to properly set up their tooling.
- [GitHub flow]: This is the branching strategy utilized when collaborating on GitHub projects. It is pretty close to trunk based development, however it is optimized to collaborate on open source projects. For these types of projects there are maintainers within the project itself who have full permissions within the project. In case external people would like to collaborate they need to fork the original repository in their own account and then create a pull request towards the original repository from a branch in their forked repository.
- [GitLab flow]: This branching strategy is also very close to trunk based development. Gitlab flow adds a specific way of how to create release branches and how to perform bug fixes in production. With GitLab flow you don't perform bug fixes on your release branches which you then merge back into main, but you rather bug fix in the main branch and then cherry pick the bug fix to a release branch. This avoids you forgetting to merge a bug fix into main and hence encountering the same bug again at a later point in time.

We link to more info on all these branching strategies in the summary of this module.

The branching strategy you prefer will depend on how your team is working and collaborating. The best way to choose a strategy is to keep it simple and only introduce extra concepts in case you find your team is missing certain capabilities. Also, whatever branching strategy you may choose, the concepts we explain in this module you will be able to apply to all of them. In each of the branching strategies branch policies and pull requests will be of use.

In this module we will make use of the trunk based development branching strategy for its ease of use.

### Other branches you may want to protect

Up until now we mainly talked about protecting the main branch of your repository, but there might be additional branches you would like to protect. All this will depend as well on the branching strategy you are applying. Based on your branching strategy other branches to protect are your release branches. These branches often trigger pipelines that initiate a deploy to your production environment. You typically won't want anyone to just merge new changes directly into a release branch. The same goes for any other branch that may trigger any type of deployment.
