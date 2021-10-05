Tailwind Traders has several workloads being migrated to Azure. It is important you design logging and monitoring for the workloads based on the following requirements: 

- **Host all logs in a single location.** The company has one team responsible for designing the logging and monitoring strategy for all workloads in Azure. This team needs a solution that is easy to manage, enables them to search across resources, and cross-correlate logs.

- **sign-in activity.** The security team requires a report of user sign-in activity. 

- **Measure user experience and analyze users' behavior****.** The reputation of the company depends on the performance, reliability, and security of its systems. It's critical to monitor your systems closely to identify any performance problems or attacks before they can affect users. 

Choose the best response for each of the questions below. Then select Check your answers.

## quiz title

## Multiple Choice
Which Log Analytics Workspace deployment model best supports the company’s needs to host all logs in a single location?
(x)Centralized {{that’s correct. The centralize model meets their needs}}
( )Decentralized {{that’s incorrect. The decentralized model doesn’t meet the needs for searching across all resources}}
( )Hybrid {{that’s incorrect. The hybrid model isn’t needed based on the requirements}}

## Multiple Choice
What solution should be used to log user sign-in activity? 
(x)Azure Active Directory Audit Logs {{that’s correct. Azure Active Directory Audit logs contains the history of sign-in activity and audit trail of changes made within a particular tenant}}
( )VM Insights {{that’s incorrect. Azure insights can be used for applications, VMs, and containers but not sign-in activity.}}
( )Azure Alerts {{that’s incorrect. Azure Alerts can notify you of an activity log event but it does not log user sign-in activity}}

## Multiple Choice
What monitoring tool do you recommended to measure user experience and analyze users' behavior for all external facing applications 
(x)Azure Application Insights {{That’s correct. Because Application Insights can measure user experience and analyze users' behavior}}
( )Azure Monitor container insights {{that’s incorrect. Container insights can show the health and performance of your Kubernetes workloads but don’t specifically measure user experience or behavior}}
( )Azure Activity log {{that’s incorrect. Azure Activity log doesn’t measure application user experience or behavior}}