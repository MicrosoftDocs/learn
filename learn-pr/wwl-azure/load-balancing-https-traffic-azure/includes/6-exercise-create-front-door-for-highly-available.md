> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

In this exercise, you will set up an Azure Front Door configuration that pools two instances of a web application that runs in different Azure regions. This configuration directs traffic to the nearest site that runs the application. Azure Front Door continuously monitors the web application. You will demonstrate automatic failover to the next available site when the nearest site is unavailable. The network configuration is shown in the following diagram:

:::image type="content" source="../media/front-door-environment-diagram-a8309453.png" alt-text="Network configuration for Azure Front Door.":::


In this exercise, you will:

 -  Task 1: Create two instances of a web app
 -  Task 2: Create a Front Door for your application
 -  Task 3: View Azure Front Door in action
 -  Task 4: Clean up resources

## Task 1: Create two instances of a web app

This exercise requires two instances of a web application that run in different Azure regions. Both the web application instances run in Active/Active mode, so either one can take traffic. This configuration differs from an Active/Stand-By configuration, where one acts as a failover.

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
2.  On the Azure portal home page, select + **Create a resource**.
3.  On the Create a resource page, select **WebApp**. 

    :::image type="content" source="../media/create-web-app-8a342a65.png" alt-text="Azure portal Create a web app.":::
    
4.  On the Create Web App page, on the **Basics** tab, enter or select the following information.
    
    |   **Setting**    |                                 **Value**                                  |
    |:----------------:|:--------------------------------------------------------------------------:|
    |   Subscription   |                         Select your subscription.                          |
    |  Resource group  |                Select the resource group provided by Learn.                |
    |       Name       |  Enter a unique Name for your web app. This example uses WebAppContoso-1.  |
    |     Publish      |                              Select **Code**.                              |
    |  Runtime stack   |                      Select **.NET Core 3.1 (LTS)**.                       |
    | Operating System |                            Select **Windows**.                             |
    |      Region      |                           Select **Central US**.                           |
    |   Windows Plan   | Select **Create new** and enter myAppServicePlanCentralUS in the text box. |
    |   SKU and size   |           Select **Standard S1 100 total ACU, 1.75 GB memory**.            |
5.  Select **Review + create**, review the Summary, and then select **Create**.<br>‎It might take several minutes for the deployment to complete.
6.  Create a second web app. On the Azure portal home page, select + **Create a resource**.
7.  On the Create a resource page, select **WebApp**.
8.  On the Create Web App page, on the **Basics** tab, enter or select the following information.
    
    |   **Setting**    |                                **Value**                                 |
    |:----------------:|:------------------------------------------------------------------------:|
    |   Subscription   |                        Select your subscription.                         |
    |  Resource group  |               Select the resource group provided by Learn.               |
    |       Name       | Enter a unique Name for your web app. This example uses WebAppContoso-2. |
    |     Publish      |                             Select **Code**.                             |
    |  Runtime stack   |                     Select **.NET Core 3.1 (LTS)**.                      |
    | Operating System |                           Select **Windows**.                            |
    |      Region      |                           Select **East US**.                            |
    |   Windows Plan   | Select **Create new** and enter myAppServicePlanEastUS in the text box.  |
    |   SKU and size   |          Select **Standard S1 100 total ACU, 1.75 GB memory**.           |
9.  Select **Review + create**, review the Summary, and then select **Create**.<br>‎It might take several minutes for the deployment to complete.

## Task 2: Create a Front Door for your application

Configure Azure Front Door to direct user traffic based on lowest latency between the two web apps servers. To begin, add a frontend host for Azure Front Door.

1.  On any Azure portal page, in **Search resources, services and docs (G+/)**, enter front door, and then select **Front Doors** from the results.

    :::image type="content" source="../media/search-front-door-2565a84c.png" alt-text="Azure portal Search for Front Door":::


2.  On the Front Doors page, select **+ Create**.
3.  In Create a Front Door, enter or select the following information.
    
    |       **Setting**       |                  **Value**                   |
    |:-----------------------:|:--------------------------------------------:|
    |      Subscription       |          Select your subscription.           |
    |     Resource group      | Select the resource group provided by Learn. |
    | Resource group location |            Select **Central US**.            |
4.  Select **Next: Configuration**.
5.  On the Configuration tab, in **Frontends/domains**, select **+** to add a frontend host.

    :::image type="content" source="../media/add-frontends-domains-6811137a.png" alt-text="Adding a frontend in the Azure portal":::


6.  Enter a globally unique **host name**, like contoso-frontend, and then select **Add**.
7.  Next, create a backend pool that contains your two web apps.<br>‎In Create a Front Door, in **Backend** pools, select + to add a backend pool.

    :::image type="content" source="../media/add-backends-15334426.png" alt-text="Create a Front Door add a backend pool":::


8.  Enter a **host name**, like BackendPool.
9.  Under **BACKENDS**, select + **Add a backend**.
10. In Add a backend, enter, or select the following information.
    
    |    **Setting**    |                                          **Value**                                          |
    |:-----------------:|:-------------------------------------------------------------------------------------------:|
    | Backend host type |                                   Select **App service**.                                   |
    |   Subscription    |                                  Select your subscription.                                  |
    | Backend host name | Select the first web app you created. In this example, the web app was **WebAppContoso-1**. |
11. Leave all other fields as default and then select **Add**.
12. Select **+ Add a backend** again, enter or select the following.
    
    |    **Setting**    |                                          **Value**                                           |
    |:-----------------:|:--------------------------------------------------------------------------------------------:|
    | Backend host type |                                     Select App service.                                      |
    |   Subscription    |                                  Select your subscription.                                   |
    | Backend host name | Select the second web app you created. In this example, the web app was **WebAppContoso-2**. |
13. Leave all other fields as default and then select **Add**.
14. On the **Add a backend** **pool** blade, select **Add** to complete the configuration of the backend pool.
15. Finally, add a routing rule. A routing rule maps your frontend host to the backend pool. This rule forwards a request for contoso-frontend.azurefd.net to myBackendPool.
16. In Create a Front Door, in **Routing rules**, select **+** to configure a routing rule.

    :::image type="content" source="../media/add-routing-rules-f2d3427f.png" alt-text="Create a Front Door add a routing rule":::


17. In Add a rule, for **Name**, enter LocationRule.
18. Accept all the default values, then select **Add** to add the routing rule.
19. Select **Review + Create**, and then **Create**.

**You must ensure that each of the frontend hosts in your Front Door has a routing rule with a default path (\*) associated with it. That is, across all your routing rules there must be at least one routing rule for each of your frontend hosts defined at the default path (\*). Failing to do so may result in your end-user traffic not getting routed correctly**.

## Task 3: View Azure Front Door in action

Once you create a Front Door, it takes a few minutes for the configuration to be deployed globally. Once complete, access the frontend host you created.

1.  In the Azure portal, navigate to your Front Door frontend. Select **Go to Resource**. Or in Search resources, services, and docs (G+/), enter **front door**, and select **Front Doors** from the results, and then select your Front Door.
2.  On the Front Door page, note the **Frontend host** URL. This exercise uses contoso-frontend.azurefd.net, but you may have altered it to ensure the name is unique.

    :::image type="content" source="../media/frontend-url-f22dc477.png" alt-text="Azure portal Frontend page - Verify Frontend URL":::


3.  In a browser, go to your Frontend host URL (contoso-frontend.azurefd.net). Your request will automatically be routed to the nearest server to you from the specified servers in the backend pool.
4.  You'll see the following information page:

    :::image type="content" source="../media/app-service-info-page-6b633245.png" alt-text="Browser showing App Service information page":::


5.  To test instant global failover in action, try the following steps:
6.  Switch to the Azure portal, search for and select **App services**.
7.  Select one of your web apps, then select **Stop**, and then select **Yes** to verify.

    :::image type="content" source="../media/stop-web-app-467fd292.png" alt-text="Azure portal showing stopped Web App":::


8.  Switch back to your browser and select Refresh. You should see the same information page.

**There may be a delay while the web app stops. If you get an error page in your browser, refresh the page**.

1.  Switch back to the Azure portal, locate the other web app, and stop it.
2.  Switch back to your browser and select Refresh. This time, you should see an error message.

:::image type="content" source="../media/web-apps-both-stopped-151f5f64.png" alt-text="Browser showing App Service error page":::


Congratulations! You have configured and tested an Azure Front Door.

## Task 4: Clean up resources

> [!NOTE]
> Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1.  In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.
2.  Delete all resource groups you created throughout the labs of this module by running the following command:
    
    ```powershell
    Remove-AzResourceGroup -Name 'ContosoResourceGroup' -Force -AsJob
    
    ```

> [!NOTE]
> The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
