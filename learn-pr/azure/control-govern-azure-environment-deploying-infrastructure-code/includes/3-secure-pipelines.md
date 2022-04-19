When you use a pipeline to deploy your infrastructure, the pipeline becomes very powerful. It's the only way that changes are applied to your controlled environments. In this unit, you'll learn about some of the approaches you can use to apply governance and controls around your deployment pipelines. 

## Protect your pipeline's secrets

Pipelines use service principals to access Azure and other environments. It's important to protect your service principals, and ensure that their credentials can't be used inappropriately. Consider applying multiple layers of protection.

First, you can consider protecting the credentials for your service principals:

* Whenever possible, use *managed identities* or *workload identities* to avoid storing credentials entirely. While you can't use managed identities or workload identities with all pipelines, if you can, it's a good practice to do so.
* Plan how you will change, or *rotate*, your service principal's credentials on a regular basis. For example, your organization might have a policy to rotate credentials every 90 or 120 days. Consider who will be responsible for doing so, and how you'll update all of the places where the credential is used.
* Consider designating a *secret custodian* - somebody whose role is to handle and manage secrets, keys, and certificates, to avoid exposing them to other parts of the organization.

Next, think about the permissions that your service principals are granted:

* Apply Azure Active Directory (Azure AD) *conditional access* policies to your service principals, which helps to identify risky sign-ins and behaviors. <!-- TODO when it's GA? -->
* Carefully consider the permissions that you grant to each service principal. For example, suppose you have a service principal that you use to read the configuration of a shared resource. Consider whether you can grant *Reader* access to that service principal, since it doesn't need to do anything more.
* Use separate service principals for each of your environments. That way, even if a principal's credentials are compromised or if somebody gets access to one environment, they can't access other environments.

## Manage users, groups, and permissions

Even if you manage all of your service principals and pipeline permissions properly, it's meaningless unless you ensure that your pipeline's user accounts and permissions are protected. Otherwise, a user might be able to use accidentally or maliciously modify your pipeline's configuration or change its permission to do something you don't intend.

It's a good practice to use your organization's Azure AD as your pipeline's identity provider. Then, you can ensure that whenever somebody joins or leaves your organization, access to your pipeline is automatically granted or revoked. By using Azure AD, you can also easily implement protections like conditional access and multifactor authentication.

::: zone pivot="github"

> [!TIP]
> Azure AD integration requires GitHub Enterprise.

::: zone-end

::: zone pivot="github"

You can also create *teams*, which represent sets of users. It's a good practice to define teams and then to assign permissions to the teams instead of to individual users. That way, it's easy to change the permissions of users by adding them to and removing them from teams.

::: zone-end

::: zone pivot="azuredevops"

You can also create *groups*, which represent sets of users. It's a good practice to define groups and then to assign permissions to the groups instead of to individual users. That way, it's easy to change the permissions of users by adding them to and removing them from groups.

::: zone-end

## Assess third-party components

If you use community-provided GitHub Actions or Azure DevOps extensions, ensure you understand their provenance and consider the security risk.

::: zone pivot="azuredevops"

## Use Azure DevOps security features

::: zone-end

TODO

::: zone pivot="github"

## Use GitHub security features

For example, use Dependsabot, secret scanning, auditing, etc. Use GitHub's Security Overview

::: zone-end

## Protect important code branches

Ensure you have a clear plan for how you protect important branches, like *main*. Use controls like automated checks and enforced code reviews. Ensure that you don't allow changes to your protected branches unless they follow your processes.

## Review changes to your pipeline definitions

TODO

## Test and review your code

Make sure your team is across your expectations for reviewing and testing all code, including IaC.
