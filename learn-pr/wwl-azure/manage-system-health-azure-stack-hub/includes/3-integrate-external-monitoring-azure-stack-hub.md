For external monitoring of the Azure Stack Hub infrastructure, you need to monitor the Azure Stack Hub software, the physical computers, and the physical network switches. Each of these areas offers a method to retrieve health and alert information:

 -  Azure Stack Hub software offers a REST-based API to retrieve health and alerts. The use of software-defined technologies such as Storage Spaces Direct, storage health, and alerts are part of software monitoring.
 -  Physical computers can make health and alert information available via the baseboard management controllers (BMCs).
 -  Physical network devices can make health and alert information available via the SNMP protocol.

Each Azure Stack Hub solution ships with a hardware lifecycle host. This host runs the original equipment manufacturer (OEM) hardware vendor's monitoring software for the physical servers and network devices. Check with your OEM provider if their monitoring solutions can integrate with existing monitoring solutions in your datacenter.

The external monitoring solution you use must be agentless. You can't install third-party agents inside Azure Stack Hub components.

The following diagram shows traffic flow between an Azure Stack Hub integrated system, the hardware lifecycle host, an external monitoring solution, and an external ticketing/data collection system.

:::image type="content" source="../media/external-monitoring-1-6e57554f.png" alt-text="Diagram showing the traffic flow between an Azure Stack Hub integrated system.":::


External monitoring integration directly with physical servers isn't allowed and actively blocked by Access Control Lists (ACLs). External monitoring integration directly with physical network devices is supported. Check with your OEM provider on how to enable this feature.

## Integrate with Operations Manager

You can use Operations Manager for external monitoring of Azure Stack Hub. The System Center Management Pack for Microsoft Azure Stack Hub enables you to monitor multiple Azure Stack Hub deployments with a single Operations Manager instance. The management pack uses the health resource provider and update resource provider REST APIs to communicate with Azure Stack Hub. If you plan to bypass the OEM monitoring software that's running on the hardware lifecycle host, you can install vendor management packs to monitor physical servers. You can also use Operations Manager network device discovery to monitor network switches.

The management pack for Azure Stack Hub provides the following capabilities:

 -  You can manage multiple Azure Stack Hub deployments.
 -  There's support for Microsoft Entra ID and Active Directory Federation Services (AD FS).
 -  You can retrieve and close alerts.
 -  There's a health and a capacity dashboard.
 -  Includes Auto Maintenance Mode detection for when patch and update (P&amp;U) are in progress.
 -  Includes Force Update tasks for deployment and region.
 -  You can add custom information to a region.
 -  Supports notification and reporting.

For a ticketing solution, you can integrate Operations Manager with System Center Service Manager. The integrated product connector enables bidirectional communication that allows you to close an alert in Azure Stack Hub and Operations Manager after you resolve a service request in Service Manager.

The following diagram shows integration of Azure Stack Hub with an existing System Center deployment. You can automate Service Manager further with System Center Orchestrator or Service Management Automation (SMA) to run operations in Azure Stack Hub.

:::image type="content" source="../media/external-monitoring-2-d45f0f32.png" alt-text="Diagram showing normalized relational tables.":::
