An Azure IoT Hub can direct the telemetry messages from one, or millions, of devices. The messages can be directed to services for analysis, for storage, for visualization. Or for any combination of these objectives. 

In this module, you'll learn about Azure IoT Hub, IoT Hub message routing, Azure storage, Azure Stream Analytics, and how to call a built-in ML model. You'll achieve this knowledge by creating an IoT system to monitor and detect vibration anomalies in a conveyor belt. You'll learn a little about vibration, and a lot more about Azure IoT services!

[![Conceptual art of conveyor belt](../media/vibrations-art1.png)](../media/vibrations-art1.png#lightbox)

## Learning objectives

In this module you will:

- Create an Azure IoT Hub, using the IoT Hub portal
- Create an Azure IoT Hub device identity, using the IoT Hub portal
- Create an app to send device telemetry to the IoT Hub
- Create rules, alerts, diagnostics, and logs, to monitor the telemetry sent to the IoT Hub

## Prerequisites

- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
- A Microsoft account, to log into Office Power BI

## Learn the scenario

Suppose you manage a packaging facility. Packages are assembled for shipping, then placed on a conveyor belt that takes the packages and drops them off in mailing bins. Your metric for success is the number of packages leaving the conveyor belt.

The conveyor belt is a critical link in your process, and is monitored for vibration. The conveyor belt has three speeds: _stopped_, _slow_, and _fast_. The number of packages being delivered at slow speed is less than at the faster speed, though the vibration is also less at the slower speed. If the vibration becomes excessive, the conveyor belt has to be stopped and inspected. A broken conveyor wheel, for example, can exacerbate the vibrations, in a cyclical fashion.

[![Graph of cyclical forced vibration](../media/vibration1.png)](../media/vibration1.png#lightbox)

There are a number of different types of vibration. _Forced vibration_ is vibration caused by an external force. Such a force as the broken wheel example, or a weighty package placed improperly on the conveyor belt. There's also _increasing vibration_, which might happen if a design limit is exceeded.

Vibration is typically measured as an acceleration (meters per second squared, m/s<sup>2</sup>).

[![Graph of increasing vibration](../media/vibration2.png)](../media/vibration2.png#lightbox)

The goal here is preventive maintenance. Detect that something is wrong, before any damage is caused.

It's not always easy to detect abnormal vibration levels. For this reason, you're looking to Azure IoT Hub to detect data anomalies. You plan to have a vibration detection sensor on the conveyor belt, sending continuous telemetry to an IoT Hub. The IoT Hub will use Azure Stream Analytics, and a built-in ML model, to give you advance warning of vibration anomalies. You also plan to archive all the telemetry data, just in case it's ever needed.

You decide to build a prototype of the planned system, initially using simulated telemetry.

## The first step

The first step to building this system is to create a custom IoT Hub.



The key to monitoring our conveyor belt is the output of vibration telemetry. Vibration is usually measured as an acceleration (m/s<sup>2</sup>), although sometimes it's measured in g-forces, where 1 g = 9.81 m/s<sup>2</sup>. There are three types of vibration.

* _Natural vibration_, which is just the frequency a structure tends to oscillate.
* _Free vibration_, which occurs when the structure is impacted, but then left to oscillate without interference.
* _Forced vibration_, which occurs when the structure is under some stress.

Forced vibration is the dangerous one for our conveyor belt. Even if it starts at a low level this vibration can build so that the structure fails prematurely. There's less of a case for free vibration in conveyor belt operation. Most machines, as we all know, have a natural vibration.

## Simulate a vibration sensor device

The code sample we'll write has a conveyor belt running at a range of speeds (stopped, slow, fast). The faster the belt is running, the more packages are delivered, but the greater the effects of vibration. We'll add natural vibration, based on a sine wave with some randomization. It's possible our anomaly detection system will falsely identify a spike or dip in this sine wave as an anomaly. We'll then add two forms of forced vibration. The first has the effect of a cyclic increase in vibration (see the images below). And secondly, an increasing vibration, where an additional sine wave is added, starting small but growing.

The natural vibration will vary from a minimum to a maximum level, similar to the following diagram.

[![Graph showing the minimum and maximum natural vibration sine waves](../media/vibration-minmax-basic.png)](../media/vibration-minmax-basic.png#lightbox)

Forced cyclic vibration will also vary from a minimum to a maximum level.

[![Graph showing the minimum and maximum forced vibration sine waves](../media/vibration-minmax-forced.png)](../media/vibration-minmax-forced.png#lightbox)

When forced vibration is added to natural vibration, the resulting vibration wave gets more complicated.

[![Graph showing the addition of forced vibration to natural vibration sine waves](../media/vibration-minmax-forced-basic.png)](../media/vibration-minmax-forced-basic.png#lightbox)

Increasing vibration starts almost undetectable.

[![Graph showing the increasing vibration sine waves](../media/vibration-minmax-increasing.png)](../media/vibration-minmax-increasing.png#lightbox)

When we add all three vibrations, notice how the extreme highs and lows slowly increase.

[![Graph showing the addition of natural, forced, and increasing sine waves](../media/vibration-basic-forced-increasing.png)](../media/vibration-basic-forced-increasing.png#lightbox)

We assume that our conveyor belt has just one sensor, and it also pumps out some other data (packages delivered, ambient temperature, and similar metrics). These extra values are just to give us something to archive!

## Code the simulator and telemetry messages

Almost all the coding in this module is in the next unit. We build the conveyor belt simulator, and send telemetry messages to the IoT Hub created in the previous unit. In later units, there's a small amount of SQL coding.

You can select your preferred development environment (Visual Studio Code, or Visual Studio). The simulator is written in C#.
