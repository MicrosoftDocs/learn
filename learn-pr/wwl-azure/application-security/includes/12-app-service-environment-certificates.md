
**Azure App Service** provides a highly scalable, self-patching web hosting service. Once the certificate is added to your App Service app or function app, you can secure a **custom Domain Name System (DNS)** name with it or use it in your application code.

> [!NOTE]
> A certificate uploaded into an app is stored in a deployment unit that is bound to the app service plan's resource group and region combination (**internally called a webspace**). This makes the certificate accessible to other apps in the same resource group and region combination.

The following lists are options for adding certificates in App Service:

 -  **Create a free App Service managed certificate**: A private certificate that's free of charge and easy to use if you just need to secure your custom domain in App Service.
 -  **Purchase an App Service certificate**: A private certificate that's managed by Azure. It combines the simplicity of automated certificate management and the flexibility of renewal and export options.
 -  **Import a certificate from Key Vault**: Useful if you use Azure Key Vault to manage your **Public-Key Cryptography Standards \#12 (PKCS12)** certificates.
 -  **Upload a private certificate**: If you already have a private certificate from a third-party provider, you can upload it.
 -  **Upload a public certificate**: Public certificates are not used to secure custom domains, but you can load them into your code if you need them to access remote resources.

## Prerequisites

 -  Create an App Service app.
 -  For a private certificate, make sure that it satisfies all requirements from App Service.
 -  Free certificate only:
     -  Map the domain you want a certificate for to App Service.
     -  For a root domain (**like contoso.com**), make sure your app doesn't have any IP restrictions configured. Both certificate creation and its periodic renewal for a root domain depends on your app being reachable from the internet.
