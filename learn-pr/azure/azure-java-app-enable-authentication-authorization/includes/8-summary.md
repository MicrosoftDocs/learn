<!--

See here for general guidance on summary units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit?branch=master

The final unit of a module must follow the above guidance, and be named "Summary".

Modules that use the sandbox should usually contain the following include in the summary unit:
[!include[](../../../includes/azure-sandbox-cleanup.md)]

Summary units often contain a subsection called "Learn more" or "Further reading", with a bulleted list of appropriate external links

-->

You have successfully secured your Java web application by allowing only the employees of your company to sign in with Azure Active Directory. Your application can also access information about the user and much more from the Microsoft Graph API with the users consent.

 In this module, you learned how to enable authentication and authorization in a Java web application by:

- Registering the web application with Azure Active Directory on the Azure Portal
- Adding sign in flows using Microsoft Authentication Library for Java (MSAL4J)
- Accessing user information from the Microsoft Graph API with the help of Microsoft Authentication Library for Java (MSAL4J) and the Microsoft Graph SDK for Java

## Clean up

You can delete your application registration on Azure Portal as follows:

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. If you have access to multiple tenants, in the top menu, use the **Directory + subscription** filter to select the tenant in which you registered the application.
1. Search for and select **Azure Active Directory**.
1. Under **Manage**, select **App registrations**.
1. Under **Owned applications**, search for and select the application you registered (the application named `java-servlet-webapp-authentication` in this module).
1. In your application registration page, select **Delete** in the top left corner.
1. In the **Delete app registration** prompt, check the box indicating that you understand the implications of deleting the application. Then select **Delete** to confirm the deletion of the application.

## References

- [Authentication flows and app scenarios](https://docs.microsoft.com/azure/active-directory/develop/authentication-flows-app-scenarios)
- [MSAL overview](https://docs.microsoft.com/azure/active-directory/develop/msal-overview)
- [Microsoft Authentication Library for Java](https://github.com/AzureAD/microsoft-authentication-library-for-java)
- [Microsoft Graph overview](https://docs.microsoft.com/graph/overview)
- [Microsoft Graph SDK for Java](https://github.com/microsoftgraph/msgraph-sdk-java)
