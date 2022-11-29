The cloud has dramatically changed the role of the operations team. They
are no longer responsible for managing the hardware and infrastructure
that hosts the application. Operations are still a critical part of
running a successful cloud application. Some of the important functions
of the operations team include:

-   Deployment
-   Monitoring
-   Escalation
-   Incident response
-   Security auditing

Robust logging and tracing are particularly important in cloud
applications. Involve the operations team in design and planning to
ensure the application gives them the data and insight they need to be
successful.

## Recommendations

* **Make all things observable.** Once a solution is deployed and
    running, logs and traces are your primary insight into the
    system. *Tracing* records a path through the system and is useful to
    pinpoint bottlenecks, performance issues, and failure
    points. *Logging* captures individual events such as application
    state changes, errors, and exceptions. Log in production, or else
    you lose insight at the very times when you need it the most.

* **Instrument for monitoring.** Monitoring gives insight into how
    well (or poorly) an application performs in terms of availability,
    performance, and system health. For example, monitoring indefinite
    if SLAs are being met. Monitoring happens during the normal
    operation of the system. It should be as close to real-time as
    possible so that the operations staff can react to issues quickly.
    Ideally, monitoring can help avert problems before a critical
    failure. For more information, see [Monitoring and diagnostics](/azure/architecture/best-practices/monitoring).

* **Instrument for root cause analysis.** Root cause analysis is the
    process of finding underlying causes of failures. It occurs after a
    failure has already happened.

* **Use distributed tracing.** Use a distributed tracing system
    designed for concurrency, asynchrony, and cloud scale. Traces should
    include a correlation ID that flows across service boundaries. A
    single operation may involve calls to multiple application services.
    If an operation fails, the correlation ID helps pinpoint the
    failure's cause.

* **Standardize logs and metrics.** The operations team will need to
    aggregate logs from across various services in your solution. If
    every service uses its logging format, it becomes difficult or
    impossible to get useful information from them. Define a common
    schema that includes fields such as correlation ID, event name, IP
    address of the sender, and so forth. Individual services can derive
    custom schemas that inherit the base schema and contain additional
    fields.

* **Automate management tasks**. This includes provisioning,
    deployment, and monitoring. Automating a task makes it repeatable
    and less prone to human errors.

* **Treat configuration as code.** Check configuration files into a
    version control system so that you can track and version your
    changes and roll back if needed.


## Review the cyber kill chain 

In information security, a *kill chain* describes the structure of an attack against an objective. The series of steps describe a cyberattack's progression from reconnaissance to data exfiltration. 

Understanding the intention of an attack can help you investigate and report the event more easily. Microsoft Defender for Cloud alerts includes the 'intent' field to help with these efforts. 

![Diagram that shows how Defender for Cloud defends across attack chains.](../media/defend-across-attack-chains.png)

## Types of logs in Azure

Cloud applications are complex, with many moving parts. Logging data can provide insights about your applications and help you: 

- Troubleshoot past problems or prevent potential ones 
- Improve application performance or maintainability 
- Automate actions that would otherwise require manual intervention 
 
![Diagram that shows types of logs in Azure.](../media/security-information-event-management.png)

Azure logs are categorized into the following types:

-   **Control/management logs** provide information about Azure Resource
    Manager CREATE, UPDATE, and DELETE operations. For more information,
    see [Azure activity logs](/azure/azure-monitor/essentials/platform-logs-overview).

-   **Data plane logs** provide information about events raised as part of Azure resource usage. Examples of this type of log are the Windows event system, security and application logs in a virtual machine (VM), and the [diagnostics logs](/azure/azure-monitor/essentials/platform-logs-overview) configured through Azure Monitor.

-   **Processed events** provide information about analyzed events/alerts. Examples of this type are [Microsoft Defender for Cloud alerts](/azure/security-center/security-center-managing-and-responding-alerts), where [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) has processed and analyzed subscriptions and provides concise security alerts.

The following table lists the most important types of logs available in Azure:

| Log category | Log type | Usage | Integration |
|:-----:|:------:|:-----------------------------:|:-------------------------------------------------------:|
| [Activity logs](/azure/azure-monitor/essentials/platform-logs-overview) | Control-plane events on Azure Resource Manager resources | Provides insight into the operations that were performed on resources in your subscription. | REST API, [Azure Monitor](/azure/azure-monitor/essentials/platform-logs-overview) |
| [Azure Resource logs](/azure/azure-monitor/essentials/platform-logs-overview) | Frequent data about the operation of Azure Resource Manager resources in the subscription | Provides insight into operations that your resource itself performed. | [Azure Monitor](/azure/azure-monitor/essentials/platform-logs-overview) |
| [Azure Active Directory reporting](/azure/active-directory/reports-monitoring/overview-reports) | Logs and reports | Reports user sign-in activities and system activity information about users and group management. | [Graph API](/azure/active-directory/develop/microsoft-graph-intro) |
| [Virtual machines and cloud services](/azure/azure-monitor/vm/monitor-virtual-machine) | Windows Event Log service and Linux Syslog | Captures system data and logging data on the virtual machines and transfers that data into a storage account of your choice. | Windows (using Microsoft Azure Diagnostics [WAD](/azure/azure-monitor/agents/diagnostics-extension-overview) storage) and Linux in Azure Monitor |
| [Azure Storage Analytics](/rest/api/storageservices/fileservices/storage-analytics) | Storage logging, provides metrics data for a storage account | Provides insight into trace requests, analyzes usage trends, and diagnoses issues with your storage account. | REST API or the [client library](/dotnet/api/overview/azure/storage) |
| [Network security group (NSG) flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview) | JSON format, shows outbound and inbound flows on a per-rule basis | Displays information about ingress and egress IP traffic through a Network Security Group. | [Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) |
| [Application insight](/azure/azure-monitor/app/app-insights-overview) | Logs, exceptions, and custom diagnostics | Provides an application performance monitoring (APM) service for web developers on multiple platforms. | REST API, [Power BI](https://powerbi.microsoft.com/documentation/powerbi-azure-and-power-bi/) |
| [Process data / security alerts](/azure/security-center/security-center-introduction) | Microsoft Defender for Cloud alerts, Azure Monitor logs alerts | Provides security information and alerts. | REST APIs, JSON |

## Auditing

Some important capabilities for auditing, based on the [Azure Well Architected Framework](/azure/architecture/framework/devops/auditing), include the following:

* Based on auditing information, **an analyst should be able to trace the sequence of business operations that users perform** so that you can reconstruct users' actions. Tracing the sequence of operations may be necessary as a matter of record, or as part of a forensic investigation.
* **Audit information is highly sensitive and should be well secured**. This information includes data that identifies the users of the system and the tasks that they're doing. Audit reports contain sensitive information available only to trusted analysts. 
* Auditing functions in your security operations strategy **should allow an analyst to generate a range of reports**. For example, reports may list the following activities:
    - All users' activities occurring during a specified time frame.
    - The chronology of a single user's activity.
    - The sequence of operations performed against one or more resources.
- **An analyst must access all the raw data in its original form.**

### Requirements for data collection

The primary sources of auditing information can include:

- The security system that manages user authentication.
- Trace logs that record user activity.
- Security logs that track all network requests.

Regulatory requirements may dictate the format of the audit data and the way it's stored. For example, it may not be possible to clean the data in any way. It must be recorded in its original format. Access to the data repository must be protected to prevent tampering.

## Audit logs in Azure AD

Azure Active Directory (Azure AD) activity logs include audit logs, which is a comprehensive report on every logged event in Azure AD. Changes to applications, groups, users, and licenses are all captured in the Azure AD audit logs.

Audit logs in Azure AD provide access to system activity records, often needed for compliance. This log is categorized by user, group, and application management. The various views and a sample of the information they provide is summarized in the following table.

| View | Information provided |
|---|---|
| User-centric view | What types of updates have been applied to users?<br>How many users were changed?<br>How many passwords were changed?<br>What has an administrator done in a directory? |
| Group-centric view | What are the groups that have been added?<br>Are there groups with membership changes?<br>Have the owners of group been changed?<br>What licenses have been assigned to a group or a user? |
| Application-centric view | What applications have been added or updated?<br>What applications have been removed?<br>Has a service principal for an application changed?<br>Have the names of applications been changed?<br>Who gave consent to an application? |

The audit activity report is available in all editions of Azure AD. To access the audit logs, you need to have one of the following roles: 

- Report Reader
- Security Reader
- Security Administrator
- Global Reader
- Global Administrator

Sign in to the Azure portal and go to **Azure AD** and select **Audit log** from the **Monitoring** section.  

## Microsoft 365 activity logs

You can view Microsoft 365 activity logs from the [Microsoft 365 admin center](/office365/admin/admin-overview/about-the-admin-center). Even though Microsoft 365 activity and Azure AD activity logs share many directory resources, only the Microsoft 365 admin center provides a full view of the Microsoft 365 activity logs. 


## Logging and auditing issues with common cloud services 

Azure provides a wide array of configurable security auditing and logging options to help you identify gaps in your security policies and mechanisms. For more information on logging and auditing issues for common Azure services, see [Security Frame: Auditing and Logging | Mitigations](/azure/security/develop/threat-modeling-tool-auditing-and-logging). .
