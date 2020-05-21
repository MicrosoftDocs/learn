We will now do a quick comparison of two cloud stacks that are currently popular in the market. We will quickly glance over the services offered by Azure and OpenStack (the open cloud computing platform).

## Microsoft Azure

Microsoft Azure is one of the fastest-growing cloud services in the market, with an expanding portfolio of cloud services.

**Compute**: Microsoft offers Azure Virtual Machines, which can be configured to run Windows or many flavors of Linux.

**Storage**: Azure offers several storage solutions, including: Azure Blob storage to store binary large objects; Azure Table storage to store NoSQL tables; and Azure File Storage, which offers SMB-based storage endpoints to mount and store files in the cloud. Azure also offers managed relational database services through Azure SQL Database; a managed NoSQL document database service, Azure Cosmos DB; and high-performance key-value cache through Azure Cache for Redis. Microsoft also offers a unique storage appliance called StorSimple, which is an SSD/HDD hybrid storage array deployed at the client's side. StorSimple also connects to Azure for backup, analytics, and/or cloud deployment.

**Networking**: Microsoft offers virtual private networking services through Azure Virtual Network. Another unique feature of the Azure platform is the ability to purchase dedicated fiber connectivity to Microsoft's datacenters through Azure ExpressRoute. Azure Traffic Manager can be used to load balance traffic to Azure Virtual Machines.

**PaaS products**: Azure offers several PaaS products: The Web Apps feature of Azure App Service is the primary PaaS platform, which enables developers to deploy scalable web applications on the Azure platform. Azure Functions allows developers to run small pieces of code "functions" without managing application infrastructure. In the analytics space, Azure offers several products including HDInsight, which is a managed open-source analytics service that can run Hadoop, Apache Spark, Apache Hive, Apache Kafka and more. Microsoft also offers other managed services like Azure Kubernetes Service and Azure Machine Learning.

## OpenStack

Microsoft Azure is a proprietary stacks hosted by Microsoft on their public cloud. The OpenStack model is markedly different as it's an open-source cloud stack that is available for both public and private clouds. OpenStack defines itself as a "cloud operating system that controls large pools of compute, storage, and networking resources throughout a datacenter, all managed and provisioned through APIs with common authentication mechanisms." OpenStack can be deployed anywhere, from a bunch of machines to an entire datacenter. Public clouds that offer OpenStack include Rackspace and Cloudsuite.

**Compute**: OpenStack's compute offering provides similar services to public cloud counterparts, with the ability to manage virtualized and commodity server resources with API-based access. OpenStack's compute system (called Nova) supports creating virtual machines and bare-metal servers (through the use of Ironic), and has limited support for system containers.

**Storage**: OpenStack offers two types of storage services: an object storage service (called Swift) and a block storage service (called Cinder). These can be deployed and scaled according to environment and application needs. Database systems can be deployed on top of virtual machines and storage services, if required, but OpenStack does not use or promote any particular type of database solution. Public clouds that use OpenStack offer MySQL, Percona, or MariaDB deployed on top of OpenStack VMs as a service.

**Networking**: OpenStack offers a pluggable, scalable, and API-driven system called Neutron to manage networks, VLANs, and IP address pools for virtual machines. One feature of OpenStack networking is support for software-defined networks such as OpenFlow, which enable fine-grained configuration of networking hardware in response to provisioning or traffic requirements. More information on software-defined networks will be covered later.

**PaaS products**: OpenStack itself does not have any PaaS services, but public cloud providers that are built on top of OpenStack have a few. For example, Rackspace provides several platforms for website hosting and managed Hadoop clusters.

<!-- Reference not cited in this unit.
 
<br>
***
### References

1. _Li Ang, et. al.  (2010). [CloudCmp: Shopping for a Cloud Made Easy](https://www.microsoft.com/en-us/research/publication/cloudcmp-shopping-for-a-cloud-made-easy/) In Proceedings of the 2nd USENIX conference on Hot topics in cloud computing_

***

[^1]: <https://www.microsoft.com/en-us/research/publication/cloudcmp-shopping-for-a-cloud-made-easy/> "Li Ang, et. al.  (2010). *CloudCmp: Shopping for a Cloud Made Easy* In Proceedings of the 2nd USENIX conference on Hot topics in cloud computing"

-->