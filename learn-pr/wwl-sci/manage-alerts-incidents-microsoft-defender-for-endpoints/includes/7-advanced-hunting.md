Advanced hunting is a query-based threat-hunting tool that lets you explore up to 30 days of raw data. You can proactively inspect events in your network to locate threat indicators and entities. The flexible access to data enables unconstrained hunting for both known and potential threats.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4bGqo?rel=0]

## Data freshness and update frequency

Advanced hunting data can be categorized into two distinct types, each consolidated differently.

**Event or activity data**—populates tables about alerts, security events, system events, and routine assessments. Advanced hunting receives this data almost immediately after the sensors that collect them successfully transmit them to Defender for Endpoint.

**Entity data**—populates tables with consolidated information about users and devices. This data comes from both relatively static data sources and dynamic sources, such as Active Directory entries and event logs. To provide fresh data, tables are updated with any new information every 15 minutes, adding rows that might not be fully populated. Every 24 hours, data is consolidated to insert a record that contains the latest, most comprehensive data set about each entity.

## Data Schema

The following reference lists all the tables in the advanced hunting schema.

- **DeviceAlertEvents** - Alerts on Microsoft Defender Security Center

- **DeviceInfo** - Device information, including OS information

- **DeviceNetworkInfo**  -	Network properties of devices, including adapters, IP and MAC addresses, as well as connected networks and domains

- **DeviceProcessEvents** - Process creation and related events

- **DeviceNetworkEvents** - Network connection and related events

- **DeviceFileEvents** - File creation, modification, and other file system events

- **DeviceRegistryEvents**  - Creation and modification of registry entries

- **DeviceLogonEvents** -	Sign-ins and other authentication events

- **DeviceImageLoadEvents** - DLL loading events

- **DeviceEvents** - Multiple event types, including events triggered by security controls such as Microsoft Defender Antivirus and exploit protection

- **DeviceFileCertificateInfo** - Certificate information of signed files obtained from certificate verification events on endpoints

- **DeviceTvmSoftwareInventoryVulnerabilities**	- Inventory of software on devices and any known vulnerabilities in these software products

- **DeviceTvmSoftwareVulnerabilitiesKB** - Knowledge base of publicly disclosed vulnerabilities, including whether exploit code is publicly available

- **DeviceTvmSecureConfigurationAssessment** - Threat & Vulnerability Management assessment events, indicating the status of various security configurations on devices

- **DeviceTvmSecureConfigurationAssessmentKB**  - Knowledge base of various security configurations used by Threat & Vulnerability Management to assess devices; includes mappings to various standards and benchmarks

## Custom detections

With custom detections, you can proactively monitor for and respond to various events and system states, including suspected breach activity and misconfigured devices. You can do this with customizable detection rules that automatically trigger alerts and response actions.

Custom detections work with advanced hunting, which provides a powerful, flexible query language that covers a broad set of event and system information from your network. You can set them to run at regular intervals, generate alerts, and take response actions whenever there are matches.

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

- Frequency—interval for running the query and taking action. See additional guidance below

- Alert title—title displayed with alerts triggered by the rule

- Severity—potential risk of the component or activity identified by the rule. Read about alert severities

- Category—type of threat component or activity, if any. Read about alert categories

- MITRE ATT&CK techniques—one or more attack techniques identified by the rule as documented in the MITRE ATT&CK framework. This section is not available with certain alert categories, such as malware, ransomware, suspicious activity, and unwanted software

- Description—more information about the component or activity identified by the rule

- Recommended actions—additional actions that responders might take in response to an alert

Rule frequency

When saved, a new custom detection rule immediately runs and checks for matches from the past 30 days of data. The rule then runs again at fixed intervals and lookback durations based on the frequency you choose:

- Every 24 hours—runs every 24 hours, checking data from the past 30 days

- Every 12 hours—runs every 12 hours, checking data from the past 24 hours

- Every 3 hours—runs every 3 hours, checking data from the past 6 hours

- Every hour—runs hourly, checking data from the past 2 hours

Select the frequency that matches how closely you want to monitor detections, and consider your organization's capacity to respond to the alerts.

**3. Choose the impacted entities.**

Identify the columns in your query results where you expect to find the main affected or impacted entity. For example, a query might return both device and user IDs. Identifying which of these columns represents the main impacted entity helps the service aggregate relevant alerts, correlate incidents, and target response actions.

You can select only one column for each entity type. Columns that are not returned by your query cannot be selected.

**4. Specify actions.**

Your custom detection rule can automatically take actions on files or devices that are returned by the query.

Actions on devices

These actions are applied to devices in the DeviceId column of the query results:

- Isolate device—applies full network isolation, preventing the device from connecting to any application or service, except for the Defender for Endpoint service. Learn more about device isolation

- Collect investigation package—collects device information in a ZIP file. Learn more about the investigation package

- Run antivirus scan—performs a full Microsoft Defender Antivirus scan on the device

- Initiate investigation—starts an automated investigation on the device

Actions on files

These actions are applied to files in the SHA1 or the InitiatingProcessSHA1 column of the query results:

- Allow/Block—automatically adds the file to your custom indicator list so that it is always allowed to run or blocked from running. You can set the scope of this action so that it is taken only on selected device groups. This scope is independent of the scope of the rule.

- Quarantine file—deletes the file from its current location and places a copy in quarantine

**5. Set the rule scope.**

Set the scope to specify which devices are covered by the rule:

- All devices

- Specific device groups

Only data from devices in scope will be queried. Also, actions will be taken only on those devices.

**6. Review and turn on the rule.**

After reviewing the rule, select Create to save it. The custom detection rule immediately runs. It runs again based on configured frequency to check for matches, generate alerts, and take response actions.

