The audit functionality in the Microsoft 365 compliance center allows organizations to view user and administrator activity through a unified audit log.  For example, did an administrator reset a password? Did a user change a setting for a team in Microsoft Teams? A unified audit log supports the search of many users and/or admin activities across Microsoft 365 services, Dynamics 365, Microsoft Power Apps, Microsoft Power Automate, Power BI, Azure Active Directory, and more. For a detailed listing, visit [Search the audit log in the compliance center](https://docs.microsoft.com/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?view=o365-worldwide).

When an audited activity is performed by a user or admin, an audit record is generated and stored in the audit log for the organization. The length of time that an audit record is kept (and searchable in the audit log) depends on the Office 365 or Microsoft 365 Enterprise subscription, and specifically the type of the license that's assigned to specific users.  For core audit capability, the audit record is kept and searchable for 90 days.

Searching the audit log requires the search capability to be turned on, and for the user doing the search to be assigned the appropriate role.  The search criteria can be configured based on:

- Activities
- Start date and end date
- Users
- File, folder, or site

The results of the audit log search, which can be filtered and exported to a CSV file, contain the following information about each event returned by the search:

- **Date**: The date and time (in UTC format) when the event occurred.
- **IP address**: The IP address of the device that was used when the activity was logged. The IP address is displayed in either an IPv4 or IPv6 address.

- **User**: The user (or service account) who completed the action that triggered the event.
- **Activity**: The activity completed by the user.  This is based on activities configured.
- **Item**: The object that was created or modified because of the corresponding activity. For example, the file that was viewed or modified, or the user account that was updated. Not all activities have a value in this column.
- **Detail**: Additional information about an activity. Again, not all activities have a value.

:::image type="content" source="../media/2-audit-search-results-inline.png" lightbox="../media/2-audit-search-results-expanded.png" alt-text="A list of results from an audit search.":::

It can take up to 30 minutes or up to 24 hours after an event occurs for the corresponding audit log record to be returned in the results of an audit log search.