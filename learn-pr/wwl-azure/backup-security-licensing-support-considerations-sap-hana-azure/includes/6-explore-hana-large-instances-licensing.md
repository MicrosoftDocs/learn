For HANA, you need licenses and software installation components for SAP HANA (platform or enterprise edition).

For SAP applications, you need to account for:

 -  Licenses and software installation components for any SAP applications that connect to SAP HANA and related SAP support contracts.
 -  Licenses and software installation components for any non-SAP applications used with SAP HANA on Azure (Large Instances) environments and related support contracts.

You will also need to account for the following (as explained earlier, there is no internet access within the HANA Large Instance datacenter):

 -  **Licenses for SUSE Linux Enterprise Server 12 for SAP Applications**: The operating system delivered by Microsoft isn't registered with SUSE. It isn't connected to a Subscription Management Tool instance. To remediate this, you will need to deploy SUSE Linux Subscription Management Tool in an Azure VM. This tool provides the capability for SAP HANA on Azure (Large Instances) to be registered and respectively updated by SUSE.
 -  **Licenses for Red Hat Enterprise Linux 6.7 or 7.x for SAP HANA**: The operating system delivered by Microsoft isn't registered with Red Hat. It isn't connected to a Red Hat Subscription Manager instance. To remediate this, you will need to deploy Red Hat Subscription Manager deployed in an Azure VM. The Red Hat Subscription Manager provides the capability for SAP HANA on Azure (Large Instances) to be registered and respectively updated by Red Hat.
