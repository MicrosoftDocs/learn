
To on-board Azure Sentinel, you first need to connect to your security sources. Azure Sentinel comes with a number of connectors for Microsoft solutions, available out of the box and providing real-time integration, including Microsoft Threat Protection solutions, and Microsoft 365 sources, including Microsoft 365, Azure AD, Azure ATP, and Microsoft Cloud App Security, and more. In addition, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions. You can also use common event format, 
Syslog or REST-API to connect your data sources with Azure Sentinel as well.

![Azure sentinel collector blade](../media/az500-sentinel-collector.png)

### Data connection methods

The following data connection methods are supported by Azure Sentinel:
* **Service to service integration**:
Some services are connected natively, such as AWS and Microsoft services, these services leverage the Azure foundation for out-of-the box integration, the following solutions can be connected in a few clicks:
* Amazon Web Services - CloudTrail
* Azure Activity
* Azure AD audit logs and sign-ins
* Azure AD Identity Protection
* Azure Advanced Threat Protection
* Azure Information Protection
* Azure Security Center
* Cloud App Security
* Domain name server
* Microsoft 365
* Microsoft Defender ATP
* Microsoft web application firewall
* Windows firewall
* Windows security events

### External solutions via API
Some data sources are connected using APIs that are provided by the connected data source. Typically, most security technologies provide a set of APIs through which event logs can be retrieved.The APIs connect to Azure Sentinel and gather specific data types and send them to Azure Log Analytics

### External solutions via agent

Azure Sentinel can be connected to all other data sources that can perform real-time log streaming using the Syslog protocol, via an agent.
The Azure Sentinel agent, which is based on the Log Analytics agent, converts CEF formatted logs into a format that can be ingested by Log Analytics. Depending on the appliance type, the agent is installed either directly on the appliance, or on a dedicated Linux server.

### Agent connection options

To connect your external appliance to Azure Sentinel, the agent must be deployed on a dedicated machine (VM or on premises) to support the communication between the appliance and Azure Sentinel. You can deploy the agent automatically or manually. Automatic deployment is only available if your dedicated machine is a new VM you are creating in Azure.

![Diagram of data flow using Azure Sentinel agent](../media/az500-sentinel-syslog.png)

Alternatively, you can deploy the agent manually on an existing Azure VM, on a VM in another cloud, or on an on-premises machine.

### Global prerequisites

* Active Azure Subscription
* Log Analytics workspace.
* To enable Azure Sentinel, you need contributor permissions to the subscription in which the Azure Sentinel workspace resides.
* To use Azure Sentinel, you need either contributor or reader permissions on the resource group that the workspace belongs to.
* Additional permissions may be needed to connect specific data sources.
* Azure Sentinel is a paid service.

