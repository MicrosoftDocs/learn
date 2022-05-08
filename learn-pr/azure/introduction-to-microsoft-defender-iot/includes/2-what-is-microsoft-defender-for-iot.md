Microsoft Defender for IoT provides passive and agentless monitoring, with asset discovery and security monitoring across business-critical network environments. Defender for IoT is a network detection and response (NDR) solution, purpose-built for discovering and securing IoT/OT devices.

Defender for IoT uses IoT/OT-aware behavioral analytics and threat intelligence, and goes beyond signature-based solutions to catch modern threats. For example, zero-day malware and living-off-the-land tactics may be missed by static indicators of compromise (IOCs), but caught by Defender for IoT.

Defender for IoT helps OT and IT teams automatically discover any unmanaged assets, connections, and critical vulnerabilities. Use Defender for IoT to detect anomalous or unauthorized behavior without impacting IoT/OT stability or performance.

## Discover your network

Do you have visibility throughout all the devices in your network? You can only protect devices that you're aware of. If we use our example of a building management company, discovery might include devices such as elevators, parking lot entrances, cameras, lighting systems, and more.

Defender for IoT's sensor console provides both a **Device inventory** page and a **Device map** page, which provide drill-down data on each of the OT/IoT devices in your network and the connections between them.

- From the **Device inventory**, view device details like IP addresses and vendors, related protocols, firmware, alerts related to the device, and more.
- From the **Device map**, view OT device connection paths, OT/IoT network topologies, and mapping across the Purdue model for ICS security.

For example, you might especially use the Device map when implementing a Zero Trust policy. You'll need to understand the connections between your devices to segment the devices onto their own networks and manage granular access.


## Manage network risks and vulnerabilities

After you've gained visibility and understanding of the devices in your network, you'll want to keep track of any of your devices' risks and vulnerabilities.

Defender for IoT's risk assessment reports, available from each sensor console, help you identify vulnerabilities in your network. For example, vulnerabilities might include unauthorized devices, unpatched systems, unauthorized internet connections, and devices with unused open ports.

Use reported data to prioritize activities when mitigating risks on your most sensitive OT/IoT assets, including any devices whose compromise would have a major impact on your organization. Examples of impact might include safety incidents, loss of revenue, or theft of sensitive IP addresses.

## Stay up to date with the latest threat intelligence

As the security landscape changes and evolves, new risks and threats arise all the time. Defender for IoT's security research group, *Section 52* is an OT/IoT-focused team of security researchers and data scientists. The Section 52 team consists of experts in threat hunting, malware reverse engineering, incident response, and data analysis.

Section 52 continuously curates threat intelligence (TI) packages built specifically for OT/IoT environments, and include the latest:

- Incidents of concern (IOCs), such as malware signatures, malicious DNS queries, and malicious IP addresses
- Common Vulnerabilities and Exposures (CVEs), to update Defender for IoT's vulnerability management reporting
- Asset profiles that enhance the Defender for IoT asset discovery features

You can keep current with the latest OT/IoT threats by keeping a Defender for IoT deployment up-to-date with the most recent TI packages.

## Manage your sites and sensors

While you can deploy Defender for IoT in a purely air-gapped, on-premises environment, you can also onboard on-premises device sensors from the cloud using the Azure portal. Use the **Getting started** page to register your sensors to a specific Azure subscription and resource. Deploying from the portal is especially helpful for customers looking to lower operational and maintenance requirements on their management systems, and who may already have other Microsoft and Azure services deployed.

Onboarded sensors are visible on the Defender for IoT **Site and sensors** page in the Azure portal. The **Site and sensors** page will look familiar to experienced Azure users and displays details for each site and sensor. Use the **Site and sensors** page to view each sensor's zone, connection status, threat intelligence update status, and to add more sensors to your deployment.

Once you have sites and sensors onboarded to Defender for IoT, either via the cloud or on-premises, use operational alerts to monitor the events occurring in your network. Operational alerts are especially helpful if you have malfunctioning or misconfigured equipment. For example, with Defender for IoT constantly scanning your network, you'll be able to identify a misconfigured engineering workspace and quickly address the root causes for your issues.

## Integrate with other Microsoft and partner services

If you have other systems that are deployed for security monitoring and governance, you can integrate the OT/IoT security with your other systems to provide a seamless experience for your teams.

For example, you can integrate Defender for IoT directly with Microsoft Sentinel, or partner services like Splunk, IBM QRadar, or ServiceNow.

Integrate Defender for IoT with other services to:

- Break down silos that slow communication between IT and OT teams, providing a common language across systems to help resolve issues quickly.

- Helps you to quickly address attacks that cross IT/OT boundaries, like TRITON

- Use the workflows, training, and tools you've spent years building for your SOC team and apply them to IoT/OT security.

### Integrate with Microsoft Sentinel

Integrating Defender for IoT and Microsoft Sentinel helps SOC teams to detect and respond faster during the entire attack timeline. The Defender for IoT and Microsoft Sentinel integration can enhance the communication, processes, and response time for both security analysts and OT personnel. Microsoft Sentinel workbooks, analytics rules, and Security operation and response (SOAR) playbooks help you monitor and respond to OT threats detected in Defender for IoT.

The following built-in security content is available with the **IoT OT Threat Monitoring with Defender for IoT** solution, which you can deploy in your Microsoft Sentinel workspace:

- **Workbooks**.   Use Microsoft Sentinel workbooks to visualize and monitor your Defender for IoT data from Microsoft Sentinel. Workbooks provide guided investigations for OT entities based on open incidents, alert notifications, and activities for OT assets.

    The workbooks also provide a hunting experience across the MITRE ATT&CK® framework for ICS, and are designed to enable analysts, security engineers, and MSSPs to gain situational awareness of OT security posture.

- **Analytics rules**. Use built-in Microsoft Sentinel analytics rules for OT networks to trigger incidents for alerts generated by Defender for IoT.

- **Playbooks**.   Microsoft Sentinel playbooks are collections of automated remediation actions that you can run as a routine to help automate and orchestrate threat response. You can run playbooks manually or set them to run automatically in response to specific alerts or incidents, when triggered by an analytics rule or an automation rule.

    For example, customers can use SOAR playbooks to:

    - **Open an asset ticket in ServiceNow** when a new asset is detected, such as a new engineering workstation. From a security perspective, such a workstation might be an unauthorized device that can be used by adversaries to reprogram PLCs.

    - **Send an email to relevant stakeholders** when suspicious activity is detected, such as unplanned PLC reprogramming. You might have an email sent to OT personnel, such as a control engineer responsible on the related production line.

