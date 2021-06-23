As a developer for Tailwind Traders, you likely have expertise creating applications. As you migrate to Azure, many of the steps that you'll follow to set up a website in the cloud will parallel the steps that you followed when you created websites in your company's datacenter. For example, you need to choose where you'll create your website, and then allocate the necessary resources. In Azure, the physical hardware is managed for you, so your tasks are to choose where your website will be located and which resources to provide.

In this exercise, you'll create an Azure App Service instance to host a WordPress website.

## Azure terminology and concepts

Before getting started, let's review and describe some basic terms and concepts that you'll need to know when you create your website.

### What is App Service?

App Service is an HTTP-based service that enables you to build and host many types of web-based solutions without managing infrastructure. For example, you can host web apps, mobile back ends, and RESTful APIs in several supported programming languages. Applications developed in .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python can run in and scale with ease on both Windows-based and Linux-based environments.

For this exercise, we want to create a website in less than the time it takes to eat lunch. So, we're not going to write any code. Instead, you'll deploy a predefined application from Azure Marketplace.

### What is Azure Marketplace?

Azure Marketplace is an online store that hosts applications that are certified and optimized to run in Azure. Many types of applications are available, ranging from AI and machine learning to web applications. As you'll see in a couple of minutes, deployments from the store are done via the Azure portal by using a wizard-style user interface. This user interface makes evaluating different solutions easy.

We're going to use one of the WordPress application options from Azure Marketplace for our website.

### Create resources in Azure

Typically, the first thing we'd do is to create a *resource group* to hold all the things that we need to create. The resource group enables us to administer all the services, disks, network interfaces, and other elements that potentially make up our solution as a unit. We can use the Azure portal to create and manage our solution's resource groups. Keep in mind that you can also manage resources via a command line by using the Azure CLI. The Azure CLI is a useful option if you need to automate the process in the future.

In the free Azure sandbox environment, you'll use the pre-created resource group  **\[sandbox resource group name\]** , and you don't need to do this step.

### Choose a location

[!include [Sandbox regions](../../../includes/azure-sandbox-regions-first-mention-note.md)]

## Create a WordPress website

1.  If you haven't done so already, verify that you've activated the sandbox. Activating the sandbox allocates the subscription and resource group you'll use in this exercise. This step is required for any Microsoft Learn exercises that use a sandbox.
2.  Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account you used to activate the sandbox.
3.  On the top left of the Azure portal pane, select **Create a resource**.<br><br>:::image type="content" source="../media/create-resource-2992fda9.png" alt-text="Screenshot of the Azure portal showing the left pane with Create a resource option highlighted.":::
    <br><br>This option takes you to **Azure Marketplace**.<br><br>:::image type="content" source="../media/azure-marketplace-c88fb81e.png" alt-text="Screenshot of the Azure portal showing Azure Marketplace categories in a left column and popular options in a right column.":::
    <br><br>
4.  Azure Marketplace has many services, solutions, and resources available for you to use. We know that we want to install WordPress, so we can do a quick search for it. In the **Search the Marketplace** box with the listed application options, enter **WordPress**. Select the default **WordPress** option from the list of options available.<br><br>:::image type="content" source="../media/search-select-wordpress-e9503694.png" alt-text="Screenshot of the Azure portal showing search results for the term WordPress with the WordPress option highlighted.":::
    <br><br>
5.  In the **WordPress** pane that appears, you'll typically find more information about the item you're about to install, such as the publisher, a brief description of the resource, and links to more information. Make sure to review this information. Select **Create** to begin the process to create a WordPress app. The **WordPress/Create** pane appears.<br><br>:::image type="content" source="../media/create-site-4de939e8.png" alt-text="Screenshot of the Azure portal showing WordPress resource type summary.":::
    <br><br>
6.  Several options appear to configure your deployment. Enter the following values for each setting.<br><br>
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        App name
      :::column-end:::
      :::column:::
        Choose a unique value for the app name. It will form part of a fully qualified domain name (FQDN).
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Make sure **Concierge Subscription** is selected.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource Group
      :::column-end:::
      :::column:::
        Select the **Use existing** option, and then select the  **\[sandbox resource group name\]**  resource group from the dropdown.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Database Provider
      :::column-end:::
      :::column:::
        From the dropdown, select **MySQL in App**.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        App Service plan/Location
      :::column-end:::
      :::column:::
        You'll change the App Service plan in the next step.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Application Insights
      :::column-end:::
      :::column:::
        Leave at the default configuration.
      :::column-end:::
    :::row-end:::
    
    
    Your configuration should look like this example.<br><br>:::image type="content" source="../media/config-info-create-ff54e006.png" alt-text="Screenshot of the Azure portal showing the new WordPress app service configured as instructed.":::
    
    
    > [!NOTE]
    > If you still see a section called **Database**, make sure you selected the correct **Database Provider** described in the preceding configuration.
7.  Now, let's configure the App Service plan to use a specific pricing tier. The App Service plan specifies the compute resources and location for the web app. Select **App Service plan/Location**. The **App Service plan** pane appears.<br><br>:::image type="content" source="../media/config-app-service-plan-461ed8e0.png" alt-text="Screenshot of the Azure portal showing WordPress App Service creation with App Service plan Location button highlighted.":::
    <br><br>
8.  Select **Create new**.<br><br>:::image type="content" source="../media/new-app-service-plan-25cf5bdd.png" alt-text="Screenshot of the Azure portal showing the App Service plan pane with the Create new button highlighted.":::
    <br><br>The **New App Service Plan** pane appears.<br><br>
9.  Enter the following values for each setting.<br><br>
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        App Service plan
      :::column-end:::
      :::column:::
        Choose a unique name for the new app service plan.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        Select **Central US** to make sure we choose a region that allows the service plan you'll choose. Normally, you'll select the region that's closest to your customers while offering the services you need.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Pricing tier
      :::column-end:::
      :::column:::
        Select this option to see the performance and feature options of the various types of app service plans. The **Spec Picker** pane appears.
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/new-service-plan-config-3995d241.png" alt-text="Screenshot of the Azure portal showing New App Service plan configuration with the Pricing tier button highlighted.":::
    <br><br>
10. The **Spec Picker** enables us to select a new pricing tier for our application. The pane opens to the **Production** tab, with the S1 pricing tier selected. Select a new pricing tier from the **Dev / Test** tab for our website.
11. Select the **Dev / Test** tab, then select the **F1** pricing tier, and then select **Apply**.<br><br>:::image type="content" source="../media/select-pricing-tier-a35df2f3.png" alt-text="Screenshot of the Azure portal showing the App Service plan Spec Picker pane with the Dev Test section selected and the free F1 tier and the Apply button highlighted.":::
    <br><br>
12. Back on the **New App Service Plan** pane, select **OK** to create the new plan.<br><br>
13. Finally, select **Create** to start the deployment of your new site.
    
    > [!NOTE]
    > If you encounter an issue when you create the resources, verify you've selected the **F1** pricing tier in the new App Service plan. Using the F1 pricing tier is a requirement of the sandbox system when you create this WordPress site.

## Verify your website is running

The deployment of the new website can take a few minutes to complete. You're welcome to explore the portal further on your own.

We can track the progress of the deployment at any time.

1.  Select the **Notifications** bell icon at the top of the portal. If your browser window width is smaller, it might be shown when you select the ellipsis (**...**) icon in the upper-right corner.<br><br>:::image type="content" source="../media/notification-bell-d2710d82.png" alt-text="Screenshot of the Azure portal showing the top-right menu with the Notifications bell button highlighted.":::
    <br><br>
2.  Select **Deployment in progress** to see the details about all the resources that are created.<br><br>:::image type="content" source="../media/notification-bell-info-bebdd609.png" alt-text="Screenshot of the Azure portal showing deployment notification in the Notifications list.":::
    <br><br>Notice how resources are listed as they're created and the status changes to a green check mark as each component in the deployment completes.<br><br>:::image type="content" source="../media/deployment-progress-5e861a21.png" alt-text="Screenshot of the Azure portal showing details of the deployment notification stating, Your deployment is underway.":::
    <br><br>
3.  After the deployment status message changes to **Your deployment is complete**, you'll notice the status in the **Notifications** dialog box changes to **Deployment succeeded**. Select **Go to resource** to go to the App Service overview.<br><br>:::image type="content" source="../media/deployment-complete-98d39411.png" alt-text="Screenshot of the Azure portal showing deployment notification stating, Deployment succeeded.":::
    <br><br>
4.  Find the **URL** in the **Overview** section.<br><br>:::image type="content" source="../media/website-url-b2b6286d.png" alt-text="Screenshot of the Azure portal showing App Service Overview pane with URL location highlighted.":::
    <br><br>
5.  Copy the **URL** information by selecting the **Copy to clipboard** icon at the end of URL.<br><br>
6.  Open a new tab in your browser, paste this URL, and press Enter to browse to your new WordPress site. You can now configure your WordPress site, and add content.<br><br>:::image type="content" source="../media/configure-wordpress-fd5cbfe7.png" alt-text="Screenshot showing preconfigured WordPress website waiting on language - location selection.":::
    
