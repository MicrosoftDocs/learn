We will now do a quick run-down of cloud stacks that are currently popular in the market. We will quickly glance over the services offered by the major cloud providers: Amazon Web Services, Microsoft, Google, and OpenStack (the open cloud computing platform).

## Amazon Web Services (AWS)

AWS is a market leader in several cloud computing segments, particularly in the IaaS space. Amazon Web Services started by commoditizing and leasing out several services that were developed in house by Amazon's engineering team to the wider public. AWS started by offering an object storage service, and then went on to provide an elastic compute cloud.

The AWS stack primarily consists of the following components:

**Compute**: Amazon's primary compute solution is Elastic Compute Cloud (EC2), which provides users with virtual machines, or instances of various capacities, for hourly or longer-term rentals. EC2 forms the backbone of the AWS cloud stack in terms of compute infrastructure. EC2 instances can be managed directly through the AWS EC2 APIs, or through other services such as Auto Scaling.

**Storage**: AWS offers multiple products in this space. Block storage is provided by Elastic Block Storage (EBS) volumes, which can be attached to  and detached from EC2 instances. Object storage is provided by Simple Storage Service (S3), which allows for binary large objects (BLOBs) to be stored and retrieved using a simple HTTP service. AWS also offers a varied suite of database services, including Relational Database Service (RDS). RDS is available on several database instance types, including Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database, and SQL Server.

**Networking**: Amazon Virtual Private Cloud (VPC), Elastic Load Balancer (ELB), and Route 53 are networking services that an organization can use to manage the connectivity between its instances and services deployed in AWS and the outside world.

**PaaS products**: AWS platforms are large and varied to cater to different applications' needs. AWS provides a suite of analytics platforms such as Elastic MapReduce (EMR), Amazon Kinesis, and Redshift. Rapid web application development is possible through AWS Elastic Beanstalk. Amazon also offers many products to manage and control cloud deployments, such as CloudFormation, OpsWorks, and CodeDeploy.

## Microsoft Azure

Microsoft Azure is one of the fastest-growing cloud services in the market, with an expanding portfolio of cloud services. Azure also leverages Microsoft's large datacenter presence worldwide, as well as CDN sites that are spread across 24 countries. Subsets of Microsoft's cloud platform are available as Windows Azure Pack, which **allows an organization to build a private cloud** that can seamlessly connect and interact with the Azure public cloud. These allow internal datacenters to be highly automated, using shared resources that can respond to sudden spurts in demand.

**Compute**: Microsoft offers Azure Virtual Machines, which can be configured to run Windows or various flavors of Linux. The virtual machines are managed by Azure Cloud Services, which provides a multi-language cloud management platform. A unique aspect of Azure is the staging environment and simulator, which allow developers to test out a cloud deployment before putting it into production.

**Storage**: Azure offers several storage solutions, including: Azure Blob storage to store binary large objects; Azure Table storage to store NoSQL tables; and Azure Files, which offers SMB-based storage endpoints (Windows-compatible file servers) to mount and store files in the cloud. Azure also offers managed relational database services through Azure SQL Database; a managed NoSQL document database service, Azure Cosmos DB; and high-performance key-value cache through Azure Cache for Redis. Microsoft also offers a unique storage appliance called StorSimple, which is an SSD/HDD hybrid storage array deployed at the client's side. StorSimple also connects to Azure for backup, analytics, and/or cloud deployment.

**Networking**: Microsoft offers virtual private networking services through Azure Virtual Network. Another unique feature of the Azure platform is the ability to purchase dedicated fiber connectivity to Microsoft's datacenters through Azure ExpressRoute. Azure Traffic Manager can be used to load balance traffic to Azure Virtual Machines.

**PaaS products**: Azure offers several PaaS products: The Web Apps feature of Azure App Service is the primary PaaS platform, which enables developers to deploy scalable web applications on the Azure platform. Azure Mobile Services allows developers to create the infrastructure required to support mobile applications. In the analytics space, Azure offers several products including HDInsight, which is a managed Hadoop cluster service similar to Amazon's EMR. Microsoft also offers the managed services Azure Machine Learning and Azure Stream Analytics services to developers.

## Google Cloud Platform

Google Cloud Platform initially offered only PaaS products and APIs into Google's most powerful products, such as the Translate API. Google Cloud Platform has now diversified into multiple services in response to the offerings of its competitors.

**Compute**: Google's primary compute platform is Google Compute Engine (GCE), which offers Linux virtual machines of various sizes depending on the application requirements. A unique differentiator of Google's platform is that instances are billed by the minute, with a minimum charge of 10 minutes.

**Storage**: Google offers three primary storage services. Cloud Storage is an object storage service similar to S3 and Azure Blob storage. Cloud Firestore is the managed NoSQL datastore service that allows users to store non-relational data with high scalability, but optionally supports transactions and SQL queries on data. In addition, Google offers a traditional managed SQL database service called Cloud SQL.

**Networking**: Google offers networking products to manage the connections between Google's cloud services and the outside world, namely Cloud Load Balancing, Cloud Interconnect, and Cloud DNS.

**PaaS products**: Google's primary PaaS offering is Google App Engine (GAE), which allows developers to deploy an application on a fully managed platform. In addition, Google offers data analytics platforms such as BigQuery, which allows users to run SQL-like queries against multi-terabyte datasets. Cloud Endpoints allows developers to create RESTful services accessible from mobile and browser clients. In addition, Google's established products, such as Cloud Translation, are available as APIs for access to developers to integrate into their own applications.

## OpenStack

All of the stacks we have looked at so far are proprietary stacks hosted by the companies on their public clouds. The OpenStack model is markedly different as it's an open-source cloud stack that is available for both public and private clouds. OpenStack defines itself as a "cloud operating system that controls large pools of compute, storage, and networking resources throughout a datacenter, all managed and provisioned through APIs with common authentication mechanisms." OpenStack can be deployed anywhere, from a bunch of machines to an entire datacenter. Public clouds that offer OpenStack include Rackspace and HP Helion.

**Compute**: OpenStack's compute offering provides similar services to the public cloud counterparts, with the ability to manage virtualized and commodity server resources with API-based access. OpenStack's compute system (called Nova) supports creating virtual machines and bare-metal servers (through the use of Ironic), and has limited support for system containers. 

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