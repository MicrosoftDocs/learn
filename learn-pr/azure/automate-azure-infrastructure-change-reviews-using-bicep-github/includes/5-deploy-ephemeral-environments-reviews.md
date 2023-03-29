Linting your Bicep code gives you some indication of whether your Azure deployment is likely to succeed. You'll also find it helpful to actually deploy your Bicep code somewhere, to see how your environment will look after the pull request is merged and the deployment is complete.

In this unit, you learn how to deploy your code to a temporary environment from within a pull request.

## Why deploy your code from within a pull request?

When you're reviewing a pull request that includes Bicep code, it's a good practice to deploy the Bicep code to a real Azure environment. By doing so, you help build confidence that your changes will work when they reach your production environment. If there's a problem, you want to discover it quickly. Pull requests give you a great opportunity to discover and highlight problems, because you're getting immediate feedback from your reviewers.

By now, you're used to the idea of deploying your changes to one or more non-production environments, such as _Test_, _QA_, and _Staging_, before deploying them to your production environment. In many organizations, these environments are _long-lived_, which means that they're updated when changes are rolled out, and the environments aren't usually deleted.

In contrast, an _ephemeral environment_ is one that you create dynamically, and that you're comfortable with being deleted when it's no longer useful. Ephemeral environments are intended to exist for a short amount of time only (for example, just long enough for your changes to be reviewed).

Ephemeral environments are a good choice when you deploy environments for pull requests, because you might have many separate pull requests open at a time, representing different types of changes. If you have several pull requests open, sharing your long-lived non-production environments means that only one change can be previewed at a time.

## Create ephemeral environments

Because you're so used to building up your Azure infrastructure as code, and you've invested in building your Bicep files to deploy your resources, you can reuse those same assets to deploy an ephemeral environment. You can even deploy multiple ephemeral environments at a time, if you need to. You just need to ensure that your deployments are sufficiently _parameterized_ and _generalized_, so that you can easily create independent environments. For example, you need to ensure that some Azure resources are given globally unique names, which can't be the same as resource names in any other ephemeral or long-lived environment.

Ephemeral environments offer a number of benefits:

- You can safely test new features and capabilities in an isolated environment that doesn't affect your other production or non-production workloads.
- You can display your changes in your own branch, letting you easily showcase your work to your colleagues or provide access to reviewers.
- You can have multiple team members test separate changes at the same time, even if the changes are incompatible.
- Because they involve running your Bicep files regularly, ephemeral environments help you continually test the accuracy and completeness of your Bicep code and other scripts. As a result, you can be more confident that the code will run perfectly in your production environment.

In this module, you'll create ephemeral environments to help you to build up confidence about the changes within pull requests. Anybody who reviews the pull request can access the ephemeral environment, including any new additions and updates, before approving and merging the pull request.

## Deployment

When you work with ephemeral environments, it's best to create a separate Azure resource group for each pull request that your team creates. If one author has two separate pull requests open, each will have its own ephemeral environment. This helps to keep each change separated from the others, and it can help to avoid confusion or accidentally overwriting resources.

:::image type="content" source="../media/5-pull-request-resource-groups.png" alt-text="Diagram that shows a resource group created for each pull request." border="false":::

For this approach to work, your pull request validation workflow needs to create resource groups dynamically. Resource groups require unique names, and you also need to be able to easily find the resource group to both test the resources and delete them when your pull request is closed. To handle resource group names effectively, you can use the pull request number within the resource group name. You'll see how to do this in the next exercise.

When it's time to delete the ephemeral environment, it's easy for your workflow to find and delete the entire resource group. All the resources that are used in the ephemeral environment will be deleted at the same time.

## Permissions

Creating resource groups requires subscription-level permissions, and typically requires the Contributor role to be assigned to your workflow's workload identity.

It's a good practice to use a dedicated Azure subscription for ephemeral environments. By following this approach, you can grant access to your workflow's workload identity and to your team members without accidentally providing access to your other environments.

> [!IMPORTANT]
> Subscription-scoped contributors are powerful, so you need to ensure you have adequate governance around your workflow's workload identity and the changes that it can deploy. By using a dedicated subscription for ephemeral environments, you reduce the risk to your other environments.

## Your workflow's identity

Your deployment workflow uses a workload identity and federated credential to authenticate to Azure. When you use pull request validation workflows, you need to configure the federated credential to work with pull requests.

In a previous exercise unit in this module, you ran a command to create a federated credential. The policy string looked similar to the following:

`repo:my-github-user/my-repo:pull_request`.

The `pull_request` near the end of the string specifies that the federated credential works with pull request validation workflows.

## Cost management

When you create ephemeral environments dynamically, there's a risk that your Azure costs could increase. If your team has a large number of pull requests open, you could deploy a large number of costly resources to Azure.

> [!TIP]
> If your team closes pull requests quickly, increased costs are less of a concern because an ephemeral environment will be deleted when its corresponding pull request is closed.

By using a dedicated Azure subscription, you can also easily monitor the costs of your ephemeral environments. And you can apply subscription-wide policies that limit the SKUs of your ephemeral resources, which can help you avoid cost overruns.

Additionally, Azure provides many ways to help you to control the costs of ephemeral environments, including:

- Microsoft Cost Management lets you set _budgets_ for a subscription. Budgets trigger notifications, so that your team is made aware that the cost is approaching the threshold you specified.
- Many Azure resource types provide cheaper, or even free, tiers for non-production workloads. Consider whether you can use these pricing tiers and SKUs.
- Azure Dev/Test pricing is available for some customers to use for their non-production subscriptions.
- Resource tags can help you identify the resources that are associated with each ephemeral environment, and calculate the cost of each ephemeral environment.
- You can create automation scripts to delete your ephemeral resources after a defined period of time or even, for example, every night after business hours.

You might also consider sharing certain resources between ephemeral environments. For example, your Bicep code might define many resources, a few of which are costly or that take a long time to provision. You might create one shared, long-lived resource group for all your pull requests to share the costly resources, and create separate ephemeral resource groups for the other resources. However, this approach makes it difficult and error-prone to manage your ephemeral environments, and to keep them separated enough to be helpful during your review process. It's best to avoid this approach unless the cost of your ephemeral environments becomes too high.
