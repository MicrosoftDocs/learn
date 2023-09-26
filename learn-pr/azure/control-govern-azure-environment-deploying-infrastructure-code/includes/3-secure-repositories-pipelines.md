When you use automation to deploy your infrastructure, your pipeline and repository become powerful and important. Because they now represent the only way that changes are applied to your controlled environments.

Many parts of your Azure DevOps organization, GitHub repository, and pipelines need to be protected. The following table provides some of the most important elements to protect, along with examples of vulnerabilities that might occur if you don't protect those elements adequately.

| Element to protect | Example vulnerability |
|-|-|
| Your Azure DevOps organization or GitHub repository, including who has access to it and what they're allowed to do. | A disgruntled ex-employee deletes your code repository. |
| Important branches in your repository, and what needs to happen to change the code on those branches. | Somebody accidentally commits some nonsecure Bicep code onto your repository's *main* branch. |
| The code inside your repository, including your infrastructure definitions, tests, and application code. | Somebody forgets to test the code they've written, and it doesn't work correctly when it's released to production. |
| The pipeline definition. | Somebody inadvertently adds a pipeline step that writes a database connection string into the pipeline's log. |
| The agents or runners that run your pipeline. | A pipeline running against a draft pull request installs a security vulnerability onto the agent, which is later used for a production deployment. |
| Any third-party tasks or components that might run within your pipeline. | A third-party pipeline task sends your service principal's credentials to a malicious website. |
| The service principals that your pipeline uses to access Azure. | A nonproduction service principal accidentally makes a change to your production environment. |
| The secrets that your pipeline uses to access external systems. | A team member writes a new pipeline definition file for a prototype and accidentally connects it to your production environment. |

Now let's learn about some of the approaches that you can use to apply governance and controls around your code repository and deployment pipelines, in Azure DevOps and GitHub.

## Manage users and permissions

Consider how you grant access to your Azure DevOps organization or GitHub repository. Think about who has access and what they can do.

It's a good practice to use your organization's Azure Active Directory (Azure AD) instance as your pipeline's identity provider. That way, you can ensure that whenever somebody joins or leaves your organization, access to your pipeline is automatically granted or revoked. By using Azure AD, you can also easily implement protections like conditional access and multifactor authentication.

> [!NOTE]
> To use Azure AD integration with GitHub, your organization needs a GitHub Enterprise license.

You can also create *teams* (in GitHub) or *groups* (in Azure DevOps), which represent sets of users who can be granted permissions together. That way, you don't need to assign permissions individually. It's easy to change the permissions of users by adding them to and removing them from a team or group.

> [!TIP]
> Azure DevOps uses a *least privilege* permission model, which is different from the model that Azure uses. In Azure DevOps, *deny* permissions override *allow* permissions. This means if you're assigned to multiple groups with different sets of permissions, you'll be allowed to do only the actions permitted by all groups.
>
> Ensure that you understand how permissions are assigned, especially to groups.

## Protect important code branches

Your pipelines and automation should be based on identifying specific code branches, like *main*. Code on these designated branches is typically trusted and allowed to be deployed to your production environments. Apply controls to ensure that the code that's on your important branches has been verified and reviewed.

Consider using *branch protection rules* (in GitHub) or *branch policies* (in Azure Repos) to prevent direct commits to important code branches. Then, you can require your team use pull requests to merge any changes. You can apply automated checks and manual review processes to verify that the changes are valid before they're merged.

## Test and review your code

Make sure your team understands your expectations for reviewing and testing all code, including your infrastructure definitions.

Your pipeline definitions are YAML files, so they're a form of code. Changes to your pipeline definitions need to be reviewed and evaluated. Otherwise, somebody might accidentally or maliciously create a pipeline step that leaks your service principal's credentials or makes a dangerous change to your Azure estate.

Any changes to pipeline definition files need to be thoroughly reviewed. Make sure that everybody on your team understands that pipelines are highly privileged and need special attention.

## Protect your pipeline agents and runners

Your pipeline runs on *agents* (for Azure Pipelines) or *runners* (for GitHub Actions). You can think of agents and runners as virtual machines. Your pipeline definition controls those virtual machines by running the tasks and scripts that you've provided.

Both Azure Pipelines and GitHub Actions provide *hosted* agents and runners, which Microsoft or GitHub configures and maintains. The platform owner configures the machines to be compliant with recommended security practices. The platform owner's responsibilities include patching operating system vulnerabilities.

You can instead choose to use your own physical or virtual machines for your agents and runners. Machines of this type are called *self-hosted* agents and runners. If you use self-hosted agents and runners, you're responsible for ensuring that the machines are configured correctly and protected against threats.

Microsoft-hosted agents and GitHub-hosted runners are ephemeral. Any files or configuration changes to an agent or runner are destroyed when a pipeline's run ends. If you self-host your agent or runner, the same machine is likely to be used for multiple separate pipelines or environments, including production and nonproduction environments. Suppose that somebody creates a pipeline definition that modifies some important files on the agent's operating system and runs the pipeline from a pull request. The next time that a deployment runs against your production environment, it might reuse the agent. Now you have no way to predict what the impact of the corrupted file might be on your production environment.

For these reasons, it's a good practice to use Microsoft-hosted agents and GitHub-hosted runners whenever you can. If you must use self-hosted runners, carefully evaluate the risks involved in their configuration and use.

## Assess third-party components that run within your pipeline

If you use community-provided GitHub Actions or Azure DevOps extensions, understand who built them and what they do. Third-party pipeline components might have access to your service principal's credentials and therefore your entire environment in Azure.

In Azure DevOps, the organization administrator typically approves every extension before it can be used. If you're the administrator for your organization, consider the security risk involved in each component that you use. You're responsible for verifying that they're trustworthy and safe.

Whenever you use a third-party action or task, you specify the version. Consider specifying the exact version that you've reviewed. Allowing the pipeline to automatically use a later version might introduce a risk that you haven't reviewed.

## Protect your pipeline's service principals

Pipelines use service principals to access Azure and other services. It's important to protect your service principals and ensure that their credentials can't be used inappropriately. Consider applying multiple layers of protection.

First, you can consider protecting the credentials for your service principals:

> [!div class="checklist"]
>
> * Whenever possible, use *managed identities* or *workload identities* to avoid storing credentials entirely. Although you can't use managed identities or workload identities with all pipelines, it's a good practice to do so when you can.
> * Plan how you'll change, or *rotate*, your service principal's credentials on a regular basis. For example, your organization might have a policy to rotate credentials every 90 or 120 days. Consider who will be responsible for the rotation and how you'll update all of the places where the credential is used.
> * Consider designating a *secret custodian* whose role is to manage secrets, keys, and certificates so they're not exposed to other parts of the organization.

Next, think about the permissions that you grant to service principals:

> [!div class="checklist"]
>
> * Apply Azure AD Conditional Access policies to your pipeline's service principals. These policies help identify risky sign-ins and behaviors. For example, if your pipeline service principals always sign in from one geographic region, Conditional Access can detect and prevent sign-ins from unexpected locations, which might indicate that the credentials have been compromised.
> * Carefully consider the permissions that you grant to each service principal. For example, suppose you have a service principal that you use to read the configuration of a shared resource. Consider whether you can grant only *Reader* access to that service principal, because the service principal doesn't need to do anything that requires more privileges.
> * Use the minimum *scope* for each permission that you assign to a service principal. For example, if your service principal needs to deploy to only a single resource group, then scope the role assignment to that resource group instead of to the whole subscription.
> * Use separate service principals for each of your environments. That way, even if a principal's credentials are compromised or if somebody gets access to one environment, they can't access other environments.

## Protect your service connections and secrets

A *service connection* (in Azure Pipelines) or *secret* (in GitHub) contains the credentials for the service principal that the pipeline uses to access your Azure environment. It's important that you protect your service connections and secrets, and that you control which pipelines use each service connection and secret. Otherwise, you might accidentally enable a nonproduction environment to use a service principal that has access to production resources.

In Azure DevOps, when you create a service connection, you can configure it to require your approval before a new pipeline or environment can use it.

Azure DevOps also allows you to associate *checks* with specific service connections. Checks add a further layer of protection. For example, you can configure a check on a production service connection to verify that it's used only on code from your repository's *main* branch. This check helps prevent unauthorized code from being deployed to your production environment.

In GitHub, you can configure environment-specific secrets, so that when the GitHub Actions workflow is working with that environment, it provides only the secret value. By using environment-specific secrets and environment controls like approvals, you can reduce the risk that a nonproduction deployment is used to deploy to your production environment. You can also use workload identities to avoid using any credentials in your GitHub Actions workflows and eliminate the possibility that credentials might be exposed.

## Use GitHub security features

GitHub provides security features that you should evaluate and use. These features include:

- *Dependabot*, which scans your source code's dependencies for known vulnerabilities.
- *Secret scanning*, which identifies text in your repository that looks like keys or credentials. It's a bad practice to store secrets in a repository. If you're alerted to a secret in your repository, you should consider the secret's value to be compromised and then revoke or change it.
- *Auditing*, to understand who has made changes to your GitHub configuration.
- *Security overview*, which consolidates all of your security alerts across your organization's repositories.

## Use Azure DevOps audit logs

Azure DevOps provides *audit logs* to help you understand who has made changes to your pipelines, branch policies, repositories, and other resources. It's a good practice to enable auditing and to review the audit logs regularly.

## Protect your repository and pipeline

We've discussed the important controls that you can apply to your repository and pipeline. Now let's consider which controls you might use to protect each of the important elements we listed earlier in this unit:

| Element to protect | Controls to apply |
|-|-|
| Your Azure DevOps organization or GitHub repository, including who has access to it and what they're allowed to do. | <ul><li>Use Azure AD for authentication.</li><li>Use teams and groups to assign permissions.</li><li>Enable audit logging, and review audit logs regularly.</li></ul> |
| Important branches in your repository, and what needs to happen to change the code on those branches. | Apply branch protection rules or branch policies. |
| The code inside your repository, including your infrastructure definitions, tests, and application code. | <ul><li>Enforce code review requirements.</li><li>Add automated or manual tests.</li><li>On GitHub, use Dependabot and secret scanning.</li></ul> |
| The pipeline definition. | Enforce code review requirements. |
| The agents or runners that run your pipeline. | <ul><li>On Azure Pipelines, use Microsoft-hosted agents.</li><li> On GitHub Actions, use GitHub-hosted runners.</li></ul> |
| Any third-party tasks or components that might run within your pipeline. | Review the security risk associated with all third-party extensions and tasks. |
| The service principals that your pipeline uses to access Azure. | <ul><li>Use workload identities in GitHub Actions. For Azure Pipelines, use service principals and regularly rotate their credentials.</li><li>Use separate service principals for each environment.</li><li>Apply conditional access policies.</li></ul> |
| The secrets that your pipeline uses to access external systems. | <ul><li>On Azure DevOps, use approvals and checks on service connections.</li><li>On GitHub, use environment-specific secrets and workload identities.</li></ul> |
