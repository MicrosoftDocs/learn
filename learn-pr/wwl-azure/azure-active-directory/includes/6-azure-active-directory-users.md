In Azure AD, every user who needs access to resources needs a user account. A user account is a synced Active Directory Domain Services (AD DS) object or an Azure AD user object that contains all the information needed to authenticate and authorize the user during the sign-on process and to build the user's access token.

To view the Azure AD users, access the **All users** blade. Take a minute to access the portal and view your users. Notice the **USER TYPE** and **SOURCE** columns, as the following figure depicts.

:::image type="content" source="../media/az500-azure-active-directory-users-8b0306e5.png" alt-text="Screenshot that depicts the All users blade, with the USER TYPE and SOURCE columns noted.":::


Typically, Azure AD defines users in three ways:

 -  **Cloud identities** \- These users exist only in Azure AD. Examples are administrator accounts and users that you manage yourself. Their source is Azure AD.
 -  **Directory-synchronized identities** \- These users exist in on-premises Active Directory. A synchronization activity that occurs via **Azure AD Connect** brings these users in to Azure.
 -  **Guest users** \- These users exist outside Azure. Examples are accounts from other cloud providers and Microsoft accounts.
