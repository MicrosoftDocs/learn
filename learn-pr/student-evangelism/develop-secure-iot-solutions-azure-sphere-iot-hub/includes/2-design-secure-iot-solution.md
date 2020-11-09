In this scenario, your goal is to maintain ambient room conditions accurately within a laboratory. Doing so ensures that your test results are accurate and stable. The system you'll build should automatically read the data and transmit it securely from the device to the cloud. To accomplish the requirement, you'll create a secure IoT solution on Azure Sphere.

## Components to use

You'll clone Azure Sphere Developer Learning Path, configure your application, and deploy it to the Azure Sphere device by using Visual Studio Code.

To accomplish this you'll use the Azure Sphere MT3620 board, which acts as a room monitor. You'll deploy an Azure Sphere application on the Azure Sphere board. It will read and transmit environmental telemetry data to the cloud so that you'll be able to monitor and analyze the data from the cloud. Additionally, you can control your room monitor from the cloud. You can specify a threshold for any of the defined variables to maintain the room condition stable.

The components you'll use are:

- **Azure Sphere MT3620 Board:** MT3620 is the first Azure Sphere certified MCU. Azure Sphere certified MCUs are a new class of secured, connected crossover microcontrollers.
- **Azure Sphere Developer Learning Path:** This series of labs is designed to ease you into the world of Azure Sphere development with the Avnet and Seeed Studio Azure Sphere development boards. The labs cover Azure Sphere security concepts, secure bi-directional cloud communications, how to integrate FreeRTOS Real-Time applications with Azure, and over-the-air updates.
