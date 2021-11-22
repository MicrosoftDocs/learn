In this module, you'll learn how to set up and configure the NVIDIA DeepStream Graph Composer on an x86-based Ubuntu 18.04 system to enable rapid development of Intelligent Video Analytics (IVA) application pipelines for deployment to cloud and edge-capable devices.

### Prerequisites

- x86-based system running Ubuntu 18.04
- RTX2080, RTX3080, T4, or A100 NVIDIA graphics card
- Familiarity with container workloads and Docker
- Familiarity with Azure IoT Edge and Azure IoT Hub
- Completion of the prerequisite module: [NVIDIA DeepStream development with Microsoft Azure](/learn/modules/setup-configure-nvidia-deepstream-development/)

:::image type="content" source="../media/composer-test1.png" alt-text="Screenshot that shows the NVIDIA DeepStream Graph Composer Test1 application example." lightbox="../media/composer-test1.png":::

## Scenario: Publish a DeepStream Graph Composer workload into Azure Container Registry for mass distribution

Your boss is impressed with the NVIDIA DeepStream SDK and its ability to enable custom development of IVA applications. The boss wants to begin rolling out a proof of concept to testers in select locations for evaluation. You've heard about a recent development tool, the NVIDIA DeepStream Graph Composer. You can use it to create visualizations of IVA solutions and also export them as containerized workloads. You decide to employ a container-based strategy for development of the proof of concept to ensure that the workload runs as expected on any compatible hardware target.

## What will you learn?

After you finish this module, you'll be able to:

- Install the NVIDIA DeepStream Graph Composer application and reference graphs.
- Develop IVA applications by using the DeepStream Graph Composer.
- Package DeepStream Graph Composer applications into a container by using *container-builder*.
- Publish DeepStream Graph Composer container workloads into Azure Container Registry for secure redistribution.

## What is the main goal?

This module will show you how to use the DeepStream Graph Composer with Azure services to create containerized IVA applications and publish them into Azure Container Registry for secure distribution.
