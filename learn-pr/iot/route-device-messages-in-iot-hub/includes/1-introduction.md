
Azure IoT Hub does stuff

## Learning objectives

In this module you will:

- Create an Azure IoT Hub

## The scenario

Suppose you run a company that.
Overall scenario is about detecting anomaly in the vibration patterns of a conveyor belt in a warehouse in order to prevent failure.
IoT Hub ingests data from a simulated device (sensors monitoring the conveyor belt that moves packages in a warehouse).
We have the following data:
Device Twin reported properties:
Package count/#
Other?
Simulated Telemetry data:
Speed (2 speeds range, slow and fast)
Vibration (Simulated)
Data is routed to an Event Hub endpoint based on telemetry (if speed is in the high range)
Stream Analytics is triggered on this event hub and implements anomaly detection
An anomaly triggers some process (we won't include the specific in this module but will point to docs and other modules going through the notion of integration into LOB apps)

## Create a custom IoT Hub app

1. Navigate to [Azure IoT Hub](https://apps.azureiothub.com/?azure-portal=true). It is a good idea to bookmark this URL, as it is the home for all your IoT Central apps.

