Azure Data lake Store allows you to upload data using a built-in REST API. You can use any programming language that supports building and sending HTTP-based messages. Let's try this out using a simple .NET Core app with C#.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, don't want to install .NET Core, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved to invoking the REST API services.

## Register Application

The first step in using the REST API is to register the application. Azure provides fine-grained access control for all API access using Azure Active Directory.

1. Sign in to [Azure portal](https://portal.azure.com?azure-portal=true)
1. In the left-hand sidebar, select **Azure Active Directory**. If you don't see it in your favorites, you can use the search bar at the top of the portal window to find the service.
1. Navigate to the **App registrations** section.
1. Select **New application registration** button from the menu bar.

    > [!NOTE]
    > There's a new UX available for this feature that uses slightly different terminology. For example, it has a button titled "New registration". If you are on the new UI, look for similar text values to complete the exercise.

1. In the "New Application" blade, fill in the following details.
    1. **Name**: Enter a name for your application (e.g. "data-uploader").
    2. **Application type**: Select **Web app / API** as the application type.
    3. **Sign-on URL**: Enter a local sign-on URL using your own domain suffix (e.g. http://sample.contosso.com). This is a value used to identify the app and can be changed later as needed.
1. Click **Create** to create the app registration.

## Grant Permission in Data Lake Store

Once you have an app registered, you will need to give it permissions to the Azure Data Lake Store REST API.

TBD

## Create a .NET Core app

TBD

1. Open Visual Studio and create a console application.
1. From the **File** menu, click **New**, and then click **Project**.
1. From **New Project**, type or select the following values:

| Property | Value  |
| -------- | ------ |
| Category | Templates/Visual C#/Windows |
| Template | Console Application |
| Name | CreateADLApplication |

1. Click **OK** to create the project.
1. Add the NuGet packages to your project.
    1. Right-click the project name in the Solution Explorer and click **Manage NuGet Packages**.
    2. In the **NuGet Package Manager** tab, make sure that **Package source** is set to **nuget.org** and that **Include prerelease** check box is selected.
    3. Search for and install the following NuGet packages:

Add the following two NuGet packages to the project.

- Microsoft.Azure.Management.DataLake.Store v2.2.0
- Microsoft.Rest.ClientRuntime.Azure.Authentication v2.3.1

![Screenshot of Adding NuGet Package](../media/4-add-nuget-package.png)

Before you start coding, you should collect the required data from Azure resources. You need details from the Azure Active Directory App for authentication. Navigate to the previously created AD App blade.

![Screenshot of Collecting details of Azure](../media/4-collect-details.png)

Copy the **Application ID** mentioned in the App blade, which will be used as Client Id in the .NET application. Click on **Keys** to generate a new key or client secret.

![Screenshot of Generating New Key](../media/4-generate-new-key.png)

Enter a key name under **Description** and select the expiry duration from the drop-down. Click on the **Save** icon on top to generate the Key.

![Screenshot of Saving New Key](../media/4-save-new-key.png)

Copy the Key, which will be hidden after you leave this blade. This key will be used as a client secret in the .NET application.

## Code Sample

Check for the sample Code Screenshot below in the code mentioned below, provide the client id, tenant id and the required details from the Azure portal.

![Screenshot of Code Sample Using Packages](../media/4-code-sample-package.png)

Declare the variables and provide the values for placeholders. Also, make sure the local path and file name you provide exist on the computer.

![Screenshot of Code Sample Body](../media/4-code-sample-body.png)
