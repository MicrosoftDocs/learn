App registration in Microsoft Entra ID, is the process of ensuring that your identity system is aware of what applications are used. Registering an app provides an identity configuration for your application that allows it to integrate with the Microsoft identity platform. Benefits of registering an app include:

 -  Customizing the branding of your application within the sign-in dialog box.
 -  Deciding if you want to allow users to sign in only if they belong to your organization.
 -  Requesting scope permissions for the app.

Single tenant apps are only available in the tenant they were registered in, while multitenant apps are available to users in both their home tenant and other tenants. A Microsoft Entra application is defined by its one and only application object, which resides in the Microsoft Entra tenant where the application was registered. A service principal is created in every tenant where the application is used.
