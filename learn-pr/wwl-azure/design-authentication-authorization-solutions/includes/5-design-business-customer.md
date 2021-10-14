[Azure AD B2C](/azure/active-directory-b2c/overview) is a type of Azure AD tenant that you use to manage customer identities and their access to your applications. 

Use Azure AD B2C to:

- Securely authenticate your customers using their preferred identity providers.

- Capture sign in, preference, and conversion data for customers.

- Store custom attributes about customers to be leveraged by your applications

- Provide branded registration and sign in experiences.

- Provide separation of your organizational accounts your customer accounts.

### How does Azure B2C work?

Azure AD B2C requires an Azure AD tenant. This tenant isn’t the same your organization’s Azure AD tenant. You use an Azure AD tenant to represent an organization. Your Azure AD B2C tenant represents the identities that are used for customer applications. 

With your Azure AD B2C tenant in place, you must register your app. You use user flows to manage things like sign-ins and sign ups. Your Azure AD B2C tenant lets you create multiple types of user flows.

:::image type="content" source="../media/application-registration.png" alt-text="Business to Customer users are registered in the Azure AD tenant.":::


### Best practices for Business to Customer

- **Configure user journeys by using policies**. A user journey is the path that you want people to take in your application to achieve their goal. For example, a user might want to make a new account, or update their profile. Azure AD B2C comes with preconfigured policies called [user flows](/azure/active-directory-b2c/user-flow-overview). You can reuse the same user flows across different applications. Reusing user flows creates a consistent user journey across all applications.

- **Use identity providers to let users sign in using their social identities**. There’s a long [list of identity providers](/azure/active-directory-b2c/add-identity-provider) and more are being added. Social providers include Amazon, Azure AD, Facebook, LinkedIn, Twitter, and Microsoft accounts. 

- **Customize your user interface**. You can change the look of the pages in your user flow. Write your own HTML and CSS or use built-in templates called [page layout templates.](/azure/active-directory-b2c/customize-ui?pivots=b2c-user-flow)

- **Integrate with external user stores**. Azure AD B2C provides a directory that can hold 100 custom attributes per user. However, you can also integrate with external systems. For example, use Azure AD B2C for authentication, but delegate to an external customer relationship management (CRM) or customer loyalty database as the source of truth for customer data.

- **Third-party identity verification and proofing**. Use Azure AD B2C to facilitate identity verification and proofing by collecting user data, then passing it to a third-party system to perform validation, trust scoring, and approval for user account creation.

> [!TIP]
> Take a few minutes to review the [WoodGrove Groceries tutorial.](/azure/active-directory-b2c/overview) WoodGrove Groceries is a live web application created by Microsoft to demonstrate several Azure AD B2C features.
