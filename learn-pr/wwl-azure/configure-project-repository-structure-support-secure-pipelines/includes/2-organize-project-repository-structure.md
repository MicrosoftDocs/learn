There are different ways to organize a project and repository structure in Azure DevOps.

In the banking institution example, you would need to securely organize your different projects and repositories to allow for team collaboration or isolation as needed.

Here, you’ll examine fundamental concepts for giving access and permissions, best practices for organizing projects and repositories, and possible project and repository structures.

## Best practices for organizing projects and repositories

Overall, it's advisable to use your business structure as a guide for the number of organizations, projects, and teams that you create in Azure DevOps. Have at least one organization, which may represent your company, your larger collection of code projects, or even multiple related business units.

An organization in Azure DevOps is a mechanism for organizing and connecting groups of related projects. Examples include business divisions, regional divisions, or other enterprise structures. You can choose one organization for your entire company or separate organizations for specific business units.

A single code repository or project only needs one organization. If you have separate teams that need to work on code or other projects in isolation, consider creating separate organizations for those teams.

Within an organization, you can take one of these approaches:

- Create a single project that contains many repos and teams
- Create many projects, each with its own set of teams, repos, builds, work items, and other elements

### Single project

A single project puts all of the work at the same "portfolio" level for the entire organization. Your work has the same set of repos and iteration paths. With a single project, teams share source repos, build definitions, release definitions, reports, and package feeds. You might have a large product or service that's managed by many teams. Those teams have tight inter-dependencies across the product life cycle. You create a project and divide the work using teams and area paths. This setup gives your teams visibility into each other's work, so the organization stays aligned. Your teams use the same taxonomy for work item tracking, making it easier to communicate and stay consistent.

### Multiple projects

If you decide to create a project team for each distinct product or feature team, each team will have its own backlog. You can configure teams and backlogs into a hierarchical structure so you can more easily track progress across teams, manage portfolios, and generate rollup data. Having several projects shifts the administration burden and gives your teams more autonomy to manage the project as the team decides. It also provides greater control of security and access to assets across the different projects. However, having team independence with many projects creates some alignment challenges. If each project is using a different process or iteration schedule, it can make communication and collaboration difficult if the taxonomies aren't the same.

When you're considering many projects, keep in mind that Git repo portability makes it easy to migrate repos (including full history) between projects. Other history can't be migrated between projects. Examples are push and pull request history.

When you map projects to business units, your company gets a single organization and sets up many projects with one or more projects representing a business unit. All Azure DevOps assets of the company are contained within this organization and located within a given region (for example, Western Europe).

Consider the following guidance for mapping your projects to business units:

|  | **One project, many teams** | **One organization, many projects, and teams** | **Many organizations** |
|---------|-------------------------|---------|---------|
| **General Guidance**    |     Best for smaller organizations or larger organizations with highly aligned teams.                    |  Good when different efforts require different processes.       |     Useful as part of Azure DevOps legacy on-premises migrations and for hard security boundaries between organizations. Used with multiple projects and teams within each organization.    |
| **Scale**    |    Supports tens of thousands of users and hundreds of teams, but best at this scale if all teams are working on related efforts.                     |   Same as with one project, but many projects may be easier.      |         |
| **Process**    |    Aligned processes across teams; team flexibility to customize boards, dashboards, and so on.                     | Independent processes for each project. For example, different work item types, custom fields, and so on.        |    Same as many projects.     |
| **Collaboration**    | Highest default visibility and reuse between work and assets of different teams.                        |      Good visibility and reuse are possible, but it's easier to hide assets between projects whether intentional.   |    Poor visibility, collaboration, and reuse between organizations.     |
| **Roll-up reporting and portfolio management**    |     Best ability to roll up across teams and coordinate between teams.                    |      Good reporting possible across projects. More difficult for cross-project roll-up and team coordination.   |      No roll-up or coordination between organizations.   |
| **Security/isolation**    |     Can lock down assets at a team level, but default is open visibility and collaboration.                    |   Better ability to lock down between projects. By default, provides good visibility within projects and good isolation across projects.      |     Hard boundaries across organizations; excellent isolation and minimal ability to share across organizations.    |
| **Context switching**    |     Easiest for teams to work together and for users to switch between efforts.                    |    Relatively easy for users to work together and switch contexts between efforts.     |   More difficult for users having to work across different organizations.      |
| **Information overload**    |    By default, all assets are visible to users who make use of “favorites” and similar mechanisms to avoid “information overload.”                     |   Reduced risk of information overload; most project assets hidden across project boundaries.     |   Assets across organizations are isolated, reducing risk of information overload.     |
| **Administrative overhead**    |    Much administration is delegated down to individual teams. Easiest for user licensing and org-level administration. More work may be needed if alignment is required between efforts.                     |  More administration at the project level. More overhead, but can be useful when projects have different administrative needs.      |  As with more projects, there's more administrative overhead, which enables more flexibility between orgs.     |

### Organize and secure repositories

You can organize your repositories in Azure Repos by using folders and adding specific groups and permissions to the repository. You can also use branch policies to secure your repositories. Branch policies allow you to:

- Require a minimum number of reviewers
- Require a minimum number of approvers
- Require a minimum number of successful builds
- Require linked work items

Another way to organize your repositories is to use Git submodules. Git submodules allow you to keep a Git repository as a subdirectory of another Git repository. This lets you clone another repository into your project and keep your commits separate.

If your pipeline consumes source code or is defined in Azure Repos, you must fully understand the [Azure Repos permissions model.](https://learn.microsoft.com/azure/devops/organizations/security/permissions) In particular, a user with **Create Branch** permission at the repository level can introduce code to the repo even if that user lacks **Contribute** permission.

- **Keep sensitive files out with .gitignore**: To help avoid the risk of someone inadvertently committing sensitive data, such as an API key or private configuration data is to build and maintain .gitignore files. These files instruct client tools, such as the git command line utility, to ignore paths and patterns when aggregating files for a commit.

- **Remove sensitive data from a repository**: Project participants should always be on the lookout for commits containing data that shouldn't be included in the repository or its history.

- **Create branch protection rules**: You can create branch protection rules to enforce certain workflows for one or more branches, such as requiring an approving review or passing status checks for all pull requests merged into the protected branch.

- **Add a CODEOWNERS file**: By adding a CODEOWNERS file to your repository, you can assign individual team members or entire teams as code owners to paths in your repository. These code owners are then required for pull-request reviews on any changes to files in a path that they're configured for.

## Possible project and repository structures

As previously discussed, the possibilities to structure your projects and repositories are endless depending on the idiosyncrasies of your business. You may want to map your organizations and projects in Azure DevOps to your enterprise, business unit, and team structure. And you may want to create one or more repositories under a single project for better version control and security.

The following image displays a sample of how your company could structure its organizations, projects, work items, teams, and repos.

![Diagram showing an Azure DevOps structure with three organizations named Contoso A, Contoso B, and Contoso C. Contoso A includes Project 1, which is separated into Team 1, Repo 1, Repo 2, and Repo 4. Contoso B includes Project 2, which is separated into Repo A, Repo B, and Team 2, which is also divided into Team 2a, and Team 2b.  Contoso C includes Project 3 and Project 4. Project 3 is separated into Repo 3 and Team 3, which is also separated into Team X, Team Y, and Team Z. Project 4 is divided into Team 4, Team Z and Repo 5.](../media/azure-devops-org-project-team-visual.png)

### Shared repo vs. forked repos

It's recommended to use a shared repo within a trusted organization. Developers use branches to maintain isolation of their changes from one another. With a good branching and release strategy, a single repo can scale to support concurrent development for more than a thousand developers. For more information about branching and release strategy, see [Branch strategically.](https://learn.microsoft.com/azure/devops/repos/tfvc/branch-strategically)

Forks can be useful when you're working with vendor teams that shouldn't have direct access to update the main repository. Forks can also be useful in scenarios where many developers contribute infrequently, such as in an open-source project.

When you're working with forks, you may want to maintain a separate project to isolate the forked repos from the main repo. There may be added administrative overhead, but it keeps the main project cleaner. For more information, see [Fork your repository.](https://learn.microsoft.com/azure/devops/repos/git/forks/)

## Create a project and repository structure

Creating a clear project and repository structure is fundamental for improving security and you can do it by following an incremental approach. The security recommendations you choose to implement will depend a lot on the needs, practices, and policies of your organization.

You can start by separating groups of resources by team projects, and defining what resources your pipeline can access based on project settings and containment. Every job in your pipeline receives an access token with permissions to read open resources. If you decide to shut off pipeline access to some of these resources, then your decision applies to all pipelines in a project as a specific pipeline can’t be granted access to an open resource. That’s why it's advised that you isolate project resources from one another.

You would usually create one repository per project but, as previously discussed, it's also possible to create multiple repositories. Azure Repos provides two types of repositories: Git and TFVC. Projects can have repos of each type. What you need to know is that:

- **Git** is a distributed version control system that allows multiple developers to work on the same codebase at the same time. It enables a great amount of flexibility in developer workflows and integrates with nearly every relevant tool in the developer ecosystem. By default, new projects have an empty Git repository and there’s no limit on the amount of Git repos that can be added to a project.

- **TFVC**, on the other hand, is a centralized version control system that allows developers to manage their code changes in a centralized repository. Unlike Git, only one TFVC repository is allowed for a project. But, within that repo, folders, and branches are used to organize code for multiple products and services, if wanted.

One project containing multiple repos works well if the products/services are working on a coordinated release schedule. If developers are frequently working with multiple repos, keep them in a single project to ensure the processes remain shared and consistent. It’s easier to manage repo access within a single project, as access control and options like case enforcement and max file size get set at the project level. You can manage the access controls and settings individually, even if your repos are in a single project. If the products stored in multiple repos work on independent schedules or processes, you can split them into multiple projects.

Base your decision for one vs. many repositories on the following factors and tips:

- Code dependencies and architecture.

- Put each independently deployable product or service in its own repository.

- Don’t separate a codebase into many repositories if you expect to make coordinated code changes across those repos, as no tools can help coordinate those changes.

- If you have many disconnected services, one repo per service is a good strategy.
