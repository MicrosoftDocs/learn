Here, we discuss what GitHub Apps are, how they work, and how you can use them to improve your workflows. Whether you're adopting a solution built by someone else or developing one to meet your exact needs, there's always room to improve your processes.

## Extend the platform through the GitHub API

GitHub provides a robust API that enables developers to do just about anything on the platform. It's exposed via REST endpoints, so it's easy to integrate with from any platform or programming language. But the API access doesn't stand on its own. Developers wanting to share their features with others still need to package it up as an app and publish it before anyone can use it.

There are several factors to consider when choosing between incorporating an OAuth app or GitHub App into your workflow. In this section, you are introduced to GitHub Apps and OAuth Apps, their usage and permission differences, and event subscriptions.

:::image type="content" source="../media/gh-apps-oauth-apps.png" alt-text="Image of an install icon and an approve icon for GitHub Apps and OAuth Apps." :::

When customizing a GitHub workflow, you have several features available such as writing custom scripts, creating and authorizing your own OAuth Apps, or installing GitHub Apps available from the GitHub marketplace. In general, scripts can be best utilized for those one off tasks. For actions that need to be run more often, you can use the automation of OAuth and GitHub Apps to help you and your team save time and retain the optimal level of security within your workflows. There are many differences that will affect how you decide between using a GitHub App or OAuth App. Understanding these differences beforehand can reduce some headache and rework down the road and help you find the best application for your specific use case within your workflow.

At the end of this section, you will have a good understanding on the differences between a GitHub App and an OAuth App, and how to best choose an app for the right situation.

## Granting access and permissions

One of the most important considerations for allowing an app to access a GitHub repository is the permissions it requires to operate. Some apps are easy to trust, but others may be suspect. Always be sure that you're comfortable with the permissions you grant an app.

![Reviewing requested permissions and repository access.](../media/2-install-permissions.png)

> [!NOTE]
> Every app uses a unique API key to make requests for the data in your repository. When you authorize access, it's the key you're authorizing. You may revoke access to an app's key at any time from your repository settings.

## OAuth Apps

OAuth Apps provide a way to access GitHub data on behalf of a user. Because it's acting on behalf of the user, it's important to note that it will consume a GitHub licensed seat. You can create and register an OAuth App in your personal account or at the organization level if you have administrative access. An OAuth App that integrates with GitHub will disclose what type of access to the organization or repository is required. Users _authorize_ OAuth Apps, which gives the app the ability to act as the authenticated user, such as reading or modifying data. This approach is essentially an automated way to read, write, or edit GitHub data as a user. It's also important to note that authorization is limited to the resources that are accessible to the user, however, the OAuth App also gets access to all the resources that are available to the user.

> [!NOTE]
> The access level is limited by the scope of the token (user, org, repository).

For organizations with OAuth App access restrictions, the Administrator is able to grant approval to use the application. With Event subscriptions, OAuth Apps respond to activity as it happens. 

## GitHub Apps 

By contrast, GitHub Apps are _installed_ in your personal account, organizations you own, or specific repositories that you have admin access. GitHub Apps are installed and interact with GitHub as a service, not an individual user as is the case with OAuth Apps. Unlike OAuth Apps, a benefit to this is that GitHub Apps do not consume a GitHub licensed seat.

GitHub Apps access data on behalf of the application itself through a Private Key that is used to sign a JWT Token (JSON Web Token). Because they are installed on specific repositories, users can choose which repositories the app is able to access that limits the amount of data the app is able to access. Permissions define what resources the GitHub App can access via the API. Unlike OAuth Apps, GitHub Apps have customizable permissions to repository data, issues, and pull requests. This allows you to grant more granular permissions, limiting the app to read and write in only the repositories it has been allowed to access. Only organization owners can manage the setting of GitHub Apps in an organization.

GitHub Apps can be found and installed from the GitHub Marketplace. When you're searching for GitHub Apps, keep in mind that some Apps have a verified badge. This badge shows that the app is owned by an organization that has verified ownership of their domain, confirmed their email addresses with GitHub Support, and requires two-factor authentication for their organization.

:::image type="content" source="../media/apps-badge.png" alt-text="Image of a verified badge for a GitHub App." :::

- An administrator can grant permissions regarding repository administration, checks, repository contents, deployments, and issues (*The administrator changes require user acceptance*)
- An administrator can grant the app user permissions to block another user, emails, followers, GPG Keys, Git SSH Keys, starring, watching (*The administrator changes require user acceptance*)
- Event Subscriptions: Security advisory, Check suite, Create, Deployment, Fork, Label, Member, Check in, Commit comment, Delete, Deployment status, Milestone, Membership, Organization (*Administrator configures in the GH Apps UI and can be changed*)

## Choose between GitHub Apps and OAuth Apps

While GitHub Apps are an ideal way to integrate into your workflow in some situations, it can be challenging for larger organizations to make the transition from the traditional use of OAuth Apps for automation. For example, a security policy restriction may also limit an administrator's options in choosing to use these tools. 

> [!NOTE]
> As the System Administrator, you should work with your developers to find the best fit options for automation through leveraging these applications while still following your security policy.

To determine which app is the right solution for your situation, here are some important questions to consider:
  - Do I want the app to act as a user? 
  - What will the rate limit needs be?
  - What access do I want the app to have in the organization and repositories?
  - Does this app comply with our security policy?

Here are some key characteristics and differences to consider when choosing between a GitHub App or OAuth App.

| GitHub Apps                                                  | OAuth Apps                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Installing a GitHub App grants the app access to a user or organization account's chosen repositories. | Authorizing an OAuth App grants the app access to the user's accessible resources. For example, repositories they can access. |
| Installation access tokens are limited to specified repositories with the permissions chosen by the creator of the app. | An OAuth access token is limited via scopes.                 |
| An installation token identifies the app as the GitHub Apps bot. | An access token identifies the app as the user who granted the token to the app. |
| GitHub Apps have targeted permissions that allow them to request access only to what they need. | OAuth Apps can't use granular permissions.                   |
| GitHub Apps aren't subject to organization application policies. A GitHub App only has access to the repositories an organization owner has granted. | If an organization application policy is active, only an organization owner can authorize the installation of an OAuth App. If installed, the OAuth App gains access to anything visible to the token the organization owner has within the approved organization. |
| Rate limit increases can be granted both at the GitHub Apps level (affecting all installations) and at the individual installation level. | Rate limit increases are granted per OAuth App. Every token granted to that OAuth App gets the increased limit. |
| GitHub Apps can authenticate on behalf of the user, which is called user-to-server requests. The flow to authorize is the same as the OAuth App authorization flow. User-to-server tokens can expire and be renewed with a refresh token. | The OAuth flow used by OAuth Apps authorizes an OAuth App on behalf of the user. This is the same flow used in GitHub App user-to-server authorization. |
| GitHub Apps ask for repository contents permission and use your installation token to authenticate via [HTTP-based Git](https://docs.github.com/en/apps/building-github-apps/authenticating-with-github-apps/#http-based-git-access-by-an-installation). | OAuth Apps ask for `write:public_key` scope and [Create a deploy key](https://docs.github.com/en/rest/reference/repos#create-a-deploy-key) via the API. You can then use that key to perform Git commands. |

## Application access and permissions

One of the most important considerations for allowing an app to access a GitHub repository is the permissions it requires to operate. Some apps are easy to trust, but others may be suspect. Always be sure that you're comfortable with the permissions you grant an app.

Making the decision to use a GitHub app or OAuth app may depend on the level of access you want the app to access. In general, you should encourage your team to use the tool with the smallest scope to accomplish the task. An OAuth App has access to all of a user or organization owner's resources.
- OAuth Apps can have *read* or *write* access to your GitHub data
- A GitHub App can be granted access to one account without being granted access to another

## Application security

When a vulnerability is found in your application, it should be a priority and within your security policy to tell the users of your project. Quickly communicating a security issue could mean the difference between your users being able to revoke a compromised token or having sensitive data exposed. While tokens are much more secure than passwords, security can still be compromised and it is important for your organization to be prepared.

In addition to a README.md file it is recommended to add a SECURITY.md file to your repositories. The SECURITY.md file highlights security-related information for the repository. The file should include the security contacts, your organization policies, and detail the response you will take when a vulnerability is discovered.

## Reacting to events

GitHub Apps are designed to be passive. They wait for something to happen, and then react, usually via the GitHub API. When waiting for events to happen on GitHub, there are two approaches: webhooks and polling.

> [!NOTE]
> GitHub Apps aren't limited to working with GitHub data. You can just as easily wait on events that happen from other sources or perform actions that update other services.  

### Using GitHub webhooks

Webhooks are the preferred approach for event handling. When something happens on GitHub within the scope of a webhook, it's raised immediately. They push notifications that your app can listen for and process in real time. You can configure webhooks in your repository settings, including the types of events, authentication, and way the HTTP notifications are delivered.

### Polling

Sometimes webhooks aren't an option. Your app might need to live behind a corporate firewall where it can't be directly reached by GitHub. In that case, an alternative is to poll for the data you're tracking by using the GitHub API. 

### Webhook relaying

An alternative to polling for apps behind a firewall is to use a webhook forwarding service, like [smee.io](https://smee.io/?azure-portal=true). With this approach, the public service will subscribe to the repository's webhook and then relay incoming data to a client service running behind the firewall. That client service then pushes the notifications to your running app as though they came from the original source.



