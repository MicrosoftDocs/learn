Microsoft requires the following information to deploy SAP HANA on Azure (Large Instances) units:

 -  Customer name.
 -  Business contact information (including email address and phone number).
 -  Technical contact information (including email address and phone number).
 -  Technical networking contact information (including email address and phone number).
 -  Azure deployment region (for example, West US, Australia East, or North Europe).
 -  SAP HANA on Azure (Large Instances) SKU (configuration).
 -  For every Azure deployment region:
    
     -  A /29 IP address range for ER-P2P connections that connect Azure virtual networks to HANA Large Instances.
     -  A /24 CIDR Block used for the HANA Large Instances server IP pool.
     -  The IP address range values used in the virtual network address space attribute of every Azure virtual network that connects to the HANA Large Instances.

In addition, you need to provide data for each HANA Large Instances system:

 -  Desired hostname, ideally with a fully qualified domain name.
 -  Desired IP address for the HANA Large Instance unit out of the Server IP pool address range. (The first 30 IP addresses in the server IP pool address range are reserved for internal use within HANA Large Instances.)
 -  SAP HANA SID name for the SAP HANA instance (required to create the necessary SAP HANA-related disk volumes). Microsoft needs the HANA SID for creating the permissions for sidadm on the NFS volumes. These volumes attach to the HANA Large Instance unit. The HANA SID is also used as one of the name components of the disk volumes that get mounted. If you want to run more than one HANA instance on the unit, you should list multiple HANA SIDs. Each one gets a separate set of volumes assigned.
 -  In the Linux OS, the sidadm user has a group ID. This ID is required to create the necessary SAP HANA-related disk volumes. The SAP HANA installation usually creates the sapsys group, with a group ID of 1001. The sidadm user is part of that group.
 -  In the Linux OS, the sidadm user has a user ID. This ID is required to create the necessary SAP HANA-related disk volumes. If you're running several HANA instances on the unit, list all the sidadm users.
 -  The Azure subscription ID for the Azure subscription to which SAP HANA on Azure HANA Large Instances are going to be directly connected. This subscription ID references the Azure subscription, which is going to be charged with the HANA Large Instance unit or units.

After you provide the preceding information, Microsoft provisions SAP HANA on Azure (Large Instances). Microsoft sends you information to link your Azure virtual networks to HANA Large Instances. You can also access the HANA Large Instance units.

Use the following sequence to connect to the HANA Large Instances after Microsoft has deployed it:

1.  Connect a VNet to HANA Large Instances ExpressRoute.
2.  Connect Azure VMs to HANA Large Instances.
3.  Implement additional network requirements (optional).
