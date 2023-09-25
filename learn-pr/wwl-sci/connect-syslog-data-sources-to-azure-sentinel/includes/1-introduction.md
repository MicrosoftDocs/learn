You send Syslog log data to the Microsoft Sentinel workspace using an Azure Monitor Agent Data Collection Rule (DCR).

You're a Security Operations Analyst working at a company that implemented Microsoft Sentinel. You need to collect log data from on-premises network appliances. The network appliances' data is provided in an unstructured format.  

You install an on-premises Linux host used as a forwarder to send the log data.  Next, you follow the instructions to install the Azure Connected Machine agent that enables you to manage your (Windows and) Linux machines hosted outside of Azure on your corporate network with Azure Arc. Once you have verified Azure Arc connectivity, you can install the Azure Monitor Linux Agent extension, and during that process you create an Azure Monitor Syslog Data Collection Rule. The final step is to configure the network appliances to forward their logs to your Linux host.  

The network appliances are now sending logs to the new Linux host, and the Linux host is then forwarding the logs to the Microsoft Sentinel workspace via the Azure Monitor Agent Data Collection Rule. In Microsoft Sentinel, you create a parser using a KQL function to make it easier for the Security Operations team to query the log records containing the unstructured string data.  

After completing this module, you'll be able to:

- Describe the Azure Monitor Agent Data Collection Rule (DCR) for Syslog
- Install and Configure the Azure Monitor Linux Agent extension with the Syslog DCR
- Run the Azure Arc Linux deployment and connection scripts
- Verify Syslog log data is available in Microsoft Sentinel
- Create a parser using KQL in Microsoft Sentinel

## Prerequisites

- Basic knowledge of operational concepts such as monitoring, logging, and alerting
- Familiarity with Linux operations and monitoring
