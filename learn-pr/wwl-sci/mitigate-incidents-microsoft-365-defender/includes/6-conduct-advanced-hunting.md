Advanced hunting is a query-based threat-hunting tool that lets you explore up to 30 days of raw data. You can proactively inspect events in your network to locate threat indicators and entities. The flexible access to data enables unconstrained hunting for both known and potential threats.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4Bp7O]

You can use the same threat-hunting queries to build custom detection rules. These rules run automatically to check for and then respond to suspected breach activity, misconfigured machines, and other findings. The advanced hunting capability supports queries that check a broader data set from:

- Microsoft Defender for Endpoint

- Microsoft Defender for Office 365

- Microsoft Defender for Cloud Apps

- Microsoft Defender for Identity

To use advanced hunting, turn on Microsoft 365 Defender.

## Data freshness and update frequency

Advanced hunting data can be categorized into two distinct types, each consolidated differently.

- Event or activity data—populates tables about alerts, security events, system events, and routine assessments. Advanced hunting receives this data almost immediately after the sensors that collect them successfully transmit them to the corresponding cloud services. For example, you can query event data from healthy sensors on workstations or domain controllers almost immediately after they are available on Microsoft Defender for Endpoint and Microsoft Defender for Identity.

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
| DeviceTvmSecureConfigurationAssessment| Threat & Vulnerability Management assessment events, indicating the status of various security configurations on devices|
| DeviceTvmSecureConfigurationAssessmentKB| Knowledge base of various security configurations used by Threat & Vulnerability Management to assess devices; includes mappings to various standards and benchmarks|
| DeviceTvmSoftwareInventoryVulnerabilities| Inventory of software on devices and any known vulnerabilities in these software products|
| DeviceTvmSoftwareVulnerabilitiesKB| Knowledge base of publicly disclosed vulnerabilities, including whether exploit code is publicly available|
| EmailAttachmentInfo| Information about files attached to emails|
| EmailEvents| Microsoft 365 email events, including email delivery and blocking events|
| EmailPostDeliveryEvents| Security events that occur post-delivery, after Microsoft 365 has delivered the emails to the recipient mailbox|
| EmailUrlInfo| Information about URLs on emails|
| IdentityDirectoryEvents| Events involving an on-premises domain controller running Active Directory (AD). This table covers a range of identity-related events and system events on the domain controller.|
| IdentityInfo| Account information from various sources, including Azure Active Directory|
| IdentityLogonEvents| Authentication events on Active Directory and Microsoft online services|
| IdentityQueryEvents| Queries for Active Directory objects, such as users, groups, devices, and domains|

## Custom detections

With custom detections, you can proactively monitor for and respond to various events and system states, including suspected breach activity and misconfigured endpoints. This is made possible by customizable detection rules that automatically trigger alerts and response actions.

Custom detections work with advanced hunting, which provides a powerful, flexible query language that covers a broad set of event and system information from your network. You can set them to run at regular intervals, generating alerts and taking response actions whenever there are matches.

Custom detections provide:

- Alerts for rule-based detections built from advanced hunting queries

- Automatic response actions