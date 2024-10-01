You've successfully secured your Java web application by allowing only your company's employees to sign in with Microsoft Entra ID. Your application can also access information about the user and much more from the Microsoft Graph API with the users' consent.

 In this module, you learned how to enable authentication and authorization in a Java web application by:

- Registering the web application with Microsoft Entra ID on the Azure portal.
- Adding sign in flows using Microsoft Authentication Library for Java (MSAL4J).
- Accessing user information from the Microsoft Graph API with the help of Microsoft Authentication Library for Java (MSAL4J) and the Microsoft Graph SDK for Java.

## Clean up

You can delete your application registration on Azure portal as follows:

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. If you have access to multiple tenants, in the top menu, use the **Directory + subscription** filter to select the tenant in which you registered the application.
1. Search for and select **Microsoft Entra ID**.
1. Under **Manage**, select **App registrations**.
1. Under **All applications**, search for and select the application you registered (the application named `java-servlet-webapp-authentication` in this module).
1. In your application registration page, select **Delete** in the top left corner.
1. In the **Delete app registration** prompt, check the box indicating that you understand the implications of deleting the application, then select **Delete** to confirm the deletion of the application.

## References

- [Microsoft identity platform app types and authentication flows](/entra/identity-platform/authentication-flows-app-scenarios)
- [MSAL overview](/entra/identity-platform/msal-overview)
- [Microsoft Authentication Library for Java](https://github.com/AzureAD/microsoft-authentication-library-for-java)
- [Microsoft Graph overview](/graph/overview)
- [Microsoft Graph SDK for Java](https://github.com/microsoftgraph/msgraph-sdk-java)
