In this unit you learn how to deploy App Service in Azure Stack Hub, which gives your users the ability to create Web, API and Azure Functions applications. You need to:

 -  Add the App Service resource provider to your Azure Stack Hub deployment using the steps described in this unit.
 -  After you install the App Service resource provider, you can include it in your offers and plans. Users can then subscribe to get the service and start creating apps.

## Run the App Service resource provider installer

Installing the App Service resource provider takes at least an hour. The length of time needed depends on how many role instances you deploy. During the deployment, the installer runs the following tasks:

 -  Registers the required resource providers in the Default Provider Subscription
 -  Grants contributor access to the App Service Identity application
 -  Create Resource Group and Virtual network (if necessary)
 -  Create Storage accounts and containers for App Service installation artifacts, usage service, and resource hydration.
 -  Download App Service artifacts and upload them to the App Service storage account.
 -  Deploy the App Service.
 -  Register the Usage Service.
 -  Create DNS Entries for App Service.
 -  Register the App Service admin and tenant resource providers.
 -  Register Gallery Items - Web, API, Function App, App Service Plan, WordPress, DNN, Orchard, and Django applications.

To deploy App Service resource provider, follow these steps:

1.  Run appservice.exe as an admin from a computer that can access the Azure Stack Hub Admin Azure Resource Management Endpoint.
2.  Select **Deploy App Service or upgrade to the latest version**.
    
    :::image type="content" source="../media/deploy-an-app-service-image-1-79b46689.png" alt-text="Screenshot showing the main screen of the Azure App Service installer.":::
    

3.  Review and accept the Microsoft Software License Terms and then select **Next**.
4.  Review and accept the third-party license terms and then select **Next**.
5.  Make sure that the App Service cloud configuration information is correct.
    
    :::image type="content" source="../media/deploy-an-app-service-image-2-25ccb730.png" alt-text="Screenshot that shows the screen for specifying the endpoints for the App Service.":::
    

6.  Now you can deploy into an existing virtual network, or let the App Service installer create a new virtual network and subnets.
    
    :::image type="content" source="../media/deploy-an-app-service-image-4-67606340.png" alt-text="Screenshot that shows the screen where you configure your virtual network in the App Service installer.":::
    

7.  Enter the info for your file share and then select **Next**. The address of the file share must use the Fully Qualified Domain Name (FQDN) or the IP address of your File Server.

8.  On the next App Service Installer page, follow these steps:
    
     -  In the Identity Application ID box, enter the GUID for the Identity application you created.
     -  In the Identity Application certificate file box, enter (or browse to) the location of the certificate file.
     -  In the Identity Application certificate password box, enter the password for the certificate. This password is the one that you made note of when you used the script to create the certificates.
     -  In the Azure Resource Manager root certificate file box, enter (or browse to) the location of the certificate file.
     -  Select **Next**.
        
        :::image type="content" source="../media/deploy-an-app-service-image-6-9f611b9f.png" alt-text="Screenshot that shows the screen that provides the details of the identity.":::
        

9.  For each of the three certificate file boxes, select **Browse** and navigate to the appropriate certificate file. Provide the password for each certificate. Select **Next** after entering all the information.

:::row:::
  :::column:::
    **Box**
  :::column-end:::
  :::column:::
    **Certificate file name example**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    App Service default SSL certificate file
  :::column-end:::
  :::column:::
    \_.appservice.local.AzureStack.external.pfx
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    App Service API SSL certificate file
  :::column-end:::
  :::column:::
    api.appservice.local.AzureStack.external.pfx
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    App Service Publisher SSL certificate file
  :::column-end:::
  :::column:::
    ftp.appservice.local.AzureStack.external.pfx
  :::column-end:::
:::row-end:::


10. If you used a different domain suffix when you created the certificates, your certificate file names don't use local.AzureStack.external. Instead, use your custom domain info.
    
    :::image type="content" source="../media/deploy-an-app-service-image-7-f12cb435.png" alt-text="Screenshot that shows the screen where you provide the details of the required certificates in the App Service Installer.":::
    

11. Enter the SQL Server details for the server instance used to host the App Service resource provider database and then select **Next**. The installer validates the SQL connection properties. ‎The App Service installer tries to test connectivity to the SQL Server before proceeding. If you're deploying to an existing virtual network, this connectivity test might fail. You're given a warning and a prompt to continue. If the SQL Server info is correct, continue the deployment.
    
    :::image type="content" source="../media/deploy-an-app-service-image-8-b4ce4401.png" alt-text="Screenshot that shows the screen where you provide the connection details for SQL Server in the App Service Installer.":::
    

12. Review the role instance and SKU options. The defaults populate with the minimum number of instances and the minimum SKU for each role in a production deployment. For ASDK deployment, you can scale the instances down to lower SKUs to reduce the core and memory commit but you will experience a performance degradation. A summary of vCPU and memory requirements is provided to help plan your deployment. After you make your selections, select Next.

:::row:::
  :::column:::
    **Role**
  :::column-end:::
  :::column:::
    **Minimum instances**
  :::column-end:::
  :::column:::
    **Minimum SKU**
  :::column-end:::
  :::column:::
    **Notes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Controller
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    Standard\_A4\_v2 - (4 cores, 8192 MB)
  :::column-end:::
  :::column:::
    Manages and maintains the health of the App Service cloud.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Management
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Standard\_D3\_v2 - (4 cores, 14336 MB)
  :::column-end:::
  :::column:::
    Manages the App Service Azure Resource Manager and API endpoints, portal extensions (admin, tenant, Functions portal), and the data service. To support failover, increase the recommended instances to 2.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Publisher
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Standard\_A2\_v2 - (2 cores, 4096 MB)
  :::column-end:::
  :::column:::
    Publishes content via FTP and web deployment.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    FrontEnd
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Standard\_A4\_v2 - (4 cores, 8192 MB)
  :::column-end:::
  :::column:::
    Routes requests to App Service apps.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Shared Worker
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Standard\_A4\_v2 - (4 cores, 8192 MB)
  :::column-end:::
  :::column:::
    Hosts web or API apps and Azure Functions apps. You might want to add more instances. As an operator, you can define your offering and choose any SKU tier. The tiers must have a minimum of one vCPU.
  :::column-end:::
:::row-end:::


13. In the **Select Platform Image** box, choose your deployment Windows Server 2016 virtual machine image from the images available in the compute resource provider for the App Service cloud. Select **Next**.
14. On the next App Service Installer page, follow these steps:
    
     -  Enter the Worker Role virtual machine admin user name and password.
     -  Enter the Other Roles virtual machine admin user name and password.
     -  Select Next.
        
        :::image type="content" source="../media/deploy-an-app-service-image-10-2fd2e52d.png" alt-text="Screenshot that shows the screen where you select the Windows Platform Image to be used by the App Service Installer.":::
        

15. On the App Service Installer summary page, follow these steps:
    
     -  Verify the selections you made. To make changes, use the Previous buttons to visit previous pages.
     -  If the configurations are correct, select the check box.
     -  To start the deployment, select Next.
        
        :::image type="content" source="../media/deploy-an-app-service-image-11-a8dfe465.png" alt-text="Screenshot that shows the summary of the options specified for deployment by the App Service Installer.":::
        

16. On the next App Service Installer page, follow these steps:
    
     -  Track the installation progress. App Service on Azure Stack Hub can take up to 240 minutes to deploy based on the default selections and age of the base Windows 2016 Datacenter image.
     -  After the installer successfully finishes, select Exit.
        
        :::image type="content" source="../media/deploy-an-app-service-image-12-07f3f365.png" alt-text="Screenshot that shows the deployment progress made by the App Service Installer.":::
        

## Post-deployment Steps

If you're deploying to an existing virtual network and using an internal IP address to connect to your file server, you must add an outbound security rule. This rule enables SMB traffic between the worker subnet and the file server. In the administrator portal, go to the WorkersNsg Network Security Group and add an outbound security rule with the following properties:

 -  Source: Any
 -  Source port range: \*
 -  Destination: IP addresses
 -  Destination IP address range: Range of IPs for your file server
 -  Destination port range: 445
 -  Protocol: TCP
 -  Action: Allow
 -  Priority: 700
 -  Name: Outbound\_Allow\_SMB445

## Validate the App Service on Azure Stack Hub installation

1.  In the Azure Stack Hub administrator portal, go to **Administration - App Service**.
2.  In the overview, under status, check to see that the **Status** displays **All roles are ready**.
    
    :::image type="content" source="../media/deploy-an-app-service-image-13-375909ec.png" alt-text="App Service administration in the Azure Stack Hub Administration Portal.":::
    
