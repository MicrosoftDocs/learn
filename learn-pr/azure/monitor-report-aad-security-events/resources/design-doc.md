# Title

Monitor and report on security events in Azure AD

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure AD
- Azure Monitor

## Prerequisites

- Familiarity with Azure AD
- Familiarity with Azure Monitor

## Summary

Keep tabs on security events in your Azure AD resources by using built-in reporting and monitoring capabilities. Respond to events as they happen and address security risks before they become a problem.

## Learning objectives

1. Store Azure audit activity and sign-in activity logs in Azure Monitor.
1. Create alerts for security events in Azure Monitor.
1. Create and view dashboards to support improved monitoring.

## Chunk your content into subtasks

Identify the subtasks of *Monitor and report on security events in Azure AD*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| 1. Learn about the different kinds of logs | demonstrate the reporting capabilities in Azure AD | KC | 1 | Yes |
| 2. Store audit logs in Azure Monitor | ensure that proper security reporting and monitoring are in place | KC & Exercise | 1 | No: 3 |
| 3. Create alerts | proper monitoring is in place to alert on security events | KC | 2 | No: 2|
| 4. Create reports and dashboards | proper monitoring is in place to alert on security events | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You work for an organization that has recently begun integrating their identities with Azure AD. Your security team would like to ensure that proper security reporting and monitoring are in place, as a recent incident with compromised identities led to exposed customer data. You need to demonstrate the reporting capabilities in Azure AD, and ensure that proper monitoring is in place to alert on security events.

1. **How to use sign-in, audit, and provisioning logs**

    - Overview of what data is contained in sign-in logs
        - Users flagged for risk
        - Where to access the sign-ins data
    - Overview of what data is contained in audit logs
        - Enterprise application audit logs
        - Portal shortcuts to accessing user and application audit logs
    - Overview of what data is contained in provisioning logs

    **Knowledge check**

    - In which log would you find information about troubleshooting and recommendations? 
    - In which log would you find information about the MFA method used?
    - In which log would you find information about Identity Protection?

1. **How to integrate activity logs with Azure Monitor logs**

    - Create a Log Analytics workspace
    - Send logs to Azure Monitor
    - Analyze the logs in Azure Monitor logs
        - Review the structure of the audit and sign-in logs
        - Query the logs for specific entries
    - Create alerts

    **Knowledge check**

    - What are the two types of query you can write in Azure Monitor? (Table-based and search)
    - What are the two types of alert logic conditions you can use? (Number of results and metric measurement)

1. **Set up reports and dashboards to visualize the information**

    - Install pre-built views for account provisioning and sign-in events
    - Customize and enhance a report by editing its supporting query
    - Save reports to security dashboard
    - Export a report to Excel and Power BI

1. **Exercise - set up reports and dashboards to visualize the information**

    1. Create a Log Analytics workspace
    1. Navigate in the portal to diagnostic settings
    1. Save Audit and sing-in logs to Azure Monitor
    1. Import Azure AD Account Provisioning Events and Sign-ins Events views
    1. Navigate to the workspace summary, select the Sign-in Events tile
    1. Select the Signs-over time, change to weekly and pin to a new security dashboard

1. **Summary**

    - Restate the scenario problem
    - Show how you solved the scenario problem
    - Describe the experience without the product
    - Describe the business impact

## Notes

Look at structuring the module based on the sections in the following doc. Consider creating a new tenant and going through the logging and monitoring configuration steps as hands-on activities. If we can generate some activity to populate queries and reports, great, but that may take extended time.

- https://docs.microsoft.com/azure/active-directory/reports-monitoring/
- https://docs.microsoft.com/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics
- https://docs.microsoft.com/azure/active-directory/reports-monitoring/howto-install-use-log-analytics-views
- https://docs.microsoft.com/power-bi/service-connect-to-azure-audit-logs
- https://docs.microsoft.com/azure/active-directory/identity-protection/
- https://docs.microsoft.com/azure/azure-monitor/log-query/get-started-portal

The exercise comes at the end, but includes tasks with information gained in earlier units to make it more useful.
