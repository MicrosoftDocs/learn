## Evaluating application portfolios with Defender for Cloud Apps

Microsoft Defender for Cloud Apps is a Cloud Access Security Broker (CASB) that supports various deployment modes including log collection, API connectors, and reverse proxy.

CASBs work by discovering and providing visibility into Shadow IT and app use, monitoring user activities for anomalous behaviors, controlling access to your resources, providing the ability to classify and prevent sensitive information leak, protecting against malicious actors, and assessing the compliance of cloud services.

## The Defender for Cloud Apps framework

-   **Discover and control the use of Shadow IT**: Identify the cloud apps, IaaS, and PaaS services used by your organization. Investigate usage patterns, assess the risk levels and business readiness of more than 31,000 SaaS apps against more than 80 risks. Start managing them to ensure security and compliance.
    
-   **Protect your sensitive information anywhere in the cloud**: Understand, classify, and protect the exposure of sensitive information at rest. Leverage out-of-the box policies and automated processes to apply controls in real time across all your cloud apps.
    
-   **Protect against cyberthreats and anomalies**: Detect unusual behavior across cloud apps to identify ransomware, compromised users or rogue applications, analyze high-risk usage and remediate automatically to limit the risk to your organization.
    
-   **Assess the compliance of your cloud apps**: Assess if your cloud apps meet relevant compliance requirements including regulatory compliance and industry standards. Prevent data leaks to non-compliant apps, and limit access to regulated data.
    


<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#architecture)
-->
## Architecture

Defender for Cloud Apps integrates visibility with your cloud by:

-   Using Cloud Discovery to map and identify your cloud environment and the cloud apps your organization is using.
-   Sanctioning and unsanctioning apps in your cloud.
-   Using easy-to-deploy app connectors that take advantage of provider APIs, for visibility and governance of apps that you connect to.
-   Using Conditional Access App Control protection to get real-time visibility and control over access and activities within your cloud apps.
-   Helping you have continuous control by setting, and then continually fine-tuning, policies.

![Defender for Cloud Apps architecture diagram.](../media/proxy-architecture.png)


<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#data-retention--compliance)
-->
### Data retention & compliance

For more information about Microsoft Defender for Cloud Apps data retention and compliance, see [Microsoft Defender for Cloud Apps data security and privacy](https://learn.microsoft.com/defender-cloud-apps/cas-compliance-trust).


<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#cloud-discovery)
-->
### Cloud Discovery

Cloud Discovery uses your traffic logs to dynamically discover and analyze the cloud apps that your organization is using. To create a snapshot report of your organization's cloud use, you can manually upload log files from your firewalls or proxies for analysis. To set up continuous reports, use Defender for Cloud Apps log collectors to periodically forward your logs.

For more information about Cloud Discovery, see [Set up Cloud Discovery](https://learn.microsoft.com/defender-cloud-apps/set-up-cloud-discovery).


<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#sanctioning-and-unsanctioning-an-app)
-->
### Sanctioning and unsanctioning an app

You can use Defender for Cloud Apps to sanction or unsanction apps in your organization by using the _cloud app catalog_. The Microsoft team of analysts has an extensive and continuously growing catalog of over 31,000 cloud apps that are ranked and scored based on industry standards. You can use the cloud app catalog to rate the risk for your cloud apps based on regulatory certifications, industry standards, and best practices. Then, customize the scores and weights of various parameters to your organization's needs. Based on these scores, Defender for Cloud Apps lets you know how risky an app is. Scoring is based on over 90 risk factors that might affect your environment.


<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#app-connectors)
-->
### App connectors

App connectors use APIs from cloud app providers to integrate the Defender for Cloud Apps cloud with other cloud apps. App connectors extend control and protection. They also give you access to information directly from cloud apps, for Defender for Cloud Apps analysis.

To connect an app and extend protection, the app administrator authorizes Defender for Cloud Apps to access the app. Then, Defender for Cloud Apps queries the app for activity logs, and it scans data, accounts, and cloud content. Defender for Cloud Apps can enforce policies, detects threats, and provides governance actions for resolving issues.

Defender for Cloud Apps uses the APIs provided by the cloud provider. Each app has its own framework and API limitations. Defender for Cloud Apps works with app providers on optimizing the use of APIs to ensure the best performance. Considering the various limitations that apps impose on APIs (such as throttling, API limits, and dynamic time-shifting API windows), the Defender for Cloud Apps engines utilize the allowed capacity. Some operations, like scanning all files in the tenant, require a large number of APIs, so they're spread over a longer period. Expect some policies to run for several hours or several days.


<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#conditional-access-app-control-protection)
-->
### Conditional Access App Control protection

Microsoft Defender for Cloud Apps Conditional Access App Control uses reverse proxy architecture to give you the tools you need to have real-time visibility and control over access to and activities performed within your cloud environment. With Conditional Access App Control, you can protect your organization:

-   Avoid data leaks by blocking downloads before they happen
-   Set rules that force data stored in and downloaded from the cloud to be protected with encryption
-   Gain visibility into unprotected endpoints so you can monitor what's being done on unmanaged devices
-   Control access from non-corporate networks or risky IP addresses
<!--
[](https://learn.microsoft.com/defender-cloud-apps/what-is-defender-for-cloud-apps#policy-control)
-->

### Policy control

You can use policies to define your users' behavior in the cloud. Use policies to detect risky behavior, violations, or suspicious data points and activities in your cloud environment. If needed, you can use policies to integrate remediation processes to achieve complete risk mitigation. Types of policies correlate to the different types of information you might want to gather about your cloud environment and the types of remediation actions you might take.