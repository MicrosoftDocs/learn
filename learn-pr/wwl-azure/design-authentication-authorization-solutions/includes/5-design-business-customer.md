[Azure AD B2C](/azure/active-directory-b2c/overview) is a type of Azure AD tenant that you use to manage customer identities and their access to your applications. 

Use Azure AD B2C to:

- Securely authenticate your customers using their preferred identity providers.

- Capture sign in, preference, and conversion data for customers.

- Store custom attributes about customers to be leveraged by your applications

- Provide branded registration and sign in experiences.

- Provide separation of your organizational accounts your customer accounts.

## How does Azure B2C work?

Azure AD B2C requires an Azure AD tenant. This tenant isn’t the same your organization’s Azure AD tenant. You use an Azure AD tenant to represent an organization. Your Azure AD B2C tenant represents the identities that are used for customer applications. 

With your Azure AD B2C tenant in place, you must register your app. You use user flows to manage things like sign-ins and sign ups. Your Azure AD B2C tenant lets you create multiple types of user flows.

:::image type="content" source="../media/application-registration.png" alt-text="Business to Customer users are registered in the Azure AD tenant.":::


## Best practices for Business to Customer

- **Configure user journeys by using policies**. A user journey is the path that you want people to take in your application to achieve their goal. For example, a user might want to make a new account, or update their profile. Azure AD B2C comes with preconfigured policies called [user flows](/azure/active-directory-b2c/user-flow-overview). You can reuse the same user flows across different applications. Reusing user flows creates a consistent user journey across all applications.

- **Use identity providers to let users sign in using their social identities**. There’s a long [list of identity providers](/azure/active-directory-b2c/add-identity-provider) and more are being added. Social providers include Amazon, Azure AD, Facebook, LinkedIn, Twitter, and Microsoft accounts. 

- **Customize your user interface**. You can customize the pages in your user flow. Write your own HTML and CSS or use built-in templates called [page layout templates.](/azure/active-directory-b2c/customize-ui?pivots=b2c-user-flow)

- **Integrate with external user stores**. Azure AD B2C provides a directory that can hold 100 custom attributes per user. However, you can also integrate with external systems. For example, use Azure AD B2C for authentication, but delegate to an external customer relationship management (CRM) or customer loyalty database as the source of truth for customer data.

- **Third-party identity verification and proofing**. Use Azure AD B2C to facilitate identity verification and proofing by collecting user data, then passing it to a third-party system to perform validation, trust scoring, and approval for user account creation.

> [!TIP]
> Take a few minutes to review the [WoodGrove Groceries tutorial.](/azure/active-directory-b2c/overview) WoodGrove Groceries is a live web application created by Microsoft to demonstrate several Azure AD B2C features.

With some basic knowledge on identity solutions, let’s review our design choices. 

| Feature | Azure AD B2B| Azure AD B2C |
| - | - | - |
| Purpose| Collaborating with business partners from external organizations like suppliers, partners, vendors. Users appear as guest users in your directory. These users may or may not have managed IT.| Customers of your product. These users are managed in a separate Azure AD directory / tenant. |
| Users| Partner users acting on behalf of their company or employees of the company| Customers acting as themselves. |
| Profiles| Managed through access reviews, email verification, or access/deny lists.| Users manage their own profiles. |
| Discoverability| Partner users are discoverable and can find other users from their organization.| Customers are invisible to other users. Privacy and content are enforced. |
| Identity providers supported| External users can collaborate using work accounts, school accounts, any email address, SAML and WS-Fed based identity providers, Gmail, and Facebook.| Consumer users with local application accounts (any email address or user name), various supported social identities, and users with corporate and government-issued identities via SAML/WS-Fed based identity provider federation. |
| External user management| External users are managed in the same directory as employees but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on.| External users are managed in the Azure AD B2C directory. They're managed separately from the organization's employee and partner directory (if any). |
| Branding| Host/inviting organization's brand is used.| Fully customizable branding per application or organization. |


> [!IMPORTANT]
> Take a few minutes to decide if Azure B2B or Azure B2C would be required by your organization. Write down a few thoughts on how these options would be used. 