Controlling access to your company's data and applications is the foundation of your enterprise security strategy. Every GitHub Enterprise user's experience begins with logging in. Before a user can access your GitHub organization, they must authenticate by supplying credentials that confirm their identity. For an individual account, users *can* log in with only a user name and password, but every GitHub user can and should enable 2FA (two-factor authentication) for a more secure authentication process.

A challenge you may face in your organization is how to balance the ease of use with an authorization process while maintaining secure best practices. Setting up your team for success requires ease of access for the user under the umbrella of secure organizational requirements.

Configuring authentication is the first step in ensuring secure software development in your enterprise. The good news is that using the tools available with your IdP is critical to getting the most value from GitHub.

## Organization management through SAML SSO

An important component of an enterprise security strategy is SAML SSO. It provides a link between the IdP authorization and access to service providers (SaaS). This form of authentication allows users to sign in to all their applications with one set of credentials. Through SAML, the IdP authenticates users and grants authorization to services like GitHub. When a user logs into GitHub, they can view the enterprises of which they're members. However, if the user tries to access repository data, it will prompt for enterprise credentials (Enterprise ID).

As the Enterprise Administrator, you're responsible for the authorization of user access and permissions. Limiting a user's access to only the resources they need is important when securing your repository. This responsibility can also include routine audit events and maintaining tightly scoped access. As an administrator of a repository, you have an overview of every user with their specific access within the repository. You can also easily export this data to a CSV file.

:::image type="content" source="../media/repository-permission-list-example.png" alt-text="Screenshot of an example of admin repository permission list review.":::

You need to configure SAML SSO for a GitHub organization with the IdP you're using. If you have specific questions on how to implement SAML SSO with your chosen IdP, you can find details in the documentation for each supported IdP. Below is a list of the SAML IdPs that GitHub currently supports:

- Active Directory Federation Services (AD FS)
- Azure Active Directory (Azure AD)
- Okta
- OneLogin
- PingOne
- Shibboleth

> [!NOTE]
> GitHub offers limited support for all identity providers that implement the SAML 2.0 standard.

You can accomplish more access management when using multiple organizations. You can use organizations to create distinct groups of users within your company, such as divisions or groups working on similar projects. Public and internal repositories that belong to an organization are accessible to members of other organizations in the enterprise. Private repositories are inaccessible to anyone who isn't a member of the organization.

## Organization private information

When an organization member creates a repository, they can choose to make the repository public or private. In addition, when creating the repository in an organization that's owned by an enterprise account, they can choose to make the repository internal. Public repositories are accessible to everyone on the internet. Private repositories are only accessible to the user who created the repository and the people with whom they explicitly share access. Keep in mind that certain organization members have access to organization internal repositories.
