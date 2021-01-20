Indicator of compromise (IoCs) matching is an essential feature in every endpoint protection solution. This capability gives SecOps the ability to set a list of detection indicators and for blocking (prevention and response). Create indicators that define the detection, prevention, and exclusion of entities. You can define the action to be taken, the duration for when to apply the action, and the scope of the device group to apply it to.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4qLVw?rel=0]

Currently supported sources are the cloud detection engine of Defender for Endpoint, the automated investigation and remediation engine, and the endpoint prevention engine (Microsoft Defender AV).

**Cloud detection engine**

The Defender for Endpoint's cloud detection engine regularly scans collected data and tries to match the indicators you set. When there is a match, action will be taken according to the IoC settings you specified.

**Endpoint prevention engine**

The same list of indicators is honored by the prevention agent. Meaning, if Microsoft Defender AV is the primary AV configured, the matched indicators will be treated according to the settings. For example, if the action is "Alert and Block", Microsoft Defender AV will prevent file executions (block and remediate), and a corresponding alert will be raised. Otherwise, if the Action is set to "Allow", Microsoft Defender AV will not detect nor block the file from being run.

**Automated investigation and remediation engine**

The automated investigation and remediation behave the same. If an indicator is set to "Allow", Automated investigation and remediation will ignore a "bad" verdict for it. If set to "Block", Automated investigation and remediation will treat it as "bad".

The current supported actions are:

- Allow

- Alert only

- Alert and block

You can create an indicator for:

- Files

- IP addresses, URLs/domains

- Certificates

There is a limit of 15,000 indicators per tenant.

## Manage indicators

To manage indicators:

- In the navigation pane, select Settings > Indicators.

- Select the tab of the entity type you'd like to manage.

- Update the indicator details and select Save or select the Delete button if you'd like to remove the entity from the list.

## Create indicators for files

You can prevent further propagation of attacks in your organization by banning potentially malicious files or suspected malware. If you know a potentially malicious portable executable (PE) file, you can block it. This operation will prevent it from being read, written, or executed on machines in your organization.

There are two ways you can create indicators for files:

- By creating an indicator through the settings page

- By creating a contextual indicator using the add indicator button from the file details page

### Prerequisites

It's important to understand the following prerequisites prior to creating indicators for files:

- This feature is available if your organization uses Windows Defender Antivirus and Cloud-based protection is enabled. For more information, see Manage cloud-based protection.

- The Antimalware client version must be 4.18.1901.x or later.

- It is supported on machines with Windows 10, version 1703 or later, Windows server 2016 and 2019.

- To start blocking files, you first need to turn the Block or allow feature on in Settings.

- This feature is designed to prevent suspected malware (or potentially malicious files) from being downloaded from the web. It currently supports portable executable (PE) files, including .exe and .dll files. The coverage will be extended over time.

> [!IMPORTANT]
> The allow or block function cannot be done on files if the file's classification exists on the device's cache prior to the allow or block action.
> Trusted signed files will be treated differently. Defender for Endpoint is optimized to handle malicious files. Trying to block trusted signed files, in some cases, may have performance implications.
> Typically, file blocks are enforced within a couple of minutes but can take upwards of 30 minutes.

### Create an indicator for files from the settings page

1. In the navigation pane, select **Settings > Indicators**.

1. Select the File hash tab.

1. Select **Add indicator**.

1. Specify the following details:

    - Indicator - Specify the entity details and define the expiration of the indicator.

    - Action - Specify the action to be taken and provide a description.

    - Scope - Define the scope of the machine group.

1. Review the details in the Summary tab, then select **Save**.

### Create a contextual indicator from the file details page

One of the options when taking response actions on a file is adding an indicator for the file. When you add an indicator hash for a file, you can choose to raise an alert and block the file whenever a machine in your organization attempts to run it. Files automatically blocked by an indicator won't show up in the file's Action center, but the alerts will still be visible in the Alerts queue.

## Create indicators for IPs and URLs/domains

Defender for Endpoint can block what Microsoft deems as malicious IPs/URLs through Windows Defender SmartScreen for Microsoft browsers and through Network Protection for non-Microsoft browsers or calls made outside of a browser.

The threat intelligence data set for this has been managed by Microsoft.

By creating indicators for IPs and URLs or domains, you can now allow or block IPs, URLs, or domains based on your own threat intelligence. You can do this through the settings page or by machine groups if you deem certain groups to be more or less at risk than others.  Classless Inter-Domain Routing (CIDR) notation for IP addresses is not supported.

### Prerequisites

It's important to understand the following prerequisites prior to creating indicators for IPS, URLs, or domains:

- URL/IP allow and block relies on the Defender for Endpoint component Network Protection to be enabled in block mode. For more information on Network Protection and configuration instructions, see Enable network protection.

- The Antimalware client version must be 4.18.1906.x or later.

- Supported on machines on Windows 10, version 1709 or later.

- Ensure that *Custom network indicators* are enabled in Microsoft Defender Security Center > Settings > Advanced features. For more information, see Advanced features.

Only external IPs can be added to the indicator list. Indicators cannot be created for internal IPs. For web protection scenarios, we recommend using the built-in capabilities in Microsoft Edge. Microsoft Edge uses Network Protection to inspect network traffic and allows blocks for TCP, HTTP, and HTTPS (TLS). For all other processes, web protection scenarios use Network Protection for inspection and enforcement:

- IP is supported for all three protocols

- Only single IP addresses are supported (no CIDR blocks or IP ranges)

- Encrypted URLs (full path) can only be blocked on first party browsers

- Encrypted URLs (FQDN only) can be blocked outside of first party browsers

- Full URL path blocks can be applied on the domain level and all unencrypted URLs

There may be up to 2 hours of latency (usually less) between the time the action is taken and the URL and IP being blocked.

### Create an indicator for IPs, URLs, or domains from the settings page

1. In the navigation pane, select **Settings > Indicators**.

1. Select the IP addresses or URLs/Domains tab.

1. Select **Add item**.

1. Specify the following details:

    - Indicator - Specify the entity details and define the expiration of the indicator.

    - Action - Specify the action to be taken and provide a description.

    - Scope - Define the scope of the machine group.

1.  Review the details in the Summary tab, then select **Save**.

## Create indicators based on certificates

You can create indicators for certificates. Some common use cases include:

- Scenarios when you need to deploy blocking technologies, such as attack surface reduction rules and controlled folder access but need to allow behaviors from signed applications by adding the certificate in the allow list.

- Blocking the use of a specific signed application across your organization. By creating an indicator to block the certificate of the application, Windows Defender AV will prevent file executions (block and remediate), and the Automated Investigation and Remediation will behave the same.

### Prerequisites

It's important to understand the following requirements prior to creating indicators for certificates:

- This feature is available if your organization uses Windows Defender Antivirus and Cloud-based protection is enabled. For more information, see Manage cloud-based protection.

- The Antimalware client version must be 4.18.1901.x or later.

- Supported on machines on Windows 10, version 1703 or later, Windows server 2016 and 2019.

- The virus and threat protection definitions must be up to date.

- This feature currently supports entering .CER or .PEM file extensions.

A valid leaf certificate is a signing certificate with a valid certification path and must be chained to the Root Certificate Authority (CA) trusted by Microsoft. Alternatively, a custom (self-signed) certificate can be used as long as it's trusted by the client (Root CA certificate is installed under the Local Machine 'Trusted Root Certification Authorities').  The children or parents of the allow/block certificate IOCs are not included in the allow/block IoC functionality; only leaf certificates are supported.  Microsoft signed certificates cannot be blocked.

It can take up to 3 hours to create and remove a certificate IoC.

### Create an indicator for certificates from the settings page:

1. In the navigation pane, select **Settings > Indicators**.

1. Select the Certificate tab.

1. Select **Add indicator**.

1. Specify the following details:

    - Indicator - Specify the entity details and define the expiration of the indicator.

    - Action - Specify the action to be taken and provide a description.

    - Scope - Define the scope of the machine group.

1. Review the details in the Summary tab, then select **Save**.

## Import a list of IoCs

You can also choose to upload a CSV file that defines the attributes of indicators, the action to be taken, and other details.

Download the sample CSV to know the supported column attributes.

1. In the navigation pane, select **Settings > Indicators**.

1. Select the tab of the entity type you'd like to import indicators for.

1. Select **Import > Choose file**.

1. Select **Import**. Do this for all the files you'd like to import.

1.  Select **Done**.

The following table shows the supported parameters.

| Parameter| Type| Description|
| :--- | :--- | :--- |
| indicatorType| Enum| Type of the indicator. Possible values are: "FileSha1", "FileSha256", "IpAddress", "DomainName" and "Url". Required|
| indicatorValue| String| Identity of the Indicator entity. Required|
| action| Enum| The action that will be taken if the indicator will be discovered in the organization. Possible values are: "Alert", "AlertAndBlock", and "Allowed". Required|
| title| String| Indicator alert title. Required|
| description| String| Description of the indicator. Required|
| expirationTime| DateTimeOffset| The expiration time of the indicator in the following format YYYY-MM-DDTHH:MM:SS.0Z. Optional|
| severity| Enum| The severity of the indicator. Possible values are: "Informational", "Low", "Medium" and "High". Optional|
| recommendedActions| String| TI indicator alert recommended actions. Optional|
| rbacGroupNames| String| Comma-separated list of RBAC group names the indicator would be applied to. Optional|
| category| String| Category of the alert. Examples include: Execution and credential access. Optional|
| MITRE techniques| String| MITRE techniques code/id (comma separated). For more information, see Enterprise tactics. Optional It is recommended to add a value in category when a MITRE technique.|

