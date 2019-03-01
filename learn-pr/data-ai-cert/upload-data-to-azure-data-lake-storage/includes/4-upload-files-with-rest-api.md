Azure Data Lake Store allows you to upload data using REST API’s. You can use any programming language that supports building and sending HTTP-based messages. In this unit, you will try this out using a simple .NET Core app with C#.

> [!NOTE]
> If you don't have an Azure account, don't want to install .NET Core, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved to invoking the REST API services.

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
    3. **Sign-on URL**: Enter a local sign-on URL using your own domain suffix (e.g. http://sample.contoso.com). This is a value used to identify the app and can be changed later as needed.
1. Click **Create** to create the app registration.
1. Once completed, in the **Registered app** blade, next to **Application ID**, copy the key into Notepad.
1.  Click on the **Settings** button, and int the Settings blade go to **Owner**. Make a note of the owner account in Notepad. Note that you can change this to a preferred service account for the registered application.
1. Go to the **Keys** in the Settings blade. 

![Screenshot of Collecting details of Azure](../media/4-collect-details.png)

1. Create a key by typing in the name **DUKey** in the "Key description..." text box.

![Screenshot of Generating New Key](../media/4-generate-new-key.png)

1. Under the **Expires** column, set the duration to **In 1 year**, and then click on the **Save** icon.

![Screenshot of Saving New Key](../media/4-save-new-key.png)

1. Copy the key value into Notepad. **You won't be able to retrieve after you leave this blade.**

1. Close down the Application Registration blade.  

## Grant Permission in Data Lake Store

Once you have an app registered, you will need to give it permissions to the Azure Data Lake Store REST API using Azure Storage Explorer, you do this by assigning permissions to the owner account of the registered application.

1. Sign into Azure Storage Explorer, you can select the subscriptions you want to work with. Make sure to select the one you created the Azure Storage account in.

The app then shows a tree of storage areas you can work with from your  subscriptions. You should see your Azure Storage account in the list.

![Screenshot of the Azure Storage Explorer app](../media/3-main-app-display.png)

1. In Azure Storage Explorer, expand your subscription, and then expand the data lake storage account to view the file system **salesdata**.

1. Right click on **salesdata**, and click on **Manage Access**.

1. In the **Manage Access** dialog box, under **Add user or group:**, type in or search for the owner account, and then click on **Add**, the name will appear under users or groups.

1. Ensure that the owner account is selected under **user or group**, and then under the section for **Permissions for: owner account name**, click on the check box in the **Access** row for the **Read**, **Write** and **Execute** permission, and then click on **Save**.

1. Confirmation that the permissions are set successfully with the message **"Successfully saved permissions for 'salesdata/'"** in the Activity window in Azure Storage Explorer.

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

- Microsoft.Azure.Management.DataLake.Store v2.4.2
- Microsoft.Rest.ClientRuntime.Azure.Authentication v2.3.7

![Screenshot of Adding NuGet Package](../media/4-add-nuget-package.png)

Before you start coding, you should collect the required data from the Azure resources. You need details from the Azure Active Directory Register Application for authentication. This shoul dbe stored in a Notepad document as directed.

## Code Sample

Check for the sample Code Screenshot below in the code mentioned below, provide the client id, tenant id and the required details from the Azure portal.

![Screenshot of Code Sample Using Packages](../media/4-code-sample-package.png)

Declare the variables and provide the values for placeholders. Also, make sure the local path and file name you provide exist on the computer.

![Screenshot of Code Sample Body](../media/4-code-sample-body.png)
