Azure Stream Analytics can analyze and process large volumes of streaming IoT data in real-time with submillisecond latencies. Important patterns and relationships can be identified in the data that can be used to fine-tune and improve a system.

In this module, you work with a combination of message processing and analysis techniques including Azure IoT Hub message routing and Azure Stream Analytics.

## Example scenario

You're developing an IoT-based solution to improve product packaging speed for your company.
 Cheese is cut and packaged, and packages are assembled into shipping containers. A conveyor belt system is used to move the product through this process.

 An efficiency metric used is the number of packages leaving the conveyor belt system per work shift. Belt speed is critical in this process, but belt vibration tends to increase in relation to belt speed.

 There are three belt speeds: **stopped**, **slow**, and **fast**.

* Slow speed vibration is lower, but fewer packages are transported.
* Fast speed vibration levels can cause packages to fall from the belt and  accelerate system wear-and-tear.
* When vibration levels exceed a threshold limit, the belt must be stopped to allow for inspection.

It's not easy for operators to visually detect abnormal vibration levels, so you're prototyping an Azure IoT solution that helps measure vibration levels and data anomalies. IoT vibration sensors are attached to the conveyor belt at various locations that send telemetry to an IoT hub. The IoT hub uses Azure Stream Analytics and a Machine Learning (ML) model to alert operators of vibration anomalies in real time. You also plan to archive all of the telemetry data so that in-house machine learning models can be developed in the future.

The automated IoT solution will implement preventive maintenance based on vibration levels, which are used to detect early warning signs before serious system damage occurs.

The prototype uses simulated telemetry from a single IoT device. Several types of vibration can contribute to the overall vibration level. For example, a "force vibration" can be caused by a broken guide wheel, or an "increasing vibration" can be introduced when a system design limit such as speed or weight is exceeded. You work with an engineering group to develop simulated IoT device models that produce an accurate representation of vibration data.

> [!NOTE]
> This is a **_guided project_** module where you'll complete an end-to-end project by following step-by-step instructions.

## Learning objectives

In this module, you practice how to:

* Connect a simulated device to Azure IoT Hub and verify that IoT Hub is receiving telemetry.
* Configure an Azure IoT Hub message route that sends selected message data to Azure Blob storage.
* Configure an Azure Stream Analytics job that analyzes message data and sends the output to Azure Blob storage.

By the end of this module, you will be able to implement IoT Hub message routing and Azure Stream Analytics in an IoT solution.
