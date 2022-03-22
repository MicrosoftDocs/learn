Linting your Bicep code gives you some indication of whether your Azure deployment is likely to succeed, but it's helpful to actually deploy your Bicep code somewhere to see how your environment will look after the pull request is merged and your deployment is complete. In this unit, you'll learn how to deploy your code to a temporary environment from within a pull request.

## Why deploy your code from within a pull request?

When you're reviewing a pull request that includes Bicep code, it's a good practice to deploy the Bicep code to a real Azure environment. By deploying the code, you help to build up more confidence that your changes will work when they reach your production environment. If there's a problem, you want to discover it quickly - and pull requests provide a great opportunity to discover problems, because the author is already getting feedback from reviewers.

By now, you're used to the idea of deploying your changes to one or more non-production environments, like *Test*, *QA*, and *Staging*, before finally deploying to your production environment. In many organizations, these environments are *long-lived* - they are updated when changes are rolled out, and the environments aren't usually deleted.

In contrast, an *ephemeral* environment is one that you create dynamically, and that you're comfortable with being deleted when it's not in use. Ephemeral environments are intended to only exist for a short amount of time - for example, long enough to review changes in a pull request.

Ephemeral environments are a good choice when you deploy environments for pull requests, because you might have many separate pull requests open at a time, representing different types of changes. If you have several pull requests open, then sharing your normal environments means that only one change can be previewed at a time.

## Create ephemeral environments

Because you're so used to building up your Azure infrastructure as code, and you've invested in building your Bicep files to deploy your resources, you can reuse those same assets to deploy an ephemeral environment. You can even deploy multiple ephemeral environments at a time, if you need to. You just need to ensure that your deployments are sufficiently *parameterized* that you can easily create independent environments.

Ephemeral environments give you a number of benefits:

- They enable you to test the new features or capabilities that you're working with, while working in an isolated environment that won't affect any of your other production or non-production resources.
- They enable you to demonstrate the changes you're making on your own branch, so that you can easily showcase your work or provide access to reviewers to check.
- They allow multiple team members to test their separate changes at the same time - even if they're incompatible with each other.
- Because they involve executing your Bicep files on a regular basis, they help you to continually test the accuracy of your Bicep code and other scripts, and give you confidence that you can create accurate representations of your production environment from your code.

In this module, you'll create ephemeral environments to help you to build up confidence about the changes within pull requests. Anybody reviewing the pull request can access the ephemeral environment, including the new additions and updates, before approving and merging the pull request.

## Deployment

When you work with ephemeral environments, it's best to create a separate Azure resource group for each pull request that your team creates. If one author has two separate pull requests open, each will have its own ephemeral environment. This helps to keep each change separated, and avoids confusion or accidentally overwriting resources.

:::image type="content" source="../media/5-dedicated-resource-groups.png" alt-text="Diagram that shows a resource group created for each pull request." border="false":::

For this to work, your pull request validation workflow needs to create resource groups dynamically. Resource groups require unique names, and you also need to be able to easily find the resource group to test the resources - and to delete them when your pull request is closed. To handle resource group names effectively, you can use the pull request number within the resource group name. You'll see how to do this in the next exercise.

When it's time to delete the ephemeral environment, it's easy for your workflow to find and delete the entire resource group. All of the resources used in the ephemeral environment will be deleted together.

## Permissions

Creating resource groups requires subscription-level permissions, and typically requires the *Contributor* role to be assigned to your workflow's service principal.

It's a good practice to use a dedicated Azure subscription for ephemeral environments. By following this approach, you can grant access to your workflow's service principal and to your team members without accidentally providing access to your other environments. 

> [!CAUTION]
> Subscription-scoped contributors are powerful, so you need to ensure you have adequate governance around your workflow's service principal and its credentials.

## Cost management

When you dynamically create ephemeral environments, there's a risk that your Azure costs could increase, because you might create large numbers of resources. If your team has a large number of pull requests open, you could also have a large number of costly resources deployed to Azure. If your team closes pull requests quickly, this is less of a concern.

By using a dedicated Azure subscription, you can also easily monitor the costs of your ephemeral environments. And, you can apply subscription-wide policies that limit the SKUs of your ephemeral resources, which helps to avoid cost overruns.

Additionally, Azure provides many capabilities to help you to control the costs of ephemeral environments, including:

- Azure Cost Management provides the ability for you to set budgets for a subscription. Budgets trigger notifications so that your team is aware that the cost is approaching the threshold you specified.
- Many Azure resource types provide cheaper, or even free, tiers for non-production workloads. Consider whether you can use these pricing tiers and SKUs.
- Azure Dev/Test pricing is available for some subscriptions.
- Resource tags can help you to identify the resources associated with each ephemeral environment.
- You can create automation scripts to delete your ephemeral resources after a defined period of time, or even every night after business hours.

> [!NOTE]
> You might also consider sharing certain resources between ephemeral environments. For example, your Bicep code might define just a small mumber of resources that are costly or that take a long time to provision. Consider whether you can have one shared, long-lived, resource group for all of your pull requests to share, and separate ephemeral resource groups for the other resources.
>
> However, whenever you create these kinds of separations, it becomes more difficult and error-prone to manage your environments amd to keep them separated enough to be helpful for your reviews. It's best to avoid this approach unless the cost of your ephemeral environments becomes too great.
