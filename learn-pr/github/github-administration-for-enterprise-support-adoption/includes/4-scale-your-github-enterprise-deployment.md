In this unit, you learn more about the GitHub Enterprise features that support your Enterprise organization as it grows. You also learn how to install tools from the GitHub Marketplace to help enhance your Enterprise organization.

As we discussed previously, a change in your organization's headcount, like a new contractor partnership, can increase the friction between GitHub and users or administrators. Suddenly, many more people require secure access to the code base. As an administrator, you're responsible for tasks like providing and revoking access to user identities during the defined work period. You're also responsible for using GitHub APIs to query the organization's audit log for compliance purposes, and installing GitHub applications from the Marketplace Azure Pipelines to establish standard workflows for deployment.

## More about GitHub Enterprise single sign-on capabilities

Previously, you learned that the first thing you should do as an administrator for a GitHub Enterprise organization is to enable authentication using Security Assertion Markup Language (SAML) single sign-on. When your organization deploys GitHub Enterprise services in GitHub's cloud ("GitHub Enterprise Cloud"), users can authenticate with their identity provider (IdP), which interfaces with GitHub's SAML single sign-on (SSO). Organization owners and administrators centrally manage users' identities, allowing review and revocation of SAML entities.

When you employ an identity provider, like Okta, it streamlines administrators' responsibilities to authenticate and provide ease of use to organization members. Use of an IdP provides security benefits including viewing and revoking a member's linked identity, active sessions, and authorized credentials.

You get the most out of this feature as your Enterprise organization scales up, because it's possible to perform those actions from a centralized location on GitHub. All you have to do is select your organization from **Your organizations** and then select a user from that organization's **People** tab. Under the **SAML identity linked** menu, you can identify the credentials through which the user verifies their identity, and then revoke those credentials if necessary.

**Warning:** If your organization uses team synchronization, revoking a person's SSO identity removes that person from any teams mapped to IdP groups.

## Use the GitHub APIs to extend your administrator capabilities

GitHub Enterprise Server supports the REST and GraphQL APIs. Working with these APIs can automate many administrative tasks. Including, performing changes to the Management Console, configuring Lightweight Directory Access Protocol (LDAP) sync, automating changes to organization members' access, and managing your enterprise account to monitor and log important changes to the organization.

Those last two capabilities are most relevant to you as your GitHub Enterprise organization enters a growth period, because they deal with security and compliance.

### Automate changes to organization members' access with SCIM

The System for Cross-Domain Identity Management (SCIM) standard uses the Rest API and common JSON requests to automate or streamline the provisioning and deprovisioning of users within an organization. This means less manual interaction with user data and credentials by administrators, increasing response time and decreasing the possibility of security issues. 

The following identity providers are compatible with the GitHub SCIM API for organizations:

- Microsoft Entra ID
- Okta
- OneLogin

### Manage enterprise accounts with GraphQL

Use the Enterprise Accounts API and the Audit Log API to help monitor and make changes in your organizations and maintain compliance. These APIs are only available as GraphQL APIs.

The enterprise account endpoints work for both GitHub Enterprise Cloud and GitHub Enterprise Server.

GraphQL allows you to request and return just the data you specify. For example, you can create a GraphQL query, or request for information, to see all the new organization members added to your organization. Or you can make a mutation, or change, to invite an administrator to your enterprise account.

With the Audit Log API, you can monitor when someone:

- Accesses your organization or repository settings.
- Changes permissions.
- Adds or removes users in an organization, repository, or team.
- Promotes users to admin.
- Changes permissions of a GitHub App.

The Audit Log API enables you to keep copies of your audit log data. For queries made with the Audit Log API, the GraphQL response can include data for up to 120 days.

## Use GitHub applications and actions to help scale your enterprise organization

Installing the right applications or actions in your GitHub Enterprise organization to enable connection to external services can automate a series of complex actions. For instance, a Marketplace action can report an incident to a server monitoring service like Datadog. The service can then signal the creation of an issue in the proper GitHub repository. Populate the issue with information from logs, assign it to a predesignated troubleshooter, and then flag the server monitoring service so that it checks for the event's reoccurrence after a version update.

### Contrast marketplace applications and actions

Actions are the most basic tools that an administrator can enable from the GitHub Marketplace.

- They're reusable scripts that form the basic building blocks of a workflow, or a larger script file that defines automated responses to known events. They usually execute simple responses to simple triggers. For example, creating an issue or pull request on GitHub itself after a timer expires, or an external system that you integrated sends a message.
- Running actions consumes GitHub Actions minutes (as discussed in previous units), and a cloud-hosted organization that purchases a GitHub Enterprise plan has access to 50,000 GitHub Actions minutes.
- Actions obtain access to your organization's repositories on a limited basis, like per instance of a target event or within a defined period.
- A runner hosted by GitHub or a runner hosted on a server under your control can run actions as part of a workflow. You also have the ability to modify or otherwise maintain these scripts.
- Actions don't have a user interface and don't extend the user's abilities to interact with GitHub.

GitHub applications are more complex tools that sacrifice customization and simplicity of implementation for greater functionality.

- Your organization consumes applications on a software-as-a-service basis (through subscriptions that you purchase in the GitHub Marketplace as an administrator).
- You can authorize an ongoing trust relationship with the application, instead of manually providing limited-lifetime authorization to access your organization's repositories (as with actions).
- Some applications interact with your repositories in the background, but most have their own custom user interface.
- Custom-built applications built and installed by an organization can use GitHub's REST and GraphQL APIs and interact with Git through cloning, updating and pushing a repository.
- Applications don't consume resources delivered through a GitHub Enterprise plan.

### Tips for locating apps and actions on the GitHub Marketplace

Let's say you want to reduce the workload for the DevOps teams within your organization because deadlines are getting tighter and capable users need to be able to shift to help with coding at any time. There's probably an app or action for that situation in the GitHub Marketplace! Here are a few tips for locating the right tools for the job.

:::image type="content" source="../media/marketplace-interface.png" alt-text="A screenshot of the GitHub marketplace interface":::

- **App or action?** Determine the scope of the problem you're trying to solve. If you need to automate a repetitive task in response to an event in your repository, you probably need an action. If you want to make it easier to complete numerous related tasks, or you want to extend GitHub's functionality, you probably need an application. Filter the available tools on the Marketplace by choosing between **Apps** and **Actions** in the **Types** section of the Marketplace sidebar.
- **Do you want to spend money?** Depending on your budget, you might seek apps that are available on a free or trial basis. Alternately, some of the most popular apps on the Marketplace have versions that you must pay for on a users-per-month basis. Narrow your results along these lines by expanding the **Filters** section of the Marketplace sidebar and choosing between **Free**, **Free Trials**, **GitHub Enterprise** (apps with special functionality for organizations with a GitHub Enterprise plan), and **Paid**. (There aren't any paid actions.)
- **Do you know the part of the process you want to improve?** The **Categories** section of the Marketplace sidebar allows you to filter by type of business operation, and it can also show **Recently added** apps and actions.

From the example, it sounds like you need a tool to improve the general CI/CD process. Because the original scenario supposes that your organization landed a major software development project, team leaders are likely willing to spend money to build the team's infrastructure so you can pay for a tool. An app is more likely than an action to provide general or varied process improvements, and CI/CD is the category of business operation you want to improve. Further, as an administrator for a GitHub Enterprise organization, extended functionality might be available from specific apps. App, CI/CD, Paid, or GitHub Enterprise, are all filters you can use in the Marketplace.
