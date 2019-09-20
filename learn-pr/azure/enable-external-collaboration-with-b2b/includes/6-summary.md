
Your organization needed to publish an application that allows clinicians from partnering health providers to access health records for patients at your facilities. As the solution architect, you were asked to enable them to collaborate securely.

Azure Active Directory B2B (Azure AD B2B) made it possible for us to collaborate with external users. We invited them as guest users in Azure AD B2B. We added a guest user to a directory, before adding them as a user in a specific group for guest users, and finally added the guest user as a user of an application we wanted to share for collaboration. We then explored how we can add additional security to our collaboration through Conditional Access policies that enforce multi-factor authentication.

Without Azure AD B2B, collaboration would be more difficult. The users wouldn't be able to just use their existing credentials to access the application. We also wouldn't have been able to scope an external user's access only to a particular application, instead we may have been forced given access at a higher scope. As a result, external users could be given more access than they need and there might have been an increased security risk. Additionally, without the ease of enforcing multi-factor authentication through Conditional Access policies, configuring multi-factor authentication would be more complex and time consuming.

With the help of Azure AD B2B, we rapidly created a collaborative environment with external users that we have invited ourselves. We were able to give them access through a simple invitation and redemption process. They click a link, and they are given access to an application. They only needed to share their email address. We did not have to create and store credentials for them, avoiding any additional unnecessary responsibilities. We can now also use Conditional Access policies that enforce multi-factor authentication, to add an additional layer of security for our shared application.

## Clean up resources

Remove the resources you have created in this module:

### Delete your user

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a user administrator or global administrator. If you're the person who signed up for an Azure subscription, you're automatically the global administrator.
1. Select **Azure Active Directory > Users**, select your user, then select **Delete user**.
1. The deleted user will be in the **Deleted users** section for 30 days. Delete it further. Select **Deleted users**, select your user, then select  **Delete permanently**.

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

1. The Azure portal will check whether you can delete the directory safely. And will allow you to select **Delete** if it is safe to do so. If it isn't safe to delete, use the links for each failed check to find out how to pass the test.

    ![Delete checks](../media/6-delete-check-directory.png)