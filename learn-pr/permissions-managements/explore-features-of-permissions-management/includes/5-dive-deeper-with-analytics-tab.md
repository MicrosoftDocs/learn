Now that you've seen some of the high-level insights that Microsoft Entra Permissions Management provides, let’s get more granular with the Analytics tab. 

:::image type="content" source="../media/analytics-tab.png" alt-text="Screenshot of the Permissions Management Analytics tab."lightbox="../media/analytics-tab.png":::

The Analytics tab gives you more detailed visibility into each cloud environment by providing access into exactly which permissions each identity has and how they're being granted. 

For the sake of this module, we focus on the **Users** view, but note that the information discussed here also applies to the **Group**, **Resource**, **Task**, **Access Key**, and **Serverless Function** views.  

:::image type="content" source="../media/analytics-menu.png" alt-text="Screenshot of the Permissions Management Analytics menu."lightbox="../media/analytics-menu.png":::

:::image type="content" source="../media/analytics-users.png" alt-text="Screenshot of the Permissions Management Analytics users view."lightbox="../media/analytics-users.png":::


The initial view on the Analytics tab shows you the following information about your users: 

- Name 
    - Name and UPN of the user 
    - Type of User (SAML Users, Local User, ED User, etc.)   
- Domain/Account 
    - The domain/account that the user is associated with 
- Permission Creep Index 
    - Index: The PCI score of the user 
    - Since: Risk Classification of the User (High, Medium, or Low Risk) and how long the user has been in that state 
- Tasks 
    - Granted: How many permissions the user has been granted 
    - Executed: How many permissions the user has used within the past 90 days 
- Total Resources Accessible: How many resources the user has access to 
- User Groups: How many groups the user belongs to 
- Last Activity On: The date and time of the user’s last executed permission 

:::image type="content" source="../media/analytics-user-information.png" alt-text="Screenshot of the Permissions Management Analytics users information."lightbox="../media/analytics-user-information.png":::

Selecting the triangular dropdown next to any user gives you a more detailed view of that user and provides the following additional information: 

- Comprehensive list of the user’s used and unused tasks 
- List of the groups that the user belongs to 
- List of the roles that the user is assigned 
    - Source of the role assignment 
    - Type of role assignment (permanent, PIM eligible, etc.) 

:::image type="content" source="../media/analytics-user-permissions.png" alt-text="Screenshot of the Permissions Management Analytics users permissions."lightbox="../media/analytics-user-permissions.png":::

For more information on a specific user, you select the specific user’s name. Selecting a user’s name pulls up a view with comprehensive information on the user, including: 

- A complete list of all the permissions that the user has and the source of each permission 
- Logs of previous high-risk activities performed by the user 
- A comprehensive list of all the resources that the user has accessed in the past 90 days and the tasks that they performed on those resources

More views and features are available depending on what you’re looking at. For example, if you’re viewing Access Key information, a calendar view is presented that allows you to see what days and times your access keys are being used.

:::image type="content" source="../media/analytics-access-key-information.png" alt-text="Screenshot of the Permissions Management Analytics Access Key information."lightbox="../media/analytics-access-key-information.png":::

For more information about analytics and the data you can view, see [View analytic information with the Analytics dashboard.](https://go.microsoft.com/fwlink/?linkid=2247976)