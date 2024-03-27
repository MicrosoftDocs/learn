
When you deploy cloud services such as Microsoft 365 or Intune, you also need to have directory services in the cloud to provide authentication and authorization for these services. Because of this, each cloud service that needs authentication will create its own Microsoft Entra tenant. When a single organization uses more than one cloud service, it’s much more convenient for these cloud services to use a single cloud directory instead of having separate directories for each service.

It’s now possible to have one identity service that covers all Microsoft cloud-based services, such as Microsoft 365, Azure, Microsoft Dynamics 365, and Intune. Microsoft Entra ID provides developers with centralized authentication and authorization for applications in Azure by using other identity providers or on-premises AD DS. Microsoft Entra ID can provide users with an SSO experience when using applications such as Facebook, Google services, Yahoo, or Microsoft cloud services.

The process of implementing Microsoft Entra ID support for custom applications is rather complex and beyond the scope of this course. However, the Azure portal and Microsoft Visual Studio 2013 and later make the process of configuring such support more straightforward.

In particular, you can enable Microsoft Entra authentication for the Web Apps feature of Azure App Service directly from the Authentication/Authorization blade in the Azure portal. By designating the Microsoft Entra tenant, you can ensure that only users with accounts in that directory can access the website. It’s possible to apply different authentication settings to individual deployment slots.

For more information, see [Configure your App Service app to use Microsoft Entra login](/azure/app-service/configure-authentication-provider-aad).
