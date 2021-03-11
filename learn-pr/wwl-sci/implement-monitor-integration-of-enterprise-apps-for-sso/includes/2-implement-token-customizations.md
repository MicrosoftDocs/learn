You can specify the lifetime of a token issued by Microsoft identity platform. Additionally, you can set token lifetimes for all apps in your organization, for a multi-tenant (multi-organization) application, or for a specific service principal in your organization.  In Azure AD, a policy object represents a set of rules that are enforced on individual applications or on all applications in an organization. Each policy type has a unique structure, with a set of properties that are applied to objects to which they are assigned.

You can designate a policy as the default policy for your organization. The policy is applied to any application in the organization, as long as it is not overridden by a policy with a higher priority. You also can assign a policy to specific applications. The order of priority varies by policy type.

## Configure authentication session management with Conditional Access

In complex deployments, organizations might have a need to restrict authentication sessions. These complex scenarios might include:

- Resource access from an unmanaged or shared device.

- Access to sensitive information from an external network.

- High impact users.

- Critical business applications.

Conditional Access controls allow you to create policies that target specific use cases within your organization without affecting all users.

For more information see the link in the resources at the end of this module.

