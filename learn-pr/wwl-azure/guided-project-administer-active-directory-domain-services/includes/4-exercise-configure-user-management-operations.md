In this exercise, you will perform user management operations.

## Create Organizational Units

In this task, you will create three OUs: Sydney, Melbourne, and Brisbane. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers from the Tools menu of the Server Manager console.
2.  Right-click on the Domain.
3.  Select **New**, then **Organizational Unit**.
4.  In the New Object dialog box, set the name to **Sydney** and click **OK**.
5.  Repeat this process to create the Melbourne OU and the Brisbane OU.

## Create users<br>

In this task you will create a user and configure account properties such as Account Expiration Date. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers (or Administrative Center).
2.  Right-click on the Sydney OU.
3.  Select **New**, then **User**.
4.  Type **SydneyContractor** in the Full name and User Logon name fields and click **Next**.
5.  Specify a password, such as Pa55w.rdPa55w.rd, and then confirm the password.
6.  Click **Next** and **Finish**.
7.  In the Sydney OU, double-click the SydneyContractor user account.
8.  In the Account tab, in the **Account expires** section, select **Jan 1, 2030**. Click **OK**.
9.  Right-click the Sydney Contractor user and select **Copy**.
10. Type **MelbourneContractor** in the Full name and User Logon name fields. Click **Next**.
11. Specify a password, such as **Pa55w.rdPa55w.rd**, and then confirm the password.
12. Click **Next** and **Finish**.
13. Right-click the Sydney Contractor user and select **Copy**.
14. Type **MelbourneContractor** in the Full name and User Logon name fields. Click **Next**.
15. Specify a password such as **Pa55w.rdPa55w.rd**, and then confirm the password.
16. Click **Next** and **Finish**.
17. Drag the Melbourne Contractor user to the Melbourne OU.
18. Drag the Brisbane Contractor user to the Brisbane OU.

## Create the Sydney Admins group<br>

In this task, you will create a new security group named Sydney Administrators. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers.
2.  Right click the Sydney OU, and select **New**, then **Group**.
3.  Type **Sydney Administrators** in Group name and select **Universal** in group scope. Click **OK**.
4.  In the Sydney OU, double-click SydneyContractor User account.
5.  In the Member Of tab, click **Add**.
6.  Type **Sydney Administrators**.
7.  Click **OK**, then click **OK**.

## Configure a user as a Protected User<br>

In this task, you will configure the SydneyContractor user account as a proptected user. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers (or Administrative Center).
2.  Navigate to the Sydney OU and double-click the SydneyContractor User account.
3.  In the Member Of tab, click **Add**.
4.  Type **Protected Users**.
5.  Click **OK**, then click **OK**.

## Delegate Security Permissions to an OU to a security group<br>

In this task, you will delegate the ability to reset passwords and force password change to the Sydney Administrators group over accounts in the Sydney OU. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers.
2.  Right-click the Sydney OU and click **Delegate Control**.
3.  On the Welcome page of the Delegation of Control Wizard, click **Next**.
4.  Click **Add** and type **Sydney Administrators**. Click **OK** and click **Next**.
5.  On the Delegate the following common tasks page, select the **Reset user passwords and force password change at next logon** option. Click **Next**.
6.  Click **Finish**.

## Configure City Attribute for a User<br>

In this task you will configure a city attribute for a user account and then use the Find attribute to verify that the user is present. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers.
2.  Select the Sydney OU, right-click the SydneyContractor user account, and click **Properties**.
3.  In the Address tab of the Sydney Contractor properties, set the City field to **Sydney** and click **OK**.
4.  In Active Directory Users and Computers, right-click Tailwindtrader.internal and click **Find**.
5.  In the Advanced tab of the Find Users, Contacts, and Groups dialog box, select **Field**, then **User**, then **City**. Set Condition to **Is (exactly)**. Set Value to **Sydney**. Click **Find Now** and verify that user SydneyContractor is listed.
6.  Close the Find Users, Contacts, and Groups dialog box.

## Disable the Melbourne Contractor User<br>

In this task, you will disable the Melbourne Contractor user. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers, and then open the Melbourne OU.
2.  In the Melbourne OU, right-click **MelbourneContractor** and click **Disable Account**.
3.  Click **OK**.

## Reset the password of the Brisbane Contractor User<br>

In this task, you will reset the password of the BrisbaneContractor user. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, open Active Directory Users and Computers, and then open the Brisbane OU.
2.  Right-click the BrisbaneContractor user and select **Reset Password**.
3.  On the Reset Password dialog box, type the password **Pa66w.rdPa66w.rd** twice and select **OK**. Click **OK** again in the dialog that notifies you that the password has been changed.
