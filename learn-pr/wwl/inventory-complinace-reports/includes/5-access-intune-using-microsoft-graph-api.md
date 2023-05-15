

The Microsoft Graph API for Intune enables programmatic access to Intune information for your tenant; the API performs the same Intune operations as those available through the Azure portal. Even though Microsoft Graph is primarily used for programmatic access to your data in the cloud, and thus can be used for building automation scripts. You can also use it to extract data from Intune and further manipulate that data into your favorite analysis or reporting tool. When you use Microsoft Graph you have access to all data in Intune but it’s more complex to work with compared to Power BI and Intune Data Warehouse, for example.

:::image type="content" source="../media/microsoft-graph-api-907866e3.png" alt-text="Illustration titled, Intune APIs in Microsoft Graph-automation, integration and advanced analytics." lightbox="../media/microsoft-graph-api-907866e3.png":::


For mobile device management (MDM) scenarios, the Graph API for Intune supports standalone deployments. Intune provides data into the Microsoft Graph in the same way as other cloud services do, with rich entity information and relationship navigation. Use Microsoft Graph to combine information from other services and Intune to build rich cross-service applications for IT professionals or end users.

Here’s an example of how you can determine whether an application is installed on a user's device:

1.  From Azure AD, get a list of devices registered to a user:
    
    ```
    https://graph.microsoft.com/beta/users/{user}/ownedDevices
    
    ```

2.  Then view the list of applications for your tenant:
    
    ```
    https://graph.microsoft.com/beta/deviceAppManagement/mobileApps
    
    ```

3.  Take the ID from the application and determine the installation state for the application (and therefore user):
    
    ```
    https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/{id}/deviceStatuses/
    
    ```

### Microsoft Graph Explorer

You could use the Microsoft Graph Explorer, which is a tool that lets you make requests and receive responses against the Microsoft Graph. Doing so should make it easier to find out how you would build your queries against Graph for Intune. You can find the Microsoft Graph Explorer at: [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer). For examples of scripts used to access and manipulate data in Intune using Microsoft Graph, refer to the Graph API PowerShell-Intune-Sample script at: [Microsoft Graph PowerShell Intune Samples](https://github.com/microsoftgraph/powershell-intune-samples).

Before using Microsoft Graph Explorer or running scripts against Microsoft Graph API, permissions must be assigned in Azure AD to the user running the tool. Microsoft Graph controls access to resources using permission scopes. As a developer, you must specify the permission scopes you need to access Intune resources. Typically, you specify the permission scopes you need in the Azure AD portal. It's also possible to assign the required permission in Microsoft Graph Explorer if you're logged on as a Global Administrator.
