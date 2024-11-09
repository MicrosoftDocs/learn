Microsoft Defender for Endpoint is a platform designed to help enterprise networks protect endpoints including laptops, phones, tablets, PCs, access points, routers, and firewalls. It does so by preventing, detecting, investigating, and responding to advanced threats. Microsoft Defender for Endpoint embeds technology built into Windows 10 and beyond, and Microsoft cloud services. This technology includes:

- Endpoint behavioral sensors that are embedded in Windows 10 and beyond that collect and process signals from the operating system.
- Cloud security analytics that translate behavioral signals into insights, detections, and recommended responses to advanced threats.
- Threat intelligence that enables Defender for Endpoint to identify attacker tools, techniques, and procedures, and generate alerts when they're observed in collected sensor data.

:::image type="content" source="../media/defender-for-endpoint-inline.png" lightbox="../media/defender-for-endpoint-expanded.png" alt-text="Diagram showing the components of Microsoft Defender Endpoint.":::

Microsoft Defender for Endpoint includes:

- **Core Defender Vulnerability Management**: Built-in core vulnerability management capabilities use a risk-based approach to the discovery, assessment, prioritization, and remediation of endpoint vulnerabilities and misconfigurations.
- **Attack surface reduction**: The attack surface reduction set of capabilities provides the first layer of defense in the stack. By ensuring configuration settings are properly set and exploit mitigation techniques are applied, the capabilities resist attacks and exploitation. This set of capabilities also includes network protection and web protection, which regulate access to malicious IP addresses, domains, and URLs.
- **Next generation protection**:  Next-generation protection was designed to catch all types of emerging threats. In addition to Microsoft Defender Antivirus, your next-generation protection services include the following capabilities:
  - Behavior-based, heuristic, and real-time antivirus protection.
  - Cloud-delivered protection, which includes near-instant detection and blocking of new and emerging threats.
  - Dedicated protection and product updates, which include updates related to keeping Microsoft Defender Antivirus up to date.
- **Endpoint detection and response**: Provides advanced attack detections that are near real time and actionable. Security analysts can prioritize alerts, see the full scope of a breach, and take response actions to remediate threats.
- **Automated investigation and remediation (AIR)**: The technology in automated investigation uses various inspection algorithms and is based on processes that are used by security analysts. AIR capabilities are designed to examine alerts and take immediate action to resolve breaches. AIR capabilities significantly reduce alert volume, allowing security operations to focus on more sophisticated threats and other high-value initiatives.
- **Microsoft Secure Score for Devices**: Microsoft Secure Score for Devices helps you dynamically assess the security state of your enterprise network, identify unprotected systems, and take recommended actions to improve the overall security of your organization.
- **Microsoft Threat Experts**: Microsoft Threat Experts is a managed threat hunting service that provides proactive hunting, prioritization, and additional context and insights that further empower Security operation centers (SOCs) to identify and respond to threats quickly and accurately.
- **Management and APIs**: Defender for Endpoint offers an API model designed to expose entities and capabilities through a standard Microsoft Entra ID-based authentication and authorization model.

Microsoft Defender for Endpoint also integrates with various components in the Microsoft Defender suite, and with other Microsoft solutions including Intune and Microsoft Defender for Cloud.

Microsoft Defender for Endpoint is available in two plans, Defender for Endpoint Plan 1 and Plan 2. Information on what's included in each plan is detailed in the Compare Microsoft Defender for Endpoint plans document linked in the summary and resources unit.

### Microsoft Defender for Endpoints in the Microsoft Defender portal

Microsoft Defender for Endpoints is experienced through the Microsoft Defender portal. The Defender portal is the home for monitoring and managing security across your Microsoft identities, data, devices, apps, and infrastructure, allowing security admins to perform their security tasks, in one location.

The Endpoints node on the left navigation panel of the Microsoft Defender portal includes the following:

- Vulnerability management - Manage vulnerabilities and other risk sources on devices. From here you can access the vulnerability management dashboard, recommendations, remediation, weaknesses, and more. More details on Microsoft Defender Vulnerability Management are in a subsequent unit of this module.
- Partners and APIs - From here you can select Connected applications and API explorer.
  - Connected applications - The Connected applications page provides information about the Microsoft Entra applications (SaaS applications that are preintegrated with Microsoft Entra ID) connected to Microsoft Defender for Endpoint in your organization. 
  - API Explorer - Defender for Endpoint exposes much of its data and actions through a set of programmatic APIs. Those APIs enable you to automate workflows and innovate based on Defender for Endpoint capabilities. The Microsoft Defender for Endpoint API Explorer is a tool that helps you explore various Defender for Endpoint APIs interactively. You can use the API explorer to test Microsoft Defender for Endpoint capabilities by running sample queries or creating and testing your own API query.
- Configuration management - Define endpoint policies and track deployment.

# [Vulnerability management dashboard](#tab/vulnerability-management-dashboard)
:::image type="content" source="../media/vulnerability-management-dashboard-v2.png" lightbox="../media/vulnerability-management-dashboard-v2.png" alt-text="A screenshot of the vulnerability dashboard page in the Microsoft Defender portal.":::

# [API explorer](#tab/api-explorer)
:::image type="content" source="../media/api-explorer-v2.png" lightbox="../media/api-explorer-v2.png" alt-text="A screenshot of the API explorer page in the Microsoft Defender portal.":::

# [Configuration management dashboard](#tab/configuration-management-dashboard)
:::image type="content" source="../media/configuration-management-dashboard-v2.png" lightbox="../media/configuration-management-dashboard-v2.png" alt-text="A screenshot of the configuration management dashboard page in the Microsoft Defender portal.":::

---

Settings, permissions, incidents and alerts, reports and other features are also available through the Microsoft Defender portal. More information is covered in the unit, "Describe the Microsoft Defender portal," included in this module.
