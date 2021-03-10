You send Syslog log data to the Azure Sentinel workspace using the provided data connector.

You are a Security Operations Analyst working at a company that implemented Azure Sentinel.  You need to collect log data from on-premise network appliances.  You need to use the Syslog connector as the network appliances' data is provided in an unstructured format.  

You install an on-premise Linux host used as a forwarder to send the log data.  Next, you follow the Syslog connector page's instructions to run the Linux host deployment script.  The final step is to configure the network appliances to forward their logs to your Linux host.  

Now the network appliances send logs to the new Linux host; the Linux host is then forwarding the logs to the Azure Sentinel workspace.  You create a parser using a KQL function to make it easier for the Security Operations team to query the log records containing the unstructured string data.  

By the end of this module, you'll be able to send Syslog log data to the Azure Sentinel workspace using the provided data connector.

After completing this module, you will be able to:

- Describe the Syslog connector deployment options in Azure Sentinel
- Run the connector deployment script to send data to Azure Sentinel
- Configure the Log Analytics agent integration for Azure Sentinel
- Create a parse using KQL in Azure Sentinel

## Prerequisites

Basic knowledge of operational concepts such as monitoring, logging, and alerting