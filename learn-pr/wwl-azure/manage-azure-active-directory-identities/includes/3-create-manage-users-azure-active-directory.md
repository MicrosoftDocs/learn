

You can manage Azure AD users, groups, and devices by using the Azure portal, the Microsoft Azure Active Directory module for Windows PowerShell, or Microsoft 365. You can add users to a directory, and also add users to groups.

You can create two types of user accounts on the Azure portal:

 -  **Member users:** Are accounts that your Azure AD tenant manages. After creating a user, you can configure user properties. Member users are the most commonly created user type.
 -  **Guest users:** Are accounts that your Azure AD tenant doesn’t manage, but you want to assign permissions to the users. A guest user account is a member user from another Azure AD tenant or a Microsoft account. Although administrators can create these accounts, these accounts are often created automatically when users share content with external users. For example, if you share a OneDrive file with a user, then a Guest user account is created.

There are essentially two ways to create and manage your users:

 -  **As cloud identities by using only Azure AD** This option is the quickest and most straightforward method.
 -  **As directory-synchronized identities by using an on-premises directory service to synchronize with Azure AD:** This method has the added complexity of installing and configuring synchronization software to ensure that directory objects synchronize successfully with Azure AD.

The Azure portal provides a simple web interface for creating and managing users, groups, and devices.

#### Create and manage users with the Azure portal

Using the Azure portal is the simplest method for creating single or small numbers of user accounts.

To create a single user, perform the following steps:

1.  In the Azure portal, on the left pane, select **Azure Active Directory**.
2.  Select **Users and groups**, and then select **All users**.
3.  Select **+ New user**.
4.  Enter the following user information:
    
     -  Name
     -  User name: < unique name >
     -  Profile - First Name/Last Name/Display Name: (choose appropriate values)
     -  Properties: choose source of authority (default is Azure AD)
     -  Groups: Select groups to which you want the new user to belong
     -  Directory role: User, Global administrator, or Limited administrator
5.  Select **Create** to finalize user creation. After the user is created, a temporary password appears.
