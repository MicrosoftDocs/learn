
In order to use these tactics like proactive and reactive detection to manage threats, you should have a central console to allow SOC administrators to detect, investigate, remediate, hunt, utilize threat intelligence, understand known vulnerabilities, lean on threat experts and block threats across any of the six pillars. The tools needed to support these phases work best if converged into a single workflow, providing a seamless experience that increases the effectiveness of the SOC analyst.

Security Operation Centers often deploy a combination of SIEM and SOAR technologies to collect, detect, investigate, and respond to threats. Microsoft offers Microsoft Sentinel as its SIEM-as-a-service offering. Microsoft Sentinel ingests all Microsoft Defender for Identity and third-party data.

Microsoft 365 Defender, a key feed into Microsoft Sentinel, provides a unified enterprise defense suite that brings context-aware protection, detection, and response across all Microsoft 365 components. By being context-aware and coordinated, customers using Microsoft 365 can gain visibility and protection across endpoints, collaboration tools, identities, and applications.

It is through this hierarchy that we enable our customers to maximize their focus. Through context-awareness and automated remediation, Microsoft 365 Defender can detect and stop many threats without adding additional alert-fatigue to already overloaded SOC personnel. Advanced hunting inside of Microsoft 365 Defender brings that context to the hunt to focus on many key attack points. And hunting and orchestration across the entire ecosystem through Microsoft Sentinel provides the ability to gain the right visibility into all aspects of a heterogeneous environment, all while minimizing the cognitive overload of the operator.

:::image type="content" source="../media/modern-security-operation.png" alt-text="Diagram showing technology capabilities for modern security operations." lightbox="../media/modern-security-operation.png":::

## Visibility, automation, and orchestration Zero Trust deployment objectives

When implementing an end-to-end Zero Trust framework for visibility, automation, and orchestration, we recommend you focus on these deployment objectives:
* **Establish visibility**
* **Enable automation**
* **Enable additional protection and detection controls**

### Establish visibility

The first step is to establish visibility by enabling [Microsoft 365 Defender](https://www.microsoft.com/security/business/threat-protection/integrated-threat-protection).

Follow these steps:

1.  Sign up for one of the Microsoft 365 Defender workloads.
2.  Enable the workloads and establish connectivity.
3.  Configure detection on your devices and infrastructure to bring immediate visibility into activities going on in the environment. This gives you the all-important "dial tone" to start the flow of critical data.
4.  Enable Microsoft 365 Defender to gain cross-workload visibility and incident detection.

### Enable automation

The next key step, once you have established visibility, is to enable automation.

#### Automated investigations and remediation

With Microsoft 365 Defender, we have automated both investigations and remediation, which essentially provides an extra Tier 1 SOC analysis.

[Automated Investigation and Remediation](/microsoft-365/security/defender/m365d-autoir) (AIR) can be enabled gradually, so that you can develop a comfort level with the actions that are taken.

Follow these steps:

1.  Enable AIR for a test group.
2.  Analyze the investigation steps and response actions.
3.  Gradually transition to automatic approval for all devices to reduce the time to detection and response.

#### Link Microsoft Purview Data Connectors and relevant third-party products to Microsoft Sentinel

In order to gain visibility into the incidents that result from deploying a Zero Trust model, it is important to connect Microsoft 365 Defender, other data connectors, and relevant third party products to [Microsoft Sentinel](https://azure.microsoft.com/services/azure-sentinel/) in order to provide a centralized platform for incident investigation and response.  
  
As part of the data connection process, relevant analytics can be enabled to trigger incidents and workbooks can be created for a graphical representation of the data over time.

#### Link threat intelligence data to Microsoft Sentinel

Although machine learning and fusion analytics are provided out of the box, it is also beneficial to ingest threat intelligence data into Microsoft Sentinel to help identify events that relate to known bad entities.

### Enable additional protection and detection controls

Enabling additional controls improves the signal coming in to Microsoft 365 Defender and Sentinel to improve your visibility and ability to orchestrate responses.

[Attack surface reduction](/windows/security/threat-protection/microsoft-defender-atp/overview-attack-surface-reduction) controls represent one such opportunity. These protective controls not only block certain activities that are most associated with malware, but also give into attempts to use specific approaches, which can help to detect adversaries leveraging these techniques earlier in the process.

## Security operations best practices for SIEM and SOAR 

Below are operational best practices for protecting your data, applications, and other assets in Azure. The best practices are based on a consensus, and they work with current Azure platform capabilities and feature sets.

### Receive incident notifications from Microsoft 

Be sure security operations teams receive Azure incident notifications from Microsoft. An incident notification lets a security team know when there are compromised Azure resources so they can quickly respond to and remediate potential security risks. 

The Azure enrollment portal admin contact information includes details that notify security operations. Contact information is an email address and phone number. 

### Monitor storage services for unexpected changes in behavior 

Diagnosing and troubleshooting issues in a distributed application hosted in a cloud environment can be more complex than in traditional environments. Applications can be deployed in a PaaS or IaaS infrastructure, on-premises, on a mobile device, or some combination of these environments. An application's network traffic might traverse public and private networks using multiple storage technologies. 

Continuously monitor the storage services of application uses for any unexpected changes in behavior (such as slower response times). Use logging to collect more detailed data and analyze a problem in depth. The diagnostics information obtained from monitoring and logging helps determine the root cause of the issue that an application encountered. From there, troubleshoot the issue and determine the appropriate steps to remediate it. 

[Azure Storage Analytics](/azure/storage/common/storage-analytics) performs logging and provides metrics data for an Azure storage account. We recommend using this data to trace requests, analyze usage trends, and diagnose issues with storage accounts. 

### Prevent, detect, and respond to threats 

Here are best practices for preventing, detecting, and responding to threats: 

- **Increase the speed and scalability of your SIEM solution by using a cloud-based SIEM** - Investigate the features and capabilities of [Microsoft Sentinel](/azure/sentinel/overview) and compare them with the capabilities of what you're currently using on-premises. Consider adopting Microsoft Sentinel if it meets your organization's SIEM requirements. 
- **Find the most serious security vulnerabilities to prioritize investigating** - Review [Azure secure score](/azure/security-center/secure-score-security-controls) to see the recommendations from the Azure policies and initiatives built into Microsoft Defender for Cloud. These recommendations help address top risks like security updates, endpoint protection, encryption, security configurations, missing WAF, internet-connected VMs, and many more. The secure score, based on Center for Internet Security (CIS) controls, lets one benchmark an organization's Azure security against external sources. External validation helps validate and enrich a security strategy. 
- **Monitor the security posture of machines, networks, storage and data services, and applications to discover and prioritize potential security issues** - Follow the [security recommendations](/azure/security-center/security-center-recommendations) in Defender for Cloud starting with the highest priority items. 
- **Integrate Defender for Cloud alerts into a security information and event management (SIEM) solution** - Most organizations with a SIEM use it as a central clearinghouse for security alerts that require an analyst response. Processed events produced by Defender for Cloud are published to the Azure Activity Log, one of the logs available through Azure Monitor. Azure Monitor offers a consolidated pipeline for routing any of your monitoring data into a SIEM tool. See [Stream alerts to a SIEM, SOAR, or IT Service Management solution](/azure/security-center/export-to-siem) for instructions. If using Microsoft Sentinel, see [Connect Microsoft Defender for Cloud](/azure/sentinel/connect-azure-security-center). 
- **Integrate Azure logs with your SIEM** - [Use Azure Monitor to gather and export data](/azure/azure-monitor/overview#integrate-and-export-data). This practice is critical for enabling security incident investigation, and online log retention is limited. If using Microsoft Sentinel, see [Connect data sources](/azure/sentinel/connect-data-sources). 
- **Speed up investigation and hunting processes and reduce false positives by integrating Endpoint Detection and Response (EDR) capabilities into an attack investigation** - [Enable the Microsoft Defender for Endpoint integration](/azure/security-center/security-center-wdatp#enable-the-microsoft-defender-for-endpoint-integration) via a Defender for Cloud security policy. Consider using Microsoft Sentinel for threat hunting and incident response. 

### Monitor end-to-end scenario-based network monitoring

Customers build an end-to-end network in Azure by combining network resources like a virtual network, ExpressRoute, Application Gateway, and load balancers. Monitoring is available on each of the network resources.

[Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) is a regional service. Use its diagnostic and visualization tools to monitor and diagnose conditions at a network scenario level in, to, and from Azure.

The following are best practices for network monitoring and available tools.

- **Automate remote network monitoring with packet capture** - Monitor and diagnose networking issues without logging in to your VMs using Network Watcher. Trigger [packet capture](/azure/network-watcher/network-watcher-alert-triggered-packet-capture) by setting alerts and gaining access to real-time performance information at the packet level. Better diagnoses can be investigated in detail when issues are seen. 
- **Gain insight into network traffic by using flow logs** - Build a deeper understanding of network traffic patterns [using network security group flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). Information in flow logs helps gather data for compliance, auditing, and monitoring a network security profile. 
- **Diagnose VPN connectivity issues** - Use Network Watcher to [diagnose your most common VPN Gateway and connection issues](/azure/network-watcher/network-watcher-diagnose-on-premises-connectivity). You can not only identify the issue but also use detailed logs to further investigate.

### Monitor Azure AD risk reports

Most security breaches occur when attackers gain access to an environment by stealing a user's identity. Discovering compromised identities is no easy task. Azure AD uses adaptive machine learning algorithms and heuristics to detect suspicious actions related to user accounts. Each detected suspicious action is stored in a record called risk detection. Risk detections are recorded in Azure AD security reports. For more information, read about the users at risk security report and the risky sign-ins security report. 

**Monitor for suspicious actions related to your user accounts** - Monitor for [users at risk](/azure/active-directory/identity-protection/overview-identity-protection) and [risky sign-ins](/azure/active-directory/identity-protection/overview-identity-protection) by using Azure AD security reports.
