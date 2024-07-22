You need to monitor the activity of the traffic flowing through your networks. Global Secure Access logs provide many data points you can review to gain insights into your network traffic. There are several specific logs you can get data for Global Secure Access.

## Global Secure Access Audit logs (preview)

The Microsoft Entra audit log is a valuable source of information when researching or troubleshooting changes to your Microsoft Entra environment. Changes related to Global Secure Access are captured in the audit logs. Logs have categories, such as filtering policy, forwarding profiles, remote network management, and more.

### Access audit logs from Global Secure Access or the Microsoft Entra admin center

#### From Global Secure Access

1. Sign in to the Microsoft Entra admin center using one of the required roles.
1. Browse to Global Secure Access > Audit logs. The filters are prepopulated with the categories and activities related to Global Secure Access.

#### From Microsoft Entra monitoring and health

1. Sign in to the Microsoft Entra admin center using one of the required roles.
1. Browse to Identity > Monitoring & health > Audit logs.
1. Select the Date range you want to query.
1. Open the Service filter, select Global Secure Access, and select Apply.
1. Open the Category filter, select at least one of the available options, and select Apply.

## Traffic logs (preview)
The Global Secure Access traffic logs provide a summary of the network connections and transactions that are occurring in your environment. These logs look at who accessed what traffic from where, and with what result. The traffic logs provide a snapshot of all connections in your environment and breaks that down into traffic that applies to your traffic forwarding profiles. The logs details provide the traffic type destination, source IP, and more. To better understand those details, it's helpful to look at the three levels of the logs and their relationship to each other.

A user accessing a website represents one session, and within that session there could be multiple connections, and within that connection there could be multiple transactions.

- Session: A session starts with the first URL a user accesses. That session could then open many connections, for example, a news site that contains multiple ads from several different sites.
- Connection: A connection includes the source and destination IP, source and destination port, and fully qualified domain name (FQDN). The connection components comprise the 5-tuple.
- Transaction: A transaction is a unique request and response pair.

## How to view the traffic logs

1. Sign in to the Microsoft Entra admin center as at least a Reports Reader.
1. Global Secure Access > Monitor > Traffic logs.

Various filters and export options are available for the traffic logs.

## Enriched Office 365 logs (preview)
The Enriched Office 365 logs provide you with the information you need to gain insights into the performance, experience, and availability of the Microsoft 365 apps your organization uses. You can integrate the logs with a Log Analytics workspace or Security Information and Event Management (SIEM) tool for further analysis. The enriched Microsoft 365 logs provide information about Microsoft 365 workloads, so you can review network diagnostic data, performance data, and security events relevant to Microsoft 365 apps. For example, if access to Microsoft 365 is blocked for a user in your organization, you need visibility into how the user's device is connecting to your network.

#### These logs provide:

 - Improved latency
 - Additional information added to original logs
 - Accurate IP address

#### How to view the logs
Viewing the enriched Microsoft 365 logs is a two-step process. First, you need to enable the log enrichment from Global Secure Access. Second, you need to configure Microsoft Entra diagnostic settings to route the logs to an endpoint, such as a Log Analytics workspace.

#### Enable the log enrichment
To enable the Enriched Microsoft 365 logs:

1. Sign in to the Microsoft Entra admin center as a Global Administrator.
1. Browse to Global Secure Access > Global settings > Logging.
1. Select the type of Microsoft 365 logs you want to enable.
1. Select Save.

#### Send logs to an endpoint

1. Sign in to the Microsoft Entra admin center as at least a Security Administrator.
1. Browse to Identity > Monitoring & health > Diagnostic settings.
1. Select Add Diagnostic setting.
1. Give your diagnostic setting a name.
1. Select EnrichedOffice365AuditLogs.
1. Select the Destination details for where you'd like to send the logs. Choose any or all of the following destinations:
   - Send to Log Analytics workspace.
   - Archive to a storage account.
   - Stream to an event hub.
   - Send to partner solution.

## Log Retention and Storage
Traffic Logs and Remote Network Health Logs: These logs are retained within the system for 30 days. This duration allows for ample time to review and analyze recent activities and network health status.

 - Audit Logs: The retention period for Audit Logs varies depending on your Microsoft Entra ID license.
 - Office Logs: Office Logs are maintained for a shorter duration, up to only 24 hours.

