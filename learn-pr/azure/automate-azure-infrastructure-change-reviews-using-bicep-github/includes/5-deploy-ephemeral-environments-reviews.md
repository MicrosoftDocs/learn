Linting your Bicep code gives you some indication of whether your Azure deployment is likely to succeed, but it's helpful to actually deploy your Bicep code somewhere to see how your environment will look after the pull request is merged and your deployment is complete. In this unit, you'll learn about how to automatically create ephemeral environments, and delete them when they're no longer required.

## Ephemeral environments

By now, you're used to the idea of deploying your changes to one or more non-production environments, like *Test*, *QA*, and *Staging*, before finally deploying to your production environment. In many organizations, these environments are *long-lived* - they are updated when changes are rolled out, and the environments aren't usually deleted.

In contrast, an *ephemeral* environment is one that you create dynamically, and that you're comfortable with being deleted when it's not in use. Ephemeral environments are intended to only exist for a short amount of time - for example, long enough to review changes in a pull request. 

Because you're so used to building up your Azure infrastructure as code, and you've invested in building your Bicep files to deploy your resources, you can reuse those same assets to deploy an ephemeral environment. You can even deploy multiple ephemeral environments at a time, if you need to. You just need to ensure that you deployments are sufficiently *parameterized* that you can easily create independent environments.

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

### Alternative approaches

You can also consider working within a single resource group for all of your ephemeral resources.

:::image type="content" source="../media/5-shared-resource-group.png" alt-text="Diagram that shows a single resource group, which is used by all pull requests." border="false":::

Then, you can either deploy separate or shared resources for each ephemeral environment.

#### Separate resources in a single resource group

If you're concerned about granting subscription-wide permissions to a workflow's service principal, you can consider deploying all of your resources into a single resource group. The workflow only needs permission to deploy into that one resource group.

<!-- TODO -->

This approach is complex to implement, because:

- TODO naming
- TODO finding resources to delete

#### Shared resources in a single resource group

You might create shared resources, which are used by everybody on the team. Every time a pull request workflow runs, any existing resources in the shared resource group will be overwritten by the most recent deployment. This approach minimizes the cost of your ephemeral environments. If you define resources that take a long time to deploy, this approach might reduce the time that it takes to run the deployment because the resources already exist. But it also introduces a lot of complexity because team members need to work together to avoid interfering with each other's work.

You lose many of the benefits of ephemeral environments by following this approach. But, you can still test every pull request's deployment process before the code is merged, and each pull request's checks will provide information about whether the deployment succeeded or failed.

<!-- TODO -->

You can also use 1 resource group, but recreate all resources with a different name for each feature your team is working on. In this case you do get separation between each feature, since for each feature you would recreate the full set of resources with a unique name. This way of working does simplify resource group creation, since you will need only 1 resource group.

You will need to make sure however that your Bicep file is carefully constructed, so it creates each resource with a unique name. In previous modules we did that by utilizing a hash that was generated based on the resource group name. This will not be sufficient if you create all resources in the same resource group.

This is a more costly solution as opposed to sharing the resources between all features. Additionally deleting any resources that were used for developing a certain feature becomes a challenge. Since all of them exist in 1 resource group, you will need to either hand-delete them 1 by 1 based on their name, which is cumbersome. Or you could automate this through CLI or Powershell statements. The above options of performing a complete mode deploy of the original Bicep template or deleting and recreating the resource group from scratch are also valid approaches here to get rid of the resources of a specific feature. However both of these approaches will delete work in progress of features as well, so it is still less ideal.

> [!NOTE]
> You can also combine the 1 resource group approach with the approach where you create a resource group per feature. It might be that certain resources are too costly or take too long to create each time. In that case you can create these resources in a shared resource group, but use a resource group per feature for all other resources.

## Manage the costs of ephemeral environments

TODO

- For a lot of resources in Azure there is either a free or developer tier available. Specifically the developer tiers usually offer the same capabilities as the enterprise tiers of a resource, but they primarily lack a Service Level Agreement (SLA). Since an ephemeral environment is a developer environment that you will delete again anyway, the fact that there is no SLA shouldn't be a problem.
- Azure knows the concept of a Dev/Test subscription, which offers lower resource pricing. This is a subscription that as well will give you no SLA on the services you create in it. We link to more info in the summary.
- In case your ephemeral environments need to live longer for whatever reason you may have, you might also use the principal of tagging these environments with a specific tag, where you for instance delete all these environments outside of business hours with a recurring GitHub action.

> [!TIP]
> Regardless of the approach you select, it's a good practice to use a dedicated Azure subscription for ephemeral environments. This helps you to monitor and control costs, and to grant access to users and to your workflow without accidentally providing access to your other environments. You can also apply subscription-wide policies that limit the SKUs of your ephemeral resources, which helps to avoid cost overruns.
