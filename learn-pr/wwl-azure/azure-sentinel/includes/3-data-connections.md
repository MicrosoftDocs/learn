
To onboard Microsoft Sentinel, you first need to connect to your security sources. Microsoft Sentinel comes with a number of connectors for Microsoft solutions, available out of the box and providing real-time integration, including Microsoft Threat Protection solutions, and Microsoft 365 sources, including Microsoft 365, Azure AD, Azure ATP, and Microsoft Cloud App Security, and more. In addition, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions. You can also use common event format, Syslog or REST-API to connect your data sources with Microsoft Sentinel as well.

:::image type="content" source="../media/sentinel-collect-data-page-a84499fc.png" alt-text="Screenshot showing the Microsoft Sentinel Data connectors page.":::


### Data connection methods

The following data connection methods are supported by Microsoft Sentinel:

 -  **Service to service integration**: Some services are connected natively, such as AWS and Microsoft services, these services leverage the Azure foundation for out-of-the-box integration, the following solutions can be connected in a few clicks:
 -  Amazon Web Services - CloudTrail
 -  Azure Activity
 -  Azure AD audit logs and sign-ins
 -  Azure AD Identity Protection
 -  Azure Advanced Threat Protection
 -  Azure Information Protection
 -  Microsoft Defender for Cloud
 -  Cloud App Security
 -  Domain name server
 -  Microsoft 365
 -  Microsoft Defender ATP
 -  Microsoft web application firewall
 -  Windows firewall
 -  Windows security events

### External solutions via API

Some data sources are connected using APIs that are provided by the connected data source. Typically, most security technologies provide a set of APIs through which event logs can be retrieved. The APIs connect to Microsoft Sentinel and gather specific data types and send them to Azure Log Analytics

### External solutions via an agent

Microsoft Sentinel can be connected to all other data sources that can perform real-time log streaming using the Syslog protocol, via an agent. The Microsoft Sentinel agent, which is based on the Log Analytics agent, converts CEF formatted logs into a format that can be ingested by Log Analytics. Depending on the appliance type, the agent is installed either directly on the appliance, or on a dedicated Linux server.

### Agent connection options

To connect your external appliance to Microsoft Sentinel, the agent must be deployed on a dedicated machine (VM or on-premises) to support the communication between the appliance and Microsoft Sentinel. You can deploy the agent automatically or manually. Automatic deployment is only available if your dedicated machine is a new VM you are creating in Azure.

:::image type="content" source="../media/az500-sentinel-syslog-4e697ba2.png" alt-text="Diagram of data flow using Azure Sentinel agent":::


Alternatively, you can deploy the agent manually on an existing Azure VM, on a VM in another cloud, or on an on-premises machine.

### Global prerequisites

 -  Active Azure Subscription
 -  Log Analytics workspace.
 -  To enable Microsoft Sentinel, you need contributor permissions to the subscription in which the Microsoft Sentinel workspace resides.
 -  To use Microsoft Sentinel, you need either contributor or reader permissions on the resource group that the workspace belongs to.
 -  Additional permissions may be needed to connect specific data sources.
 -  Microsoft Sentinel is a paid service.
