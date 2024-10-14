# Title

Introduction to Azure Sentinel

## Role(s)

- Administrator
- DevOps Engineer
- Solution Architect

## Level

- Beginner

## Product(s)

- Azure Sentinel

## Prerequisites

- A basic familiarity with Azure and the Azure portal

## Summary

Get familiar with Azure Sentinel. You can expect to configure Azure Sentinel, connect your first data sources, visualize them in workbooks and investigate alerts.

## Learning objectives

1. By the end of this module the learner will be able to understand the various components and functionality of Azure Sentinel
2. By the end of this module the learner will be able to provision and perform basic configuration of Azure Sentinel within their Azure Subscription.

## Chunk your content into subtasks

Identify the subtasks of Introduction to Azure Sentinel

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe the components of  Azure Sentinel | Understanding the capability of Azure Sentinel and which business objectives it could solve. | Knowledge Check | 1 | yes |
| Configure Azure Sentinel and Connect Data Sources | Getting your workspace configured and start bringing your data in to Sentinel. | Knowledge Check | 2 | yes |
| Understand Kusto Query Language (KQL) | Learn about the query language behind Azure Sentinel. This is foundational for hunting, creating workbooks and alerts. | Knowledge Check | 1 | yes |
| Visualize  data in Workbooks | Visualize your data using built in or custom Workbooks or Dashboards | Knowledge Check | 2 | yes |
|Configure Alerts | Configure alerts based on built in or custom attack detection queries. | Knowledge Check | 2 | yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

   You work as a SOC Analyst for a national/regional insurance provider. The business has already started moving some workloads to the public cloud, and you've been tasked with evaluating Security Information and Event Management (SIEM) solutions that can help in both an on premises and multi-cloud environment. You've heard about Azure Sentinel and want to see whether this could potentially be the right SIEM for your business.

1. **What is Azure Sentinel?**

    List the content that will enable the learner to describe the components of Azure Sentinel:

    - Describe at a high level the components of Azure Sentinel
        - Data Connectors
        - Workbooks
        - Alerts
        - Hunting
        - Incidents
        - Investigations
        - Automated Response

    **Knowledge check**

    What types of questions will test describe the components of Azure Sentinel?

    - Questions related to which component helps achieve what outcome. 
        - i.e. Which of the following would enable you to visualize your data within the Azure Sentinel Portal (The answer is Workbooks)

1. **Initial Configuration**

    List the content that will enable the learner to describe the components of Azure Sentinel:

    - Configure Azure Sentinel Workspace
        - Create a workspace in the portal
    - Add Data Connectors
        - Add Azure Activity and Azure AD Activity Logs to our newly created workspace

    **Knowledge check**

    What types of questions will configure Azure Sentinel and add Data sources?

    - Questions related to how we can configure Sentinel
        - i.e. API, Portal etc.

1. **Querying Data in Sentinel**

    List the content that will enable the learner to understand the basics of KQL.
    
    - Understand the data structure
        - Table structure
    - Perform a Basic Query
        - table wide queries
        - where
        - top
        - count

    **Knowledge check**

    What types of questions will test understanding basic KQL?

    - Questions related to the syntax of KQL queries.

1. **Visualize Data**

    List the content that will enable the learner to visualize their data in Azure Sentinel using workbooks:

    - Configure Workbooks
        - Navigate to workbooks
        - Select a workbook
        - Save Workbook
        - View Workbook
        - Edit Workbook

    **Knowledge check**

    What types of questions will test visualize data in Azure Sentinel?

    - Questions about what workbooks are, and how to use them.

1. **Configure Alerts**

    List the content that will enable the learner to configure security alerts:

    - Configure Alerts
        - Navigate to Analytics
        - Select an Alert rule template
        - Customize Logic / KQL
        - Create Rule
    **Knowledge check**

    What types of questions will test configure alert rules in Azure Sentinel?

    - Questions related to actions when rules are triggered. 
        - i.e. Which of the following actions are available when an alert rule is triggered. (Trigger Playbook / Create Incident)

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    As a SOC Analyst you had to identify a SIEM that would support your organization's evolving workloads that were deployed on premises and across multiple cloud providers.

    Azure Sentinel is a cloud native SIEM solution that enables us to manage the entire Security operations process, from data collection through to automated remediation. We configured Azure Sentinel, set up our data connectors, visualized our data and then configured security alert rules on that data too. We also spent some time understanding the underlying query language KQL.

    Imagine how much work it would be to configure that in a traditional SIEM. Azure Sentinel made it easy. The built in connectors and simple provisioning made it simple to get our SIEM solution initially configured,with dat flowing in from various sources.Then the built in Workbooks and Alert Rules made it straight forward  to start gaining value and security insights from that data.

## Notes