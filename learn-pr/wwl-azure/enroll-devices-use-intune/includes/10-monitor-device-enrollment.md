

As an Intune administrator, you must ensure that managed devices are providing the resources that your users need to do their work, while protecting that data from risk.

The Devices workload gives you insights into the devices you manage, and lets you perform remote tasks on those devices.

#### Monitoring enrolled devices

1.  Sign in to the **Microsoft Intune admin center**.
2.  Select **Devices**. This view shows detailed information about the individual devices, and what you can do with them, including:
    
     -  **Overview** shows a visual snapshot of the enrolled devices, and also shows how many devices are using the different platforms, including Android, iOS, and more.
        
        :::image type="content" source="../media/endpoint-manage-admin-center-devices-overview-7cec0bde.png" alt-text="Screenshot of the Devices, Overview screen.":::
        
     -  **All devices** shows a list of the enrolled devices you manage.
        
        :::image type="content" source="../media/endpoint-manage-admin-center-all-devices-f210129c.png" alt-text="Screenshot of the Devices, All devices screen.":::
        
        
         -  Use the Export feature to create a .csv list of all the devices, in increments of 10,000 (Internet Explorer) or 30,000 (Microsoft Edge, Chrome).
         -  Select any device to view additional details about that device, including hardware details, installed apps, its compliance policy status, and more.
     -  **Monitor** provides several reports related to the status of devices.
        
        :::image type="content" source="../media/intune-monitor-enrollment-failures-0d6af6b0.png" alt-text="Screenshot of the Devices, Monitor Overview, Enrollment failures screen.":::
        
        
         -  Enrollment failures. Provides views of devices, which include the type of failure and method of enrollment.
         -  Incomplete user enrollments. Using this information, you can update your onboarding documents to help users complete enrollment. For example, if many users are quitting at the Terms of Use, you might investigate that area and make it more intuitive for users.

#### Monitoring Azure AD-joined devices

Not all devices will be necessarily listed in the Microsoft Intune admin center, only devices that are enrolled in Intune. For devices that are joined to the domain, but haven't been enrolled in Intune, you can view these devices in the Azure portal.

1.  Sign in to the Azure portal.
2.  Select **Azure Active Directory**, and then select **Devices**.
    
     -  **All Devices** shows a list of the devices registered or joined with Azure Active Directory (Azure AD).
        
        :::image type="content" source="../media/azure-active-directory-devices-4b76d514.png" alt-text="Screenshot of the Azure AD Devices, All devices screen.":::
        
     -  **Device Settings** includes settings which users can join devices to Azure AD, local administrator accounts, allowing users to register personal devices, and whether to require MFA.
     -  **Enterprise State Roaming** defines which groups may sync settings and app data across devices.
     -  **Audit Logs** log all activities that generated changes in Microsoft Intune. Audit logs include activities such as create, update, delete, and assign. You can review audit logs for most Intune workloads. Auditing is enabled by default, and it can't be disabled. As there can be many audit events, you can filter them based on several criteria or use Graph API to retrieve up to one year of audit events.
        
        :::image type="content" source="../media/intune-monitor-enrollment-failures-0d6af6b0.png" alt-text="Screenshot of the Devices, Overview screen.":::
        
