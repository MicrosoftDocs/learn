You ran applications on the Azure Sphere to send environment data to IoT Hub. Using Azure IoT Explorer you were able to monitor and control your Azure Sphere.

We learnt that Azure Sphere is secure by default, with ongoing updates, and multiple layers of security. Azure Sphere protects our IoT devices, our networks, and our solutions. It also helps to protect against software bugs and mistakes we make in our applications.

We also learnt that Azure Sphere is flexible and supports a wide range of application scenarios. Azure Sphere has three developer-accessible cores. You ran a high-level application while running time sensitive applications on the real-time Cortex-M4F cores.

Internet of Things security was critical for this microbiology lab. Without this Azure Sphere-based application, you would need to manually record room conditions at regular intervals. Using this solution, you can record accurate and secure results in near real time.

> [!IMPORTANT]
> Azure Sphere (Legacy) service interfaces — the `azsphere` CLI and the Legacy Public API (PAPI) — are scheduled to retire on **27 September 2027**. The Azure Sphere device platform itself remains supported. For new work, migrate to **Azure Sphere (Integrated)**, which uses the `az sphere` extension for the Azure CLI. See [Migrate from Azure Sphere (Legacy) to Azure Sphere (Integrated)](/azure-sphere/product-overview/migrate-legacy-integrated?azure-portal=true).
>
> Similarly, **Azure RTOS** has transitioned to the Eclipse Foundation and is now **Eclipse ThreadX**. Source code, documentation, and releases are available at [threadx.io](https://threadx.io?azure-portal=true) and on [GitHub (eclipse-threadx)](https://github.com/eclipse-threadx?azure-portal=true).

## Azure IoT reference architecture

Azure Sphere and IoT Hub are only part of an Internet of Things solution. You can learn more about IoT solutions by reviewing the [Azure IoT architecture overview](/azure/architecture/reference-architectures/iot?azure-portal=true) guide.

:::image type="content" source="../media/iot-refarch.png" alt-text="This illustration shows the recommended architecture for IoT applications on Azure using PaaS (platform-as-a-service) components." lightbox="../media/iot-refarch.png":::

## Next steps

To learn more about Azure Sphere and IoT Hub then review the following resources.

1. [Azure Sphere documentation](/azure-sphere?azure-portal=true)
1. [Migrate from Azure Sphere (Legacy) to Azure Sphere (Integrated)](/azure-sphere/product-overview/migrate-legacy-integrated?azure-portal=true)
1. [Azure IoT Hub documentation](/azure/iot-hub?azure-portal=true)
1. [Azure IoT architecture overview](/azure/architecture/reference-architectures/iot?azure-portal=true)
1. [Eclipse ThreadX (formerly Azure RTOS)](https://threadx.io?azure-portal=true)
1. [Azure IoT documentation](/azure/iot/?azure-portal=true) - Browse all Azure IoT services, tutorials, and reference architectures.


## Learning module feedback

Take a moment to rate this learning module and provide feedback to help us improve the learning experience. Thank you.
