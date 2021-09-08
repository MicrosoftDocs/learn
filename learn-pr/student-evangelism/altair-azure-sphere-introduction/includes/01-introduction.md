Welcome to the "Learn Computing fundamentals with Altair 8800 emulator & Azure Sphere" learning path.

## Introduction

Welcome to the cloud-connected Altair 8800 on Azure Sphere learning path. You’ve come to the right place if you are interested in secure IoT devices and cloud computing. Not only do you get to learn about device and cloud computing, but you'll also get a taste of retro computing. You'll gain an understanding of the Altair 8800 personal computer, invented in the 1970s.

## Scenario: Curiosity

You've just read an article on the internet about the Altair 8800 personal computer, and it has captured your attention. The article says the Altair 8800 was invented nearly 50 years ago, and it was the computer that ignited the personal computer revolution. Now you’re curious how the Altair 8800 works, and how it can be programmed. You'd love to buy an Altair 8800, but they are expensive and difficult to find.

The Altair 8800 emulator running on Azure Sphere brings together retro computing, the modern world of IoT and cloud computing, and the chance to step back in time and program one of the first personal computers invented.

The Altair 8800 emulator provides the perfect platform to learn about the Altair 8800, how it works, and how it can be programmed. You'll get to program apps and games in Basic and C. For the more adventurous, you can code applications in Assembly language. Or you can take a notch deeper and program the Altair 8800 with Intel 8080 machine code.

## What will you learn?

In this module, you'll learn about the Azure Sphere, a platform for secure IoT, and the history of the Altair 8800, and the open-source Altair 8800 emulator. The Altair 8800 was invented well before the Internet as we know it today, and you'll learn techniques that you can apply to day-to-day IoT solutions.

## What is the main goal?

Azure Sphere is a unique highly secure IoT platform. You focus on your solution, Azure Sphere deals with security, identity, certificates, reporting, tracking emerging attack vectors, mitigating, updating the platform, and application distribution to protect your solutions, customers, and reputations.

Azure Sphere consists of the following components:

- **Azure Sphere certified chips** from hardware partners include built-in Microsoft security technology to provide connectivity and a dependable hardware root of trust.
- **Azure Sphere OS** adds layers of protection and ongoing security updates to create a trustworthy platform for new IoT experiences.
- **Azure Sphere Security Service** brokers trust for device-to-cloud communication, detects threats, and renews device security.

Together these components implement [The Seven Properties of Highly Secure Devices](https://www.microsoft.com/research/publication/seven-properties-highly-secure-devices?azure-portal=true).

:::image type="content" source="../media/azure-sphere-end-to-end.png" alt-text="Diagram that shows Azure Sphere end-to-end." border="false":::

## Introduction to the cloud-connected Altair emulator on Azure Sphere

The core of the system is the Open Source Intel 8080 CPU emulator that runs compiled Intel 8080 binaries. Layered on the emulator is Altair BASIC and the CP/M operating system. On CP/M, three languages are available: BASIC, C, and Assembly.

- The solution integrates several Azure cloud services including:
  - Azure IoT Central to configure the Altair emulator and reporting.
  - An Azure Static Web App for the Altair Web Terminal
  - An Azure Virtual Machine. The virtual machine runs the virtual disk and MQTT broker services.

- The Altair emulator running on the Azure Sphere is accessible via a web browser-based terminal.

- The Altair emulator runs on the Azure Sphere Cortex A7. Depending on your hardware configuration, a virtual disk cache or SD Card server is running on one of the real-time Cortex M4 cores.

:::image type="content" source="../media/altair-azure-sphere-architecture.png" alt-text="Diagram that shows the Azure Sphere architecture." border="false":::

## Introduction video to Altair 8800 emulator on Azure Sphere

Select the following image to view an introduction to the cloud-connected Altair emulator running on Azure Sphere.

[![Intro to the the Altair 8800 emulator on Azure Sphere video](../media/youtube-intro-thumbnail.png)](https://www.youtube.com/watch?v=nUMOpEOx6LI)

In this module, you will:

- Learn about the Altair 8800.
- Learn about Azure Sphere.
- Learn about the cloud-connected Altair emulator on Azure Sphere.

## Prerequisites

- A computer with an x86-64-based processor running one of the following operating systems:
  - Windows 10 Anniversary Update or later
  - 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS
- An Azure Sphere developer board that has one of the following kits:
  - Avnet Azure Sphere Starter Kit Rev 1 or 2
  - Seeed Studio Azure Sphere MT3620 Development Kit
- A GitHub account.
- An Azure account. Sign up for a free [Azure for Students account](https://azure.microsoft.com/free/students?azure-portal=true) or a free [Azure account](https://azure.microsoft.com/free?azure-portal=true).
