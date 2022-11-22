Azure DevOps offers developers a suite of DevOps capabilities, including Source control, Agile planning, Build, Release, Test, and more.

But to use Azure DevOps features requires the user to first sign in using a Microsoft or GitHub Account.

However, this blocks many engaging scenarios where you want to publicly share your code and artifacts or provide a wiki library or build status page for unauthenticated users.

With public projects, users can mark an Azure DevOps Team Project as public.

This will enable anonymous users to view the contents of that project in a read-only state enabling collaboration with anonymous (unauthenticated) users that wasn't possible before.

Anonymous users will essentially see the same views as authenticated users, with non-public functionality such as settings or actions (such as queue build) hidden or disabled.

## Public versus private projects

Projects in Azure DevOps provide a repository for source code and a place for a group of developers and teams to plan, track progress, and collaborate on building software solutions.

One or more projects can be defined within an organization in Azure DevOps.

Users that aren't signed into the service have read-only access to public projects on Azure DevOps.

Private projects require users to be granted access to the project and signed in to access the services.

## Supported services

Non-members of a public project will have read-only access to a limited set of services, precisely:

 -  Browse the code base, download code, view commits, branches, and pull requests.
 -  View and filter work items.
 -  View a project page or dashboard.
 -  View the project Wiki.
 -  Do a semantic search of the code or work items.

For more information, see [Differences and limitations for non-members of a public project](/azure/devops/organizations/public/feature-differences).

## A practical example: .NET Core CLI

Supporting open-source development is one of the most compelling scenarios for public projects. A good example is the .NET Core CLI.

Their source is hosted on GitHub, and they use Azure DevOps for their CI builds.

However, if you click on the build badges in their readme, you'll not see the build results unless you were one of the project's maintainers.

Since this is an open-source project, everybody should view the full results to see why a build failed and maybe even send a pull request to help fix it.

Thanks to public projects capabilities, the team will enable just that experience. Everyone in the community will have access to the same build results, whether they are a maintainer on the project.

## How do I qualify for the free tier of Azure Pipelines for public projects?

Microsoft will automatically apply the free tier limits for public projects if you meet both conditions:

 -  Your pipeline is part of an Azure Pipelines public project.
 -  Your pipeline builds a public repository from GitHub or the same public project in your Azure DevOps organization.

## Are there limits on who can use Azure Pipelines?

You can have as many users as you want when you're using Azure Pipelines. There's no per-user charge for using Azure Pipelines.

Users with both basic and stakeholder access can author as many builds and releases as they want.

## Are there any limits on the number of builds and release pipelines that I can create?

No. You can create hundreds or even thousands of definitions for no charge. You can register any number of self-hosted agents for no cost.

## As a Visual Studio Enterprise subscriber, do I get more parallel jobs for Azure Pipelines?

Yes. Visual Studio Enterprise subscribers get one self-hosted parallel job in each Azure DevOps Services organization where they're a member.

## When you're using the per-minute plan, you can run only one job at a time.

If you run builds for more than 14 paid hours in a month, the per-minute plan might be less cost-effective than the parallel jobs model.

See [Azure DevOps Services Pricing \| Microsoft Azure](https://azure.microsoft.com/pricing/details/devops/azure-devops-services/) for current pricing.
