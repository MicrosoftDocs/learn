In the traditional approach to IoT microcontroller development, you're responsible for integrating and maintaining all the bits of a solution. 

This approach includes:
- The communications stack.
- Security.
- Authentication.
- Certificates.
- Identity.
- Encryption libraries.
- Update processes.
- Your solution. 

You're a solution domain expert. But you're now also responsible for tracking new and emerging security threats, mitigating them, and updating the platform to protect IoT devices.

Azure Sphere is a unique, highly secure IoT platform. It allows you to focus on your solution. 

Azure Sphere manages: 
- Security.
- Identity.
- Certificates.
- Reporting.
- Tracking emerging attack vectors.
- Mitigating threats.
- Updating the platform. 
- Distributing applications to help protect your solutions, customers, and reputations.

Azure Sphere consists of these components:

- **Azure Sphere certified chips** from hardware partners include built-in Microsoft security technology to provide connectivity and a dependable hardware root of trust.
- **Azure Sphere OS** adds layers of protection and ongoing security updates to create a trustworthy platform for new IoT experiences.
- **Azure Sphere Security Service** brokers trust for device-to-cloud communication, detects threats, and renews device security.

Together these components implement [The Seven Properties of Highly Secure Devices](https://www.microsoft.com/research/publication/seven-properties-highly-secure-devices?azure-portal=true).

:::image type="content" source="../media/azure-sphere-end-to-end.png" alt-text="Diagram that shows Azure Sphere, end to end." border="false":::

## Azure Sphere architecture

The Azure Sphere microcontroller unit (MCU) has three developer-accessible cores: a Cortex-A7 that runs a Linux kernel and two Cortex-M4 cores that can run bare-metal code or an operating system like the Azure real-time operating system or FreeRTOS.

:::image type="content" source="../media/azure-sphere-architecture.png" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

High-level applications that run on the Cortex-A7 Linux kernel are used for less timing-sensitive tasks, like: 
- Establishing network connections. 
- Negotiating security.
- Updating device state.
- Communicating with real-time core applications. 
- Sending telemetry messages to cloud gateways like Azure IoT Hub.

