



You've been asked to help secure information being transmitted between your companies app and the customer. Azure App Service has tools that let you  create, upload, or import a private certificate or a public certificate into App Service.

A certificate uploaded into an app is stored in a deployment unit that is bound to the app service plan's resource group and region combination (internally called a *webspace*). This makes the certificate accessible to other apps in the same resource group and region combination.

The table below details the options you have for adding certificates in App Service:

| Option | Description |
|--|--|
| Create a free App Service managed certificate | A private certificate that's free of charge and easy to use if you just need to secure your custom domain in App Service. |
| Purchase an App Service certificate | A private certificate that's managed by Azure. It combines the simplicity of automated certificate management and the flexibility of renewal and export options. |
| Import a certificate from Key Vault | Useful if you use Azure Key Vault to manage your certificates. |
| Upload a private certificate | If you already have a private certificate from a third-party provider, you can upload it. |
| Upload a public certificate | Public certificates aren't used to secure custom domains, but you can load them into your code if you need them to access remote resources. |

## Private certificate requirements

The free **App Service managed certificate** and the **App Service certificate** already satisfy the requirements of App Service. If you want to use a private certificate in App Service, your certificate must meet the following requirements:

* Exported as a password-protected PFX file, encrypted using triple DES.
* Contains private key at least 2048 bits long
* Contains all intermediate certificates in the certificate chain

To secure a custom domain in a TLS binding, the certificate has other requirements:

* Contains an Extended Key Usage for server authentication (OID = 1.3.6.1.5.5.7.3.1)
* Signed by a trusted certificate authority

## Creating a free managed certificate

To create custom TLS/SSL bindings or enable client certificates for your App Service app, your App Service plan must be in the **Basic**, **Standard**, **Premium**, or **Isolated** tier.

The free App Service managed certificate is a turn-key solution for securing your custom DNS name in App Service. It's a TLS/SSL server certificate that's fully managed by App Service and renewed continuously and automatically in six-month increments, 45 days before expiration. You create the certificate and bind it to a custom domain, and let App Service do the rest.

The free certificate comes with the following limitations:

* Doesn't support wildcard certificates.
* Doesn't support usage as a client certificate by certificate thumbprint.
* Isn't exportable.
* Isn't supported on App Service Environment (ASE).
* Isn't supported with root domains that are integrated with Traffic Manager.
* If a certificate is for a CNAME-mapped domain, the CNAME must be mapped directly to `<app-name>.azurewebsites.net`.

## Import an App Service Certificate

If you purchase an App Service Certificate from Azure, Azure manages the following tasks:

* Takes care of the purchase process from certificate provider.
* Performs domain verification of the certificate.
* Maintains the certificate in Azure Key Vault.
* Manages certificate renewal.
* Synchronize the certificate automatically with the imported copies in App Service apps.

If you already have a working App Service certificate, you can:

* Import the certificate into App Service.
* Manage the certificate, such as renew, rekey, and export it.

> [!NOTE]
> App Service Certificates are not supported in Azure National Clouds at this time.

## Upload a private certificate

If your certificate authority gives you multiple certificates in the certificate chain, you need to merge the certificates in order. Then you can Export your merged TLS/SSL certificate with the private key that your certificate request was generated with.

If you generated your certificate request using OpenSSL, then you've created a private key file. To export your certificate to PFX, run the following command. Replace the placeholders `<private-key-file>` and `<merged-certificate-file>` with the paths to your private key and your merged certificate file.

```bash
openssl pkcs12 -export -out myserver.pfx -inkey <private-key-file> -in <merged-certificate-file>
```

When prompted, define an export password. You'll use this password when uploading your TLS/SSL certificate to App Service.

## Enforce HTTPS

By default, anyone can still access your app using HTTP. You can redirect all HTTP requests to the HTTPS port by navigating to your app page and, in the left navigation, select **TLS/SSL settings**. Then, in **HTTPS Only**, select **On**.

:::image type="content" source="../media/enforce-https.png" alt-text="Enabling HTTPS Only in your web app.":::
