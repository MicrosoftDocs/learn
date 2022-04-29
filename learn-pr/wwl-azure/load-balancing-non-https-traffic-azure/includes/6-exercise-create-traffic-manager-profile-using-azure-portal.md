> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

In this exercise, you will create a Traffic Manager profile to deliver high availability for the fictional Contoso Ltd organization's web application.

You will create two instances of a web application deployed in two different regions (East US and West Europe). The East US region will act as a primary endpoint for Traffic Manager, and the West Europe region will act as a failover endpoint.

You will then create a Traffic Manager profile based on endpoint priority. This profile will direct user traffic to the primary site running the web application. Traffic Manager will continuously monitor the web application, and if the primary site in East US is unavailable, it will provide automatic failover to the backup site in West Europe.

The diagram below approximately illustrates the environment you will be deploying in this exercise.

:::image type="content" source="../media/exercise-traffic-manager-environment-diagram-71c239ce.png" alt-text="Traffic manager profile pointed to two app service plans":::


In this exercise, you will:

 -  Task 1: Create the web apps
 -  Task 2: Create a Traffic Manager profile
 -  Task 3: Add Traffic Manager endpoints
 -  Task 4: Test the Traffic Manager profile
 -  Task 5: Clean up resources

## Task 1: Create the web apps

In this section, you will create two instances of a web application deployed in the two different Azure regions.

1.  On the Azure portal home page, select **Create a resource**, then select **Web App** (if this resource type is not listed on the page, use the search box at the top of the page to search for it and select it).
2.  On the **Create Web App** page, on the **Basics** tab, use the information in the table below to create the first web application.
    
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
        Subscription
      :::column-end:::
      :::column:::
        Select your subscription
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        Select **Create new** Name: **Contoso-RG-TM1**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **ContosoWebAppEastUSxx** (where xx are your initials to make the name unique)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Publish
      :::column-end:::
      :::column:::
        **Code**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Runtime stack
      :::column-end:::
      :::column:::
        **ASP.NET V4.8**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Operating system
      :::column-end:::
      :::column:::
        **Windows**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **East US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Windows Plan
      :::column-end:::
      :::column:::
        Select **Create new** Name: **ContosoAppServicePlanEastUS**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Sku and size
      :::column-end:::
      :::column:::
        **Standard S1 100 total ACU, 1.75-GB memory**
      :::column-end:::
    :::row-end:::
    
3.  Select the **Monitoring** tab.
4.  Under **Monitoring** set **Application Insights** to **No**.
5.  Select  **Review + create**.

    :::image type="content" source="../media/create-web-app-1-d09fee7f.png" alt-text="create a web app":::


6.  Select **Create**. When the Web App successfully deploys, it creates a default web site.
7.  Repeat steps 1-6 above to create a second web app. Use the same settings as before except for the information in the table below.
    
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
        Resource group
      :::column-end:::
      :::column:::
        Select **Create new** Name: **Contoso-RG-TM2**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **ContosoWebAppWestEuropexx** (where xx are your initials to make the name unique)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **West Europe**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Windows Plan
      :::column-end:::
      :::column:::
        Select **Create new** Name: **ContosoAppServicePlanWestEurope**
      :::column-end:::
    :::row-end:::
    
8.  On the Azure home page, select **All services**, in the left navigation menu, select **Web**, and then select **App Services**.
9.  You should see the two new web apps listed.

    :::image type="content" source="../media/create-web-app-2-621589aa.png" alt-text="showing two web apps listed in the Azure portal":::


## Task 2: Create a Traffic Manager profile

Now you will create a Traffic Manager profile that directs user traffic based on endpoint priority.

1.  On the Azure portal home page, select **Create a resource**.
2.  In the search box at the top of the page, type **Traffic Manager profile**, and then select it from the pop-up list.

    :::image type="content" source="../media/create-traffic-manager-profile-1-1eb497fc.png" alt-text="search results for traffic manager profile":::


3.  Select **Create**.
4.  On the **Create Traffic Manager profile** page, use the information in the table below to create the Traffic Manager profile.
    
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
        Name
      :::column-end:::
      :::column:::
        **Contoso-TMProfilexx** (where xx are your initials to make the name unique)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Routing method
      :::column-end:::
      :::column:::
        **Priority**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Select your subscription
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        **Contoso-RG-TM1**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group location
      :::column-end:::
      :::column:::
        **East US**
      :::column-end:::
    :::row-end:::
    
5.  Select **Create**.

## Task 3: Add Traffic Manager endpoints

In this section, you will add the website in the East US as the primary endpoint to route all the user traffic. You will then add the website in West Europe as a failover endpoint. If the primary endpoint becomes unavailable, then traffic will automatically be routed to the failover endpoint.

1.  On the Azure portal home page, select **All resources**, then select on **Contoso-TMProfile** in the resources list.
2.  Under **Settings**, select **Endpoints**, and then select **Add**.

    :::image type="content" source="../media/create-traffic-manager-endpoints-1-e7c38a4d.png" alt-text="add endpoints":::


3.  On the **Add endpoint** page, enter the information from the table below.
    
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
        Type
      :::column-end:::
      :::column:::
        **Azure endpoint**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **myPrimaryEndpoint**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Target resource type
      :::column-end:::
      :::column:::
        **App Service**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Target resource
      :::column-end:::
      :::column:::
        **ContosoWebAppEastUS (East US)**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Priority
      :::column-end:::
      :::column:::
        **1**
      :::column-end:::
    :::row-end:::
    
4.  Select **Add**.
5.  Repeat steps 2-4 above to create the failover endpoint. Use the same settings as before except for the information in the table below.
    
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
        Name
      :::column-end:::
      :::column:::
        **myFailoverEndpoint**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Target resource
      :::column-end:::
      :::column:::
        **ContosoWebAppWestEurope (West Europe)**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Priority
      :::column-end:::
      :::column:::
        **2**
      :::column-end:::
    :::row-end:::
    
6.  Setting a priority of 2 means that traffic will route to this failover endpoint if the configured primary endpoint becomes unhealthy.
7.  The two new endpoints are displayed in the Traffic Manager profile. Notice that after a few minutes the **Monitoring status** should change to **Online**.

:::image type="content" source="../media/create-traffic-manager-endpoints-2-a187bbc3.png" alt-text="two traffic manager endpoints":::


## Task 4: Test the Traffic Manager profile

In this section, you will check the DNS name of your Traffic Manager profile, and then you will configure the primary endpoint so that it is unavailable. You will then verify that the web app is still available, to test that the Traffic Manager profile is successfully sending traffic to the failover endpoint.

1.  On the **Contoso-TMProfile** page, select **Overview**.
2.  On the **Overview** screen, copy the **DNS name** entry to the clipboard (or take note of it somewhere).

    :::image type="content" source="../media/check-dns-name-1-dd70a336.png" alt-text="traffic manager DNS name":::


3.  Open a web browser tab, and paste (or enter) the **DNS name** entry (contoso-tmprofile.trafficmanager.net) into the address bar, and press Enter.
4.  The web app's default web site should be displayed.

    :::image type="content" source="../media/traffic-manager-web-app-test-1-af6fbe90.png" alt-text="web apps default webpage":::


5.  Currently all traffic is being sent to the primary endpoint as you set its **Priority** to **1**.
6.  To test the failover endpoint is working properly, you need to disable the primary site.
7.  On the **Contoso-TMProfile** page, on the overview screen, select **myPrimaryEndpoint**.
8.  On the **myPrimaryEndpoint** page, under **Status**, select **Disabled**, and then select **Save**.

    :::image type="content" source="../media/disable-primary-endpoint-1-d06833d5.png" alt-text="disable primary endpoint":::


9.  Close the **myPrimaryEndpoint** page (select the **X** in the top right corner of the page).
10. On the **Contoso-TMProfile** page, the **Monitor status** for **myPrimaryEndpoint** should now be **Disabled**.
11. Open a new web browser session, and paste (or enter) the **DNS name** entry (contoso-tmprofile.trafficmanager.net) into the address bar, and press Enter.
12. Verify that the web app is still responding. As the primary endpoint was not available, the traffic was instead routed to the failover endpoint to allow the web site to still function.

## Task 5: Clean up resources

> [!NOTE]
> Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1.  In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.
2.  Delete all resource groups you created throughout the labs of this module by running the following command:
    
    ```powershell
    Remove-AzResourceGroup -Name 'Contoso-RG-TM1' -Force -AsJob
    
    ```

> [!NOTE]
> The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
