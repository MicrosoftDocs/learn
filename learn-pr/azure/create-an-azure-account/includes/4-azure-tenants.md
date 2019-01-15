As you've seen, your Azure account is a globally unique entity that gives you access to your Azure subscriptions and services. Authentication for your account is performed using Azure Active Directory (Azure AD). Azure AD is a modern identity provider that supports multiple authentication protocols to secure applications and services in the cloud. 

> [!IMPORTANT]
> Azure AD is _not_ the same as Windows Active Directory. Windows Active Directory is focused on securing Windows desktops and servers. In contrast, Azure AD is all about web-based authentication standards such as OpenID and OAuth.

Users, applications, and other entities registered in Azure AD aren't all lumped into a single global service. Instead, Azure AD is partitioned into separate _tenants_. A tenant is a dedicated, isolated instance of the Azure Active Directory service, owned and managed by an organization. When you sign up for a Microsoft cloud service subscription such as Microsoft Azure, Microsoft Intune, or Office 365, a dedicated instance of Azure AD is automatically created for your organization.

When it comes to Azure AD tenants, there is no concrete definition of "organization" &mdash; tenants can be owned by individuals, teams, companies, or any other group of people. Tenants are commonly associated with companies. If you sign up for Azure with an email address that's not associated with an existing tenant, the sign-up process will walk you through creating a tenant, owned entirely by you.

> [!TIP]
> The email address you use to sign in to Azure can be associated with more than one tenant. You might see this if you have an Azure account and you use Microsoft Learn's Azure Sandbox to complete exercises. In the Azure portal, you can only view resources belonging to one tenant at a time. To switch the tenant, you're viewing resources for select the **Book and filter** icon at the top of the portal and choose a different tenant in the **Switch directory** section.

Azure AD tenants and subscriptions have a many-to-one trust relationship: A tenant can be associated with multiple Azure subscriptions, but every subscription is associated with only one tenant. This structure allows organizations to manage multiple subscriptions and set security rules across all the resources contained within them.

Here's a simple representation of how accounts, subscriptions, tenants, and resources work together.

![An illustration showing two different Azure AD tenants. One tenant has two subscriptions, and each subscription is linked to a set of Azure resources. The other tenant has one subscription that is linked to a different set of Azure resources.](../media/4-azure-ad-tenant.png)

Notice that each Azure AD tenant has an _account owner_. This is the original Azure account that is responsible for billing. You can add additional users to the tenant, and even invite guests from other Azure AD tenants to access resources in subscriptions.