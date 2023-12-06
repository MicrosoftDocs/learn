In addition to the existing investigation of OAuth apps connected to your environment, you can set permission policies so that you get automated notifications when an OAuth app meets certain criteria. For example, you can automatically be alerted when there are apps that require a high permission level and were authorized by more than 50 users. OAuth app policies enable you to investigate which permissions each app requested and which users authorized them for Office 365, and other OAuth apps. You're also able to mark these permissions as approved or banned. Marking them as banned will disable the correlating Enterprise Application.

## Create a new OAuth app policy

1.  Launch **Microsoft Defender for Cloud Apps** at [https://www.cloudappsecurity.com](https://www.cloudappsecurity.com).
2.  Under **Investigate**, select **OAuth apps**.
3.  Filter the apps according to your needs.
    
    
     -  For example, you can view all apps that request Permission to Modify calendars in your mailbox.
4.  Select the **New policy** from search button.
    
    :::image type="content" source="../media/oauth-policy-dialog-dd3bedc7.png" alt-text="Screenshot of the Microsoft Defender for Cloud Apps site with the create OAuth Policy dialog open.":::
    
5.  You can use the **Community use** filter to get information on whether allowing permission to this app is common, uncommon, or rare.
    
    
     -  This filter can be helpful if you have an app that's rare and requests permission that has a high severity level or requests permission from many users.
6.  You can set the policy based on the group memberships of the users who authorized the apps.
    
    
     -  For example, an admin can decide to set a policy that revokes uncommon apps if they ask for high permissions, only if the user who authorized the permissions is a member of the Administrators group.

### Control policies

Alternatively, you can also create the policy by selecting **Control** followed by **Policies**. Then select **Create policy** followed by **OAuth app policy**.
