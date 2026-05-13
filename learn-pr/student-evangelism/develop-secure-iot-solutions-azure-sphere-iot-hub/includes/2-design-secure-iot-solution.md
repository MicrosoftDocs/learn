In the scenario, your goal is to maintain ambient room conditions accurately within a laboratory. Doing so ensures that your test results are accurate and stable. The system you build should automatically read the data and transmit it securely from the device to the cloud. To accomplish the requirement, you create a secure IoT solution to run on Azure Sphere.

## Components to use

You clone the Azure Sphere Developer Learning Path, configure your application, and deploy it to the Azure Sphere device by using Visual Studio Code.

To accomplish this, you use the Azure Sphere MT3620 board to:

1. Act as a room environment monitor. You deploy an Azure Sphere application on the Azure Sphere board. It will read and transmit environment telemetry data to the cloud so that you're able to monitor and analyze the data from the cloud.
1. Additionally, you can control your room environment from the cloud.  You can specify a threshold for any of the defined variables to maintain stable room conditions with a virtual "Heating, Ventilation, and Air Conditioning (HVAC)" unit that automatically adjusts the environment to match the requirements of your lab experiments.

The components you use are:

- **Azure Sphere MT3620 board:** MT3620 is the first Azure Sphere certified MCU. Azure Sphere certified MCUs are a new class of secured, connected crossover microcontrollers.
- **Azure Sphere Developer Learning Path:** The labs in this learning path are designed to ease you into the world of Azure Sphere development with the Avnet and Seeed Studio Azure Sphere development boards. The labs cover Azure Sphere security concepts, secure bi-directional cloud communications, how to integrate Eclipse ThreadX (formerly Azure RTOS) real-time applications with Azure, and over-the-air updates.
