Cloud services increase flexibility for employees and IT, but introduce new challenges and complexities for keeping organizations secure. To get the full benefit of cloud apps and services, you must balance access support with maintaining control and helping protect critical data. Given the increasing number of cybersecurity attacks and compliance requirements, it's crucial to gain visibility and control of data in cloud applications.

This unit describes Microsoft Defender for Cloud Apps, a user-based subscription service that provides visibility and control over data and sophisticated analytics to identify and combat cyberthreats across cloud services. Defender for Cloud Apps identifies and combats threats by operating as an intermediary, or *Cloud Access Security Broker (CASB)*, between a cloud user and the cloud provider. CASBs help oversee and control activities and information across cloud (SaaS) apps and infrastructure-as-a-service (IaaS) services. CASB capabilities include visibility into cloud app usage, Shadow IT discovery, information protection and compliance assessment, and protection against app-based threats.

Defender for Cloud Apps helps businesses identify sensitive data across cloud apps, monitor when it's shared with risky environments, and take necessary governance actions by classifying, labeling, and protecting data. Defender for Cloud Apps is part of Microsoft 365 Defender, which correlates signals from across the Microsoft Defender suite to provide incident-level detection, investigation, and response capabilities. Defender for Cloud Apps can show you the full picture of risks to your environment from SaaS app usage and resources, and give you control of what apps you use and when.

## Defender for Cloud Apps architecture

The following diagram shows Defender for Cloud Apps capabilities and funtionality:

:::image type="content" source="../media/6-proxy-architecture.png" alt-text="Diagram that shows Defender for Cloud Apps architecture." border="false":::

## Defender for Cloud Apps capabilities

Defender for Cloud Apps integrates visibility with your cloud by:

- Using Cloud Discovery to map and identify your cloud environment and the cloud apps your organization is using.
- Using easy-to-deploy app connectors that take advantage of provider APIs, for visibility and governance of apps that you connect to.
- Sanctioning and unsanctioning apps in your cloud.
- Using Conditional Access App Control protection to get real-time visibility and control over access and activities within your cloud apps.
- Helping you set and continually fine-tune policies.

### App identification

Defender for Cloud apps uses data based on an assessment of network traffic and an extensive app catalog to identify apps accessed by users across your organization. Defender for Cloud Apps provides details about which apps are being used both on and off your corporate network. Defender for Cloud Apps detects all your cloud services and also identifies all the users and third-party apps that are able to sign in.

Cloud Discovery uses traffic logs to dynamically discover and analyze the cloud apps your organization is using. To create a snapshot report of your organization's cloud use, you can manually upload log files from your firewalls or proxies for analysis. To set up continuous reports, use Defender for Cloud Apps log collectors to periodically forward your logs.

### Shadow IT discovery

To discover and control the use of Shadow IT, Defender for Cloud Apps identifies the cloud apps, IaaS, and platform-as-a-service (PaaS) services that your organization uses. Some of these apps and services might not even be known or controlled by your IT department. Defender for Cloud Apps integrates with Microsoft Defender for Endpoint, a unified endpoint security platform for protection, detection, investigation, and response, to enhance the discovery of Shadow IT in your organization.

### Risk assessment

Defender for Cloud Apps investigates usage patterns, assigns each app a risk ranking, and assesses the risk levels and business readiness of more than 16,000 SaaS apps against more than 90 risks. This evaluation of discovered apps helps you sort through the apps and assess your organization's security and compliance posture.

You can use Defender for Cloud Apps to sanction or unsanction apps in your organization by using the *Cloud app catalog*. The Cloud app catalog is an extensive and continuously growing catalog of over 16,000 cloud apps that are ranked and scored based on industry standards. The Cloud app catalog rates the risk for your cloud apps based on regulatory certifications, industry standards, and best practices.

You can customize the scores and weights of various parameters to your organization's needs. Based on these scores, Defender for Cloud Apps lets you know how risky an app is.

### Continuous threat protection

Defender for Cloud Apps lets you set policies that monitor apps around the clock. If anomalous behaviors occur, like unusual usage spikes, you're automatically alerted and guided to action. Defender for Cloud Apps helps protect against cyberthreats and anomalies by analyzing high-risk usage and detecting unusual behavior across cloud apps. Defender for Cloud Apps can identify ransomware, compromised users, or rogue applications, and remediate automatically to limit the risk to your organization.

### Information protection

Defender for Cloud Apps helps protect your sensitive information anywhere in the cloud. Use Defender for Cloud Apps to understand, classify, and help protect against the exposure of sensitive information at rest. Leverage out-of-the-box policies and automated processes to apply controls in real time across all your cloud apps.

### Compliance

Defender for Cloud Apps helps you assess the compliance of your cloud apps. Determine whether your cloud apps meet relevant compliance requirements, including regulatory compliance and industry standards. Prevent data leaks to noncompliant apps, and limit access to regulated data.

### SaaS Security Posture Management (SSPM)

While optimizing an organization's security posture is a critical focus area, security teams are challenged by needing to research best practices for each app individually. Defender for Cloud Apps helps you by surfacing misconfigurations and recommending specific actions to strengthen the security posture for each connected app. Recommendations are based on industry standards like the Center for Internet Security and follow best practices set by the specific app provider.

SaaS Security Posture Management (SSPM) enables security teams to improve an organization's security posture. Defender for Cloud Apps automatically provides SSPM data in Microsoft Secure Score for any supported and connected app.

### Continuous threat protection with eXtended detection and response (XDR)

While cloud apps continue to be a target for adversaries trying to exfiltrate corporate data, sophisticated attacks often cross modalities. These attacks move laterally from email as the most common entry point, to compromise endpoints and identities, before ultimately gaining access to in-app data. Advanced threat protection, as part of Microsoft's extended detection and response (XDR) solution, enables powerful correlation of signal and visibility across the kill chain of advanced attacks.

Defender for Cloud Apps offers built-in adaptive access control (AAC), provides user and entity behavior analysis (UEBA), and helps you mitigate malware. Defender for Cloud Apps is also integrated directly into Microsoft 365 Defender, correlating XDR signals from the Microsoft Defender suite and providing incident-level detection, investigation, and powerful response capabilities. Integrating SaaS security into Microsoft's XDR experience gives Security Operations Center (SOC) teams full kill chain visibility and improves operational efficiency and effectiveness.

### App-to-app protection with app governance

OAuth apps often behave unnoticed, while still having extensive permissions to access data in other apps on behalf of an employee, making OAuth apps susceptible to compromise. App-to-app protection extends the core threat scenarios to OAuth-enabled apps that have permissions and privileges to access critical data and resources. 

Defender for Cloud Apps closes the gap on OAuth app security, helping you protect inter-app data exchange with application governance. You can watch for unused apps and monitor both current and expired credentials to govern the apps used in your organization and maintain app hygiene.

## Microsoft Defender for Cloud Apps and Office 365 Cloud App Security

Microsoft Defender for Cloud Apps is a comprehensive cross-SaaS solution that brings deep visibility, strong data controls, and enhanced threat protection to your cloud apps. With this service, you can gain visibility into Shadow IT by discovering cloud apps in use. You can control and protect data in the apps once you sanction them to the service.

Office 365 Cloud App Security is a subset of Microsoft Defender for Cloud Apps that provides enhanced visibility and control for Office 365. Office 365 Cloud App Security includes threat detection based on user activity logs, discovery of Shadow IT for apps that have similar functionality to Office 365 offerings, Office 365 permission control, and access and session controls. Office 365 Cloud App Security has access to all of the features of Microsoft Defender for Cloud Apps, but supports only the Office 365 app connector.

You access Office 365 Cloud App Security through the same portal as Microsoft Defender for Cloud Apps. Depending on your Office 365 license, you have access either to Office 365 Cloud App Security or to the entire Defender for Cloud Apps solution.

