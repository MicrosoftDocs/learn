
When users need to access resources in a different organization, or when a web application needs to accept sign-ins from users who belong to external identity systems, a challenge arises: how do you let someone authenticate using their own organization's identity provider to access your resources—without requiring them to create a separate account?

*Federation* is the answer. Federation enables access to services across organizational or domain boundaries by establishing *trust relationships* between separate identity providers.

## How federation works

Think of federation like passport control between countries/regions. Your passport was issued by your home country/region, but many other countries/regions accept it as proof of identity without requiring you to get a new ID from them. Federation works the same way—your organization's identity system vouches for you, and a partner's system accepts that voucher. The user signs in once with credentials they already have. No new account in the other organization is needed.

In practice, Organization A configures its identity provider to *trust* Organization B's identity provider. When a user from Organization B tries to access a resource in Organization A, Organization A's identity provider accepts the authentication that Organization B already performed and grants access based on that trust.

:::image type="content" source="../media/5-federated-identification.png" alt-text="Diagram showing a simplified view of how federation works, with a user in Domain B authenticating with IdP-B to gain shared access to a website in Domain A, whose IdP-A has a trust relationship with IdP-B." lightbox="../media/5-federated-identification.png":::

An important point: trust relationships aren't automatically bidirectional. If Organization A trusts Organization B, that doesn't mean Organization B automatically trusts Organization A. A two-way trust must be explicitly configured if both organizations need to access each other's resources.

## Federation in practice

Federation works across different vendors and platforms because identity providers use industry-standard protocols to exchange security tokens consistently. This interoperability makes federation practical in many common scenarios:

**Business-to-business (B2B) collaboration**: When two companies partner on a project, federation lets employees from one company access shared resources—a project workspace, a joint application, a collaboration portal—using their own company credentials. Administrators configure a trust relationship between the two organizations' identity providers rather than creating and managing individual guest accounts.

**Social and consumer identity providers**: When a consumer application lets users sign in with their Google, Microsoft, or GitHub account instead of creating a new account, that's a federated sign-in. The application trusts the social identity provider to authenticate the user. This approach is common in customer-facing applications where reducing sign-up friction improves adoption.

**Enterprise application integration with on-premises identity**: Organizations with on-premises Active Directory Domain Services can use federation to extend on-premises authentication to cloud services. *Active Directory Federation Services (AD FS)* is a Microsoft server role that enables organizations to share identity information with external services securely. Through AD FS, on-premises Active Directory users can access cloud applications by authenticating against the on-premises AD FS server, which issues tokens that cloud services accept.

Microsoft Entra ID supports federation across all of these scenarios, letting organizations extend trust to partners, customers, and external users without requiring those users to create new accounts or learn new credentials.
