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

<!-- TODO -->

When creating ephemeral environments there are a couple of decisions you will need to make and a couple of things you will need to keep in mind.

When you create an ephemeral environment the first question you need to ask yourself is how you will organize these environments into resource groups. There are a couple of options to do this:

**Note to John: maybe some graphics will support the below explanation**
**Another note to John: I started with renaming feature to 'piece of work', but that made the text feel clunky ... I propose you try it out with piece of work when you copy over to the learn GH and see how it feels. If you like the wording, keep it, if you don't you're at the same feeling-place as I am currently.**

#### 1 resource group with shared resources

You might decide to use 1 resource group and have each team member run their Bicep template updates against this 1 resource group, where they share all already existing resources as well. This will be the most cost-effective solution, since each resource will exist only once.

This is a good solution if you have high cost constraints, however, it will not allow team members to work independently from each other. Team members might get in each others way when working on features. Also, if someone starts developing a new feature and next needs to remove previously added resources again, this becomes a challenge. You might decide then to introduce complete mode deployment to remove unwanted resources, but that will also remove resources from team members working on other features. Another option might be to regularly delete the entire resource group and recreate it from scratch so everyone can start with a clean slate. You could do this with a workflow that runs on a nightly basis.

This is also a good solution if your resources take a long time to create. When working on new features, especially when the added functionality is low, team members maybe don't want to wait each time for the creation of the full environment before they can start testing. Giving them the opportunity to then work in a shared environment that already has all the resources and they only need to add their own components can then be more preferable.

#### 1 resource group with separate resources

You can also use 1 resource group, but recreate all resources with a different name for each feature your team is working on. In this case you do get separation between each feature, since for each feature you would recreate the full set of resources with a unique name. This way of working does simplify resource group creation, since you will need only 1 resource group.

You will need to make sure however that your Bicep file is carefully constructed, so it creates each resource with a unique name. In previous modules we did that by utilizing a hash that was generated based on the resource group name. This will not be sufficient if you create all resources in the same resource group.

This is a more costly solution as opposed to sharing the resources between all features. Additionally deleting any resources that were used for developing a certain feature becomes a challenge. Since all of them exist in 1 resource group, you will need to either hand-delete them 1 by 1 based on their name, which is cumbersome. Or you could automate this through CLI or Powershell statements. The above options of performing a complete mode deploy of the original Bicep template or deleting and recreating the resource group from scratch are also valid approaches here to get rid of the resources of a specific feature. However both of these approaches will delete work in progress of features as well, so it is still less ideal.

#### a resource group per feature

Another way of working would be to create a new resource group for each feature your team is working on. Both the resource group and the resources in it can use a naming convention based on the pull request number.

This is also a more costly solution, since you will recreate all resources for each feature that is in progress. However, deleting all work after a pull request is closed becomes as simple as deleting the pull request specific resource group. Because of this simplicity of deletion, people are less likely to keep resources around they don't need anymore. Even better is that this process of creating and deleting the resource group and resources for each pull request is easy to automate with GitHub Action workflows. This results in an added cost of only the in progress pull requests.

Working within the scope of a resource group per feature also better complies with the reasoning that a resource group should contain all resources that should be created and deleted together. This will be exactly what you'll be doing in this way of working.

> [!NOTE]
> You can also combine the 1 resource group approach with the approach where you create a resource group per feature. It might be that certain resources are too costly or take too long to create each time. In that case you can create these resources in a shared resource group, but use a resource group per feature for all other resources.

### Cost implications

**Note to John: the cost implications are kinda in the above sections. Or do you want us to pull these out and move to here? And because of this, I tried to add additional pointers and explanation here.**

As already stated above, an ephemeral environment will also have a certain cost implication. Each ephemeral environment you create will have the same cost as standing up an entire new environment. This is why you want to keep their lifetime short.

There are however ways to limit this cost of standing up an entire new environment:

- For a lot of resources in Azure there is either a free or developer tier available. Specifically the developer tiers usually offer the same capabilities as the enterprise tiers of a resource, but they primarily lack a Service Level Agreement (SLA). Since an ephemeral environment is a developer environment that you will delete again anyway, the fact that there is no SLA shouldn't be a problem.
- Azure knows the concept of a Dev/Test subscription, which offers lower resource pricing. This is a subscription that as well will give you no SLA on the services you create in it. We link to more info in the summary.

In case your ephemeral environments need to live longer for whatever reason you may have, you might also use the principal of tagging these environments with a specific tag, where you for instance delete all these environments outside of business hours with a recurring GitHub action.

### Permissions

Based on how you design your resource groups for your ephemeral environments you will have other challenges with regards to permissions towards these resource groups.

#### Owner/Contributor role on the resource group level

When you choose for a model that uses just 1 resource group for an ephemeral environment, you can give your team members and workflows permissions scoped to that 1 resource group. You can create this resource group beforehand as well as the role assignments on this resource group.

#### Owner/Contributor on the subscription level

In case you need a model that uses more than 1 resource group and where these resource groups get created on the fly as well, a service principal with permissions on a resource group level will not be sufficient. You will need a service principal that is scoped at the subscription level. The service principal will at least need permissions to create and delete resource groups within the subscription. Additionally to the permission used to create and delete resources.

Security-wise this will bring risks in case this subscription is also used for other purposes. As long as those other purposes are all development environment related and don't involve any link to production workloads, the risk will be low. In case you do have in this subscription production workloads or links to production workloads, you should not choose for this option. The risk in that case would be that your workflows or team members would accidentally or deliberately update or delete production workloads.

> [!WARNING]
> Do not use subscription level service principals on any of your production environments. In case the service principal gets compromised it will have access to your entire production environment.

In case you use a totally different subscription for your production workloads and the service principal you use only has access to your development subscription, this is a valid approach to use.
