Microsoft Defender for IoT is a component within Microsoft Defender for Cloud's integrated cloud workload protection (CWP), which brings advanced, intelligent, protection of your Azure and hybrid resources and workloads.

## Microsoft Defender for IoT options

Microsoft Defender for IoT offers two sets of capabilities to fit your environment's needs, one for "end-user organizations" and one for "device builders".

For end-user organizations with IoT/OT environments, Microsoft Defender for IoT delivers agentless, network-layer monitoring that:

 -  Can be rapidly deployed.
 -  Integrates smoothly with diverse industrial equipment and SOC tools.
 -  Can be deployed fully on-premises or in Azure-connected and hybrid environments.

For IoT device builders and IoT solutions that are built around Azure IoT Hub, Microsoft Defender for IoT also offers a lightweight micro agent that supports standard IoT operating systems, such as Linux and RTOS. The Microsoft Defender device builder agent helps ensure that security is built into your IoT/OT initiatives from the edge to the cloud. It includes source code for flexible, customizable deployment.

The agent-based option of Microsoft Defender for IoT includes the following components:

 -  IoT Hub integration.
 -  Device agents (optional).
 -  Send security message SDK.
 -  Analytics pipeline.

## Microsoft Defender for IoT agent-based solutions

The Microsoft Defender for IoT agent-based solution is implemented using the following architecture:

:::image type="content" source="../media/m10-l02-defender-iot-security-architecture-37a94c17.png" alt-text="Diagram that shows Microsoft Defender for IoT micro agent within a security architecture.":::


> [!NOTE]
> Microsoft Sentinel enables organizations to quickly detect multistage attacks that often cross IT and OT boundaries. Additionally, Defender for IoT’s integration with Microsoft Sentinel's security orchestration, automation, and response (SOAR) capabilities enable automated response and prevention using built-in OT-optimized playbooks. We do not explore the details of Microsoft Sentinel in this course.

### IoT hub built-in security

Defender for IoT is enabled by default in every new IoT Hub that is created. Defender for IoT provides real-time monitoring, recommendations, and alerts, without requiring agent installation on any devices and uses advanced analytics on logged IoT Hub meta data to analyze and protect your field devices and IoT hubs.

### Defender for IoT micro agent

Defender for IoT micro agent provides depth security protection and visibility into device behavior. It collects, aggregates, and analyzes raw security events from your devices. Raw security events can include IP connections, process creation, user logins, and other security-relevant information. Defender for IoT device agents also handles event aggregation to help avoid high network throughput. The agents are highly customizable, allowing you to use them for specific tasks, such as sending only important information at the fastest SLA, or for aggregating extensive security information and context into larger segments, avoiding higher service costs.

## Microsoft Defender for IoT prerequisites

### Minimum requirements

 -  Network switches that support traffic monitoring via SPAN port.
 -  Hardware appliances for NTA sensors.
 -  The Azure Subscription Contributor role. It's required only during onboarding for defining committed devices and connection to Microsoft Sentinel (within agentless solutions).
 -  Azure IoT Hub (Free or Standard tier) Contributor role, for cloud-connected management. Make sure that the Microsoft Defender for IoT feature is enabled.
 -  For device-level security module support, Defender for IoT agents support a growing list of devices and platforms.

### Working with Microsoft Defender for IoT service

Defender for IoT is enabled by default in every new IoT Hub that is created. Microsoft Defender for IoT insights and reporting can be viewed directly in the Azure portal within IoT Hub UI.

### Supported service regions

Microsoft Defender for IoT is non-regional (no dependency on a specific Azure region).

Defender for IoT routes all traffic from all European regions to the West Europe regional datacenter. It routes traffic from all remaining regions to the Central US regional datacenter.

### Where's my IoT Hub?

Check your IoT Hub location to verify service availability before you begin.

 -  Open your IoT Hub.
 -  Click Overview.
 -  Verify the location listed matches one of the supported service regions.

### Supported platforms for agents

Microsoft Defender for IoT agents supports a growing list of devices and platforms that includes Linux versions for C-based agents and both Linux and Windows versions for C\#-based agents. For the most current list, see: [Select and deploy a security agent on your IoT device](/azure/defender-for-iot/how-to-deploy-agent)