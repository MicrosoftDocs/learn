Configuring Active Directory objects is essential for maintaining the integrity and security of the network. By setting parameters such as expiration dates for user accounts, disabling accounts when necessary, and resetting passwords, AD administrators ensure that only authorized users have access to the resources they need, and for the appropriate amount of time.

Although these are only a subset of routine tasks an Active Directory administrator performs, they are critical in protecting sensitive information from unauthorized access and potential security breaches. Proper configuration helps in enforcing compliance with security policies, streamlining user management, and minimizing the risk of downtime due to compromised accounts. Therefore, understanding and executing these configuration tasks effectively is a fundamental responsibility for AD administrators to maintain a secure and efficient network.

## Configure the expiration date of a user account

To configure the expiration date for a user account in Active Directory:

1.  In the **Active Directory Administrative Center**, navigate to the OU where the user account resides.
2.  Find and select the user account you want to modify.
3.  In the right-hand action pane, click **Properties**.
4.  Scroll down to the **Account** section.
5.  Under the **Account** section, you will find the **Account expires** option. Click **End of** and select the date on which you want the account to expire.
6.  Click **OK** to save changes.

This sets the expiration date for the user account, after which the account will no longer be active in Active Directory. Remember to communicate any account changes to the affected user to avoid any disruptions in their access.

## Disable user accounts

To disable user accounts in Active Directory:

1.  Open the **Active Directory Administrative Center** (ADAC).
2.  Navigate to the OU where the user account is located.
3.  Find and select the user account you want to disable.
4.  In the right-hand action pane, click **Properties**.
5.  In the Account tab, select the **Account is disabled** checkbox.
6.  Click **OK** to save changes and disable the account.

This will disable the selected user account, preventing any logins using that account. Remember to document any changes made to user accounts for future reference and compliance.

## Reset user passwords

To ensure that users are forced to change their password at the next logon in Active Directory:

1.  In **Active Directory Administrative Center**, navigate to the OU where the user account is located.
2.  Find and select the user account you want to modify.
3.  In the right-hand action pane, click **Properties**.
4.  In the **Account** tab, check **User must change password at next logon**.
5.  Click **OK** to save the changes.

This action will prompt the user to create a new password the next time they attempt to log in, enhancing the security of the user account and the network.
