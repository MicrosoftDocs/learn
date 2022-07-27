Organizations often need to collaborate on projects with people outside of their company, but they want to make sure that only authorized people can access the resources they want to share. In the financial firm scenario, we'll use cross-tenant access settings to determine who has access to which resources. 

Here, you'll learn the cross-tenant access settings that let you allow or block B2B collaboration with other organizations by default.

[Diagram showing cross-tenant access settings and B2B collaboration.]

## Managing B2B collaboration

With Azure AD B2B collaboration, an organization can invite external people to sign in to their applications and services. For added security, organizations can use cross-tenant access settings to create detailed policies that determine who has access to which resources.

There are different settings that let you control your inbound and outbound B2B collaboration. The setting you use depends on who you collaborate with and what you want to manage:

|When you're collaborating with  |And you want to manage  |Use these settings |
|---------|---------|---------|
|Other Azure AD organizations     |- Inbound and outbound B2B collaboration<br>- Access to internal and external applications<br>- Access for specific users, groups, and applications         | Cross-tenant access settings |
|Anyone (Azure AD orgs, non-Azure AD orgs, individuals)     | - Who in your organization can invite external users <br>- Whether specific domains are allowed or blocked<br>- How much of your directory you want guest users to be able to access        |External collaboration settings |

[Diagram comparing external collaboration settings with cross-tenant access settings.]

When you use cross-tenant access settings, you're setting policies for collaboration with users who are part of another Azure AD organization. By contrast, External collaboration settings apply across all types of external users and organizations. When you plan your overall B2B collaboration policies, organizations need to be aware that all of these settings can affect their B2B collaboration experience.

## Default cross-tenant access settings

Before you've updated any cross-tenant access settings, both inbound and outbound B2B collaboration settings are "Allowed" by default. Your users can invite external guests to access your resources, and they can be invited to external organizations as guests. By default, there are no partner- or organization-specific settings, and all applications and users are allowed for B2B collaboration.

As we saw in our financial firm scenario, you might want more control over who has access to your internal applications. For example, you might want to allow everyone in your organization to collaborate with external partners using the partners' applications. But if you have internal applications with data that you need to restrict access to, you can block all inbound B2B collaboration with external Azure AD organizations. All of these policies can be set using cross-tenant access settings.

[Diagram showing all the cross-tenant access settings you can configure.]

Even though your default settings come pre-configured, you can change them. When you do, the new default settings go into effect for all external Azure AD organizations.

For example, suppose you want to allow outbound B2B collaboration with other Azure AD organizations. You would make sure your default settings are set to "Allowed."

[Two screenshots showing inbound and outbound B2B collaboration set to Allowed.]

But let's say that by default, you want to block all inbound B2B collaboration so that external Azure AD users can't access your restricted internal applications. You would update your default settings by choosing to block all inbound B2B collaboration.

[Screenshot showing inbound B2B collaboration blocked.]

## Scoping cross-tenant access settings

So far, we've seen how cross-tenant access settings can apply to Azure AD organizations as a whole. All users and applications in an organization are subject to the settings. But you can also scope cross-tenant access settings to specific users, groups, or applications, meaning you have granular control over who has access to B2B collaboration and what they can access. An Azure AD Premium license is required if you want to scope settings to users, groups, and applications.

[Diagram showing individual users allowed for B2B collaboration]
