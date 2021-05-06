<!--
management
migration
security
redundancy

Ways that the Azure VMware Solution is different than running VMware on-premises
billing and licensing
support and responsibility matrix
service components
network connectivity

-->
Azure VMware Solution (AVS) provides you with private clouds that contain vSphere clusters, built from dedicated bare-metal Azure infrastructure. Keep managing your existing environments with the same VMware tools you already know while you modernize your applications using Azure services. 

This unit you will cover the tools and services to manage, migrate, secure, and provide continuity of operations for your AVS environment. 

### Familiar and consistent VMware tools and technology
Create operational consistency for admins as you continue to use VMware for resources running on Azure infrastructure including vSphere Client and NSX-T Manager. The Azure portal is used for deployment and several management operations. 

Access to vSphere, VMware HCX, and NSX-T are enabled during the Private Cloud deployment process. Credentials are registered in Azure connect to the private cluster hosts.

### Continuity of Operations
Azure VMware Solution provides application high availability and modernization with well-managed Azure Infrastructure designed for end-to-end High Availability. The Azure VMware Solution has built in redundancy with no single point of failure. 

With AVS, you can deploy VMware resources on Azure for a primary or secondary on-demand recovery site to provide business continuity for your existing on-premises datacenter resources. 

### Seamless integration for Azure infrastructure resources 
Easily scale and manage your infrastructure as your business needs it through the Azure portal and native tools. Add new nodes as required to increase compute and storage during peak times. And delete nodes seasonally when infrastructure demands are lower. 

Add and delete new clusters as required:

- Min 3 nodes per cluster
- Max 16 nodes in a vSphere cluster
- Max 64 nodes to an Azure Private Cloud instance

Once AVS is deployed into your subscription, Azure Monitor logs are generated automatically. Azure Monitor logs can provide the following data:

- Collect logs on each of your VMs.
- Download and install the MMA agent on Linux and Windows VMs.
- Enable the Azure diagnostics extension.
- Create and run new queries.
- Run the same queries you usually run on your VMs



###  Migration into Azure VMware Solutions
Before to migrating to Azure VMware Solution (AVS), an assessment of on-premises servers in your VMware environment should be completed. One of the recommended tools for assessments is the Azure Migrate: Discovery and assessment tool. An AVS assessment can be created for servers in VMware environment only. The Azure Migrate: Discovery and assessment tool can provide several types of assessments and sizing criteria. There are two types of sizing that you can use to create Azure VMware Solution (AVS) assessments:


|  Assessment Type | Details |
| :---------- | :------------------ |
| Performance-based |Assessments based on collected performance data of on-premises servers. Provides the recommended Node size: Based on CPU and memory utilization data along with node type, storage type, and FTT setting that you select for the assessment.|
| As on-premises |Assessments based on on-premises sizing. Provides data that recommends node size: Based on the on-premises server size along with the node type, storage type, and FTT setting that you select for the assessment. |

Using VMware HCX, you can migrate your VMware workloads to Azure VMware Solution and other connected sites through various migration types. During deployment of the Azure VMware Solution, it deploys and configures HCX Cloud Manager. The HCX Connector is downloaded, installed and configred in your on-premises VMware datacenter. 


### Security and compliance with Azure VMware Solutions
Azure VMware Solution private clouds use vSphere role-based access control for acesss and security. You can integrate vSphere SSO LDAP capabilities with Azure Active Directory. 

In Azure VMware Solution, vCenter has a built-in local user called cloudadmin and assigned to the CloudAdmin role.  The CloudAdmin role has vCenter privileges that differ from other VMware cloud solutions.

- The local cloudadmin user is used to set up users in Active Directory (AD).

- In an Azure VMware Solution deployment, the administrator doesn't have access to the administrator user account. They are, however, assign AD users and groups to the CloudAdmin role on vCenter.

- The private cloud user doesn't have access to and can't configure specific management components supported and managed by Microsoft. For example, clusters, hosts, datastores, and distributed virtual switches.

vSan storage datastore security is provided by data-at-rest encryption that is turned on by default. The encryption is KMS-based and supports vCenter operations for key management. Keys are stored encrypted, wrapped by an Azure Key Vault master key. When a host is removed from a cluster, data on SSDs is invalidated immediately.


### Private cloud networking
The Azure VMware Solution private cloud environment can be accessible from on-premises and Azure-based resources.  The following services deliver the connectivity:

- Azure ExpressRoute
- VPN connections
- Azure Virtual WAN

These services require specific network address ranges and firewall ports for enabling the services. 

You can use an existing ExpressRoute Gateway to connect to Azure VMware Solution as long as it doesn't exceed the limit of four ExpressRoute circuits per virtual network. To access Azure VMware Solution from on-premises through ExpressRoute. You must have ExpressRoute Global Reach since the ExpressRoute Gateway doesn't provide transitive routing between its connected circuits. 

ExpressRoute Global Reach is used to connect private clouds to on-premises environments. The connection requires a virtual network with an ExpressRoute circuit to on-premises in your subscription.
There are two ways to interconnectivity in the Azure VMware Solution private cloud:

- Basic Azure-only interconnectivity lets you manage and use your private cloud with only a single virtual network in Azure. This implementation is best suited for Azure VMware Solution evaluations or implementations that don't require access from on-premises environments.

- Full on-premises to private cloud interconnectivity extends the basic Azure-only implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds.

During the deployment of a private cloud the private networks for management, provisioning, and vMotion get created. These private networks will be used to access vCenter and NSX-T Manager and virtual machine vMotion or deployment.


### Private cloud storage

Azure VMware Solution uses native fully configured all-flash vSAN storage, local to the cluster. All local storage from each host in a cluster is used in a vSAN datastore and data-at-rest encryption enabled by default. De-duplication and compression are enabled on the vSAN datastore by default

All diskgroups use an NVMe cache tier of 1.6 TB with the raw, per host, SSD-based capacity of 15.4 TB. Two disk groups are created on each node of the vSphere cluster. Each disk group contains one cache disk and three capacity disks. All datastores are created as part of a private cloud deployment and are available for use immediately.

Policy is created on the vSphere cluster and applied to the vSAN datastore, determines how the VM storage objects are provisioned and allocated within the datastore to guarantee the required level of service. To maintain SLA, 25% spare capacity must be maintained on the vSAN datastore. 
You can use Azure storage services in workloads running in your private cloud. The Azure storage services include:
- Storage Accounts 
- Table Storage
- Blob Storage



 
