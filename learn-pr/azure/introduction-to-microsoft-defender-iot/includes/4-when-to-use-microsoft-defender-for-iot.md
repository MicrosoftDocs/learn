Now that you know what Microsoft Defender for IoT is, let's discuss the scenarios best suited for this service.

## When to choose Defender for IoT

The following table describes business needs and applicable scenarios where Defender for IoT might be a good choice for an organization.

|Business need  |Description  |
|---------|---------|
|Device discovery     | The Defender for IoT sensor console provides a **Device inventory** page and a **Device map** page. The pages provide drill-down data on each of the OT/IoT devices in your network and the connections among them.      |
|Manage network risks and vulnerabilities     |  Defender for IoT *risk assessment reports* are available from each sensor console. These reports help you identify vulnerabilities in your network. <br><br>For example, reports can include unauthorized devices, unpatched systems, unauthorized internet connections, and devices with unused open ports.       |
|Keep up to date with recent threat intelligence     |  Make sure that sensors in your network have the most recent *threat intelligence (TI) packages* installed. <br><br>TI packages are provided by the Defender for IoT research team. They include recent incidents of concern, common vulnerabilities and exposures, and new asset profiles.|
|Manage sites and sensors     | In fully on-premises environments, manage OT sensors in bulk by using an on-premises management console. <br><br>You can also onboard OT sensors to the cloud and manage them from the Azure portal on the **Sites and sensors** page.       |
|Run guided investigations for OT entities     |SOC teams can use the Microsoft Sentinel workbooks provided with the IoT OT Threat Monitoring with Defender for IoT solution. Use them to run investigations based on open incidents, alert notifications, and activities for OT assets. <br><br>The workbooks also provide a hunting experience across the MITRE ATT&CK® framework for ICS. They're designed to enable analysts, security engineers, and MSSPs to gain situational awareness of OT security posture.         |
|Automate remediation actions     |    Use the Microsoft Sentinel playbooks provided with the IoT OT Threat Monitoring with Defender for IoT solution to run automated remediation actions as a routine.   |

## When not to choose Defender for IoT

Defender for IoT isn't suited for devices that aren't connected to a network. Devices must be connected to a network to be discovered by Defender for IoT sensors and have their traffic analyzed for security risks.

## Is Defender for IoT the right choice?

Let's reconsider our smart building-management company from the first unit. The key points from that scenario were:

- Users include security and operations teams. Officers from both teams need access to security data.
- Users must be able to view all equipment running on the network and communication paths between subsystems.
- Users must be alerted about unauthorized actions or unplanned activities that occur on the network.
- Users need tools to respond to immediate threats and carry out ongoing operational and network-security tasks.

Defender for IoT can support all these scenarios and would be a good choice for this organization.
