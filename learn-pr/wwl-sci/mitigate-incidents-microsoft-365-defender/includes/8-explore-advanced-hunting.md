Advanced hunting is a query-based threat-hunting tool that lets you explore up to 30 days of raw data. You can proactively inspect events in your network to locate threat indicators and entities. The flexible access to data enables unconstrained hunting for both known and potential threats.

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=197cbd32-a06e-4efc-ade0-0c9875d7b105]

You can use the same threat-hunting queries to build custom detection rules. These rules run automatically to check for and then respond to suspected breach activity, misconfigured machines, and other findings. The advanced hunting capability supports queries that check a broader data set from:

- Microsoft Defender for Endpoint

- Microsoft Defender for Office 365

- Microsoft Defender for Cloud Apps

- Microsoft Defender for Identity

To use advanced hunting, turn on Microsoft Defender XDR.

## Data freshness and update frequency

Advanced hunting data can be categorized into two distinct types, each consolidated differently.

- Event or activity data—populates tables about alerts, security events, system events, and routine assessments. Advanced hunting receives this data almost immediately after the sensors that collect them successfully transmit them to the corresponding cloud services. For example, you can query event data from healthy sensors on workstations or domain controllers almost immediately after they're available on Microsoft Defender for Endpoint and Microsoft Defender for Identity.

- Entity data—populates tables with information about users and devices. This data comes from both relatively static data sources and dynamic sources, such as Active Directory entries and event logs. To provide fresh data, tables are updated with any new information every 15 minutes, adding rows that might not be fully populated. Every 24 hours, data is consolidated to insert a record that contains the latest, most comprehensive data set about each entity.

## Time zone

Time information in advanced hunting is in the UTC zone.

## Data schema

The advanced hunting schema is made up of multiple tables that provide either event information or information about devices, alerts, identities, and other entity types. To effectively build queries that span multiple tables, you need to understand the tables and the columns in the advanced hunting schema.

### Get schema information

While constructing queries, use the built-in schema reference to quickly get the following information about each table in the schema:

- Table description—type of data contained in the table and the source of that data.

- Columns—all the columns in the table.

- Action types—possible values in the ActionType column representing the event types supported by the table. This information is provided only for tables that contain event information.

- Sample query—example queries that feature how the table can be utilized.

### Access the schema reference

To quickly access the schema reference, select the View reference action next to the table name in the schema representation. You can also select Schema reference to search for a table.

### Learn the schema tables

The following reference lists all the tables in the schema. Each table name links to a page describing the column names for that table. Table and column names are also listed in the security center as part of the schema representation on the advanced hunting screen.

| Table name| Description|
| :--- | :--- |
| AlertEvidence| Files, IP addresses, URLs, users, or devices associated with alerts|
| AlertInfo| Alerts from Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Microsoft Cloud App Security, and Microsoft Defender for Identity, including severity information and threat categorization|
| CloudAppEvents| Events involving accounts and objects in Office 365 and other cloud apps and services|
| DeviceEvents| Multiple event types, including events triggered by security controls such as Windows Defender Antivirus and exploit protection|
| DeviceFileCertificateInfo| Certificate information of signed files obtained from certificate verification events on endpoints|
| DeviceFileEvents| File creation, modification, and other file system events|
| DeviceImageLoadEvents| DLL loading events|
| DeviceInfo| Machine information, including OS information|
| DeviceLogonEvents| Sign-ins and other authentication events on devices|
| DeviceNetworkEvents| Network connection and related events|
| DeviceNetworkInfo| Network properties of devices, including physical adapters, IP and MAC addresses, as well as connected networks and domains|
| DeviceProcessEvents| Process creation and related events|
| DeviceRegistryEvents| Creation and modification of registry entries|
| DeviceTvmSecureConfigurationAssessment | Threat & Vulnerability Management assessment events, indicating the status of various security configurations on devices |
| DeviceTvmSecureConfigurationAssessmentKB | Knowledge base of various security configurations used by Threat & Vulnerability Management to assess devices; includes mappings to various standards and benchmarks|
| DeviceTvmSoftwareInventory | Inventory of software installed on devices, including their version information and end-of-support status | 
|DeviceTvmSoftwareVulnerabilities| Software vulnerabilities found on devices and the list of available security updates that address each vulnerability |
| DeviceTvmSoftwareVulnerabilitiesKB| Knowledge base of publicly disclosed vulnerabilities, including whether exploit code is publicly available|  
|EmailAttachmentInfo| Information about files attached to emails|
| EmailEvents| Microsoft 365 email events, including email delivery and blocking events|
| EmailPostDeliveryEvents| Security events that occur post-delivery, after Microsoft 365 delivered the emails to the recipient mailbox|
| EmailUrlInfo| Information about URLs on emails|
| IdentityDirectoryEvents| Events involving an on-premises domain controller running Active Directory (AD). This table covers a range of identity-related events and system events on the domain controller.|
| IdentityInfo| Account information from various sources, including Microsoft Entra ID|
| IdentityLogonEvents| Authentication events on Active Directory and Microsoft online services|
| IdentityQueryEvents| Queries for Active Directory objects, such as users, groups, devices, and domains|

## Custom detections

With custom detections, you can proactively monitor for and respond to various events and system states, including suspected breach activity and misconfigured endpoints. This is made possible by customizable detection rules that automatically trigger alerts and response actions.

Custom detections work with advanced hunting, which provides a powerful, flexible query language that covers a broad set of event and system information from your network. You can set them to run at regular intervals, generating alerts and taking response actions whenever there are matches.

Custom detections provide:

- Alerts for rule-based detections built from advanced hunting queries

- Automatic response actions that apply to files and devices


### Create detection rules

To create detection rules:

**1. Prepare the query.**

In Microsoft Defender Security Center, go to Advanced hunting and select an existing query or create a new query. When using a new query, run the query to identify errors and understand possible results.

> [!IMPORTANT]
> To prevent the service from returning too many alerts, each rule is limited to generating only 100 alerts whenever it runs. Before creating a rule, tweak your query to avoid alerting for normal, day-to-day activity.

To use a query for a custom detection rule, the query must return the following columns:

- Timestamp

- DeviceId

- ReportId

Simple queries, such as those that don't use the project or summarize operator to customize or aggregate results, typically return these common columns.

There are various ways to ensure more complex queries return these columns. For example, if you prefer to aggregate and count by DeviceId, you can still return Timestamp and ReportId by getting them from the most recent event involving each device.

The sample query below counts the number of unique devices (DeviceId) with antivirus detections and uses this to find only those devices with more than five detections. To return the latest Timestamp and the corresponding ReportId, it uses the summarize operator with the arg_max function.

```kusto
DeviceEvents
| where Timestamp > ago(7d)
| where ActionType == "AntivirusDetection"
| summarize (Timestamp, ReportId)=arg_max(Timestamp, ReportId), count() by DeviceId
| where count_ > 5

```

**2. Create a new rule and provide alert details.**

With the query in the query editor, select Create detection rule and specify the following alert details:

- Detection name—name of the detection rule

- Frequency—interval for running the query and taking action. See more guidance below

- Alert title—title displayed with alerts triggered by the rule

- Severity—potential risk of the component or activity identified by the rule.

- Category—type of threat component or activity, if any.

- MITRE ATT&CK techniques—one or more attack techniques identified by the rule as documented in the MITRE ATT&CK framework. This section isn't available with certain alert categories, such as malware, ransomware, suspicious activity, and unwanted software

- Description—more information about the component or activity identified by the rule

- Recommended actions—additional actions that responders might take in response to an alert


**3. Rule frequency**

When saved, a new custom detection rule immediately runs and checks for matches from the past 30 days of data. The rule then runs again at fixed intervals and lookback durations based on the frequency you choose:

- Every 24 hours—runs every 24 hours, checking data from the past 30 days

- Every 12 hours—runs every 12 hours, checking data from the past 48 hours

- Every 3 hours—runs every 3 hours, checking data from the past 12 hours

- Every hour—runs hourly, checking data from the past 4 hours

- Continuous (NRT)—runs continuously, checking data from events as they're collected and processed in near real-time   (NRT)

Select the frequency that matches how closely you want to monitor detections, and consider your organization's capacity to respond to the alerts.

> [!NOTE]
> Setting a custom detection to run in Continuous (NRT) frequency allows you to increase your organization's ability to identify threats faster.

**4. Choose the impacted entities.**

Identify the columns in your query results where you expect to find the main affected or impacted entity. For example, a query might return both device and user IDs. Identifying which of these columns represents the main impacted entity helps the service aggregate relevant alerts, correlate incidents, and target response actions.

You can select only one column for each entity type. Columns not returned by your query can't be selected.

**5. Specify actions.**

Your custom detection rule can automatically take actions on files or devices returned by the query.

Actions on devices

These actions are applied to devices in the DeviceId column of the query results:

- Isolate device—applies full network isolation, preventing the device from connecting to any application or service, except for the Defender for Endpoint service.

- Collect investigation package—collects device information in a ZIP file. 

- Run antivirus scan—performs a full Microsoft Defender Antivirus scan on the device

- Initiate investigation—starts an automated investigation on the device

Actions on files

These actions are applied to files in the SHA1 or the InitiatingProcessSHA1 column of the query results:

- Allow/Block—automatically adds the file to your custom indicator list so that it's always allowed to run or blocked from running. You can set the scope of this action so that it's taken only on selected device groups. This scope is independent of the scope of the rule.

- Quarantine file—deletes the file from its current location and places a copy in quarantine

**6. Set the rule scope.**

Set the scope to specify which devices are covered by the rule:

- All devices

- Specific device groups

Only data from devices in scope are queried. Also, actions are taken only on those devices.

**7. Review and turn on the rule.**

After reviewing the rule, select Create to save it. The custom detection rule immediately runs. It runs again based on configured frequency to check for matches, generate alerts, and take response actions.

## Visualize threat paths with the Hunting graph (Preview)

> [!IMPORTANT]
> The Hunting graph is in Preview. Capabilities may change before general availability.

The Hunting graph is the Microsoft Sentinel graph integration with Microsoft Defender XDR. It extends advanced hunting by rendering predefined threat scenarios as interactive, graph‑based visualizations. Instead of manually stitching relationships through KQL joins, you can visually traverse entities (nodes) and their relationships (edges) to quickly spot attack paths, choke points, or over‑privileged identities.

:::image type="content" source="../media/hunting-graph-render.png" alt-text="Screenshot of a rendered graph in the hunting graph page." lightbox="../media/hunting-graph-render.png":::

### Why use the Hunting graph?

Use it when you need to:

- Trace potential lateral‑movement paths between two entities.
- Assess exposure to sensitive assets (Key Vaults, storage accounts, SQL data stores, Kubernetes clusters).
- Inventory identities with access to high‑value repositories (for example, Azure DevOps).
- Prioritize mitigation by finding nodes that appear in many critical paths.

It complements tabular KQL queries: start visually to scope the investigation, then pivot to advanced hunting queries or custom detections for automation.

### Prerequisites and access

You need:

- Appropriate Microsoft Entra ID role for advanced hunting.
- Access to the Microsoft Sentinel data lake (for cross‑workspace graph data).
- At least read-only access in Microsoft Security Exposure Management.

### How to launch it

1. In the Microsoft Defender portal: **Investigation & response > Hunting > Advanced hunting**.
2. In the Advanced hunting page toolbar, select the hunting graph icon, or choose **Create new > Hunting graph**.
3. A new tab labeled “New hunt” opens.

:::image type="content" source="../media/hunting-graph-new.png" alt-text="Screenshot of the Create new Hunting graph option in the advanced hunting page." lightbox="../media/hunting-graph-new.png":::

### Graph basics

- **Nodes** represent entities (users, devices, storage accounts, clusters, repositories, etc.).
- **Edges** represent relationships (permissions, authentication capability, membership, traffic routing, containment).
- Controls in the lower-right let you zoom and manage **Layers** (helpful for decluttering dense graphs).

### Using predefined scenarios

Choose “Search with predefined scenarios” to load a guided panel.

:::image type="content" source="../media/hunting-graph-predefined-scenarios.png" alt-text="Screenshot of the hunting graph page highlighting the Search with Predefined scenarios button." lightbox="../media/hunting-graph-predefined-scenarios.png":::

Scenarios bundle queries + relationship logic. Common examples:

| Scenario | What it helps you answer | Input required |
|----------|--------------------------|----------------|
| Paths between two entities | Is there a traversable path from A to B? | Start entity, End entity |
| Users with access to sensitive data | Which users can reach a sensitive storage asset? | Target storage account |
| Data exfiltration by a device | What storage accounts can a given device access? | Source device |
| Paths to a highly critical Kubernetes cluster | Which actors can reach a critical cluster? | Target Kubernetes cluster |
| Identities with access to Azure DevOps repositories | Who can read/write a specific repo? | Target ADO repository |
| Nodes in highest number of paths to SQL data stores | Which nodes are high-leverage for reaching SQL assets? | None |
| Critical users with access to sensitive storage | Which privileged identities can touch sensitive data? | None |
| Entities that have access to a key vault | Who (directly or indirectly) can reach a Key Vault? | Target key vault |


:::image type="content" source="../media/hunting-graph-select-scenario.png" alt-text="Screenshot of the predefined scenarios side panel highlighting the available options." lightbox="../media/hunting-graph-select-scenario.png":::

For scenarios with inputs, type or search the entity name/ID. Direction matters for “Paths between two entities” (start → end).

### Refining with filters

Use panel filters to narrow focus:

- Shortest paths only (quickly identify minimal traversal).
- Source / Target node constraints (Is critical, Is vulnerable, Has sensitive data, Has risk score, Exposed to internet).
- Edge type filters (for example: has permissions to, can authenticate as, member of, routes traffic to, has role on, can impersonate as).

Remove individual filters or clear all to broaden exploration.

### Rendering and exploring

After selecting scenario + filters:

1. Select **Run** to generate the graph.
2. Select nodes to view enriched context (roles, sensitivity, exposure).
3. Expand or focus on subregions if paths are dense.
4. Identify repeated intermediate nodes (potential choke points or escalation catalysts).

### Workflow integration

| Goal | Suggested approach |
|------|--------------------|
| Hypothesize lateral movement | Use “Paths between two entities” then build a KQL query to validate event evidence. |
| Privilege review | Run “Critical users with access…” and export involved identities to an access review process. |
| Data exfiltration triage | Start with “Data exfiltration by a device” to scope possible targets, then craft a custom detection for unusual transfer volumes. |
| Attack surface reduction | Use “Nodes in highest number of paths…” to find over‑centralized assets and apply segmentation or least privilege. |
