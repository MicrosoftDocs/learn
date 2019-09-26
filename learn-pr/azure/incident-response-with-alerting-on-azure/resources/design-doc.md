# Title

Improve incident response with alerting on Azure

## Role(s)

- Solution Architect

## Level

- Beginner

## Product(s)

- Azure Monitor alerts

## Prerequisites

- Basic knowledge of Azure Monitor

## Summary

Respond to incidents and activities in your infrastructure through alerting capabilities in Azure Monitor.

## Learning objectives

1. Configure alerts on events in your Azure resources based on metrics, log events, and Activity log events
2. Use smart groups to identify and group related alerts to reduce alert noise

## Chunk your content into subtasks

Identify the subtasks of *Improve incident response with alerting on Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Introduce alerting in Azure | Understand the alerting options available in Azure | Knowledge Check | 1 | Yes |
| Metric alerts in Azure | Use metric alerts to improve customer satisfaction | Knowledge Check | 1 | Yes |
| Log alerts in Azure | Use log alerts to improve customer satisfaction | Knowledge Check | 1 | Yes |
| Activity log alerts in Azure | Use activity log alerts to improve customer satisfaction | Knowledge Check | 1 | Yes |
| Smart groups | Use smart groups to improve responsiveness and customer satisfaction | Knowledge Check | 2 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    A shipping company has deployed several applications to Azure and has experienced issues that impacted customers ability to track their orders, leading to a drop in customer satisfaction. They need to set up alerting in their environment so they can engage the right teams to fix issues as they arise.

1. **Explore the different alert types supported by Azure Monitor**

    List the content that will enable the learner to *Understand alert types in Azure*:

    - Overview of alerting in Azure Monitor
        - Composition of an alert
        - Scope and usage of alerts
        - Creating and managing alerts

   **Knowledge check**

    What types of questions will test *Configure alert events in Azure resources based on metric events*?

    - Which of these use cases is a valid use of alerting?
    - What is an alert rule?
    - When managing an alert, what does the New state mean?

1. **Use metric alerts to alert on performance issues in your Azure environment**

    List the content that will enable the learner to *Use metric alerts to improve customer satisfaction*:

    - Introduction to metric alerts in Alert Monitor
        - When to use metric alerts
        - Composition of metric alerts
            - Using static threshold metric alerts
            - Using dynamic threshold metric alerts
        - Understanding dimensions
        - Scaling metric alerts
        - Configure and setup of metric alerts

1. **Exercise - Use metric alerts to alert on performance issues in your Azure environment**

    1. Create a VM that spins up a CPU to 100%
    1. Create a CPU alert (with CLI)
    1. In the Azure portal, go to the VM, include it in Azure Monitor (Insights preview)
    1. Add diagnostic logging
    1. View the CPU alert in Azure Monitor for Virtual Machines

1. **Use log alerts to alert on events in your application**

    List the content that will enable the learner to *use log alerts to improve customer satisfaction*:

    - Introduction to log alerts in Alert Monitor
        - When to use log alerts
        - Composition of a log alert
            - number of results log alert
            - metric measurements log alert
        - Stateless nature of log alerts
        - Configure and setup of log alerts

   **Knowledge check**

    What types of questions will test *Configure alerts in your Azure resources based on log events*?

    - Which of these statements will increase the size of the sample data used in a metric measurement log alert?
    - How many alerts are generated from a number of results log alert?
    - What is the log query?
    - What is the primary consideration when using log alerts?

1. **Use activity log alerts to alert on events within your Azure infrastructure**

    List the content that will enable the learner to *use activity log alerts to improve customer satisfaction*:

    - Introduction to Activity log alerts in Azure Monitor
        - When to use activity log alerts
        - Composition of an activity log alert
        - Specific operations alerts
        - Service health alerts
        - Action groups
        - Configure and setup of activity log alerts

1. **Exercise - Use activity log alerts to alert on events within your Azure infrastructure**

    1. In the Azure portal, go to Azure Monitor
    1. Add a new Alert for the created storage account (used to store diagnostic data in the first exercise)
    1. Monitor the signal - Delete Storage Account (storageAccounts)
    1. Delete the storage account
    1. View the Storage alert in Azure Monitor

1. **Use smart groups to reduce alert noise in Azure Monitor**

    List the content that will enable the learner to *Use smart groups to improve responsiveness and customer satisfaction*:

    - Overview of Smart groups in Azure Monitor
        - When to use smart groups
        - Managing smart groups
        - Smart group states
        - Configure and setup smart groups

   **Knowledge check**

    What types of questions will test *Use smart groups to identify and group related alerts to reduce alert noise*?

    - What is the smart group taxonomy?
    - Which of these isn't a valid smart group state?
    - Why would you use smart groups?

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Basic understanding of alerts in Azure portal
    - When to use metric, log, and activity log events
    - Creating alerts in Azure portal
    - Using smart groups to manage similar alerts

## Notes

Useful URLs:
- Alerts in Azure Monitor overview - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-overview
- Smart groups - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-smartgroups-overview
- Metric alerts - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric-overview
- Log alerts - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-unified-log
- Activity log alerts - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log-alerts
