Here, we first describe the components of 5G and Azure private multi-access edge compute (MEC). There are four levels to consider:

- Azure Stack hardware and services
- Application services
- Azure Management services
- Azure Network Functions offered via Azure Marketplace

## Azure Stack hardware and services

**Azure Stack Edge:** Azure Stack Edge is implemented as a portfolio of devices that bring compute, storage, and intelligence to the edge where data is created. Azure IoT Edge allows you to deploy and manage containers from IoT Hub and integrate with Azure IoT solutions on the Azure Stack Edge.

**Azure Stack HCI:** A hyper-converged infrastructure (HCI) operating system delivered as an Azure service that provides security, performance, and feature updates. Azure Stack HCI is typically deployed in your datacenter and runs on Windows and Linux virtual machines (VMs).

## Application services

**Azure IoT Edge Runtime:** Deploy and manage cloud workloads to edge compute appliances.

**Azure IoT Hub:** Provides a cloud-hosted back-end solution to connect devices virtually. Azure IoT Hub extends your solution from the cloud to the edge by providing per-device authentication, built-in device management, and scaled provisioning.

**Azure IoT Central:** A managed application platform for device management and data ingestion. You can deploy and scale your IoT applications with predictable pricing.

**Azure Digital Twins:** Digital Twins turn a set of devices into a digital replica of a physical asset or environment.

**Azure Video Indexer:** Helps build intelligent video-based applications.

**Web Apps in Microsoft Azure App Service:** Creates and deploys mission-critical web applications that scale with your business.

**Media Services Storage:** Use Azure Storage to store large media files.

## Azure Management services

**Azure Network Functions Manager:** Deploy network functions to the IoT Edge by using Azure tools and interfaces. Use Azure Network Function Manager to deploy network functions like mobile packet core, SD-WAN edge, and VPN services to your Azure Stack Edge device from the Azure portal. It also brings network functions from the partner ecosystem.

**Arc-enabled Kubernetes:** Attach and configure Kubernetes clusters located either inside or outside Azure.

## Azure Network Functions offered via Azure Marketplace

**Fusion Core:** A cloud-native implementation of the 3GPP 5G Next-Generation Core. With Fusion Core, the mobile network operator can use a small footprint packet core at an enterprise edge. Network operators can aggregate data traffic from end devices over multiple wireless and fixed access technologies. You can deploy Fusion Core in pure 5G scenarios, or it can interoperate with 4G networks.

In a private network that comprises Azure private MEC, you can use fusion core capabilities to implement a low latency IoT solution combined with the centralized management capabilities of Azure.

This solution provides several benefits to enterprises, including:

- Automation
- Real-time processing of telemetry data
- Analytics

**Affirmed Private Network Service**: APNS is a complete turnkey managed network service offering for mobile network operators and managed service providers to provide private LTE and private 5G solutions to enterprises. APNS is designed to help carriers and enterprises take advantage of managed networks and the mobile edge. From the perspective of the mobile network operator, APNS provides a combination of cloud management services and automation. The operator can choose the best solution from the marketplace by combining components such as Radio Access Network, SIM, and Azure services from the partner ecosystem accessed via the Azure Marketplace.

The solution is composed of five components: Cloud-native Mobile Core, Private Network Service Manager - Affirmed Networks, Azure Network Functions Manager, Azure Cloud, and Azure Stack Edge:

APNS provides several benefits to mobile network operators:

- **Deployment Flexibility**: APNS employs Control and User Plane Separation technology and supports three types of deployment modes: Standalone, Distributed, and All in Cloud. With this flexibility, the operator can offer various scenarios for the enterprise.
- **MNO Integration**: APNS provides complete integration with private and public operator networks.
- **Automation and Ease of Management**: Remote management facility through Service Manager on the Azure cloud.
- Smarter network and business insights.
- Data privacy and security.

Typically, you deploy new 5G based services as a partnership between an enterprise, a network operator, and a systems integrator. Participants in the collaborative 5G ecosystem can take advantage of various benefits as part of their value proposition.

**Enterprise customers** benefit from having access to a portfolio of Azure services and its vibrant developer ecosystem. Enterprises can access 5G through a fully integrated technology stack and use tools that they're already familiar with.

**Telco and System Integrator partners** access the Azure developer ecosystem and are an integrated way to deploy 5G edge services to the enterprise. They can also access supporting products and services through the marketplace.

Finally, **Application ISVs (systems integrators)** can get a full-feature platform to develop ultra-low latency applications and distribute their applications at scale through the marketplace.
