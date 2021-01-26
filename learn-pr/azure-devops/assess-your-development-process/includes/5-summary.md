As you can see, Mara and her team face a number of challenges. Although releases happen eventually, Mara feels they can happen much more frequently and efficiently.

Mara hopes she can convince the team it's at least worth testing out a DevOps approach. Perhaps they can apply a few DevOps practices as they finish up work on the _Space Game_ website.

## What is DevOps?

At this point, we haven't yet defined DevOps. We'll do that in the next module. But for now, think of DevOps as something that brings together people, processes and products, automating software delivery to provide continuous value to your users.

Azure DevOps is a suite of services that spans the entire DevOps life cycle. Azure DevOps starts with planning and goes all the way through deployment and monitoring. If you already have some pieces in place, you can select which services you want to use. Azure DevOps integrates with many tools, such as Jenkins.

We'll go deeper into Azure DevOps in future modules. You can also check out these resources:

* [Azure DevOps](https://azure.com/devops?azure-portal=true)
* [DevOps Resource Center](https://docs.microsoft.com/azure/devops/learn?azure-portal=true)

## Appendix: General recommendations for migrating and consolidating tools to Azure DevOps

The following sections are optional. They provide additional information beyond what's covered in this module.

You've seen how analyzing all your existing artifacts and tools is the first step toward designing a DevOps strategy. Once you've done that, here are a few recommendations for developing migration and integration strategies you can use if you're using Azure DevOps.

### Designing an authentication and access strategy

Azure DevOps Services uses enterprise-grade authentication. You can use either a Microsoft account or Azure Active Directory (Azure AD) to protect and secure your data. Many client applications such as
Visual Studio or Visual Studio code, natively support authentication by either Microsoft Accounts or Azure AD. Eclipse can also support this, if you install a Team Explorer Everywhere plugin.

When you need a non-Microsoft tool to integrate directly with Azure DevOps Services and the tools don't directly support a Microsoft account or an Azure AD account for authentication, you can still use them by setting up personal access tokens. These tokens can be set up using Git credential managers or you can create them manually.

Personal access tokens are also useful when you need to establish access in command line tools,
or in tools and tasks in build pipelines and when calling REST-based APIs, because you don't have a UI popping out to perform the authentication. When access is no longer required you can then just revoke the personal access token.

Azure DevOps is pre-configured with default security groups. Default permissions are assigned to the default security groups. But you can also configure access at the organization level, the collection level and at the project or object level. In the organization settings in Azure DevOps,
you can configure app access policies. Based on your security policies, you might allow alternate authentication methods, allow third party applications to access via OAuth or even allow anonymous access to some projects.

For even tighter control, you can set conditional access to Azure DevOps. This offers simple ways to help secure resources when using Azure Active Directory for authentication. Conditional access policies such as multifactor authentication can help to minimize the risk of compromised credentials. As part of a conditional access policy you might require security group membership,
a particular location or network identity, a specific operating system, a managed device, or other criteria.

### Migrating and integrating artifact repositories

While you can continue to work with your existing artifact repositories in their current locations when using Azure DevOps, there are advantages to migrating them. For NuGet, Azure DevOps Services provides hosted NuGet feeds as a service. By using this service, you can often eliminate the dependencies on on-premises resources such as file shares and locally hosted instances of NuGet.Server. The feeds can also be consumed by any continuous integration system that supports authenticated NuGet feeds.

### Designing a licensing strategy

Azure DevOps has many different licensing policies designed to suit many different situations. To get a quick overview, go to [Pricing for Azure DevOps](https://azure.microsoft.com/pricing/details/devops/azure-devops-services/?azure-portal=true) to see what's available.

There is also a large number of both free and paid extensions, many of which you use to integrate third-party applications. Depending upon your current configuration, you might also decide to implement Group-Based Licensing. This makes it easier to manage licenses in Azure DevOps.
If you're planning to make this change though, it's important to avoid a situation where migration to Group-Based Licensing results in users temporarily losing their currently assigned licenses.

In addition to Azure DevOps Licensing, you need to ensure you have appropriate licenses for any third party tools that you need. Also, you need to make sure that any open-source tools that you have included have licenses that are compatible with how you intend to use them.

### Migrating and integrating source control

Similarly to artifacts, you might consider migrating your source control to Azure DevOps by using Azure Repos. However, moving your team from a centralized version control system to a distributed system like Git involves much more than learning the new commands. A successful migration to Git requires that you understand the differences in how file history and branches are handled.

The Azure DevOps team recommends the following process:

1. Evaluate the tools and processes you're using.
1. Select a branching strategy for Git.
1. Decide how to migrate history – or if you even want to.
1. Maintain your old version control system.
1. Remove binaries and executables from source control.
1. Train your team in the concepts and practice of Git.
1. Perform the actual migration to Git.

### Migrating and integrating work management tools

Migrating from other work management tools to Azure DevOps takes considerable planning. Most work management tools are highly configurable by the end user. This means that there might not be a tool available that will perform the migration without further configuration. One example is Jira.

In the Visual Studio Marketplace, [Solidify](https://marketplace.visualstudio.com/items?itemName=solidify.jira-devops-migration&azure-portal=true) offers a tool for Jira to Azure DevOps migration. It does the migration in two phases. Jira issues are exported to files and then the files are imported to Azure DevOps.

If you decide to try to write the migration code yourself, the following blog post provides sample code that might help you to get started: [Migrate Your Project From Jira to Azure DevOps](https://www.cryingcloud.com/2018/10/01/migrate-your-project-from-jira-to-azure-devops/)

### Migrating and integrating test tools

[Azure Test Plans](https://azure.microsoft.com/services/devops/test-plans/?azure-portal=true) are used to track manual testing for sprints and milestones. This allows you to track when that testing is complete.

[Apache JMeter](https://docs.microsoft.com/azure/devops/test/load-test/get-started-jmeter-test?view=azure-devops&viewFallbackFrom=vsts&azure-portal=true) is open source software written in Java and designed to load test functional behavior and measure performance.

[Pester](https://marketplace.visualstudio.com/items?itemName=richardfennellBM.BM-VSTS-PesterRunner-Task&azure-portal=true) is a tool that can be used to automate the testing of PowerShell code.

[SoapUI](https://marketplace.visualstudio.com/items?itemName=AjeetChouksey.soapui&azure-portal=true) is another testing framework for SOAP and REST testing.
