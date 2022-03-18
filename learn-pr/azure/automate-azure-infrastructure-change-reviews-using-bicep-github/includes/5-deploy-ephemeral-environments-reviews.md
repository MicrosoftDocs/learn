Linting your Bicep code gives you some indication of whether your Azure deployment is likely to succeed, but it's helpful to actually deploy your Bicep code somewhere to see how your environment will look after the pull request is merged and your deployment is complete. In this unit, you'll learn about how to automatically create ephemeral environments, and delete them when they're no longer required.

## Ephemeral environments

By now, you're used to the idea of deploying your changes to one or more non-production environments, like *Test*, *QA*, and *Staging*, before finally deploying to your production environment. In many organizations, these environments are *long-lived* - they are updated when changes are rolled out, and the environments aren't usually deleted.

In contrast, an *ephemeral* environment is one that you create dynamically, and that you're comfortable with being deleted when it's not in use. Ephemeral environments are intended to only exist for a short amount of time - for example, long enough to review changes in a pull request. 

Because you're so used to building up your Azure infrastructure as code, and you've invested in building your Bicep files to deploy your resources, you can reuse those same assets to deploy an ephemeral environment. You can even deploy multiple ephemeral environments at a time, if you need to. You just need to ensure that your deployments are sufficiently *parameterized* that you can easily create independent environments.

Ephemeral environments give you a number of benefits:

- They enable you to test the new features or capabilities that you're working with, while working in an isolated environment that won't affect any of your other production or non-production resources.
- They enable you to demonstrate the changes you're making on your own branch, so that you can easily showcase your work or provide access to reviewers to check.
- They allow multiple team members to test their separate changes at the same time - even if they're incompatible with each other.
- Because they involve executing your Bicep files on a regular basis, they help you to continually test the accuracy of your Bicep code and other scripts, and give you confidence that you can create accurate representations of your production environment from your code.

In this module, you'll create ephemeral environments to help you to build up confidence about the changes within pull requests. Anybody reviewing the pull request can access the ephemeral environment, including the new additions and updates, before approving and merging the pull request.

## Deployment approaches

When you create ephemeral environments, you need to decide how you'll deploy them to Azure. This decision has implications for your Azure environment's cost, the ease of management, and the permissions you need to assign to your workflow.

### Create a resource group for each pull request

The simplest option is to create a resource group for each pull request that your team creates. If one author has two separate pull requests open, each will have its own ephemeral environment. This helps to keep each change separated, and avoids confusion or accidentally overwriting resources.

:::image type="content" source="../media/5-dedicated-resource-groups.png" alt-text="Diagram that shows a resource group created for each pull request." border="false":::

In order to use this deployment approach, your workflow needs to create resource groups dynamically. Resource groups require unique names, and you also need to be able to easily find the resource group to test the resources - and to delete them when your pull request is closed. To handle resource group names effectively, you can use the pull request number within the resource group name. You'll see how to do this in the next exercise.

When it's time to delete the ephemeral environment, it's easy for your workflow to find and delete the entire resource group. All of the resources used in the ephemeral environment will be deleted together.

However, it's important to consider the cost implications of creating ephemeral resources. If your team has a large number of pull requests open, you could also have a large number of costly resources deployed to Azure. If your team closes pull requests quickly, this is less of a concern.

It's also important to understand the permissions that your workflow requires. Creating resource groups requires subscription-level permissions, and typically it's assigned by using the *Contributor* role. Subscription-scoped contributors are powerful, so you need to ensure you have adequate governance to ensure you don't accidentally expose your environment to any unnecessary security risks.

> [!TIP]
> Regardless of the approach you select, it's a good practice to use a dedicated Azure subscription for ephemeral environments. This helps you to monitor and control costs, and to grant access to users and to your workflow without accidentally providing access to your other environments. You can also apply subscription-wide policies that limit the SKUs of your ephemeral resources, which helps to avoid cost overruns.

### Alternative approaches

You can also consider working within a single resource group for all of your ephemeral resources.

:::image type="content" source="../media/5-shared-resource-group.png" alt-text="Diagram that shows a single resource group, which is used by all pull requests." border="false":::

If you're concerned about granting subscription-wide permissions to a workflow's service principal, you can consider deploying all of your resources into a single resource group. The workflow only needs permission to deploy into that one resource group.

Then, you can decide whether to deploy separate or shared resources for each ephemeral environment.

#### Separate resources in a single resource group

You might choose to deploy separate resources for each pull request into the single resource group. This approach can be complex to implement, because:

- You need to ensure that each resource has a unique name. Your Bicep code needs to be carefully constructed to avoid two environments trying to create a resource with the same name. Throughout the Bicep modules, you've been using the `uniqueString()` function to generate a resource name that's unique within the resource group. This won't be sufficient if you have multiple copies of a resource in the same resource group.
- You also need to be able to identify the resources that you should delete when the pull request is closed. It can be challenging to find and delete all of the resources that relate to a single ephemeral environment within a resource group.

#### Shared resources in a single resource group

You might create shared resources, which are used by everybody on the team. Every time a pull request workflow runs, any existing resources in the shared resource group will be overwritten by the most recent deployment. This approach minimizes the cost of your ephemeral environments. If you define resources that take a long time to deploy, this approach might reduce the time that it takes to run the deployment because the resources already exist. But it also introduces a lot of complexity because team members need to work together to avoid interfering with each other's work.

You lose many of the benefits of ephemeral environments by following this approach. But, you can still test every pull request's deployment process before the code is merged, and each pull request's checks will provide information about whether the deployment succeeded or failed.

> [!NOTE]
> You can also consider combining some of these approaches, if you need to. For example, your Bicep code might define just a small mumber of resources that are costly or that take a long time to provision. Consider whether you can have one shared, long-lived, resource group for all of your pull requests to share, and separate resource groups for the other resources. However, whenever you create these kinds of separations, it becomes more difficult and error-prone to manage your environments.

## Manage the costs of ephemeral environments

When you dynamically create ephemeral environments, there's a risk that your Azure costs could increase. Azure provides many capabilities to help you to control the costs of ephemeral environments, including:

- Azure Cost Management provides the ability for you to set budgets for a subscription. Budgets trigger notifications so that your team is aware that the cost is approaching the threshold you specified.
- Many Azure resource types provide cheaper, or even free, tiers for non-production workloads. Consider whether you can use these pricing tiers and SKUs.
- Azure Dev/Test pricing is available for some subscriptions.
- Resource tags can help you to identify the resources associated with each ephemeral environment.
- You can create automation scripts to delete your ephemeral resources after a defined period of time, or even every night after business hours.
