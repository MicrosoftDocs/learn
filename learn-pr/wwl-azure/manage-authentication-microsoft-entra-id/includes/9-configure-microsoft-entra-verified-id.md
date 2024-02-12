In a real-world scenario, where the issuer and verifier are separate organizations, the verifier uses their own Microsoft Entra tenant to perform the verification of the credential that was issued by the other organization. As a verifier, you unlock privileges to subjects that possess verified credential expert cards.

## Prerequisites

 -  Set up a tenant for Microsoft Entra Verified ID.
 -  If you want to clone the repository that hosts the sample app, install Git.
 -  Visual Studio Code or similar code editor.
 -  .NET 5.0.
 -  Download ngrok and sign up for a free account. If you can't use ngrok in your organization, please read this FAQ.
 -  A mobile device with Microsoft Authenticator:
     -  Android version 6.2206.3973 or later installed.
     -  iOS version 6.6.2 or later installed.

## Gather tenant details to set up your sample application

Now that you've set up your Microsoft Entra Verified ID service, you're going to gather some information about your environment and the verifiable credentials you set. You use these pieces of information when you set up your sample application.

## Download the sample code

The sample application is available in .NET, and the code is maintained in a GitHub repository.

## **Configure the verifiable credentials app**

Create a client secret for the registered application you created. The sample application uses the client secret to prove its identity when it requests tokens.

## Update the sample application

Now make modifications to the sample app's issuer code to update it with your verifiable credential URL. This step allows you to issue verifiable credentials by using your own tenant.

## Run and test the sample app

Now you're ready to present and verify your first verified credential expert card by running the sample application.

**Example**: Complete the following steps to **present** and **verify** your Microsoft Entra Verified ID for a sample application:<br>

:::image type="content" source="../media/microsoft-entra-verified-id-configuration-steps-806ee747.png" alt-text="Diagram showing how to run and test a Microsoft Entra Verified ID sample application.":::
<br>
