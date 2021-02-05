

Customers such as Contoso, who are running Operations Manager 2016 or newer and that want to leverage Azure Monitor capabilities, can integrate their existing deployment with Log Analytics. This provides the benefits described earlier in this module, while also using Operations Manager to:

- Monitor the health of on-premises services.
- Integrate with on-premises ITSM Connector solutions, including incident and problem management.
- Manage agents deployed to on-premises systems.

## Overview

Integrating Azure Monitor with Operations Manager builds synergy between these two services. The resulting solution has the Azure Monitor speed and efficiency in collecting, storing, and analyzing data within the scope configurable by Operations Manager. Azure Monitor compliments Operations Manager capabilities with its query engine and reporting capabilities that facilitate analyzing performance, event, and alert data.

For example, if you implement the Azure Monitor for VMs' Map feature in combination with Operations Manager, you can use the latter to create distributed application diagrams based on the dynamic dependency maps in Azure Monitor. In addition, you can deploy the Service Map management pack to all Windows computers reporting to the management group, which will have a subset of the Service Map features within the Operations Manager console.

Agents reporting to an Operations Manager management group collect data from servers based on Log Analytics data source settings and solutions enabled in the corresponding Log Analytics workspace.

> [!TIP]
> You can configure a Windows agent to report to one or more workspaces, even while it's reporting to an Operations Manager management group.

Solution-specific settings determine whether data is sent to an Operations Manager management server or to the Log Analytics workspace. In case of the former, the management server forwards data to the Log Analytics workspace.

> [!NOTE]
> The Windows agent can report up to four workspaces. However, a management group can be connected to only one Log Analytics workspace.

If a management server loses connectivity to Azure Monitor, it temporarily caches collected data locally until access to the Log Analytics workspace is re-established. If one of the management servers is offline as a result of planned maintenance or an unplanned outage, another management server in the same management group takes over communication with Azure Monitor.

> [!NOTE]
> If on-premises security policies don't allow computers to connect directly to the internet, you can configure management servers to connect to the Log Analytics gateway to retrieve Azure Monitor configuration settings, and then forward collected data.

## Implement Azure Monitor integration with Operations Manager

In general, to implement integration between Operations Manager and a Log Analytics workspace, you must register the Microsoft Operations Management Suite (OMS) connection by using the **Operations Management Suite Onboarding Wizard**, available from the Operations Manager console. During the registration process, you'll be prompted to provide the target Azure tenant, subscription, and Log Analytics workspace.

After you register Operations Manager with an Azure Log Analytics workspace, you must designate agent-managed computers that will collect log data for Azure Monitor.

> [!TIP]
> These agent-managed computers can be either individual computer objects or groups containing Windows computer objects.

> [!CAUTION]
> If you don't designate the computers, Log Analytics will not collect data from the agents reporting to your management group.

After configuration is complete, the Operations Manager management group establishes a persistent connection to Azure Monitor. That connection is used to retrieve management packs corresponding to the Azure Monitor solutions that you decided to implement.

Operations Manager automatically downloads and imports these management packs after they are enabled.

> [!TIP]
> As with any management pack, you have the option of configuring overrides and rules that enable you to control the updates schedule, or disable them completely.

In some cases, additional configuration might be required. For example, to implement the Map feature for on-premises servers that are part of an Operations Manager management group, you must import the Service Map management pack, which will add the Service Map node to the Operations Management Suite in the **Administration** pane of the Operations Manager Operations console.

> [!NOTE]
> The node provides the ability to designate the target Log Analytics workspace by using the **Add Microsoft Operations Management Suite Workspace Wizard**.

The registration process will add the Service Map node to the **Administration** pane.

From the Service Map node, you can monitor:

- Active alerts
- List monitored servers
- Display groups created by using the **Service Map** feature in Azure Monitor, and their dependencies

These views  facilitate creating distributed applications in Operations Manager.
