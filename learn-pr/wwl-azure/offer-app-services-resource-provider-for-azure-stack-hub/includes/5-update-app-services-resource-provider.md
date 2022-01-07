In this unit, you learn how to upgrade the Azure App Service resource provider deployed in an internet-connected Azure Stack Hub environment.

## Run the Azure App Service resource provider installer

During this process, the upgrade will:

 -  Detect prior deployment of Azure App Service.
 -  Prepare all update packages and new versions of all OSS Libraries to be deployed.
 -  Upload to storage.
 -  Upgrade all Azure App Service roles (Controllers, Management, Front-End, Publisher, and Worker roles).
 -  Update Azure App Service scale set definitions.
 -  Update Azure App Service resource provider manifest.

The Azure App Service installer must be run on a machine, which can reach the Azure Stack Hub admin Azure Resource Manager endpoint.

To upgrade your deployment of Azure App Service on Azure Stack Hub, follow these steps:

1.  Download the [Azure App Service Installer](https://aka.ms/appsvcupdateQ3installer).
2.  Run appservice.exe as an admin.
    
    :::image type="content" source="../media/update-app-service-image-1-2ec1aca0.png" alt-text="Screenshot that shows how to start the deployment or upgrade process in the App Service installer.":::
    

3.  Click **Deploy Azure App Service or upgrade to the latest version**.
4.  Review and accept the Microsoft Software License Terms and then click **Next**.
5.  Review and accept the third-party license terms and then click **Next**.
6.  Make sure that the Azure Stack Hub Azure Resource Manager endpoint and Active Directory Tenant info is correct. If you used the default settings during ASDK deployment, you can accept the default values here.
    
    :::image type="content" source="../media/update-app-service-image-2-0be450af.png" alt-text="Screenshot that shows where to configure the ARM endpoints in the App Service installer.":::
    

7.  On the next page **Credential** or **Service Principal**.
    
    :::image type="content" source="../media/update-app-service-image-3-52284e5b.png" alt-text="Screenshot that shows where you specify the Azure Stack Hub subscription information in the App Service installer.":::
    

8.  On the summary page, set the following:
    
     -  Verify the selections you made. To make changes, use the **Previous** buttons to visit previous pages.
     -  If the configurations are correct, select the check box.
     -  To start the upgrade, click **Next**.
        
        :::image type="content" source="../media/update-app-service-image-4-683fa275.png" alt-text="Screenshot that shows the App Service upgrade summary in the installer.":::
        

9.  Upgrade progress page:
    
     -  Track the upgrade progress. The duration of the upgrade of Azure App Service on Azure Stack Hub varies depending on the number of role instances deployed.
     -  After the upgrade successfully completes, click **Exit**.
        
        :::image type="content" source="../media/update-app-service-image-5-24c3b7b8.png" alt-text="Screenshot that shows the deployment progress in the App Service installer.":::
        
