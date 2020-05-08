SAP HANA on Azure (Large Instances) is a unique solution to Azure. In addition to providing virtual machines for deploying and running SAP HANA, Azure offers you the possibility to run and deploy SAP HANA on bare-metal servers that are dedicated to you. The SAP HANA on Azure (Large Instances) solution builds on non-shared host/server bare-metal hardware that is assigned to you. The server hardware is embedded in larger stamps that contain compute/server, networking, and storage infrastructure. As a combination, it's HANA tailored data center integration (TDI) certified. SAP HANA on Azure (Large Instances) offers different server SKUs or sizes. Units can have 36 Intel CPU cores and 768 GB of memory and go up to units that have up to 480 Intel CPU cores and up to 24 TB of memory.


## Prerequisites for deploying HANA large instance units

Microsoft requires the following information to deploy HANA large instance units:
* Customer name

* Business contact information (including email address and phone number)

* Technical contact information (including email address and phone number)

* Technical networking contact information (including email address and phone number)

* Azure deployment region (for example, West US, Australia East, or North Europe)

* SAP HANA on Azure (large instances) SKU (configuration)

For every Azure deployment region:

* A /29 IP address range for ER-P2P connections that connect Azure virtual networks to HANA large instances.

* A /24 CIDR Block used for the HANA large instances server IP pool.

* The IP address range values used in the virtual network address space attribute of every Azure virtual network that connects to the HANA large instances.

## Required data for each HANA large instance
The following information is required for deploying HANA large instance units: 

* Desired hostname, ideally with a fully qualified domain name.

* Desired IP address for the HANA large instance unit out of the Server IP pool address range. (The first 30 IP addresses in the server IP pool address range are reserved for internal use within HANA large instances.)

* SAP HANA SID name for the SAP HANA instance (required to create the necessary SAP HANA-related disk volumes). Microsoft needs the HANA SID for creating the permissions for sidadm on the NFS volumes. These volumes attach to the HANA large instance unit. The HANA SID is also used as one of the name components of the disk volumes that get mounted. If you want to run more than one HANA instance on the unit, you should list multiple HANA SIDs. Each one gets a separate set of volumes assigned.

* In the Linux OS, the sidadm user has a group ID. This ID is required to create the necessary SAP HANA-related disk volumes. The SAP HANA installation usually creates the sapsys group, with a group ID of 1001. The sidadm user is part of that group.

* In the Linux OS, the sidadm user has a user ID. This ID is required to create the necessary SAP HANA-related disk volumes. If you're running several HANA instances on the unit, list all the sidadm users.

* The Azure subscription ID for the Azure subscription to which SAP HANA on Azure HANA large instances are going to be directly connected. This subscription ID references the Azure subscription, which is going to be charged with the HANA large instance unit or units.

After you provide the preceding information, Microsoft sends you information to link your Azure virtual networks to HANA large instances. You can also access the HANA large instance units.

Use the following sequence to connect to the HANA large instances after Microsoft has deployed it:

1. Connect a VNet to HANA large instances ExpressRoute

2. Connect Azure VMs to HANA large instances

3. Implement additional network requirements (optional)
