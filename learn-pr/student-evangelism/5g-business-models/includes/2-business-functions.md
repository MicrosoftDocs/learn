5G based services within the Azure Cloud technologies are implemented through a combination of Azure private MEC and other Azure technologies such as:

- Azure Stack Edge
- Azure Arc
- Azure Sphere
- Azure IoT Edge
- Azure IoT Hub
- Azure Machine Learning
- Azure Digital Twins
- Azure Time Series Insights
- Azure Data Lake Storage

There are three possibilities for 5G and Azure deployments

- Azure for Operators
- Azure private multi-access edge compute (MEC), implemented over Azure Stack Edge - Azure Stack HCI (for data centers)

We focus on Azure private MEC because this module is targeted to enterprise developers using Azure technologies. Also, in this module, we focus on low latency-based IoT services, but similar considerations could also apply to a live video analytics service based on Azure private MEC and 5G. 

Typically, you deploy new 5G based services as a partnership between an enterprise, a network operator, and a systems integrator. The design considerations for a new service based on Azure private MEC and 5G include considerations listed below. 

## IoT

- Ultra-low latency IoT applications

- Applications needing a high device density of up to 1 million devices per square kilometer

- Connecting brownfield equipment through Azure IoT Edge or Azure Sphere guardian modules

- Ensuring forward compatibility with cellular connectivity options, i.e., the ability to evolve from 4G LTE networks available today to 5G in the future

- Ability to deploy services in areas where there's no Wi-Fi coverage

- M2M connectivity: local connectivity within offices, factories, farms, or warehouses where machines communicate with each other or with the cloud

- Increased connectivity options for Enterprise solutions 

## Live Video Analytics

- Live video analytics: the ability to capture, record, and analyze live video and publish results in the cloud or the edge
- Enhanced broadband speeds coupled with low latency that lead to better video applications compared to Wi-Fi

## Security

- Ability to run a private network for critical areas such as smart grids or hospitals where devices won't be exposed to the open internet
- Improved end to end security through the use of Azure Sphere

## Enhanced Services

- IoT Data Collection: The ability to monitor and track assets by capturing data from sensors attached to the object. The data can be analyzed near real-time by machine learning algorithms and analytics on the edge or the cloud
- Providing an integrated and consistent experience through Azure private MEC. As an application developer, you can develop and deploy distributed applications across the cloud, on-premises, and edge using already familiar tools
- Providing immersive, near real-time experiences through the ability to process data locally for latency-critical industrial IoT and media services workloads
- Accelerating the deployment of new classes of applications using the power of Azure IoT Edge and 5G such as drones, autonomous vehicles, and virtual reality that need a combination of high bandwidth, low latency, and security

## Management

- Cloud-native orchestration and lifecycle management of applications using Azure ARC
- The ability to incorporate solutions from third parties by leveraging Azure private MEC as a platform to access partner services such as Virtual Network Functions (5G software, SD-WAN, and firewalls)
- Working with Telecoms or industry partners

## Analytics

- Deploying edge analytics and providing real-time analytics solutions by combining the characteristics of the Cloud and the Edge

To summarize, 5G networking technologies are designed for high bandwidth and low latency enterprise applications. Data captured through sensors via Azure private MEC is processed through a set of supporting technologies either in the cloud or on edge devices. Hence, to design a new service or a business model, we need to consider low latency and edge are the primary considerations. The supporting set of Azure technologies then complement Azure private MEC to create the service. In this module, we illustrate these principles by considering a use case based on low latency IoT applications. The solution uses the following Azure components. These combine functions on the cloud and the edge. 

On the Edge side, Azure Stack Edge functions as a cloud storage gateway providing access to local files. Combined with Azure IoT Edge and Azure IoT Hub, a bidirectional service is provided between IoT devices and Azure. Azure Sphere provides additional security for devices where needed. On the Cloud side, data is stored in Azure data lake storage and analyzed through Azure machine learning and Azure time series insights. Finally, Azure digital twins provide a cloud-based representation of the data, and Azure Arc enabled Kubernetes manages Kubernetes clusters. 