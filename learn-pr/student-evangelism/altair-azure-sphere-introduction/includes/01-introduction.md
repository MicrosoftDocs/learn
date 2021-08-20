Welcome to the *Learn computing fundamentals with Altair 8800 emulator & Azure Sphere* learning path.

## Introduction to the Altair 8800

The Altair 8800 is considered to be the computer that kick-started the Personal Computer revolution. You can learn more about the Altair at https://en.wikipedia.org/wiki/Altair_8800?azure-portal=true.

:::image type="content" source="../media/altair-8800-smithsonian-museum.png" alt-text="Diagram that shows the Altair 8800." border="false":::

[Altair 8800 image attribution - Smithsonian Museum](https://commons.wikimedia.org/wiki/File:Altair_8800,_Smithsonian_Museum.jpg?azure-portal=true)

The Altair 8800 was built on the [Intel 8080](https://en.wikipedia.org/wiki/Intel_8080?azure-portal=true) CPU, the second 8-bit microprocessor manufactured by Intel in 1974. By today's standards, it is a simple CPU design, perfect for learning, due to its limited instruction set. This makes it easier to understand and learn computer fundamentals.

This learning path brings the Altair 8800 to the Azure Sphere. You will learn about secure IoT, secure cloud services, computer fundamentals, using caches to improve performance, and how to program the Altair with Intel 8080 OpCodes, Assembly, C, and BASIC.

## Introduction to Azure Sphere

The traditional approach to IoT microcontroller (MCU) development is that you are responsible for integrating and maintaining all the bits of a solution. This includes the communications stack, security, authentication, certificates, identity, encryption libraries, update processes, your solution, and more. Not only are you a solution domain expert, but you are now responsible for tracking new and emerging security threats, mitigating, and updating to protect IoT devices.

Azure Sphere is a unique highly secure IoT platform. You focus on your solution, Azure Sphere deals with security, identity, certificates, reporting, tracking emerging attack vectors, mitigating, updating the platform, and application distribution to protect your solutions, customers, and reputations.

Azure Sphere consists of the following components:
- **Azure Sphere–certified chips** from hardware partners include built-in Microsoft security technology to provide connectivity and a dependable hardware root of trust.
- **Azure Sphere OS** adds layers of protection and ongoing security updates to create a trustworthy platform for new IoT experiences.
- **Azure Sphere Security Service** brokers trust for device-to-cloud communication, detects threats, and renews device security.

Together these components implement [The Seven Properties of Highly Secure Devices](https://www.microsoft.com/research/publication/seven-properties-highly-secure-devices?azure-portal=true).

:::image type="content" source="../media/azure-sphere-end-to-end.png" alt-text="Diagram that shows Azure Sphere end-to-end." border="false":::

## Introduction to the cloud-enabled Altair emulator on Azure Sphere

The Azure Sphere is running an Open Source Intel 8080 emulator, and on top of the emulator, we are layering Altair BASIC and CP/M. On CP/M, three languages are available: BASIC, and C, and Assembler.

The solution integrates several Azure cloud services - IoT Central, Static Web Apps, and Azure VM for virtual disks and MQTT communications services. 

The Altair emulator running on the Azure Sphere is accessible via a web browser-based terminal. You can access the Altair emulator securely from anywhere from a web browser.

Three apps are running on the Azure Sphere - one on each Cortex core. The Altair emulator runs on the Cortex A7. The virtual disk cache and the environment monitor run on each of the two real-time Cortex M4 cores.

:::image type="content" source="../media/altair-azure-sphere-architecture.png" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

In this module, you will:

- Learn about the Altair 8800.
- Learn about Azure Sphere.
- Learn about the cloud-enabled Altair emulator on Azure Sphere.

## Prerequisites

TBD
