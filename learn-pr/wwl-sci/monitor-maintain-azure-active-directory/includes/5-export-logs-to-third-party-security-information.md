Since the introduction of Azure Monitor, significant strides have been made to consolidate Azure services onto a single logging pipeline. Most of the top Azure services, including Azure Resource Manager and Azure Security Center, have onboarded to Azure Monitor and are producing relevant security logs.

The integration process has also been simplified with key capabilities like security information and event management (SIEM) tools, such as routing data to a single event hub and enabling multiple diagnostic settings per resource. Work in flight will ease setup and management of log routing across large Azure environments.

Azure has also partnered with the top SIEM partners to build connectors that get the data from Azure Monitor into those tools. These connectors consume data routed to Azure Event Hubs by Azure Monitor—a simple, scalable, and manageable approach for delivering log data to an external application, and Microsoft’s recommended approach for integrating Azure with SIEM tools going forward.

We’ve continued to support customers who are using the Azure Log Integration tool (AzLog) to integrate with these same SIEMs. AzLog was initially released to help customers navigate the complex process of consolidating, translating, and forwarding logs from a variety of Azure services to a SIEM tool. At the time, Azure Monitor didn’t exist, and there was very little standardization in terms of how Azure services exposed log data to customers. Some dumped data into a storage account, others exposed an API, etc.

## Integration recommendations

The table below indicates what you should do based on the SIEM tool(s) you are using and your current integration status. Only SIEM tools that were officially supported by AzLog are included below.

| **SIEM Tool**| **Currently using log integrator**| **Currently investigating SIEM integration options**|
| :--- | :--- | :--- |
| **Splunk**| Begin migrating to the Azure Monitor Add-On for Splunk.| Use the Azure Monitor Add-On for Splunk.|
| **IBM QRadar**| Begin migrating to the Microsoft Azure DSM and Microsoft Azure Event Hub Protocol, available from the IBM support website.| Use the Microsoft Azure DSM and Microsoft Azure Event Hub Protocol, available from the IBM support website. You can learn more about the integration with Azure.|
| **ArcSight**| The Azure log integration tool offered collecting Azure logs into JSON files for the purpose of integrating with ArcSight using existing JSON connectors from ArcSight, with JSON to CEF mapping available only for Azure Activity Logs and not for the other types of Azure logs. |  |

## Integration roadmap

Today, Azure Monitor’s SIEM integration capabilities can’t do everything the Azure Log Integration tool could do. Below is our roadmap for addressing known gaps between what you could accomplish with Azure Log Integration and what you can accomplish with Azure Monitor.

**Azure Active Directory logs** – Azure Active Directory logs are the only log type directly integrated with AzLog that aren’t yet available in Azure Monitor.

**Integrate Azure VM logs** – AzLog provided the option to integrate your Azure VM guest operating system logs (e.g., Windows Security Events) with select SIEMs. Azure Monitor has agents available for Linux and Windows that are capable of routing OS logs to an event hub, but end-to-end integration with SIEMs is nontrivial.

**End-to-end setup** – AzLog has a script that automates the end-to-end setup of log sources. While Azure Monitor offers the ability to script out creation of diagnostic settings, we’re partnering with the Azure Policy team to deliver seamless enablement via Resource Manager policies that ensure log data is being routed from all sources.

**Integration with other SIEM tools** – AzLog provided a generic capability to push standardized Azure logs in JSON format to disk. While other SIEM tools weren’t officially supported by AzLog, this offered a way to easily get log data into tools such as LogRhythm. Our recommendation for customers using AzLog for these tools is to work with the producer of that tool to provide an Azure Monitor Event Hubs integration.

The security of your Azure environment is always top priority on the Azure team, both in terms of how we engineer the Azure platform and in terms of the capabilities we provide for you for securing your own assets on that platform. Moving SIEM integration to Azure Monitor is a step towards enabling you to manageably secure your applications on Azure at scale.

