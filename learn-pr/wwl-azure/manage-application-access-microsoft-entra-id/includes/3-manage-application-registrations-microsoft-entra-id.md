When you register a new application in Microsoft Entra ID, a service principal is automatically created for the app registration. The service principal is the app's identity in the Microsoft Entra tenant. Access to resources is restricted by the roles assigned to the service principal, giving you control over which resources can be accessed and at which level. For security reasons, it's always recommended to use service principals with automated tools rather than allowing them to sign in with a user identity.

Instead of creating a service principal, consider using managed identities for Azure resources for your application identity. If your code runs on a service that supports managed identities and accesses resources that support Microsoft Entra authentication, managed identities are a better option for you. To learn more about managed identities for Azure resources, including which services currently support it, see [What is managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview).

## Prerequisites

To register an application in your Microsoft Entra tenant, you need:

 -  A Microsoft Entra user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

## Permissions required for registering an app

You must have sufficient permissions to register an application with your Microsoft Entra tenant, and assign to the application a role in your Azure subscription. To complete these tasks, you require `Application.ReadWrite.Allpermission`.

## Register an application with Microsoft Entra ID and create a service principal

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

2. Browse to **Identity** &gt; **Applications** &gt; **App registrations** then select **New registration**.

3. Name the application, for example "example-app".

4. Select a supported account type, which determines who can use the application.

5. Under **Redirect URI**, select **Web** for the type of application you want to create. Enter the URI where the access token is sent to.

6. Select **Register**.

:::image type="content" source="../media/create-application-411da6f3.png" alt-text="Screenshot showing how to register an application in the Microsoft Entra administration center.":::
<br>

You've created your Microsoft Entra application and service principal.<br>

## Assign a role to the application

To access resources in your subscription, you must assign a role to the application. Decide which role offers the right permissions for the application.

You can set the scope at the level of the subscription, resource group, or resource. Permissions are inherited to lower levels of scope.

1. Sign in to the [Azure portal](https://portal.azure.com/)

2. Select the level of scope you wish to assign the application to. For example, to assign a role at the subscription scope, search for and select **Subscriptions**. If you don't see the subscription you're looking for, select **global subscriptions filter**. Make sure the subscription you want is selected for the tenant.

3. Select **Access control (IAM)**.

4. Select **Add**, then select **Add role assignment**.

5. In the **Role** tab, select the role you wish to assign to the application in the list. For example, to allow the application to execute actions like reboot, start and stop instances, select the **Contributor** role.

6. Select the **Next**.

7. On the **Members** tab. Select **Assign access to**, then select **User**, **group**, **or service principal**

8. Select **Select members**. By default, Microsoft Entra applications aren't displayed in the available options. To find your application, Search for it by its name.

9. Select the **Select** button, then select **Review + assign**.

:::image type="content" source="../media/add-role-assignment-example-e0b86b09.png" alt-text="Screenshot showing how to add a role assignment in the Identity and Access Management controls.":::


Your service principal is set up. You can start using it to run your scripts or apps. To **manage your service principal** (permissions, user consented permissions, see which users have consented, review permissions, see sign in information, and more), go to **Enterprise applications**.<br>

## Sign in to the application

When programmatically signing in, pass the tenant ID and the application ID in your authentication request. You also need a certificate or an authentication key. To obtain the directory (tenant) ID and application ID:

1. Browse to **Identity** &gt; **Applications** &gt; **App registrations**, then select your application.<br>

2. On the app's overview page, copy the Directory (tenant) ID value and store it in your application code.

3. Copy the Application (client) ID value and store it in your application code.

## Set up authentication

There are two types of authentication available for service principals: password-based authentication (application secret) and certificate-based authentication. We recommend using a trusted certificate issued by a certificate authority, but you can also create an application secret or create a self-signed certificate for testing.

### Option 1 (recommended): Upload a trusted certificate issued by a certificate authority

To upload the certificate file:

1. Browse to **Identity** &gt; **Applications** &gt; **App registrations**, then select your application.<br>

2. Select **Certificates & secrets**.

3. Select **Certificates**, then select **Upload certificate** and then select the certificate file to upload.

4. Select Add. Once the certificate is uploaded, the thumbprint, start date, and expiration values are displayed.

After registering the certificate with your application in the application registration portal, enable the **confidential client application code** to use the certificate.

### Option 2: Testing only- create and upload a self-signed certificate

Optionally, you can create a self-signed certificate for *testing purposes only*. To create a self-signed certificate, open Windows PowerShell and run **New-SelfSignedCertificate** with the following parameters to create the certificate in the user certificate store on your computer:

```powershell
PowerShell
```

```powershell
$cert=New-SelfSignedCertificate -Subject "CN=DaemonConsoleCert" -CertStoreLocation "Cert:\CurrentUser\My"  -KeyExportPolicy Exportable -KeySpec Signature
```

Export this certificate to a file using the **Manage User Certificate** MMC snap-in accessible from the Windows Control Panel.

1. Select **Run** from the **Start** menu, and then enter **certmgr.msc**. The Certificate Manager tool for the current user appears.

2. To view your certificates, under **Certificates** \- **Current User** in the left pane, expand the **Personal** directory.

3. Right-click on the certificate you created, select **All tasks**\-&gt;**Export**.

4. Follow the Certificate Export wizard.

To upload the certificate:

1. Browse to **Identity** &gt; **Applications** &gt; **App registrations**, then select your application.<br>

2. Select **Certificates & secrets**.

3. Select Certificates, then select **Upload certificate** and then select the certificate (an existing certificate or the self-signed certificate you exported).

4. Select **Add**.

After registering the certificate with your application in the application registration portal, enable the **confidential client application** code to use the certificate.

### Option 3: Create a new client secret

If you choose not to use a certificate, you can create a new client secret.

1. Browse to **Identity** &gt; **Applications** &gt; **App registrations**, then select your application.

2. Select **Certificates & secrets**.

3. Select **Client secrets**, and then Select **New client secret**.

4. Provide a description of the secret, and a duration.

5. Select **Add**.

Once you've saved the client secret, the value of the client secret is displayed. This is only displayed once, so copy this value and store it where your application can retrieve it, usually where your application keeps values like `clientId`, or`authority` in the source code. You'll provide the secret value along with the application's client ID to sign in as the application.

:::image type="content" source="../media/client-secret-example-2702a4a4.png" alt-text="Screenshot showing an example of how to generate a new client secret.":::


## Configure access policies on resources

You might need to configure extra permissions on resources that your application needs to access. For example, you must also update a key vault's access policies to give your application access to keys, secrets, or certificates.

To configure access policies:

1. Sign in to the [Azure portal](https://portal.azure.com/).

2. Select your key vault and select **Access policies**.

3. Select **Add access policy**, then select the key, secret, and certificate permissions you want to grant your application. Select the service principal you created previously.

4. Select **Add** to add the access policy.

5. **Save**.

:::image type="content" source="../media/add-access-policy-098236c8.png" alt-text="Screenshot showing how to configure access policies on resources.":::
