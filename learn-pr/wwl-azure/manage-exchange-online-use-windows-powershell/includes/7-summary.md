In this module, you've learned how to use PowerShell cmdlets to efficiently manage bulk operations on Exchange Online and perform tasks that aren't possible through a web-based administrative interface. This includes managing mailboxes, resources, and admin roles. The following are the key takeaways:

- Some of the information that you can review and manage by using Exchange Online PowerShell, such as email addresses, you can also review in the properties of user objects with AzureAD cmdlets. However, you can manage mail-related properties only by using Exchange Online PowerShell.
- Mailboxes are created automatically for users who are assigned a license that includes an Exchange Online service plan. One can also create specialized mailboxes such as room mailboxes, equipment mailboxes, and shared mailboxes.
- Room and equipment mailboxes are known as resource mailboxes. There are cmdlets that you can run to configure the scheduling process for resource mailboxes and review the current configuration.
- In Exchange Online, the preconfigured management roles are referred to as a role group, because a group has been assigned the permissions. There are default role groups that are sufficient for many organizations. However, you can create customized role groups that allow you to define granular permissions, down to specific cmdlets that users are allowed to run.
 
## Additional reading

For more detailed information about role groups and permissions in Exchange Online, refer to the following document:
- [Permissions in Exchange Online](https://aka.ms/permissions-in-exchange-online)