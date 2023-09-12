To provide an end to end data technology stack, we'll be creating many resources and integrating them together to create a flow of data. This exercise includes setting up Azure Data Factory, Microsoft Purview, CluedIn, a service principal, an Azure Storage account, and Azure Key Vault. If you have these components already, you can move on to the next section. 

>[!TIP]
>Even if you already have a security principal, confirm you have the correct permissions in the [set up authentication using a service principal](#set-up-authentication-using-service-principal) section.

## Create an Azure Data Factory

We'll be using Azure Data Factory as our mechanism to pull data from source systems into storage accounts, and pull data registered in Microsoft Purview to CluedIn to be processed.

If you don't have an Azure Data Factory instance, you can use the following guide to create one:

1. Launch a **Microsoft Edge** or **Google Chrome** web browser. Currently, only Microsoft Edge and Google Chrome web browsers support the Azure Data Factory UI.
1. Go to the [Azure Data Factory Studio](https://adf.azure.com) and choose the **Create a new data factory** radio button.
1. You can use the default values to create an instance, or enter a unique name and choose a preferred location and subscription and select **Create**.

   :::image type="content" source="../media/create-azure-data-factory.png" alt-text="Shows a screenshot of the Azure Data Factory Studio page to create a new data factory.":::

## Create a Microsoft Purview instance

You'll need to bring your own Microsoft Purview instance to the learning module, or you can create one using these steps:

1. Select **Create a resource** in the [Azure portal](https://portal.azure.com),search for **Microsoft Purview**, and select **Create** to create a new Microsoft Purview account.

    :::image type="content" source="../media/search-marketplace.png" alt-text="Screenshot showing Microsoft Purview in the Azure Marketplace, with the create button highlighted.":::

1. On the new Create Microsoft Purview account page under the **Basics** tab, select your Azure subscription, resource group, enter a name, and choose a location.

    :::image type="content" source="../media/create-microsoft-purview-account-azure-portal.png" alt-text="Screenshot of the Create Microsoft Purview account page in the Azure portal.":::

    >[!TIP]
    > The list shows only locations that support the Microsoft Purview governance portal. The location you choose will be the region where your Microsoft Purview account and metadata will be stored. Sources can be housed in other regions.

1. Select **Review & Create**, and then select **Create**.

## Create a service principal

You'll also need to set up a Service Principal to generate the right credentials for all the components to talk with each other.

To create a new service principal:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. From the portal, search for and select **Azure Active Directory**.
1. From the **Azure Active Directory** page, select **App registrations** from the left pane.
1. Select **New registration**.
1. On the **Register an application** page:
    1. Enter a **Name** for the application (the service principal name).
    1. Select **Accounts in this organizational directory only (_&lt;your tenant's name&gt;_ only - Single tenant)**.
    1. For **Redirect URI (optional)**, select **Web** and enter a value. This value doesn't need to be a valid endpoint. `https://exampleURI.com` will do.
    1. Select **Register**.

    :::image type="content" source="../media/application-registration-inline.png" alt-text="Screenshot of the application registration page, with the above options filled out." lightbox="../media/application-registration.png":::

1. On the new service principal page, copy the values of the **Display name** and the **Application (client) ID** to save for later.

   :::image type="content" source="../media/application-id-inline.png" alt-text="Screenshot of the application page in the portal with the Application (client) ID highlighted." lightbox="../media/application-id.png":::

To use the service principal (application), you need to know the service principal's password that can be found by:

1. From the Azure portal, search for and select **Azure Active Directory**, and then select **App registrations** from the left pane.
1. Select your service principal (application) from the list.
1. Select **Certificates & secrets** from the left pane.
1. Select **New client secret**.
1. On the **Add a client secret** page, enter a **Description**, select an expiration time under **Expires**, and then select **Add**.
1. On the **Client secrets** page, the string in the **Value** column of your new secret is your password. Save this value to use later.

   :::image type="content" source="../media/client-secret.png" alt-text="Screenshot showing a client secret.":::

## Set up authentication using service principal

Once the new service principal is created, or if you're bringing your own, you need to assign the data plane roles of your Microsoft Purview account to the service principal:

1. Navigate to your [Microsoft Purview governance portal](https://web.purview.azure.com/resource/).
1. Select the Data Map in the left menu.
1. Select Collections.
1. Select the root collection in the collections menu. This will be the top collection in the list, and will have the same name as your Microsoft Purview account.

    >[!NOTE] 
    >You can also assign your service principal permission to any sub-collections, instead of the root collection. However, all APIs will be scoped to that collection (and sub-collections that inherit permissions), and users trying to call the API for another collection will get errors.

1. Select the **Role assignments** tab.

1. Assign the following roles to the service principal created previously to access various data planes in Microsoft Purview.

    * Data Curator role to access Catalog Data plane.
    * Data Source Administrator role to access Scanning Data plane.
    * Collection Admin role to access Account Data Plane and Metadata policy Data Plane.

    > [!Note]
    > Only members of the Collection Admin role can assign data plane roles in Microsoft Purview.

## Create a CluedIn instance

You can also create a CluedIn instance directly through the Azure Marketplace or Azure portal. You'll need to make sure that you check and validate that you have all the prerequisites for installing the trial, available here: https://documentation.cluedin.net/deployment/azure-marketplace.

To create a CluedIn instance, go to the Azure portal and follow the steps below:

1. Search **CluedIn** in your Azure portal and select the application under the Marketplace section.

    :::image type="content" source="../media/create-cluedin-azure-portal-inline.png" alt-text="Screenshot of Azure Marketplace, showing CluedIn Master Data Management." lightbox="../media/create-cluedin-azure-portal.png" :::

1. This will take you to a form where you'll be asked to choose the type of plan. CluedIn provides a seven-day trial that is cost-free from CluedIn, but will charge for the underlying Azure infrastructure used to install within your environment. You can also choose the **CluedIn Platform** plan that is hourly based pricing. In this module, we'll walk you through using the CluedIn seven-day trial.

    :::image type="content" source="../media/choose-cluedin-instance.png" alt-text="Screenshot of CluedIn Master Data Management Page, showing the CluedIn Platform option.":::

1. Choose **Trial Version** from the dropdown and select **Create**.

1. Fill in the Subscription and Resource Group you would like to use. For the region, make sure you choose a region where you're able to create infrastructure and that you have enough of a quota to spin up the required infrastructure. If you are in doubt, [there's a handy PowerShell script that you can run](https://documentation.cluedin.net/deployment/azure-marketplace) that will tell you if you have enough quota and all required prerequisites before running the installation.

    >[!NOTE]
    >The Managed Resource Group name is autogenerated for you, there is no need to rename this. Call your Installation Name something that will be easy for you to remember through the rest of the module.

    :::image type="content" source="../media/fill-cluedin-trial-form.png" alt-text="Screenshot of CluedIn Master Data Management Page creation form, showing some generic options.":::

1. Select **Next : CluedIn - Organization Setup >** to set the Organization Name, Administrator Email Address, CluedIn Administrator Password, and Confirm Password. The Organization Name will be the name for your new instance of CluedIn and the subdomain that will be used to access your CluedIn Studio in the browser. Provide an email address that is valid and that you have access to, and provide a strong Password in the CluedIn Administration Password and Confirm password fields.

    :::image type="content" source="../media/fill-cluedin-organization-details.png" alt-text="Screenshot of CluedIn Master Data Management Page organization setup page.":::

    >[!NOTE]
    >If you are required to use Single Sign On for your Learning Module then you will need to use the "CluedIn Platform" plan. The Trial does not support SSO setup and uses simple OAuth 2 / JWT authentication.

1. Select **Next : CluedIn - AKS Setup >** and leave all of the values as the default.

    :::image type="content" source="../media/fill-cluedin-aks-setup.png" alt-text="Screenshot of CluedIn Master Data Management Page AKS setup page.":::

1. Select **Next : Review + create >**. On this next page, you'll need to check the checkbox to agree to the terms and conditions.

In approximately 15 to 20 minutes, you'll have a created instance of CluedIn and will be able to access your newly created CluedIn environment. We'll show you how in the next section.

## Create an Azure Storage Account

You need an ADLS Gen2 Storage Account to host all of the data used for the module.

You can bring an account you already have or use this guide to create one:

1. In the Azure portal, search **Storage account**, select it, and select **Create**.

    :::image type="content" source="../media/select-storage-account-inline.png" alt-text="Screenshot of the Azure Marketplace showing a Storage account." lightbox="../media/select-storage-account.png" :::

1. In the basics tab, provide your subscription, resource group, a name, performance (for this module we'll use standard), and redundancy (for this module we'll use local redundancy.)

    :::image type="content" source="../media/create-storage-account-basics.png" alt-text="Screenshot of the Create a storage account page basics tab.":::

1. Select the **Advanced** tab, and select **Enable hierarchical namespace**.

    :::image type="content" source="../media/create-storage-account-advanced.png" alt-text="Screenshot of the Create a storage account page advanced tab.":::

1. Select **Review** and after validation has passed, select **Create**.

## Create an Azure Key Vault

1. From the Azure portal menu, or from the Home page, select Create a resource.
1. In the Search box, enter Key Vault.
1. From the results list, choose Key Vault.
1. On the Key Vault section, choose Create.
1. On the Create key vault section provide the following information:
    1. Name: A unique name is required.
    1. Subscription: Choose a subscription.
    1. Under Resource Group, choose Create new and enter a resource group name.
    1. In the Location pull-down menu, choose a location.
    1. Leave the other options to their defaults.
1. Select Create.
