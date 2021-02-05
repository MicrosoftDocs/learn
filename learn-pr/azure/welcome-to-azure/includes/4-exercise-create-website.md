As a technology professional, you likely have expertise in a specific area. Perhaps you're a storage admin or virtualization expert, or maybe you focus on the latest security practices. If you're a student, you may still be exploring what interests you most.

No matter your role, most people get started with the cloud by creating a website. Here you'll deploy a website hosted in an App Service.

Let's review some basic terms and get your first website up and running.

## What is an App Service?

Azure App Service is an HTTP-based service that enables you to build and host many types of web-based solutions without managing infrastructure. For example, you can host web apps, mobile back ends, and RESTful APIs in several supported programming languages. Applications developed in .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python can run in and scale with ease on both Windows and Linux-based environments.

We aim to create a website in less than the time it takes to eat lunch. Therefore, we're not going to write any code and will instead deploy a predefined application from the Microsoft Azure Marketplace.

## What is the Microsoft Azure Marketplace?

The Microsoft Azure Marketplace is an online store that hosts applications that are certified and optimized to run in Azure. Many types of applications are available, ranging from AI + Machine Learning to Web applications. As you'll see in a couple of minutes, deployments from the store are done via the Azure portal using a wizard-style user interface. This user interface makes evaluating different solutions easy.

We're going to use one of the WordPress application options from the Azure Marketplace for our website.

## Creating resources in Azure

Typically, the first thing we'd do is to create a *resource group* to hold all the things that we need to create. The *resource group* allows us to administer all the services, disks, network interfaces, and other elements that potentially make up our solution as a unit. We can use the Azure portal to create and manage our solution's resource groups. However, keep in mind that you can also manage resources via a command line using the Azure CLI. The Azure CLI is a useful option should you need to automate the process in the future.

In the free Azure sandbox environment, you'll use the pre-created resource group **<rgn>[sandbox resource group name]</rgn>**, and you don't need to do this step.

## Choosing a location

[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

## Create a WordPress website

1. If you haven't already, verify that you have activated the sandbox above. Activating the sandbox will allocate the subscription and resource group you will use in this exercise. This step is required for any Microsoft Learn exercises that use a sandbox.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

    [!include[](../../includes/verify-directory-and-sandbox.md)]

1. Expand the left-hand navigation panel.

1. From the top of the Azure portal navigation list, select **Create a resource**.

    :::image source="../media/4-create-resource.png" alt-text="Screenshot of Azure portal showing left-hand navigation with Create a resource option option highlighted.":::

    This option takes you to the **Azure Marketplace**.

    :::image source="../media/4-azure-marketplace.png" alt-text="Screenshot of Azure portal showing Azure Marketplace categories in a left column and popular options in a right column.":::

1. The Azure Marketplace has many services, solutions, and resources available for you to use. Since we know that we want to install WordPress, we can do a quick search for it. In the **Search the Marketplace** box above the listed application options, type in **WordPress**. Select the default *WordPress* option from the list of options available.

    :::image source="../media/4-search-select-wordpress.png" alt-text="Screenshot of Azure portal showing search results for the term WordPress with the WordPress option highlighted.":::

1. In the newly presented panel, you'll typically find additional information about the item you're about to install, including the publisher, a brief description of the resource, and links to more information. Make sure to review this information. Select **Create** to begin the process to create a WordPress app.

    :::image source="../media/4-create-site.png" alt-text="Screenshot of Azure portal showing WordPress resource type summary.":::

1. Next, you're presented with several options to configure your deployment. Enter the following information:

    1. **App Name**: Choose a unique value for the App name. It will form part of a Fully Qualified Domain Name (FQDN).
    1. **Subscription**: Make sure the **Concierge Subscription** is selected.
    1. **Resource Group**: Select the **Use existing** radio button, then select the **<rgn>[sandbox resource group name]</rgn>** resource group from the drop-down list.
    1. **Database Provider**: Select **MySQL in App**.
    1. **App Service plan/location**: You'll change the App Service plan in the next step.
    1. **Application Insights**: Leave at the default configuration.

    Your configuration should look like this:

    [![Screenshot of Azure portal showing the new WordPress app service configured as instructed.](../media/4-config-info-create.png)](../media/4-config-info-create-expanded.png#lightbox)
    
    > [!NOTE]
    > If you still see a section called **Database**, make sure you selected the correct **Database Provider** described in the configuration above.

1. Now let's configure the App Service plan to use a specific pricing tier. The App Service plan specifies the compute resources and location for the web app. Select **App Service plan/location**.

    ![Screenshot of Azure portal showing WordPress App Service creation with App Service plan/Location button highlighted.](../media/4-config-app-service-plan.png)

1. In the **App Service plan** panel, select **Create new**.

    ![Screenshot of Azure portal showing the App Service plan pane with the create new button highlighted.](../media/4-new-app-service-plan.png)

1. In the **New App Service plan** panel, enter a **name** for the new service plan.
1. For **Location**, pick **Central US** to make sure we pick a region that allows the service plan you will pick. Normally, you would pick the region that is closest to your customers while offering the services you need.
1. Select **Pricing tier** to see the performance and feature options of the various types of service plans.

    ![Screenshot of Azure portal showing New App Service Plan configuration with the pricing tier button highlighted.](../media/4-new-service-plan-config.png)

1. The **Spec Picker** allows us to select a new pricing tier for our application. This screen opens to the *Production* tab, with the S1 pricing tier selected. We'll select a new pricing tier from the *Dev / Test* tab for our website.

    Select the **Dev / Test** tab and select the **F1** pricing tier. Then select **Apply**.

    [![Screenshot of Azure portal showing the App Service Plan Spec Picker pane with the Dev/Test section selected and the free F1 tier and apply button highlighted.](../media/4-select-pricing-tier.png)](../media/4-select-pricing-tier-expanded.png#lightbox)

1. Back on the **New App Service plan** panel, select **OK** to create the new plan and close the panel.

    :::image source="../media/4-new-service-plan-config-set.png" alt-text="Screenshot of Azure portal showing New App Service Plan configuration after selecting the F1 free pricing tier.":::

1. Finally, select the **Create** button to start the deployment of your new site.

> [!NOTE]
> If you encounter an issue creating the resources, verify you've selected the **F1** pricing tier in the new App Service plan. This is a requirement of the sandbox system when creating this WordPress site.

## Verify your website is running

The deployment of the new website can take a few minutes to complete, and you're welcome to explore the portal further on your own.

We can track the progress of the deployment at any time.

1. Select the **notification bell** icon at the top of the portal. If your browser window width is smaller, it may be shown when you click on the ellipsis (**...**) icon at the top right.

    ![Screenshot of Azure portal showing top-right menu with the notification bell button highlighted.](../media/4-notification-bell.png)

1. Select **Deployment in progress...** to see the details about all the resources that are created.

    ![Screenshot of Azure portal showing deployment notification in the notifications list.](../media/4-notification-bell-info.png)

    Notice how resources are listed as they're created and the status changes to a green check as each component in the deployment completes.

    [![Screenshot of Azure portal showing details of the deployment notification, stating "Your deployment is underway".](../media/4-deployment-progress.png)](../media/4-deployment-progress-expanded.png#lightbox)

1. Once the deployment status message changes to **Your deployment is complete**, you'll notice the status in the notification dialogue changes to **Deployment succeeded**. Select **Go to resource** to navigate to the App Service overview.

    ![Screenshot of Azure portal showing deployment notification, stating "Deployment succeeded".](../media/4-deployment-complete.png)

1. Find the URL in the Overview section.

    [![Screenshot of Azure portal showing App Service overview pane with URL location highlighted.](../media/4-website-url.png)](../media/4-website-url-expanded.png#lightbox)

    Copy the **URL** information. Open a new tab in your browser and use the information to browse to your new WordPress site. You can now configure your WordPress website and add content.

    :::image type="content" source="../media/4-configure-wordpress.png" alt-text="Screenshot showing pre-configured WordPress website waiting on language/location selection." loc-scope="third-party":::
