In this module, we will publish and deploy an ARM-based DeepStream container workload to NVIDIA embedded hardware using Azure IoT Edge.

### Prerequisites

- X86 Based System running Ubuntu 18.04 OS
- RTX2080, RTX3080, T4, or A100 NVIDIA Graphics Card
- [NVIDIA Jetson Embedded Device](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/) provisioned with [JetPack 4.5.1 GA](https://developer.nvidia.com/jetpack-sdk-451-archive)
- Familiarity with container workloads / Docker
- Familiarity with Azure IoT Edge / IoT Hub
  - Completion of the prerequisite module: [Introduction to NVIDIA DeepStream Graph Composer with Microsoft Azure](/learn/modules/introduction-nvidia-deepstream-graph-composer-azure/)

![Azure IoT Edge](../media/install-edge-full.png)

## Scenario: Deploy a DeepStream Graph Composer workload to a real device at the edge

Your boss is excited about the progress of your Intelligent Video Application and is interested in putting your work into production. You learn that NVIDIA produces a line of embedded devices that are capable of running NVIDIA DeepStream Graph Composer workloads. You've decided to investigate using the Azure IoT Edge runtime to securely distribute your NVIDIA DeepStream Graph Composer workload to these small form-factor GPU-accelerated devices at locations around the world. This strategy will not only solve the issue of deployment, but also allow you to gather metrics from all devices into a single location where you can then perform analysis with services in Microsoft Azure.

## What will you learn?

When you finish this module, you'll be able to:

- Modify a NVIDIA DeepStream Graph Composer Application to Publish Data to an Azure IoT Hub
- Build and Publish cross-platform NVIDIA DeepStream container images to an Azure Container Registry
- Configure Azure IoT Edge to run on NVIDIA Embedded Hardware
- Deploy cross-platform NVIDIA DeepStream images to NVIDIA embedded devices using Azure IoT Edge

## What is the main goal?

This module will show you how to use the DeepStream Graph Composer to build cross-platform container images. We will then publish those artifacts into an Azure Container Registry where they can be referenced and securely deployed to a NVIDIA embedded device running Azure IoT Edge.
