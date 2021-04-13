In this unit, you'll learn about the features and pricing for each GitHub product.

> [!NOTE]
> In many ways, this unit is merely reviewing and restating the information from GitHub's own [pricing page](https://github.com/pricing?azure-portal=true) and [documentation](https://docs.github.com/free-pro-team@latest/github/getting-started-with-github/githubs-products?azure-portal=true).

## What is the difference between accounts, products, teams, and permissions?

It's important to have a clear understanding of the difference between accounts and products.

There are three types of accounts:
- Personal user accounts
- Organization accounts
- Enterprise accounts

And there are six products:
- GitHub Free for user accounts
- GitHub Free for organizations
- GitHub Pro
- GitHub Team
- GitHub Enterprise / GitHub Enterprise Cloud
- GitHub One

The rest of this section should help you build a basic mental model of how accounts, products, teams, repository permissions, and permission levels relate to each other.  Keeping these separate but related concepts straight in your mind will provide a foundation on which to build.

Anyone can sign up for the "GitHub Free for user accounts" product. Signing up for the "GitHub Free for user accounts" will give every new user a *Personal user account*.  

If the user wants to set up a GitHub workspace for an organization, they may want to sign up for "GitHub Free for organizations", which will create an *organization account*.   When a user creates an organization, they are assigned the "Owner" permission level for that organization.

A user can create public and private repositories that belong to them personally, or can create public and private repositories that belong to the organization.

A user can invite other users to collaborate on their public and private repositories, or can invite users to collaborate on public and private repositories in an organization, though it requires an extra step or two.  

When the user invites collaborators to their personal public and private repositories, those collaborators will automatically have the permission to write to the repository.  

However, an "Owner" of an organization invites collaborators to an organization's public and private repositories by first adding them as Members of the organization, then adding them to a Team.  Each team is intended to reflect a company or group's structure, and is used to provide cascading access permissions and make it easy to notify all team members via mentions.

Each user, as a team member, is assigned a *permission* for a given repository.  There are five repository permission levels with an increasing degree of control over the repository: read, triage, write, maintain, admin.

Each user, as an organization member, is assigned a *permission level* that gives them the ability to create new teams, change the team roster, and so on.  Users with the Billing Manager permission level can only view and edit billing information.  Users with the Member permission level can create and manage organization repositories and teams.  Users with the Owner permission level can do everything members can, Owner permission level can add or remove others users to and from the organization.

Finally, a user can create one or more *enterprise accounts* by signing up for the paid GitHub Enterprise product.  When a user creates an enterprise account, they are assigned the role of *enterprise owner*.  Each user, as an enterprise owner, can add and remove organizations to and from the enterprise account.  They can manage other administrators, enforce security policies across organizations, and so on.

Keep these distinctions in mind as we discuss the features of each GitHub product.

## Free products

The remainder of this unit will focus on products.  GitHub's free products provide access to many of the most vital tools required for public and private projects without any fees.  As we noted in the previous section, users can invite collaborators to work on their repositories, or can collaborate in others' repositories.

GitHub's [pricing page](https://github.com/pricing?azure-portal=true) does a great job breaking down and explaining each of the features included across all of their products, across categories like:
- Code management
- Code workflow
- Collaboration
- Security and compliance
- Marketplace and integrations
- Support and deployment

A few key features change based on the product, for example:

- *GitHub Actions* - Automate CI/CD workflows to build, test, and deploy your code. Trigger actions from a large community of software integrations.  You get execution minutes for hosted runners to perform the automation.
- *GitHub Packages storage* - Host and publish your packages, distributing them privately or publicly via standard package managers. Packages are free for public repositories, so the limits on GitHub Packages storage describe the maximum private package capacity for a given product.

At the free tier, the amount of GitHub Actions minutes and GitHub Packages storage should be sufficient enough for most users, and provide enough room to test the features out for more active users and organizations.

| Feature | Limit |
|---|---|
| GitHub Actions minutes | 2000 |
| GitHub Packages storage | 500 MB |

### GitHub Free for user accounts

Signing up for a *GitHub Free for user account* provides the user with a *Personal user account*.  A Personal user account gives the user unlimited public and private repositories, and unlimited collaborators.

Again, refer to GitHub's pricing page for a more comprehensive list of features include, but a few of the most important features include the items in the table below.

| Feature | Explanation |
|---|---|
| GitHub Community Support | Allows users to resolve issues with the help of the user community via self-serve forums. |
| Dependabot alerts | Dependabot security updates make it easier for you to fix vulnerable dependencies in your repository. If you enable this feature, when a Dependabot alert is raised for a vulnerable dependency in the dependency graph of your repository, Dependabot automatically tries to fix it. |
| Two-factor authentication enforcement | Allows the user to strengthen their own account by requiring any attempts to log in will require two-factor authentication. |

### GitHub Free for organizations

GitHub Free for organizations allows organizations to create teams that reflect its structure, assigning permissions to users in each team to access repositories, and more.

GitHub Free for organizations builds on GitHub Free for user accounts by adding a few features for teams:

| Feature | Explanation |
|---|---|
| Team discussions | Provides a threaded discussion feature that a team can use to plan together, update one another, or talk about any topic in discussion posts on the team's page in an organization. |
| Team access controls for managing groups | Manage which individual user accounts have read or write access to each repository. |

## Paid products

GitHub's Paid products are priced on a per account, per month basis.  

> [!NOTE]
> For current prices, please refer to [GitHub's pricing page](https://github.com/pricing?azure-portal=true).

The paid products build on the free products by adding features and increasing limits.

### GitHub Pro

GitHub Pro is available for individual developers who want access to many of the features of GitHub Teams, but do not belong to an organization.  

Pro accounts get all of the features from the GitHub Free for user accounts, plus the following premium features:

| Feature | Explanation |
|---|---|
| GitHub Support via Email | A support option upgrade to the community forums. |
| Required pull request reviewers  | Ensure that pull requests have a specific number of approving reviews before collaborators can make changes to a protected branch. |
| Multiple pull request reviewers  | Lifts the restriction on GitHub Free for organizations where you’re limited to one assignee on issue assignees, pull request assignees, and pull request reviewers. |
| GitHub Pages | Use GitHub Pages to host a website about yourself, your organization, or your project directly from a GitHub repository. |
| Wikis | Host documentation for your repository in a wiki, so that others can use and contribute to your project. |
| Protected branches | Create rules to ensure that collaborators on your repository cannot make irrevocable changes to branches. They allow you to enable optional checks and requirements, like required status checks and required reviews. |
| Code owners | A repository's code owners are team members that are automatically added as reviewers to pull requests made against it.  You define code owners in a special file in a given repository. |
| Repository insights graphs | Displays a series of graphs that provides basic information about a repository, such as the repository's activity and contribution activity. |

Finally, the Pro product increases the limits of GitHub Actions and GitHub Packages. Furthermore, these features can be used on both private and public repositories.

| Feature | Limit |
|---|---|
| GitHub Actions minutes | 3000 |
| GitHub Packages storage | 2 GB |

> [!NOTE]
> GitHub Pro doesn't show up on the pricing page, but is available as an upgrade to personal user accounts once the user is logged in.  If the account already belongs to an organization, GitHub Pro will not show as an option, only GitHub Team will.

### GitHub Team

GitHub Team is the paid equivalent of GitHub Free for organizations, but with all of the benefits already discussed in GitHub Pro.  They also get the following features not included in GitHub Pro.

| Feature | Explanation |
|---|---|
| Draft pull requests | Tag your pull request as a work in progress, indicating to reviewers that you're accepting input at this early stage, but the code is not yet in a state to be fully reviewed. |
| Team pull request reviewers | Assign a pull request review to any person or team with read access to a repository. If you assign to a team, it will use a special algorithm to determine who should be assigned based on number of outstanding review requests. |
| Scheduled reminders | Set up daily reminders for you or your team of pull requests waiting for review via Slack.  Reduces time spent waiting on code reviews. |

### GitHub Enterprise

GitHub Enterprise can be hosted on-premise, or "in the cloud" using GitHub's existing infrastructure.  GitHub Enterprise accounts enjoy a greater level of support, as well as additional security, compliance, and deployment controls.

Enterprises get an increase in the degree of integration with existing on-prem or cloud services.  For example, they can synchronize their authentication with SAML to enable single sign-on by using their existing configurations stored in Active Directory Federation Services or Azure Active Directory.  Or, they can provision access to other services by using SAML or SCIM as the identity provider.  Finally, they can use GitHub Connect to share certain features and data between your GitHub Enterprise Server instance and your GitHub Enterprise Cloud organization or enterprise account on GitHub.com.

### GitHub Enterprise Cloud

The hosted cloud version of GitHub includes a dramatic increase in GitHub Actions minutes and GitHub Packages storage, per the table below.

| Feature | Limit |
|---|---|
| GitHub Actions minutes | 50,000 |
| GitHub Packages storage | 50 GB |

It also comes with a service level agreement of 99.9% monthly uptime, and provides centralize billing options.

### GitHub One

GitHub One extends GitHub Enterprise to offer the GitHub Support Premium Plus plan and GitHub Engineering Direct, providing an escalation path to GitHub's engineering team when significant issues arise.

| Feature | Explanation |
|---|---|
| GitHub Insights | A C-suite reporting tool providing visualizations of each team or repository's productivity and collaboration. |
| Advanced Security |  Find security vulnerabilities and errors in the code for your project on GitHub using a semantic code analysis engine called CodeQL. |
| GitHub Learning Lab for organizations | Helps developers learn and apply new skills through short, hands-on projects. |

## Recap

The key takeaways from this unit:

- There's an intricate relationship between products, account types, teams, repo permissions, and permission levels for organizations and enterprises.
- As far as products are concerned, there are two basic types of products: free and paid.
- Free accounts give you basic GitHub features, like unlimited private and public repositories, community-based support, and access to features like GitHub Actions and GitHub Package storage that is limited to public repos.
- Paid accounts build on the free account features, improved support options, and more GitHub Actions minutes and more GitHub Packages storage that can be used in both private and public repos.
- Paid accounts also include collaborative features (GitHub Pages, Wikis), control features (Required pull request reviewers, Code owners, protected branches), and insights via reports.
- GitHub Enterprise and One include more access to support, additional security, compliance, and deployment controls, single sign-on, and more.
- GitHub One includes C-suite analysis of productivity, better security scanning, and GitHub Learning Lab for organizations.