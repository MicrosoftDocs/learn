In this module, you'll publish and deploy an ARM64-based DeepStream container workload to NVIDIA embedded hardware by using Azure IoT Edge.

### Prerequisites

- x86-based system running Ubuntu 18.04.
- RTX 2080, RTX 3080, T4, or A100 NVIDIA graphics card.
- [NVIDIA Jetson embedded device](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/?azure-portal=true) provisioned with [JetPack 4.6](https://developer.nvidia.com/jetpack-sdk-46).
- Be familiar with container workloads and Docker.
- Be familiar with Azure IoT Edge and Azure IoT Hub.
- Complete the prerequisite module [Introduction to NVIDIA DeepStream Graph Composer with Azure](/learn/modules/introduction-nvidia-deepstream-graph-composer-azure/?azure-portal=true).

:::image type="content" source="../media/jetson-edge-device.jpg" alt-text="Screenshot that shows an NVIDIA Jetson embedded device." lightbox="../media/jetson-edge-device.jpg":::

## Scenario: Deploy a DeepStream Graph Composer workload to a real device at the edge

Your boss is excited about the progress of your Intelligent Video Application and is interested in putting your work into production. You learn that NVIDIA produces a line of embedded devices that are capable of running NVIDIA DeepStream Graph Composer workloads. You've decided to investigate using the Azure IoT Edge runtime to securely distribute your NVIDIA DeepStream Graph Composer workload to these small form factor graphics processing unit (GPU)-accelerated devices at locations around the world. This strategy will not only solve the issue of deployment, but also allow you to gather metrics from all devices in a single location. Then, you can perform analysis by using services in Azure.

## What will you learn?

When you finish this module, you'll be able to:

- Modify an NVIDIA DeepStream Graph Composer application to publish data to a hub in Azure IoT Hub.
- Build and publish cross-platform NVIDIA DeepStream container images to a container registry in Azure Container Registry.
- Configure Azure IoT Edge to run on NVIDIA embedded hardware.
- Deploy cross-platform NVIDIA DeepStream images to NVIDIA embedded devices by using Azure IoT Edge.

## What is the main goal?

This module will show you how to use DeepStream Graph Composer to build cross-platform container images. Then, you'll publish those artifacts to a container registry in Azure, where you can reference them and securely deploy them to an NVIDIA embedded device running Azure IoT Edge.
