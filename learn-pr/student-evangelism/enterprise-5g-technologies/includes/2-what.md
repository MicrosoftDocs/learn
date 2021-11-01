Here, we first describe the components of 5G and Azure private multi-access edge compute (MEC). There are four levels to consider:

- Azure Stack hardware and services
- Application services
- Azure Management services
- Azure Network Functions offered via Marketplace

## Azure Stack hardware and services

**Azure Stack Edge:** Azure Stack Edge is implemented as a portfolio of devices that bring compute, storage, and intelligence to the edge where data is created. Azure IoT Edge allows you to deploy and manage containers from IoT Hub and integrate with Azure IoT solutions on the Azure Stack Edge. 

**Azure Stack HCI:** Azure Stack HCI is a hyper-converged infrastructure (HCI) operating system delivered as an Azure service that provides security, performance, and feature updates. Azure Stack HCI is typically deployed in your datacenter and runs on Windows and Linux virtual machines (VMs).

## Application services

**Azure IoT Edge Runtime:** Azure IoT Edge Runtime enables you to deploy and manage cloud workloads to edge compute appliances.

**Azure IoT Hub:** provides a cloud-hosted solution back-end to connect devices virtually. Azure IoT Hub extends your solution from the cloud to the edge by providing per-device authentication, built-in device management and scaled provisioning.

**Azure IoT Central:** Azure IoT Central is a managed application platform for device management and data ingestion. It allows you to deploy and scale your IoT applications with predictable pricing. 

**Azure Digital Twins:** Digital twins turn a set of devices into a digital replica of a physical asset or environment. 

**Azure Video Analyzer:** helps build intelligent video-based applications. 

**Web Apps in Microsoft Azure App Service:** creates and deploys mission-critical web applications that scale with your business.

**Media Services Storage:** uses Azure Storage to store large media files.

## Azure Management services	

**Azure Network Functions Manager (NFM):** Azure Network Function Manager enables the deployment of network functions to the IoT Edge using Azure tools and interfaces. Accessed through the marketplace, the Azure network function manager enables you to deploy network functions such as mobile packet core, SD-WAN edge, and VPN services to your Azure Stack Edge device directly from the Azure management portal. Azure Network Function Manager also brings network functions from the partner ecosystem.

**Arc Enabled Kubernetes:** Azure Arc enabled Kubernetes allows you to attach and configure Kubernetes clusters located either inside or outside Azure.

## Azure Network Functions offered via Marketplace

**Fusion Core:** is a cloud-native implementation of the 3GPP 5G Next-Generation Core. Fusion core allows the mobile network operator to leverage a small footprint packet core at an enterprise edge. Fusion core allows network operators to aggregate data traffic from end devices over multiple wireless and fixed access technologies. It can be deployed in pure 5G scenarios, or it can interoperate with 4G networks.

In a private network comprising Azure private multi-access edge compute, you can use fusion core capabilities to implement a low latency IoT solution combined with the centralized management capabilities of Azure.

This provides several benefits to enterprises, including:

- Automation
- Real-time processing of telemetry data
- Analytics

**Affirmed Private Network Service**: APNS is a complete turnkey managed network service offering for mobile network operators and managed service providers to provide private LTE and private 5G solutions to enterprises. APNS is designed to help carriers and enterprises take advantage of managed networks and the mobile edge. From the perspective of the mobile network operator, APNS provides a combination of cloud management services and automation. APNS allows the operator to choose a best of breed solution from the marketplace by combining components such as Radio Access Network, SIM, and Azure services from the partner ecosystem accessed via the Azure Marketplace.

The solution is composed of five components: Cloud-native Mobile Core, Private Network Service Manager - Affirmed Networks, Azure Network Functions Manager, Azure Cloud, and Azure Stack Edge: 

APNS provides several key benefits to mobile network operators:

- Deployment Flexibility - APNS employs Control and User Plane Separation technology and supports three types of deployment modes: Standalone, Distributed, and All in Cloud. This flexibility allows the operator to offer a variety of scenarios for the enterprise
-  MNO Integration - APNS provides complete integration with private and public operator networks 
-  Automation and Ease of Management – remote management facility through Service Manager on the Azure cloud.
- Smarter Network & Business Insights
- Data Privacy & Security 

Typically, you deploy new 5G based services as a partnership between an enterprise, a network operator, and a systems integrator. Participants in the collaborative 5G ecosystem will avail of various benefits as part of their value proposition. 

**Enterprise customers** benefit from having access to a portfolio of Azure services and its vibrant developer ecosystem. In addition, enterprises can access 5G through a fully integrated technology stack and use tools they are already familiar with.

**Telco and System Integrator partners:** access the Azure developer ecosystem and an integrated way to deploy 5G edge services to the enterprise. They can also access supporting products and services through the marketplace.

Finally, **Application ISVs (systems integrators)** can get a fully-featured platform to develop ultra-low latency applications and distribute their applications at scale through the marketplace.