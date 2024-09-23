After you onboard Microsoft Sentinel into your workspace, use data connectors to start ingesting your data into Microsoft Sentinel. Microsoft Sentinel comes with many out of the box connectors for Microsoft services, which integrate in real time. For example, the Microsoft 365 Defender connector is a service-to-service connector that integrates data from Office 365, Microsoft Entra ID, Microsoft Defender for Identity, and Microsoft Defender for Cloud Apps.

Built-in connectors enable connection to the broader security ecosystem for non-Microsoft products. For example, use Syslog, Common Event Format (CEF), or REST APIs to connect your data sources with Microsoft Sentinel.

The Microsoft Sentinel Data connectors page shows the full list of connectors and their status for your workspace. Soon this page will only show the list of in-use data connectors.

> [!NOTE]
> To add more data connectors, install the solution associated with the data connector from the **Content Hub**.

## Enable a data connector

From the Data connectors page, select the active or custom connector you want to connect, and then select Open connector page. If you don't see the data connector you want, install the solution associated with it from the Content Hub.

Once you fulfill all the prerequisites listed in the Instructions tab, the connector page describes how to ingest the data to Microsoft Sentinel. It may take some time for data to start arriving.<br>

After you connect, you see a summary of the data in the Data received graph, and the connectivity status of the data types.

### REST API integration for data connectors

Many security technologies provide a set of APIs for retrieving log files, and some data sources can use those APIs to connect to Microsoft Sentinel.

Data connectors that use APIs either integrate from the provider side or integrate using Azure Functions, as described in the following sections.<br>

### REST API integration on the provider side<br>

An API integration built by the provider connects with the provider data sources and pushes data into Microsoft Sentinel custom log tables using the Azure Monitor Data Collector API.

### REST API integration using Azure Functions<br>

Integrations that use Azure Functions to connect with a provider API first format the data, and then send it to Microsoft Sentinel custom log tables using the Azure Monitor Data Collector API.

## Agent-based integration for data connectors

Microsoft Sentinel can use the Syslog protocol to connect an agent to any data source that can perform real-time log streaming. For example, most on-premises data sources connect using agent-based integration.

The following sections describe the different types of Microsoft Sentinel agent-based data connectors. Follow the steps in each Microsoft Sentinel data connector page to configure connections using agent-based mechanisms.

### Syslog

You can stream events from Linux-based, Syslog-supporting devices into Microsoft Sentinel using the Azure Monitor Agent (AMA). Depending on the device type, the agent is installed either directly on the device, or on a dedicated Linux-based log forwarder. The AMA receives events from the Syslog daemon over UDP. The Syslog daemon forwards events to the agent internally, communicating over UDS (Unix Domain Sockets). The AMA then transmits these events to the Microsoft Sentinel workspace.

Here is a simple flow that shows how Microsoft Sentinel streams Syslog data.<br>

1.  The device's built-in Syslog daemon collects local events of the specified types, and forwards the events locally to the agent.<br>
2.  The agent streams the events to your Log Analytics workspace.
3.  After successful configuration, the data appears in the Log Analytics Syslog table.

### Common Event Format (CEF)

Log formats vary, but many sources support CEF-based formatting. The Microsoft Sentinel agent, which is actually the Log Analytics agent, converts CEF-formatted logs into a format that Log Analytics can ingest.

For data sources that emit data in CEF, set up the Syslog agent and then configure the CEF data flow. After successful configuration, the data appears in the **CommonSecurityLog** table.

### Custom logs

For some data sources, you can collect logs as files on Windows or Linux computers using the Log Analytics custom log collection agent.

Follow the steps in each Microsoft Sentinel data connector page to connect using the Log Analytics custom log collection agent. After successful configuration, the data appears in custom tables.

## Service-to-service integration for data connectors

Microsoft Sentinel uses the Azure foundation to provide out-of-the-box, service-to-service support for Microsoft services and Amazon Web Services.

## Deploy data connectors as part of a solution

Microsoft Sentinel solutions provide packages of security content, including data connectors, workbooks, analytics rules, playbooks, and more. When you deploy a solution with a data connector, you get the data connector together with related content in the same deployment.

## Data connector support

Both Microsoft and other organizations author Microsoft Sentinel data connectors. Each data connector has one of these support types:

| **Support type**    | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Microsoft supported | Applies to data connectors for data sources where Microsoft is the data provider and author.<br>Some Microsoft-authored data connectors for non-Microsoft data sources.<br><br>Microsoft supports and maintains data connectors in this category according to the Microsoft Azure Support Plans.<br><br>Partners or the Community support data connectors that are authored by any party other than Microsoft.                                                                                                 |
| Partner supported   | Applies to data connectors authored by parties other than Microsoft.<br><br>The partner company provides support or maintenance for these data connectors. The partner company can be an Independent Software Vendor, a Managed Service Provider, a Systems Integrator, or any organization whose contact information is provided on the Microsoft Sentinel page for that data connector.<br><br>For any issues with a partner supported data connector, contact the specified data connector support contact. |
| Community supported | Applies to data connectors authored by Microsoft or partner developers that don't have listed contacts for data connector support and maintenance on the specified data connector page in Microsoft Sentinel.                                                                                                                                                                                                                                                                                                  |
