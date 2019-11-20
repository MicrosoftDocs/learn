Azure IoT Hub is a cloud service that can handle large volumes of telemetry sent from remote devices. The remote devices typically contain a number of sensors (temperature, humidity, location, velocity, to name a few). These sensors send out telemetry on a regular basis. An IoT Hub processes this data in a number of ways, including storing it, or running a back-end app on the data. The IoT Hub also communicates new settings back to the devices.

An IoT Hub can scale to handle millions of devices. An IoT device can upload files, as well as send telemetry.

In this module, you will learn about Azure IoT Hub, Azure Stream Analytics, and Azure Machine Learning, by creating an IoT system to detect vibration anomalies in a conveyor belt.

![Conceptual art of conveyor belt](../media/vibrations-art1.png)

## Learning objectives

In this module you will:

- Create an Azure IoT Hub, using the Azure portal
- Create an Azure IoT Hub device identity, using the Azure portal
- Create a C# app to send device telemetry to the IoT Hub, using Visual Studio or Visual Studio code
- Create a message route, through to blob storage, using the Azure portal
- Create a second message route, through to an Azure Analytics job, using the Azure portal
- Create a dashboard to visualize data anomalies, using Power BI

## Prerequisites

- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
- A Microsoft account, to log into Office Power BI

## Learn the scenario

Suppose you manage a packaging facility. Packages are assembled for shipping, then placed on a conveyor belt that takes the packages and drops them off in mailing bins. Your metric for success is the number of packages leaving the conveyor belt.

The conveyor belt is a critical link in your process, and is monitored for vibration. The conveyor belt has three speeds: _stopped_, _slow_, and _fast_. The number of packages being delivered at slow speed is less than at the faster speed, though the vibration is also less at the slower speed. If the vibration becomes excessive, the conveyor belt has to be stopped and inspected. A broken conveyor wheel, for example, can exacerbate the vibrations, in a cyclical fashion.

![Graph of cyclical forced vibration](../media/vibration1.png)

There are a number of different types of vibration. What is known as _forced vibration_, which is vibration caused by an external force, such as the broken wheel example, or a weighty package that has not been placed properly on the conveyor belt. There is also _increasing vibration_ where the vibration levels increase, slowly or quickly, due to, for example, a design limit being exceeded.

Vibration is typically measured as an acceleration (meters per second squared, m/s<sup>2</sup>), or possibly g-forces.

![Graph of increasing vibration](../media/vibration2.png)

The goal here is clearly preventive maintenance. If you can detect that something is wrong, before any damage is caused, then your delivery metrics are unlikely to be affected nearly as much as a system failure.

It is not always easy to visually detect that vibration levels are not normal. For this reason you are looking to Azure IoT Hub, and machine learning, to detect data anomalies before a human observer would notice anything was wrong. You plan to have an IoT Hub vibration detection device on the conveyor belt send continuous telemetry to an IoT Hub. An IoT Hub can cope with millions of telemetry readings, and is well suited to handle the volume of telemetry you have in mind. The IoT Hub will use Azure Stream Analytics, and machine learning, to give you advance warning of data anomalies. Gotta prevent that conveyor belt from failing!

You decide to build a simulation prototype of the system.

## The first step

The first step to building this scenario is to create a custom IoT Hub.

## Jobs

1. check images for private stuff, overwrite
1. verify knowledge check text
1. acrolinx fixes
1. read from start to finish, edit
1. check input/output names match images, code
1. clear resources, and test end-to-end
