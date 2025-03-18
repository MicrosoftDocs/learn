You’ve learned about the fundamental AD DS structure and how users, groups, and group managed service accounts relate to Organizational Units OUs. You’ve also learned that there are several tools that you can use to manage AD DS.

In this unit, you’ll see how to create basic AD DS objects, starting with OUs, which are essential for grouping and managing resources within a domain. The examples in this unit show the steps to create these objects using the Active Directory Administrative Center, but you can accomplish the same tasks using other tools, such as Windows PowerShell.

## Create an organizational unit

Creating an organizational unit (OU) in Active Directory provides you with a hierarchical framework for organizing objects, such as users, groups, and computers. You can then use this framework to apply group policies and delegate administrative control over these resources.

To create a new Organizational Unit (OU) in Active Directory:

1.  Open the Active Directory Administrative Center.
2.  In the navigation pane, right-click the domain or the folder where you want to add the new OU.
3.  Select **New** and then select **Organizational Unit**.
4.  In the dialog box that appears, type the name of the new OU.
5.  Select **OK** to create the OU.

## Create a new user account

When you create a new user account in Active Directory, you provide an individual with access permissions and the resources necessary for their role within the organization.

To create a new user account in an OU in Active Directory:

1.  In the Active Directory Administrative Center, navigate to the desired OU where you want to create the new user account.
2.  Right-click the OU, select **New** and then select **User**.
3.  When the wizard opens, enter the user’s details. This includes the new user’s full name, user logon name, and any other pertinent details.
4.  Once you have entered all the required information, click **Next**.
5.  You’re then prompted to enter a password for the new user account and to confirm it.<br>You can also set various user account options, such as password expiration or user being required change their password at the next logon.
6.  After setting the password and other options, click **Next**.
7.  Review the information and click **Finish**.

## Create a new group

Creating a group in Active Directory lets you manage a collection of users, computers, contacts, and other groups as a single entity. Groups make it simpler to assign permissions and rights across multiple accounts.

To create a new group in a specific OU in Active Directory:

1.  In the Active Directory Administrative Center, navigate to the desired OU where you want to create the new group.
2.  Right-click the OU, select **New** and then select **Group**.
3.  In the **Group** dialog box, enter the group’s name and choose the group scope and type.
4.  Click **OK** to create the new group.

### Add a user to a group

To add a user account to a group in an OU in Active Directory:

1.  In the Active Directory Administrative Center, navigate to the OU where the group is located.
2.  Find and select the group you want to add the user to.
3.  In the right-hand action pane, select **Members**.
4.  In the Members section, click **Add**.
5.  In the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box, type the name of the user you want to add to the group, and then click **OK**.<br>The user will now be listed as a member of the group.
6.  Click **OK** to confirm and close the dialog box.
