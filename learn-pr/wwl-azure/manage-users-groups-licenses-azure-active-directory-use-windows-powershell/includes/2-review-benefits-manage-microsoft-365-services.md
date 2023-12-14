The Microsoft 365 admin center is a web-based console that you can use to manage users, groups, licensing, and other tenant-level configuration settings. When you manage users and groups from here, the properties you modify might be part of Microsoft Entra ID, Exchange Online, or another service. This console provides a unified interface for some common management tasks.

Links to service-specific, web-based consoles enable you to perform more detailed configuration of Microsoft 365 services. You can use these links to manage services such as Microsoft Entra ID, Exchange Online, Microsoft Teams, and SharePoint Online. With the service-specific consoles, you can perform tasks such as:

- Creating users and group.
- Modifying email addresses.
- Setting organizational defaults for Teams.
- Configuring external sharing settings for SharePoint Online.

> [!NOTE]
> You can access the Microsoft 365 admin console at `https://admin.microsoft.com`.

The service-specific, web-based consoles are intuitive and easy to use, but they don't provide access to all possible configuration options. There are many useful configuration options that you can review and configure only by using PowerShell cmdlets. For example, in Exchange Online you can use PowerShell to review the permissions assigned to and configured on a calendar in a mailbox. In the web-based console, you can only review mailbox-level permissions.

Using PowerShell to manage Microsoft 365 services also provides many of the same benefits as using PowerShell to manage local resources. You can:

- Use a query for objects matching certain criteria, and then generate reports.
- Use the pipeline to perform complex operations.
- Automate bulk processes.
- Manage multiple services simultaneously.
