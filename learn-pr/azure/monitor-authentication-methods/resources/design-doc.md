
# Title

Monitor and report on authentication methods used in Azure AD with Azure AD workbooks

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

Use Azure AD workbooks to build a package (bundle) of activity log data queries and visualizations that help you solve a business problems.



## Learning objectives

1. Choose the right activity logs. 
2. Write queries to retrieve the activity data you need. 
3. Create a new Azure AD workbook to generate a rich report of your activity data. 


## Chunk your content into subtasks

Identify the subtasks of this module.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| 1. Choose the right activity logs | Identify the demonstrate the reporting capabilities in Azure AD | KC | 1 | Yes |
| 2. Integrate activity logs with Azure Monitor log analytics | ensure that proper security reporting and monitoring are in place | Exercise | 2 | Yes |
| 3. Write queries to get the log data you need | proper monitoring is in place to alert on security events | KC | 2 | Yes|
| 4. Create a custom workbook | proper monitoring is in place to alert on security events | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    Suppose you were recently hired as the Identity & Security Architect with an a large, multinational, insurance company. You are tasked with creating new security policies that will prohibit the use of legacy authentication methods and limits the use of mobile devices not connected to the corporate network. The leadership is expecting to be able to reduce the amount of legacy authentication by 50% in the next 6 weeks. They also expect to limit all mobile access to OneDrive when not connected to the corp network within two weeks. You are brand new to the company so you need to learn the environment quickly in order to create these policies. You expect there will be more data than you can process manually and you need a way to monitor this on an on-going basis. You build a KQL query in Log Analytics that monitors the type of client apps used, breaking down authentications by legacy and mobile authentications by user, date and application. You convert this query into a workbook and build policies to address the specific users and applications that are using legacy authentications clients or mobile clients from an unprotected network.

2. **Choose the right activity logs**

    - What is an activity log in Azure AD?
    - What kind of activity logs do exist in Azure AD?
    - How can you access activity logs?
    - What are common scenarios for using activity logs?
    
    **Knowledge check**

    - In which log would you find information about troubleshooting and recommendations? 
    - In which log would you find information about the MFA method used?
    - In which log would you find information about Identity Protection?

3. **Integrate activity logs with Azure monitor log anaytics**

    - What is a log analytics workspace?
    - How to create a Log analytics workspace
    - Send logs to Azure Monitor
 
4. **Write KQL queries**
    - What is a Kusto query?
    - What is a query statement?
    - To be continued...
    
    **Knowledge check**
    - What are the two types of query you can write in Azure Monitor? (Table-based and search)
    - To be continued...
 
5. **Create a custom Azure AD workbook to track your solution**

    - What is an Azure AD workbook?
    - How can you access Azure AD workbooks?
    - What is the Azure AD workbook gallery?
    - Should I create a new or use an existing Azure AD workbook from the gallery? 
    - Add your query 
    - Pick the right visual representation (charts, graphs, and tables)
    - Safe your workbook
    - (Test your workbook) 

6. **Summary**

    - Restate the scenario problem
    - Show how you solved the scenario problem
    - Describe the experience without the product
    - Describe the business impact