The Azure Defender for IoT agent-based solution can be implemented using one of two feature workflows: Built-in and Enhanced

The management portal located in the IoT Hub allows you to complete the following tasks:

 -  Manage IoT Hub security.
 -  Implement basic management of an IoT device's security without installing an agent based on the IoT Hub telemetry.
 -  Implement advanced management for the security of an IoT device based on the micro agent.

## Built-in capabilities

Offering real-time monitoring, recommendations and alerts, the built-in capabilities offer single-step device visibility. Accessing the build-in features does not require agent installation on any devices and uses advanced analytics on logged activities to analyze and protect your field devices.

The built-in capabilities of Azure Defender for IoT are enabled by default when a new IoT Hub is created. For an existing IoT Hub, you can verify that Defender for IoT is enabled as follows:

 -  Use the Azure portal to open IoT Hub.
 -  On the left-side menu under Security, select Settings.
 -  On the Settings page, select Data Collection, and then verify that Enable Azure Defender for IoT is enabled.

## Enhanced capabilities

Installing Azure Defender for IoT micro agents on your devices provides enhanced capabilities. The micro agents collect, aggregate, and analyze raw security events from your devices. Raw security events can include IP connections, process creation, user logins, and other security-relevant information. Azure Defender for IoT micro agents also handle event aggregation to help avoid high network throughput. The agents are highly customizable, allowing you to use them for specific tasks, such as sending only important information at the fastest SLA, or for aggregating extensive security information and context into larger segments, avoiding higher service costs.

:::image type="content" source="../media/m10-l02-security-center-azure-iot-security-architecture-a62fe9bb.png" alt-text="Diagram that shows Azure Defender for IoT micro agent within a security architecture.":::


Micro agents, and other applications use the Azure send security message SDK to send security information into Azure IoT Hub. IoT Hub picks up this information and forwards it to the Azure Defender for IoT service.

Once the Azure Defender for IoT service is enabled, in addition to the forwarded data, IoT Hub also sends out all of its internal data for analysis by Azure Defender for IoT. This data includes device-cloud operation logs, device identities, and Hub configuration. All of this information helps to create the Azure Defender for IoT analytics pipeline.

Azure Defender for IoT analytics pipeline also receives threat intelligence streams from various sources within Microsoft and Microsoft partners. The Azure Defender for IoT entire analytics pipeline works with every customer configuration made on the service (such as custom alerts and use of the send security message SDK).

Using the analytics pipeline, Azure Defender for IoT combines all of the streams of information to generate actionable recommendations and alerts. The pipeline contains both custom rules created by security researchers and experts as well as machine learning models searching for deviation from standard device behavior and risk analysis.

Azure Defender for IoT recommendations and alerts (analytics pipeline output) is written to the Log Analytics workspace of each customer. Including the raw events, alerts, and recommendations in the workspace enables deep dive investigations and queries using the exact details of the suspicious activities detected.
