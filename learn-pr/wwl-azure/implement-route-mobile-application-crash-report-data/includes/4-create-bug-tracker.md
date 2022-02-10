You can integrate third-party bug tracker tools with App Center to stay informed and better manage your crashes.

Read the [bug tracker documentation](/appcenter/dashboard/bugtracker/index) to learn how to get started.

App Center has bug tracker integration for the crashes service. Users can be quickly informed about critical App Center events within the tools you regularly use in your day-to-day flow for a seamless experience.

App Center supports bug trackers like Jira, Azure DevOps, and GitHub.

Users need to have manager or developer permissions to create and configure the bug tracker.

For Azure DevOps:

1.  Log in with your Azure DevOps credentials and click Accept when prompted on app authorization.
2.  Select which Azure DevOps Projects to integrate the bug tracker with and click Next.
3.  Under Add bug tracker, fill in the fields for Number of crashes, Area and Default Payload, and click Add:
    
     -  The number of crashes is a threshold you can set for the minimum number of crashes to happen in a crash group before a ticket is created in Azure DevOps.
     -  Default payload is an optional field to fill in for use in work items. For example,\{"System.IterationPath": "Area\\Iteration 1", "System.AssignedTo": "Fabrikam"\}.

For more information, see [work item types API](/rest/api/vsts/wit/work%20item%20types).

:::image type="content" source="../media/add-bug-tracker-azure-devops-93bc5567.gif" alt-text="How to add a bug tracker for Azure DevOps.":::
