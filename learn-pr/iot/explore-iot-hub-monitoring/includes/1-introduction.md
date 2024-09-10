The Azure IoT Hub service provides metrics that can be monitored using Azure Monitor to help ensure that your solution is performing as expected. In this module, you work with IoT Hub diagnostics, metrics, and alerts.

## Example scenario

Suppose you joined a team that is implementing an Azure IoT solution for the company. Your team needs to configure IoT Hub monitoring and troubleshoot device connection and communication issues that can occur. You decide to gain experience by configuring IoT Hub monitoring in a test environment.

Your company's Asset monitoring and tracking solution is working well. The system provides continuous monitoring throughout the packaging and shipping process. You implemented group enrollments within Azure IoT Hub Device Provisioning Service (DPS) to provision devices at scale. When the container arrives at the destination, the IoT device is "decommissioned" through DPS so that it can be reused for future shipments.

To help manage device utilization and other characteristics of the solution, the IT department asked your team to implement Azure monitoring and logging services within the IoT solution.

You agree to begin by implementing some simple metrics in a proof-of-concept that can be reviewed with your IT team before you commit to more workload.

> [!NOTE]
> This is a **_guided project_** module where you'll complete an end-to-end project by following step-by-step instructions.

## Learning objectives

In this module, you complete exercises that include the following activities:

* Enable IoT Hub diagnostics logs and metrics.
* Configure alerts for IoT Hub metrics.
* Trigger alerts and verify records in the diagnostics log.

By the end of this module, you'll be able to configure IoT Hub monitoring and log alerts.
