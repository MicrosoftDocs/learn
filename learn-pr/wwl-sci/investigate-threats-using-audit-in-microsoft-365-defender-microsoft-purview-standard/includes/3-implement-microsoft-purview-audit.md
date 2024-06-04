
Microsoft Purview Audit (Standard) is enabled by default for most Microsoft 365 and Office 365 organizations. As a result, there's only a few things an organization must do before it can search the audit log.

:::image type="content" source="../media/basic-audit-workflow-595d32ab.png" alt-text="Diagram showing the steps to set up Microsoft Purview Audit (Standard), which include setting up licensing and permissions.":::

The setup steps that must be completed before an organization can search the audit log using Audit (Standard) include:

- Ensuring the proper organizational subscriptions and user licensing required to generate and preserve audit records.
- Assigning permissions to team members of your security operations, IT, compliance, and legal teams.

These steps are examined in greater detail in the following sections.

### Step 1: Verify organization subscription and user licensing

Licensing for Audit (Standard) requires the appropriate organization subscription that provides:

 -  Access to the audit log search tool.
 -  Per-user licensing that's required to log and retain audit records.

When an audited activity is performed by a user or admin, an audit record is generated and stored in the audit log for the organization. In Audit (Standard), audit records are retained and searchable in the audit log for 180 days.

For a list of subscription and licensing requirements for Audit (Standard), see [Auditing solutions in Microsoft 365](/microsoft-365/compliance/auditing-solutions-overview?azure-portal=true).

### Step 2: Assign permissions to search the audit log

To search the audit log, administrators and members of investigation teams must be assigned the **View-Only Audit Logs** or **Audit Logs** role in Exchange Online.

 -  By default, these roles are assigned to the **Compliance Management** and **Organization Management** role groups on the **Permissions** page in the Exchange admin center.
 -  Global administrators in Office 365 and Microsoft 365 are automatically added as members of the **Organization Management** role group in Exchange Online.

To give a user the ability to search the audit log with the minimum level of privileges, organizations can:

1. Create a custom role group in **Exchange Online**.
1. Add the **View-Only Audit Logs** or **Audit Logs** role to the role group.
1. Add the user as a member of the new role group.

For more information, see [Manage role groups in Exchange Online](/Exchange/permissions-exo/role-groups?azure-portal=true).

The following screenshot shows the two audit-related roles assigned to the **Organization Management** role group in the Exchange admin center.

:::image type="content" source="../media/organization-management-role-7ba83501.png" alt-text="Screenshot of the Exchange admin center showing the organization management role and the permissions assigned to it."  lightbox="../media/organization-management-role-7ba83501.png":::


### Step 3: Search the audit log

At this point, an organization is ready to search the audit log within the Microsoft Purview compliance portal.

> [!IMPORTANT]
> If you've never used the Audit search, you'll probably have to Start recording user and admin activity. This is covered in the next unit.

1. In the **Microsoft Purview compliance** portal, select **Audit** in the **Solutions** section of the navigation pane.
1. On the **Audit** page, configure the search using the following conditions on the **New Search** tab.
    
    :::image type="content" source="../media/audit-log-search-tool-callouts-db4d2a76.png" alt-text="Screenshot of the Audit page on the Microsoft Purview compliance portal showing the audit log search settings." lightbox="../media/audit-log-search-tool-callouts-db4d2a76.png":::
    
    
     -  **A. Date and time range**. Select a date and time range to display the events that occurred within that period. The date and time are presented in local time. The last seven days are selected by default.
     
     > [!NOTE]
     > If you started recording activity less than seven days prior, the date recording started is the default Start date.

     -  **B. Activities**. Select the activities to search for. Use the search box to search for activities to add to the list. For a partial list of audited activities, see [Audited activities](/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?azure-portal=true). Leave this box blank to return entries for all audited activities.
     -  **C. Users**. Select in this box and start typing the name of users to display search results for. The audit log entries for the selected activities performed by the users you select in this box are displayed in the list of results. Leave this box blank to return entries for all users (and service accounts) in your organization.
     -  **D. File**, **folder**, **or site**. Type some or all of a file or folder name to search for activity related to the file of folder that contains the specified keyword. You can also specify a URL of a file or folder. If you use a URL of a file or folder, be sure the type the full URL path or if you type a portion of the URL, don't include any special characters or spaces. Leave this box blank to return entries for all files and folders in your organization.
     - **E. Record type**. Use the search box to select a Record type from the Office 365 Management API Schemas to search for. See [AuditLogRecordType](/office/office-365-management-api/office-365-management-activity-api-schema#auditlogrecordtype)
     - **F. Workload**. Workloads provide more filtering combined with Activities. Workloads are a top level categorization based on products. Examples include AzureActiveDirectory, Exchange, OneDrive. They're where the activity occurred. Use the search box to enter a Workload to search for.
     - **G. Keyword Search**. Enter a Keyword to search for.
     - **H. Search name**. Optional, give the Search a name.
1. Select **Search** to run the search.

<!-- A new page is displayed that shows the audit log search is running. When the search is completed, audit records are displayed on the page. Select a record to display a flyout page with detailed properties.

> [!NOTE]
> This step is examined in greater detail in the following unit. -->