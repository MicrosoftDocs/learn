
Your organization needed to publish an application that allows clinicians from partnering healthcare providers to access records for patients at your facilities. As the solution architect, you were asked to enable them to collaborate securely.

Azure Active Directory B2B (Azure AD B2B) makes it possible to collaborate with external users. You invited external users as guests in Azure AD B2B. Then you added a guest user to a directory, before adding them as a user in a specific group for guest users. Finally, you added the guest as a user of an application you wanted to share for collaboration. You explored how to add extra security to the collaboration through Conditional Access policies that enforce multi-factor authentication.

Without Azure AD B2B, collaboration would be more difficult. Users couldn't just use their existing credentials to access the application. You wouldn't have been able to scope an external user's access to a particular application only. Instead, you may have been forced to give access at a higher scope. External users could then be given more access than they need and there might be an increased security risk. Without the ease of enforcing multi-factor authentication through Conditional Access policies, configuring multi-factor authentication would be more complex and time consuming.

You used Azure AD B2B to rapidly create a collaborative environment with external users who you invited. These users were given access through a simple invitation and redemption process. Users click a link, and get access to an application, just by sharing their email address. You didn't have to create and store credentials for them, avoiding any additional unnecessary responsibilities. Also, you can now use Conditional Access policies that enforce multi-factor authentication, to add an extra layer of security for the shared application.

## Clean up resources

Remove the resources you've created in this module:

### Delete your user

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a user administrator or global administrator. If you're the person who signed up for an Azure subscription, you're automatically the global administrator.
1. Select **Azure Active Directory > Users**, select your user, then select **Delete user**.
1. The deleted user will be in the **Deleted users** section for 30 days. To delete it further, select **Deleted users**, select your user, then select  **Delete permanently**.

    ![Delete user permanently](../media/6-delete-user.png)

### Delete your group

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a global administrator. If you're the person who signed up for an Azure subscription, you're automatically the global administrator.
1. Select **Azure Active Directory > Groups**. Select your group, then select **Delete**.

    ![Delete group](../media/6-delete-group.png)

### Delete your application

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a global administrator.
1. Select **Azure Active Directory > Enterprise Applications**, then select your application.
1. Select **Properties > Delete**.

    ![Delete application](../media/6-delete-app.png)

### Delete the directory

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a global administrator.
1. Select **Azure Active Directory > Delete directory**.

    ![Delete directory](../media/6-delete-directory.png)

1. The Azure portal will check whether you can delete the directory safely. The portal allows you to select **Delete** if it's safe to do so. If it isn't safe to delete, use the links for each failed check to find out how to pass the test.

    ![Delete checks](../media/6-delete-check-directory.png)

## Learn more

[Azure Active Directory B2B documentation](https://docs.microsoft.com/azure/active-directory/b2b/)
