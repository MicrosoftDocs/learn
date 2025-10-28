Organizations use Azure monitoring tools to identify, analyze, and troubleshoot application and infrastructure issues. However, incident management workflows typically occur in separate IT Service Management (ITSM) tools where work items, tickets, and change requests are tracked.

## The integration challenge

When monitoring and incident management occur in separate systems, teams face workflow inefficiencies:

**Context switching overhead:** Engineers must switch between Azure monitoring tools to investigate issues and ITSM tools to document findings, create tickets, and track resolutions. This switching wastes time and breaks concentration during critical incident response.

**Manual data transfer:** Information discovered in monitoring tools must be manually copied into ITSM tickets. This manual transfer is error-prone and time-consuming, especially during high-pressure incident situations.

**Delayed incident creation:** The time required to manually create ITSM tickets from monitoring alerts delays official incident response workflows and notification of support teams.

**Incomplete context:** When tickets are created manually, they often lack complete diagnostic context from monitoring tools. Responders must revisit monitoring tools to gather missing information.

## IT Service Management Connector

IT Service Management Connector (ITSMC) for Azure solves these integration challenges by providing bi-directional synchronization between Azure monitoring tools and ITSM platforms. ITSMC integrates with leading ITSM solutions including ServiceNow, Provance, Cherwell, and System Center Service Manager.

### Bi-directional integration benefits

ITSMC connects Azure Monitor with ITSM tools in both directions:

**Azure to ITSM:** Automatically create or update work items in ITSM tools based on Azure monitoring alerts. When Azure Monitor detects issues, ITSM tickets are created automatically with complete diagnostic context.

**ITSM to Azure:** Pull incident and change request data from ITSM tools into Azure Log Analytics. This integration enables correlation between incidents tracked in ITSM systems and telemetry data in Azure Monitor.

### Supported Azure alert types

ITSMC can create ITSM work items from multiple Azure alert sources:

- **Activity Log Alerts:** Alerts based on Azure resource management operations, service health events, and resource health changes.
- **Metric Alerts:** Near real-time alerts triggered when metrics cross defined thresholds.
- **Log Analytics Alerts:** Alerts generated from log queries in Azure Monitor Logs.

### Work item types

ITSMC can create and update various ITSM work item types:

- **Events:** General notifications about system occurrences.
- **Alerts:** Notifications requiring attention or investigation.
- **Incidents:** Work items tracking service disruptions requiring resolution.

## Key capabilities of ITSMC

**Automated incident creation:** When Azure Monitor raises alerts, ITSMC automatically creates corresponding incidents in your ITSM tool. This automation eliminates manual ticket creation and ensures incidents are logged immediately when problems are detected.

**Rich alert context:** Automatically created incidents include complete context from Azure Monitor including affected resources, alert conditions, diagnostic data, and links back to Azure Monitor for additional investigation.

**Work item updates:** When Azure alerts change state (such as resolving), ITSMC can automatically update corresponding ITSM work items, keeping incident status synchronized between systems.

**Change request tracking:** Pull change request data from ITSM systems into Azure Log Analytics. This capability enables correlation between application changes and performance impacts or incidents.

**Incident correlation:** Analyze incidents from ITSM systems alongside telemetry data in Azure Monitor. This correlation helps identify patterns such as which types of changes lead to incidents or which infrastructure issues cause the most service disruptions.

### Improved troubleshooting experience

With ITSMC, engineers can:

- View ITSM incident context directly from Azure Monitor dashboards.
- Navigate from Azure alerts to related ITSM tickets for complete incident history.
- Analyze incident patterns using combined data from both systems.
- Reduce time spent switching between tools during investigations.

**Reduced resolution time:** By automating incident creation and synchronizing data bi-directionally, ITSMC significantly reduces the time from alert detection to incident resolution. Engineers have all necessary information in one place and can respond faster without manual data transfer between systems.

## Setting up ITSMC

To implement IT Service Management Connector in your environment, follow the setup guidance in the [ITSMC Overview documentation](/azure/azure-monitor/platform/itsmc-overview). The setup process includes:

- Configuring the connection between Azure Monitor and your ITSM tool.
- Defining which Azure alerts should create ITSM work items.
- Mapping Azure alert fields to ITSM work item fields.
- Configuring bi-directional sync settings.
- Testing the integration to verify proper operation.

Proper ITSMC configuration ensures seamless workflow integration between Azure monitoring and your existing ITSM processes, improving both operational efficiency and incident response effectiveness.
