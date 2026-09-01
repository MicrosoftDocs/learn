In addition to assessing and addressing problems with their hybrid environment's security configuration, Contoso must also monitor for new problems and threats, and respond appropriately. Microsoft Sentinel is a SIEM and SOAR solution for cloud, multicloud, and hybrid environments.

> [!NOTE]
> SIEM solutions provide storage and analysis of logs, events, and alerts that other systems generate, and you can configure these solutions to raise their own alerts. SOAR solutions support the remediation of vulnerabilities and the overall automation of security processes.

## What is Microsoft Sentinel?

Microsoft Sentinel meets the needs of both SIEM and SOAR solutions through:

- Collecting data across cloud-based and on-premises users, devices, apps, and infrastructure.
- Using AI to identify suspicious activity.
- Detecting threats with fewer false positives.
- Responding to incidents quickly and automatically.

Microsoft Sentinel is available in both the Azure portal and the Microsoft Defender portal. The Defender portal provides a unified security operations experience across Microsoft Sentinel, Microsoft Defender XDR, and other Microsoft security services. 

### Prerequisites for Microsoft Sentinel

To enable Microsoft Sentinel, you'll need:

- A **Log Analytics** workspace.

    > [!TIP]
    > Microsoft Sentinel must be added to a Log Analytics workspace. The default workspaces created by Microsoft Defender for Cloud aren't shown in the Microsoft Sentinel workspace list and can't be used for Microsoft Sentinel.

- Contributor permissions to the subscription where the Microsoft Sentinel workspace resides.
- Microsoft Sentinel Contributor or Microsoft Sentinel Reader permissions on the resource group that contains the workspace.
- Microsoft Sentinel Contributor permissions to install or manage solutions from the content hub.
- Appropriate permissions on any resources that you connect to Microsoft Sentinel.

### Data connections

Microsoft Sentinel uses data connectors to ingest events, alerts, and logs. Microsoft Sentinel can connect to Microsoft Defender for Cloud so you can analyze Defender for Cloud alerts in broader organizational context. It can also use the Microsoft Defender XDR connector to integrate data from Office 365, Microsoft Entra ID, Microsoft Defender for Identity, and Microsoft Defender for Cloud Apps.

Microsoft Sentinel data connection support includes:

- Native service-to-service connections. Microsoft Sentinel integrates natively with Microsoft, Azure, and selected cloud services, including:
  - Azure activity logs
  - Microsoft Entra audit logs
  - Microsoft Entra ID Protection
  - Microsoft Defender XDR
  - Microsoft Defender for Cloud
  - Microsoft Defender for Identity
  - Microsoft Defender for Cloud Apps
  - AWS CloudTrail
  - DNS servers
  - Microsoft 365
  - Microsoft Defender for Endpoint
  - Microsoft web application firewall
  - Windows Defender Firewall with Advanced Security
  - Windows security events
- External solution connections through APIs. Microsoft Sentinel can connect to many data sources through data connectors from the content hub, the Logs Ingestion API, the Codeless Connector Framework, Azure Functions, or Logic Apps.
- External solution connections through an agent. Microsoft Sentinel can connect to data sources that support Syslog or Common Event Format (CEF) by using the Azure Monitor Agent (AMA). The agent can run on a Linux device or on a dedicated Linux log forwarder. Support for connecting through an agent includes the following devices and solutions:
  - Firewalls, internet proxies, and endpoints
  - Data loss prevention (DLP) solutions
  - DNS machines
  - Linux servers
  - Other cloud providers

### Permissions

Access in Microsoft Sentinel is managed through role-based access control (RBAC) roles. These roles give you the ability to manage what users can observe and do within Microsoft Sentinel:

- Global roles. The built-in Azure global roles&mdash;Owner, Contributor, and Reader&mdash;grant access to all Azure resources, including Microsoft Sentinel and Log Analytics.
- Microsoft Sentinel-specific roles. The built-in roles that are specific to Microsoft Sentinel are:
  - Microsoft Sentinel Reader. This role can get data, incidents, dashboards, and information about Sentinel resources.
  - Microsoft Sentinel Responder. This role has all the capabilities of the Microsoft Sentinel Reader role and can also manage incidents.
  - Microsoft Sentinel Contributor. In addition to the capabilities of the Microsoft Sentinel Responder role, this role can create and edit dashboards, analytics rules, and other Sentinel resources.
- Other roles. Log Analytics Contributor and Log Analytics Reader are built-in roles that are specific to Log Analytics. These roles grant permissions only to the **Log Analytics** workspace. If you don't have the global Contributor or Owner roles, you'll need the Logic App Contributor role to create and run playbooks in response to alerts.

### Implement Microsoft Sentinel

To implement Microsoft Sentinel:

1. Create a Log Analytics workspace, or identify an existing workspace that isn't a default workspace created by Microsoft Defender for Cloud.
2. In the Azure portal, search for and select **Microsoft Sentinel**.
3. Select **Create**, choose the workspace, and then select **Add**.
4. Access Microsoft Sentinel from the Microsoft Defender portal at `https://security.microsoft.com`, or continue in the Azure portal while it remains supported.
5. In Microsoft Sentinel, select **Content hub** and install the solution that contains the connector and security content you need. For example, install the **Microsoft Defender for Cloud** solution.
6. Select **Configuration** > **Data connectors**.
7. Select the appropriate connector. For example, select **Microsoft Defender for Cloud**.
8. Select **Open connector page**, review the prerequisites, and then connect the data source.

## What is SIEM?

SIEM solutions store and analyze log data that comes from external sources. You connect data sources from Azure and external sources in your organization, including on-premises resources. Microsoft Sentinel then provides workbooks, hunting, analytics, and incident views that help you analyze and visualize those events. These experiences help you understand the number of events received, the number of alerts generated from that data, and the status of incidents created from those alerts.

Microsoft Sentinel uses built-in and custom detections to alert you to potential security threats&mdash;for example, attempts to access Contoso's organization from outside their infrastructure or when data from Contoso appears to be sent to a known malicious IP address. It also enables you to create incidents based on these alerts.

Microsoft Sentinel provides built-in and custom workbooks to help you analyze incoming data. *Workbooks* are interactive reports that include log queries, text, metrics, and other data. Analytics rules and Microsoft security connectors enable you to create incidents from alerts that other services such as Microsoft Defender for Cloud generate.

To implement SIEM functionality in Microsoft Sentinel:

- Enable Microsoft Sentinel.
- Create a data connection.
- Create a custom rule that generates an alert.

## What is SOAR?

SOAR solutions enable you to manage or orchestrate analysis of data that you have collected about security threats, coordinate your response to those threats, and create automated responses. Microsoft Sentinel's SOAR capabilities are tied closely to its SIEM functionality.

Use the following best practices to implement SOAR in Microsoft Sentinel:

- When you create analytics rules that raise alerts, also configure them to create incidents.
- Use the incidents to manage the investigation and response process.
- Group related alerts into an incident.
- Use automation rules to triage, assign, tag, or close incidents when specific conditions are met.
- Use playbooks based on Azure Logic Apps to run repeatable response actions.

### Investigate incidents

In Microsoft Sentinel, you can review how many incidents are open, how many are being worked on, and how many are closed. You can reopen closed incidents. You can get the details of an incident, such as when it occurred and its status. You can also add comments to an incident and change its status so that progress is easier to understand. Incidents can be assigned to specific users.

### Respond to alerts with security playbooks

Microsoft Sentinel enables you to use security playbooks to respond to alerts and incidents. *Security playbooks* are collections of procedures based on Azure Logic Apps that run in response to an alert or incident. You can run these security playbooks manually during an investigation, or you can use automation rules to run a playbook automatically.
