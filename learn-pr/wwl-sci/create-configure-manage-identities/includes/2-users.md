Every user who needs access to Azure resources needs an Azure user account. A user account contains all the information needed to authenticate the user during the sign-on process. Once authenticated Microsoft Entra ID builds an access token to authorize the user and determine what resources they can access and what they can do with those resources.

You use the **Microsoft Entra ID** dashboard in the Azure portal to work with user objects. Keep in mind that you can only work with a single directory at a time. You can use the **Directory + Subscription** panel to switch directories. The dashboard also has a **Switch directory** button in the toolbar which makes it easy to switch to another available directory.

## View users

To view the Microsoft Entra users, select the **Users** entry under the **Manage** group - this will open the **All Users** view. Take a minute to access the portal and view your users. Notice the **User Type** column to see members and guests, as the following figure depicts.

:::image type="content" source="../media/all-users-dialog-50b4e098.png" alt-text="Screenshot of the Microsoft Entra ID view all users page.  It displays a list of the users in alphabetical order with basic information about each user like their full name, alias, and whether they are a member of the directory or a guest.":::


Typically, Microsoft Entra ID defines users in three ways:

 -  **Cloud identities** \- These users exist only in Microsoft Entra ID. Examples are administrator accounts and users that you manage yourself. Their source is **Microsoft Entra ID** or **External Microsoft Entra directory** if the user is defined in another Microsoft Entra instance but needs access to subscription resources controlled by this directory. When these accounts are removed from the primary directory, they are deleted.
 -  **Directory-synchronized identities** \- These users exist in an on-premises Active Directory. A synchronization activity that occurs via **Microsoft Entra Connect** brings these users in to Azure. Their source is **Windows Server AD**.
 -  **Guest users** \- These users exist outside Azure. Examples are accounts from other cloud providers and Microsoft accounts such as an Xbox LIVE account. Their source is **Invited user**. This type of account is useful when external vendors or contractors need access to your Azure resources. Once their help is no longer necessary, you can remove the account and all of their access.
