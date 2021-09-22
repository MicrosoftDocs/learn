Answer the question to test your knowledge of Azure Monitor.
## Review Questions


## Multiple Choice
Data collected by Azure Monitor collects fits into which two fundamental types. What are those types of data? 
() Events and Alerts{{Events and alerts are what Azure Monitor is looking for and how you are notified.}}
(x) Logs and Metrics{{Logs, Metrics. All data collected by Azure Monitor fits into one of two fundamental types, metrics and logs. Metrics are numerical values that describe some aspect of a system at a point in time. They are lightweight and capable of supporting near real-time scenarios. Logs contain different kinds of data organized into records with different sets of properties for each type. Telemetry such as events and traces are stored as logs in addition to performance data so that it can all be combined for analysis.}}
() Records and Triggers{{Records are items within a log, and triggers are specific events that cause alerts.}}


## Multiple Choice 
You can query Log Analytics workspace with which of the following? Select one.  
() Contextual Query Language{{Contextual queries will not work with log analytics.}}
() Embedded SQL{{This is a type of SQL embedded into a solution.}}
(x) Kusto Query Language{{Kusto Query Language. All data is retrieved from a Log Analytics workspace using a log query written using Kusto Query Language (KQL). You can write your own queries or use solutions and insights that include log queries for an application or service.}}


## Multiple Choice 
You want to be notified when any virtual machine in the production resource group is deleted. What should you configure? Select one.  
(x) Activity log alert{{Activity log alert. An activity log alert to receive notifications when specific changes occur to resources in your Azure subscription.}}
() Application alert{{An application alert will notify you if there is a problem with an application not the virtual machine.}}
() Log alert{{A log alert is not going to help in this situation.}}



## Multiple Choice 
The IT managers would like to use a visualization tool for the Azure Monitor results. You suggest all the following, except? 
() Dashboard{{The dashboard will help you visualize your Azure Monitor results.}}
(x) Logic Apps{{Logic Apps. Logic apps would be used for integration activities. Workbooks are interactive documents that provide deep insights into your data, investigation, and collaboration inside the team. Specific examples where workbooks are useful are troubleshooting guides and incident postmortem. Dashboards and Power BI allow you to quickly identify important issues.}}
() Power BI{{Power BI is a great data visualization tool.}} 

 