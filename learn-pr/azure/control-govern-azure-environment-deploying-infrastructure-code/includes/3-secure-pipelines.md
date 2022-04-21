When you use automation to deploy your infrastructure, your pipeline and repository becomes very powerful and important because they represent the only way that changes are applied to your controlled environments.

There are many different parts of your Azure DevOps organization, GitHub repository, and pipelines that each need to be protected. The table below provides some of the most important elements to protect, and an example of a vulnerability that might occur if you don't protect it adequately.

| Element to protect | Example vulnerability |
|-|-|
| Your Azure DevOps organization or GitHub repository, including who has access to it and what they're allowed to do. | A disgrunted ex-employee deletes your code repository. |
| Important branches in your repository, and what needs to happen to change the code on those branches. | Somebody accidentally commits some insecure Bicep code onto your repository's *main* branch. |
| The code inside your repository, including your infrastructure definitions, tests, and application code. | Somebody forgets to test the code they've just written, and it doesn't work correctly when it's released to production. |
| The pipeline definition. | Somebody inadvertently adds a pipeline step that logs a database connection string into the pipeline's log. |
| Any third-party tasks or components that might run within your pipeline. | A third-party pipeline task logs your service principal's credentials to a malicious website. |
| The service principals that your pipeline uses to access Azure. | A non-production service principal accidentally makes a change to your production environment. |
| The secrets that your pipeline uses to access external systems. | A team member writes a new pipeline definition file and uses it to log the production environment's service principal's credentials. |

Throughout the rest of this unit, you'll learn about some of the approaches you can use to apply governance and controls around your code repository and deployment pipelines.

## Manage users and permissions

Consider how you'll grant access to your Azure DevOps organization or GitHub repository, including both who has access and what they can do.

It's a good practice to use your organization's Azure AD as your pipeline's identity provider. Then, you can ensure that whenever somebody joins or leaves your organization, access to your pipeline is automatically granted or revoked. By using Azure AD, you can also easily implement protections like conditional access and multifactor authentication.

> [!NOTE]
> To use Azure AD integration with GitHub, your organization needs a GitHub Enterprise license.

You can also create *teams* (in GitHub) or *groups* (in Azure DevOps), which represent sets of users who can be granted permissions together. It's a good practice to define teams and then to assign permissions to the teams instead of to individual users. That way, it's easy to change the permissions of users by adding them to and removing them from teams.

## Protect important code branches

Your pipelines and automation are based around identifying specific code branches, like *main*. Code on these designated branches might be considered to be trusted, and deployed through to your production environments. So, it's important to apply controls to ensure that the code that's on your important branches has been verified and reviewed.

Consider using branch protection policies to prevent direct commits to important code branches. Then, you can require your team use pull requests to merge any changes, and you can apply automated and manual checks and review processes to verify that the changes are valid.

## Test and review your code

Make sure your team understands your expectations for reviewing and testing all code, including your infrastructure definitions.

Remember that your pipeline definitions are a form of code, too, and changes need to be reviewed and evaluated. Otherwise, somebody might accidentally or maliciously create a pipeline step that leaks your production credentials or makes a dangerous change to your Azure environment. Ensure your team is aware that any changes to pipeline definition files needs to be thoroughly reviewed, and that everybody understands that pipelines are so highly privileged that they need to be given special attention.

## Assess third-party components that run within your pipeline

If you use community-provided GitHub Actions or Azure DevOps extensions, understand who built them and what they do. Third-party pipeline components have access to your service principal's credentials, and therefore they might have access to your entire Azure environment. Consider the security risk involved in each component you use, and remember that you're responsible for verifying that they don't do anything malicious.

## Protect your pipeline's service principals

Pipelines use service principals to access Azure and other environments. It's important to protect your service principals, and ensure that their credentials can't be used inappropriately. Consider applying multiple layers of protection.

First, you can consider protecting the credentials for your service principals:

* Whenever possible, use *managed identities* or *workload identities* to avoid storing credentials entirely. While you can't use managed identities or workload identities with all pipelines, if you can, it's a good practice to do so.
* Plan how you will change, or *rotate*, your service principal's credentials on a regular basis. For example, your organization might have a policy to rotate credentials every 90 or 120 days. Consider who will be responsible for doing so, and how you'll update all of the places where the credential is used.
* Consider designating a *secret custodian* - somebody whose role is to handle and manage secrets, keys, and certificates, to avoid exposing them to other parts of the organization.

Next, think about the permissions that your service principals are granted:

* Apply Azure Active Directory (Azure AD) *conditional access* policies to your service principals, which helps to identify risky sign-ins and behaviors. <!-- TODO when it's GA? -->
* Carefully consider the permissions that you grant to each service principal. For example, suppose you have a service principal that you use to read the configuration of a shared resource. Consider whether you can grant *Reader* access to that service principal, since it doesn't need to do anything more.
* Use separate service principals for each of your environments. That way, even if a principal's credentials are compromised or if somebody gets access to one environment, they can't access other environments.

## Protect your Azure Pipelines service connections

In Azure Pipelines, a *service connection* contains the credentials for a service principal to use to access your Azure environment. It's important that you protect your service connections, and that you control which pipelines use each service connection. Otherwise, you might accidentally enable a non-production environment to use a service principal with access to production resources. When you create a service connection, you can configure it to require your approval before it can be used by a new pipeline.

You can also associate *checks* with specific service connections, which adds a further layer of protection. For example, you can configure a production service connection to include a check that verifies it's only used on code from your repository's *main* branch. This check helps to prevent unauthorized code from being deployed to your production environment.

## Use GitHub security features

GitHub provides a suite of security features, which you should evaluate and use. These features include:

- Dependsabot, which scans your source code's dependencies for known vulnerabilities.
- Secret scanning, which identifies text in your repository that looks like secrets. It's a bad practice to store secrets in a repository, so if you're alerted to a secret in your repository you should consider it to be compromised and you should revoke or change it.
- Auditing, to understand who has made changes to your GitHub environment.
- Security overview, which consolidates all of your security alerts across your organization's repositories.

## Use Azure DevOps audit logging

Azure DevOps provides *audit logs*, to help you to understand who has made changes to your pipelines, branch policies, repositories, and other resources. It's a good practice to enable auditing, and to review the audit logs regularly.
