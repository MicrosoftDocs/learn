The ability to manage multiple Active Directory (AD) objects efficiently is not just a convenience—it’s a necessity. Bulk management allows you to perform tasks across numerous AD objects with ease and precision. Using bulk management is particularly beneficial when dealing with large-scale changes that would be too cumbersome to handle individually.

By leveraging tools like Windows PowerShell, or Active Directory Administrative Center, you can automate repetitive tasks, such as moving user accounts to specific organizational units or updating user attributes in bulk, saving valuable time and reducing the potential for human error.

The examples in this unit show the steps to perform the tasks using the Active Directory Administrative Center, but you can accomplish the same result using other tools, such as Windows PowerShell.

## Move user accounts to a new organizational unit

Moving user accounts to a specific organizational unit (OU) allows for centralized control and uniform policy enforcement, making the administration of permissions and resources both effective and efficient.

1.  Open the Active Directory Administrative Center and browse to the domain.
2.  Right-click the root of the domain, select **Find** and then select the **Advanced** tab.
3.  Select **Field**, click the **User** dropdown list, and select **Is Exactly**.
4.  Click the **Value** dropdown list and select **=London**.
5.  Select **Add** and click **Find now**.<br>This action returns all the user accounts with the City attribute set to London.
6.  Select and right-click all the returned user accounts, and from the context menu select **Move**.
7.  In the **Move** dialog box, navigate to and select the London OU, then click **OK** to move the accounts.
8.  With the user accounts still selected in the London OU, right-click and select **Disable** to disable all selected accounts.

## Re-enable accounts and force a password reset

Regularly changing passwords helps prevent unauthorized access from compromised credentials and reduces the window of opportunity for an attacker to use stolen passwords.

1.  To re-enable the accounts in the London OU, right-click the disabled accounts and select **Enable**.
2.  Right-click the accounts again and select **Properties**.
3.  Navigate to the **Account** tab, check the **User must change password at next logon** option, and apply the changes.<br>This will force a password reset the next time a user attempts to log on to the domain.

These examples show how an administrator can efficiently manage multiple user accounts in AD DS, ensuring that organizational changes are reflected promptly in the directory service.

Please note that the procedures in this unit are a general guide. For specific instructions tailored to directory management and security of your environment, you should refer to any documentation or guidance provided by your organization's IT department.
