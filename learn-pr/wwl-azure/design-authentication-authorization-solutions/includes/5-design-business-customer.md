[Azure AD B2C](/azure/active-directory-b2c/overview) is a type of Microsoft Entra tenant for managing customer identities and their access to your apps. Azure AD B2C requires a Microsoft Entra tenant, but this tenant _isn't_ the same as the Microsoft Entra tenant for your organization.
- The **Microsoft Entra tenant** represents your organization.
- The **Azure AD B2C tenant** represents the identities for your customer apps. 

After you set up your Azure AD B2C tenant, you must register your app. You use user flows to manage things like user sign-ins and sign-ups. Your Azure AD B2C tenant lets you create multiple types of user flows.

:::image type="content" source="../media/application-registration.png" alt-text="Diagram that shows how business-to-customer users are registered in the Microsoft Entra tenant." border="false":::

### Things to know about Azure AD B2C

You've reviewed the B2B features of Microsoft Entra ID and considered how they might be implemented in an identity solution for Tailwind Traders. Let's look at the customer features offered by Azure AD B2C.

- Azure AD B2C provides secure authentication for your customers by using their preferred identity providers.

- You can capture sign in, preference, and conversion data for your customers.

- Azure AD B2C stores custom attributes about customers so you can use the information in your apps.

- You can use branded registration and custom UI sign-in experiences.

- The B2C option lets you separate the organization account from the customer account.

### Things to consider when using Azure AD B2C

Tailwind Traders wants to investigate how to implement identity management for users who are customer of their products. Review the following points about using the Azure AD B2C solution.

- **Consider reusable flows for user journeys**. A user journey is the path that you want people to take in your app to achieve their goal. A Tailwind Traders user might want to make a new account, update their profile, or frequently check for other users. Azure AD B2C comes with preconfigured policies called [user flows](/azure/active-directory-b2c/user-flow-overview). You can reuse the same user flows across different apps. Reusing user flows creates a consistent user journey across all apps.

- **Consider allowing users to sign in with their social identities**. Support identity providers to enable Tailwind Traders users to sign in with their existing social or enterprise accounts. There's a long [list of identity providers](/azure/active-directory-b2c/add-identity-provider) and more are being added. Social providers include Amazon, Microsoft Entra ID, Facebook, LinkedIn, Twitter, and Microsoft accounts. 

- **Consider a customizable user interface to support branding**. Customize the pages in your Tailwind Traders user flow. Write your own HTML and CSS or use built-in templates called [page layout templates](/azure/active-directory-b2c/customize-ui?pivots=b2c-user-flow).

- **Consider integration with external user stores**. Azure AD B2C provides a directory that can hold 100 custom attributes per user. However, integration with external systems is also an option. You can use Azure AD B2C for authentication, but delegate to an external customer relationship management (CRM) or customer loyalty database as the source of truth for customer data.

- **Consider third-party identity verification and proofing**. Use Azure AD B2C to facilitate identity verification and proofing for Tailwind Traders by collecting user data. Pass the data to a third-party system to perform validation, trust scoring, and approval for user account creation.

## Compare B2B to B2C identity solutions

Now that you have some basic knowledge about the Microsoft Entra identity solutions, let's compare the options for Tailwind Traders.

| <!-- Blank --> | Microsoft Entra B2B (business-to-business) | Azure AD B2C (business-to-customer) |
| --- | --- | --- |
| **Define your focus** | Tailwind Traders wants to collaborate with business partners from external organizations like suppliers, partners, and vendors. You'll support users as guest users in your directory, and they might or might not have managed IT. | Tailwind Traders wants to engage with customers of their products. You'll manage users in a separate Microsoft Entra directory / tenant. |
| **Identify your users** | Your users will represent a Tailwind Traders partner company, or be employees of Tailwind Traders. | Your users will be customers of Tailwind Traders who represent themselves. |
| **Manage user profiles** | Tailwind Traders will manage partner user profiles through access reviews, email verification, or access and blocklists. | Customer users of Tailwind Traders will manage their own profiles. |
| **Store user information** | You'll manage external users in the same directory as Tailwind Traders employees, but the external users will typically be annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on. | You'll manage external users in the Azure AD B2C directory. They're managed separately from the Tailwind Traders employee and partner directory (if any). |
| **Enable user discovery and support privacy** | Partner users of Tailwind Traders will be discoverable and they can find other users from their organization. | Customer users of Tailwind Traders will be invisible to other users. Privacy and content will be enforced. |
| **Work with identity providers** | External users will collaborate by using work accounts, school accounts, any email address, SAML and WS-Fed based identity providers, Gmail, and Facebook. | Consumer users with local app accounts (any email address or user name), various supported social identities, and users with corporate and government-issued identities via SAML/WS-Fed based identity provider federation will access the apps. |
| **Customize UI and support branding** | You expect to use customized UI branding for the host or inviting organization (Tailwind Traders). | You want the branding to be fully customizable per app or organization and not specific to Tailwind Traders. |

## WoodGrove Groceries tutorial

We prepared a tutorial to help you in the decision making process for choosing a Microsoft Entra identity solution. [WoodGrove Groceries](https://woodgrovedemo.com/?azure-portal=true) is a live web app created by Microsoft to demonstrate several Azure AD B2C features. You can read about the [WoodGrove Groceries](/azure/active-directory-b2c/overview#example-woodgrove-groceries) configuration. Take a few minutes now to complete the tutorial demo.

> [!IMPORTANT]
> After you complete the WoodGrove Groceries tutorial, take a moment to decide if Azure B2B or Azure B2C would be required by your own organization. Write down a few thoughts on how these options would be used.
