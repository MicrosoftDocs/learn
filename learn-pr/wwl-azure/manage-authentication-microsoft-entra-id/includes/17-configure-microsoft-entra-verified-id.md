In a real-world scenario, where the issuer and verifier are separate organizations, the verifier uses their own Microsoft Entra tenant to perform the verification of the credential that was issued by the other organization.

As a verifier, you unlock privileges to subjects that possess verified credential expert cards. In this example, a sample application is executed from a local computer that asks you to present a verified credential expert card, and then verifies it.

## Prerequisites

 -  [Set up a tenant for Microsoft Entra Verified ID](/entra/verified-id/verifiable-credentials-configure-tenant).
 -  If you want to clone the repository that hosts the sample app, install [Git](https://git-scm.com/downloads).
 -  [Visual Studio Code](https://code.visualstudio.com/Download), [Visual Studio](https://visualstudio.microsoft.com/downloads/) or similar code editor.
 -  [.NET 7.0](https://dotnet.microsoft.com/download/dotnet/6.0).
 -  Download [ngrok](https://ngrok.com/) and sign up for a free account. If you can't use ngrok in your organization, read this [FAQ](/entra/verified-id/verifiable-credentials-faq#i-cannot-use-ngrok-what-do-i-do).
 -  A mobile device with the latest version of Microsoft Authenticator.

## Gather tenant details to set up your sample application

Now that you've set up your Microsoft Entra Verified ID service, you're going to gather some information about your environment and the verifiable credentials you set. You use these pieces of information when you set up your sample application.

1. From Verified ID, select Organization settings.<br>

2. Copy the Tenant identifier value, and record it for later.

3. Copy the Decentralized identifier value, and record it for later.

The following screenshot demonstrates how to copy the required values:

:::image type="content" source="../media/tenant-settings-6440e831.png" alt-text="Screenshot showing the verified identity organization settings page.":::


## Download the sample code

The sample application is available in .NET, and the code is maintained in a GitHub repository. Download the sample code from the [GitHub repo](https://github.com/Azure-Samples/active-directory-verifiable-credentials-dotnet), or clone the repository to your local computer:<br>

## Configure the verifiable credentials app<br>

Create a client secret for the registered application you created. The sample application uses the client secret to prove its identity when it requests tokens.

1. In Microsoft Entra ID, go to **App registrations**.<br>

2. Select the **verifiable-credentials-app** application you created earlier.<br>

3. Select the name to go into the **App registrations details**.<br>

4. Copy the **Application (client) ID** value, and store it for later.

    :::image type="content" source="../media/verifiable-credentials-application-955830fc.png" alt-text="Screenshot showing the verifiable credentials application page.":::


5. In **App registration details**, from the main menu, under **Manage**, select **Certificates & secrets**.

6. Select **New client secret**.<br>

 -  In the **Description** box, enter a description for the client secret (for example, vc-sample-secret).<br>
 -  Under **Expires**, select a duration for which the secret is valid (for example, six months). Then select **Add**.<br>
 -  Record the secret's **Value**. This value is needed in a later step. The secret’s value won't be displayed again, and isn't retrievable by **any** other means, so you should record it once it's visible.<br>

At this point, you should have all the required information that you need to set up your sample application.<br>

## Update the sample application

Now make modifications to the sample app's issuer code to update it with your verifiable credential URL. This step allows you to issue verifiable credentials by using your own tenant.

1. In the active-directory-verifiable-credentials-dotnet-main directory, open Visual Studio Code. Select the project inside the 1. asp-net-core-api-idtokenhint directory.

2. Under the project root folder, open the appsettings.json file. This file contains information about your credentials in Microsoft Entra Verified ID environment. Update the following properties with the information that you collected during earlier steps.

 -  **Tenant ID**: Your tenant ID
 -  **Client ID**: Your client ID
 -  **Client Secret**: Your client secret
 -  **DidAuthority**: Your decentralized identifier
 -  **CredentialType**: Your credential type. CredentialManifest is only needed for issuance, so if all you want to do is presentation, it strictly isn't needed.

3. Save the *appsettings.json* file.

The following JavaScript Object Notation (JSON) demonstrates a complete *appsettings.json* file:

```
{
  "VerifiedID": {
    "Endpoint": "https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/",
    "VCServiceScope": "3db474b9-6a0c-4840-96ac-1fceb342124f/.default",
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "12345678-0000-0000-0000-000000000000",
    "ClientId": "33333333-0000-0000-0000-000000000000",
    "ClientSecret": "123456789012345678901234567890",
    "CertificateName": "[Or instead of client secret: Enter here the name of a certificate (from the user cert store) as registered with your application]",
    "DidAuthority": "did:web:...your-decentralized-identifier...",
    "CredentialType": "VerifiedCredentialExpert",
    "CredentialManifest":  "https://verifiedid.did.msidentity.com/v1.0/12345678-0000-0000-0000-000000000000/verifiableCredentials/contracts/VerifiedCredentialExpert"
    }
}
```

## Run and test the sample app

Now you're ready to present and verify your first verified credential expert card by running the sample application.

1.  From Visual Studio Code, run the *Verifiable\_credentials\_DotNet* project. Or from the command shell, run the following commands:
    
    ```
    cd active-directory-verifiable-credentials-dotnet\1-asp-net-core-api-idtokenhint
    dotnet build "AspNetCoreVerifiableCredentials.csproj" -c Debug -o .\bin\Debug\net6
    dotnet run
    ```
2.  In another terminal, run the following command. This command runs the ngrok to set up a URL on 5000 and make it publicly available on the internet.
    
    ```
    ngrok http 5000
    ```
    
    > [!NOTE]
    > On some computers, you might need to run the command in this format: `./ngrok http 5000`.<br>
3.  Open the HTTPS URL generated by ngrok.
    
    :::image type="content" source="../media/run-command-7f02363f.png" alt-text="Screenshot showing the terminal run command to run and test the sample application.":::
    
4.  From the web browser, select **Verify Credential**.
    
    :::image type="content" source="../media/verify-credential-a3be0fcb.png" alt-text="Screenshot showing the verify credential page.":::
    
5.  Using Authenticator, scan the QR code, or scan it directly from your mobile camera.
6.  When you see the warning message, *This app or website may be risky*, select **Advanced**. You're seeing this warning because your domain isn't verified. For this example, you can skip the domain registration.
    
    :::image type="content" source="../media/at-risk-3e120e91.png" alt-text="Screenshot showing the application or website may be risky.":::
    
7.  At the risky website warning, select **Proceed anyways (unsafe)**.
    
    :::image type="content" source="../media/proceed-anyway-fec8ac87.png" alt-text="Screenshot showing the proceed anyways unsafe warning.":::
    
8.  Approve the request by selecting **Allow**.
    
    :::image type="content" source="../media/approve-presentation-request-2a1ebf74.jpg" alt-text="Screenshot showing the new permission request page.":::
    
9.  After you approve the request, you can see that the request has been approved. You can also check the log. To see the log, select the verifiable credential.
    
    :::image type="content" source="../media/verifable-credential-information-5720385c.png" alt-text="Screenshot showing verifiable credential information page.":::
    
10. Then select **Recent Activity**.
    
    :::image type="content" source="../media/verifable-credential-history-bb92af55.jpg" alt-text="Screenshot showing verifiable credential history page.":::
    
11. **Recent Activity** shows you the recent activities of your verifiable credential.
    
    :::image type="content" source="../media/verify-credential-recent-history-b3530d8e.jpg" alt-text="Screenshot showing verifiable credential recent activity page.":::
    
12. Go back to the sample app. It shows you that the presentation of the verifiable credentials was received.
    
    :::image type="content" source="../media/presentation-received-3260ce8c.png" alt-text="Screenshot showing verifiable credential presentation received page.":::
    
