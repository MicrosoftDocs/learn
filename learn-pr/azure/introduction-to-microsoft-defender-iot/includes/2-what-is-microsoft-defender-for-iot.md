Microsoft Defender for IoT provides passive and agentless monitoring with asset discovery and security monitoring across business-critical network environments. Defender for IoT is a network-detection and response solution that's purpose-built for discovering and securing IoT/OT devices.

Defender for IoT uses IoT/OT-aware behavioral analytics and threat intelligence. It goes beyond signature-based solutions to catch modern threats. For example, zero-day malware and living-off-the-land tactics might be missed by static indicators of compromise, but caught by Defender for IoT.

Defender for IoT helps OT and IT teams automatically discover any unmanaged assets, connections, and critical vulnerabilities. Use Defender for IoT to detect anomalous or unauthorized behavior without affecting IoT/OT stability or performance.

## Discover your network

Do you have visibility throughout all the devices in your network? You can only protect devices of which you're aware. If we use our example of a building-management company, discovery might include devices such as elevators, parking lot entrances, cameras, and lighting systems.

The Defender for IoT sensor console provides a **Device inventory** page and a **Device map** page. They both provide drill-down data on each of the OT/IoT devices in your network and the connections between them.

- **Device inventory**: View device details like IP addresses and vendors, related protocols, firmware, and alerts related to the device.

    :::image type="content" source="../media/2-inventory-sensor.png" alt-text="Screenshot of the Device inventory from a sensor console." lightbox="../media/2-inventory-sensor.png":::

- **Device map**: View OT device connection paths, OT/IoT network topologies, and mapping across the Purdue model for ICS security.

For example, you might especially use the Device map when you implement a Zero Trust policy. You'll need to understand the connections between your devices to segment the devices onto their own networks and manage granular access.

## Manage network risks and vulnerabilities

After you've gained visibility and understanding of the devices in your network, you'll want to keep track of any of your devices' risks and vulnerabilities.

Defender for IoT risk-assessment reports are available from each sensor console. The reports help you identify vulnerabilities in your network. For example, vulnerabilities might include unauthorized devices, unpatched systems, unauthorized internet connections, and devices with unused open ports.

You can use reported data to prioritize activities when you mitigate risks on your most sensitive OT/IoT assets, including any devices whose compromise would have a major impact on your organization. Examples of impact might include safety incidents, loss of revenue, or theft of sensitive IP addresses.

## Stay up to date with the latest threat intelligence

As the security landscape changes and evolves, new risks and threats arise all the time. The Defender for IoT security research group, *Section 52*, is an OT/IoT-focused team of security researchers and data scientists. The Section 52 team consists of experts in threat hunting, malware reverse engineering, incident response, and data analysis.

Section 52 continuously curates threat intelligence packages built specifically for OT/IoT environments. The packages include the latest:

- Incidents of concern, such as malware signatures, malicious DNS queries, and malicious IP addresses.
- Common vulnerabilities and exposures to update vulnerability management reporting for Defender for IoT.
- Asset profiles that enhance the Defender for IoT asset discovery features.

You can keep current with the latest OT/IoT threats by keeping a Defender for IoT deployment up to date with the most recent threat-intelligence packages.

:::image type="content" source="../media/2-threat-intelligence.png" alt-text="Screenshot that shows how to update threat-intelligence packages in the Azure portal." lightbox="../media/2-threat-intelligence.png":::

## Manage your sites and sensors

While you can deploy Defender for IoT in a purely air-gapped, on-premises environment, you can also onboard on-premises device sensors from the cloud by using the Azure portal. You can use the **Getting started** page to register your sensors to a specific Azure subscription and resource. Deploying from the portal is helpful if you want to lower operational and maintenance requirements on your management systems, and if you have other Microsoft and Azure services deployed.

Onboarded sensors are visible on the Defender for IoT **Sites and sensors** page in the Azure portal. This page will look familiar to experienced Azure users, and it displays details for each site and sensor. You can use the **Sites and sensors** page to view each sensor's zone, connection status, and threat-intelligence update status. You can also use it to add more sensors to your deployment.

:::image type="content" source="../media/2-onboard-sensor.png" alt-text="Screenshot that shows the Sites and sensors page in the Azure portal." lightbox="../media/2-onboard-sensor.png":::

After you've onboarded sites and sensors to Defender for IoT, you can use operational alerts to monitor the events that occur in your network. Operational alerts are helpful if you have malfunctioning or misconfigured equipment. For example, with Defender for IoT constantly scanning your network, you can identify a misconfigured engineering workspace and quickly address the root causes for your issues.

:::image type="content" source="../media/sensor-alerts.png" alt-text="Screenshot that shows the Alerts page in the sensor console." lightbox="../media/sensor-alerts.png":::

## Integrate with other Microsoft and partner services

If you have other systems that are deployed for security monitoring and governance, you can integrate the OT/IoT security with your other systems to provide a seamless experience for your teams.

For example, you can integrate Defender for IoT directly with Microsoft Sentinel or partner services like Splunk, IBM QRadar, or ServiceNow.

Integrate Defender for IoT with other services to:

- Break down silos that slow communication between IT and OT teams and provide a common language across systems to help resolve issues quickly.
- Help you quickly address attacks that cross IT/OT boundaries, like TRITON.
- Use the workflows, training, and tools you've spent years building for your SOC team and apply them to IoT/OT security.

### Integrate with Microsoft Sentinel

Integrating Defender for IoT and Microsoft Sentinel helps SOC teams to detect and respond faster during the entire attack timeline. Integrating Defender for IoT and Microsoft Sentinel can enhance the communication, processes, and response time for security analysts and OT personnel. Microsoft Sentinel workbooks, analytics rules, and security operation and response playbooks help you monitor and respond to OT threats detected in Defender for IoT.

Install the Defender for IoT data connector in your Microsoft Sentinel workspace. The Defender for IoT data connector comes with the following built-in content:

- **Workbooks**: Use Microsoft Sentinel workbooks to visualize and monitor your Defender for IoT data from Microsoft Sentinel. Workbooks provide guided investigations for OT entities based on open incidents, alert notifications, and activities for OT assets.
- **Analytics rule templates**: Use Microsoft Sentinel analytics rule templates to configure incident triggers for alerts generated by Defender for IoT from OT traffic.

You can then use Microsoft Sentinel playbooks to create automated remediation actions to run as a routine to help automate and orchestrate threat response. You can run playbooks manually or set them to run automatically in response to specific alerts or incidents. Use an analytics rule or an automation rule as a trigger.

:::image type="content" source="../media/2-sentinel-data-connector.png" alt-text="Screenshot that shows the Defender for IoT data connector in Microsoft Sentinel." lightbox="../media/2-sentinel-data-connector.png":::