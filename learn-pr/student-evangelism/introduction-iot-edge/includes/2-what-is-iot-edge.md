Azure IoT Edge is a device-focused runtime and a feature of Azure IoT Hub. It enables you to deploy, run, and monitor containerized Linux applications on edge devices by using modules, the IoT Edge runtime on the device, and a cloud-based interface for remote monitoring and management. Modules are deployed as OCI/Docker-compatible Linux container images and can contain artificial intelligence applications, Azure and third-party services, or your business logic. The IoT Edge hub routes messages between module inputs and outputs and between modules and IoT Hub, so modules can form processing pipelines without requiring a single fixed processing order.

IoT Edge enables you to:

**React in near real time to local changes:** Because you can implement some functionality at the edge, the device spends less time communicating with the cloud. Hence, the device can react quickly to local changes by processing the data on the device and reducing latency. When modules run locally, they can also use specialized hardware accelerators, such as a GPU or other on-device AI accelerator.

**Manage edge devices:** IoT Edge provides a cloud interface and device runtime, which enables you to remotely manage and deploy workloads to edge devices through IoT Hub.

**Deploy using Linux containers:** IoT Edge allows you to use OCI/Docker-compatible Linux container images to run your business logic at the edge.

**Deploy on supported platforms and hardware:** IoT Edge 1.5 LTS can run Linux containers on supported Linux hosts or on supported Windows hosts by using IoT Edge for Linux on Windows (EFLOW). For production Linux deployments, use `moby-engine` except in supported Ubuntu Core snap scenarios.

**Distribute AI and analytics workloads to the edge:** IoT Edge allows you to deploy models built and trained in the cloud and run them on edge devices. IoT Edge uses the model to process data locally and responds to the event rapidly.

**Use existing developer skillsets and code:** IoT Edge code supports languages such as C, C#, Java, Node.js, and Python.

**Manage data to reduce costs:** IoT Edge devices capture a large amount of data, but typically you only need a small portion of that data for further analysis. If you send all the data to the cloud, you incur transportation and storage costs. IoT Edge reduces costs by allowing you to send only a portion of the data when needed. You can also aggregate data at the edge before sending it to the cloud, which lowers bandwidth usage and storage requirements.

**Reliably operate in offline or intermittent mode:** Often, IoT devices need to work with intermittent or offline connectivity to the cloud. IoT Edge devices and assigned downstream devices can operate offline after the IoT Edge device has connected to IoT Hub and synced at least once. Locally stored messages are delivered and device or module state is reconciled when connectivity is restored, subject to store-and-forward time-to-live (TTL) settings and available storage. Cloud and portal status can be stale while the device is offline.

**Provide security for edge deployments:** IoT Edge helps secure edge deployments through an extensible security framework. Working with IoT Hub, you can use certificate-based authentication and authorization so that trusted devices and modules communicate and receive the right software. If you need additional security monitoring, review the current [Microsoft Defender for IoT for device builders](/azure/defender-for-iot/device-builders/overview) guidance and the [agentless OT and Enterprise IoT monitoring guidance](/azure/defender-for-iot/organizations/overview).

For production designs, consider hardware root of trust technologies, such as TPM, DICE, TrustZone, or SGX, configure persistent host storage and permissions, and implement encryption at rest (such as Linux storage encryption or Windows BitLocker) as appropriate. Use the IoT Edge workload API to issue module identities and certificates — including HSM-rooted signed tokens, X.509 certificates, and the trust bundle — so modules can authenticate securely to each other and to IoT Hub.

**Help improve privacy and compliance for IoT deployments:** IoT Edge can help improve privacy and compliance by processing, filtering, aggregating, or retaining selected data locally before sending only required insights to the cloud. Compliance still depends on solution-specific controls, including data sensitivity, access controls, retention, encryption, and regulatory requirements.

**Act as a gateway:** IoT Edge includes transparent gateway behavior, so downstream devices can connect through an IoT Edge device while retaining their identities in IoT Hub. If your scenario needs protocol translation or identity translation, use custom, non-Microsoft, or marketplace modules for that translation logic.

**Availability of third-party modules:** You can use Azure Marketplace to discover third-party IoT Edge modules. Starting August 28, 2024, partner images are hosted in publisher-owned container registries — they're no longer downloadable from the Azure Marketplace container registry. Contact the publisher through the Marketplace listing to obtain the current container image URI and update your IoT Edge deployment manifest with that URI.
