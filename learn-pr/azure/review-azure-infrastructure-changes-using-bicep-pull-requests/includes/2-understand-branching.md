When you build Bicep templates and work within a Git repository, all of your team's changes are eventually merged into the main branch of your repository. It's important to protect the main branch so that no unwanted changes are deployed to your production environment. However, you also want your contributors to be able to work and collaborate flexibly, and to be able to try out ideas easily.

In this unit, you'll learn about branching strategies and how to protect the main branch. You'll also learn how you can set up a review process for your branches.

## Why do you want to protect the main branch?

The main branch determines what gets deployed to your Azure environments. For many solutions, you'll have multiple environments such as *Development*, *Quality Assurance (QA)*, and *Production*. In other scenarios, you might have only a *Production* environment. Regardless of how many environments you use, the main branch is the branch that your team members contribute to. Their changes ultimately land on the main branch.

A typical process might be the following: 

1. A team member clones your shared repository.
1. They make local changes on a branch in their own local copy of the repository.
1. When they're finished with their changes, they merge these changes in their local repository's main branch.
1. They push these changes to the remote repository's main branch.
1. In some scenarios, the remote repository's push triggers an automated pipeline to verify, test, and deploy the code. You'll learn more about pipelines in other Microsoft Learn modules.

The following diagram illustrates the process.

:::image type="content" source="../media/2-basic-process.png" alt-text="Diagram that shows the process of making local changes, pushing changes to the remote main branch, and triggering a pipeline." border="false":::

Suppose the changes that the team member made introduced a subtle bug. After the complete process runs, the bug is now in the main branch of the project. This is the branch that gets deployed to production. You might not discover it until you try to deploy it and get an error. Or, for other types of bugs, the deployment might succeed but cause subtle problems later.

In another scenario, suppose a team member is working on a feature and pushes half of the finished work of the feature to the shared repository's main branch. You now have changes on the main branch that aren't completely finished or tested. These changes probably shouldn't be deployed to your production environment. Deployments to production might need to be blocked until the feature is finished. If newly finished features are in the main branch, you might not be able to deploy them to your customers.

> [!TIP]
> These problems are particularly difficult for large teams, where multiple people contribute to the same code. But the guidance in this module is valuable as soon as you collaborate with more than one person. The guidance is valueable even when it's just you working on a project, and you work on multiple separate features at the same time.

A better way of working is to keep your changes separate while you work on them. Yo can then have another team member review any changes before they're merged into the main branch of your team's shared repository. This process helps your team to make an informed decision on a change before you approve it to be merged.

## Feature branches

A *feature branch* indicates a new piece of work you're starting. The work might be a change to the configuration of a resource defined in your Bicep file, or a new set of resources that you need to deploy. Every time you start a new piece of work, you create a new feature branch.

You create a feature branch from the main branch. By doing this, you ensure that you're starting from the current state of your Azure environment. Then, you make all of the changes that you need to implement the change. 

Because all of the code changes are committed to the feature branch, they won't interfere with the main branch of the repository. And, if somebody else on your team needs to make an urgent change to the main branch, they can do that on another feature branch that's independent of yours.

You can collaborate on feature branches, too. By publishing and pushing your feature branch to the shared repository, you and your team members can work together on a change. Or, you can hand over a feature to someone else to complete when you go on vacation.

### Update your feature branches

While your feature branch is underway, other features might be merged to the main branch of your repository. This means that your feature branch and the main branch of your project will drift apart. The farther they drift apart, the harder it will be to merge the two branches again at a later point, and the more merge conflicts you might encounter.

It's a good idea to update your feature branch regularly so that you incorporate any changes that have been made to the main branch of the repository. It's also a good idea to update your feature branch before you start to merge the feature branch back into the main branch. This way, you make sure that your new changes can be merged into the main branch easily.

> [!TIP]
> It's a good idea to merge the main branch into your feature branch often.

### Use small, short-lived branches

It's a good idea to aim for short-lived feature branches. This helps you to avoid merge conflicts by reducing the amount of time that your branches might get out of sync. It also makes it easier for your colleagues to understand the changes that have been made, which is helpful when you need someone to review your changes.

Split up large pieces of work into multiple smaller pieces and create new feature branches for each one. The bigger the feature the longer someone will need to work on it and the longer the feature branch will live. You can deploy the smaller changes to production as you merge each feature branch, and gradually build up the feature you're building towards.

When you work in this manner, it can be helpful to use the `if` keyword to disable the deployment of resources until they're ready. For example, you might create a Bicep file that defines a storage account, but disable the storage account's deployment until you're done with all of the changes:

:::code language="bicep" source="code/2-storage-condition.bicep" highlight="4" :::

You can use parameters to specify different values for the `storageAccountReady` variable in different environments. For example, you might set the parameter value to `true` for your test environment, and `false` for your production environment, so that you can try out the new storage account in your test environment.

> [!NOTE]
> When it's time to enable the feature in production, remember that you need to do both of the following for your change to take effect:
> - Change the parameter value.
> - Redeploy your Bicep file.

### Merging feature branches

When you've finished working on a feature branch, you need to merge it into your repository's main branch. It's a good practice to review the changes that were made on the feature branch before merging. Pull requests enable you to review your code. You'll learn more about pull requests later in this module.

::: zone pivot="github"

### Branch protections

In GitHub, you can configure *branch protections* for the shared repository's main branch. Branch protections enforce rules like:

- No change can be merged to the main branch except through a pull request.
- Changes need to be reviewed by at least two other people.

If somebody tries to push a commit directly to a protected branch, the push will fail. You'll learn how to apply branch protections in the next unit.

::: zone-end

::: zone pivot="azurerepos"

### Branch policies

In Azure DevOps, you can configure *branch policies* for the shared repository's main branch. Branch policies enforce rules like:

- No change can be merged to the main branch except through a pull request.
- Changes need to be reviewed by at least two other people.

If somebody tries to push a commit directly to a protected branch, the push will fail. You'll learn how to apply branch policies in the next unit.

::: zone-end

## Other branching strategies

When you collaborate on your Bicep code, there are different branching strategies you can use. Each branching strategy has its own benefits and drawbacks.

The process you've learned about so far is a version of the *trunk-based development* strategy. In this branching strategy, work is done on short-lived feature branches, and is then merged to a single main branch. You might automatically deploy the contents of the shared repository's main branch to production every time a change is merged. Or, you might batch changes and release them on a schedule, like every week. Trunk-based development is easy to understand, and it enables collaboration without much overhead.

Some teams separate the work that they've completed from the work that they've deployed to production. They use a long-lived *development* branch as the target for merging their feature branches, and they merge the *development* branch to their *main* branch when they release changes to production.

Some other branching strategies require you to create *release branches*. When you have a set of changes ready to deploy to production, you create a release branch with the changes to deploy. These strategies can make sense when you deploy your Azure infrastructure on a regular cadence, or when you're integrating your changes with many other teams.

Other branching strategies you might come across include Gitflow, GitHub Flow, and GitLab Flow. Some teams use GitHub Flow or GitLab Flow because it enables separating work from different teams, as well as separating urgent bug fixes from other changes. These processes can also enable you to separate your commits into different releases of your solution, which is called *cherry picking*. However, they require more management to ensure that your changes are compatible with each other. We provide links to more information on these branching strategies in the summary of this module.

The branching strategy that's right for your team depends on the way your team works, collaborates, and releases your changes. It's a good idea to start from a simple process, like trunk-based development. If you find your team isn't able to work effectively by using this process, gradually introduce additional layers of branching, or adopt a branching strategy. But be aware that as you add more branches, it will become more complex to manage your repository.

> [!TIP]
> Regardless of the branching strategy you use, it's good to use branch policies to protect the main branch, and to use pull requests to review your changes. Other branching strategies also introduce other important branches that you should protect.

In this module we use trunk-based development with feature branches, because it's easy to understand and use.
