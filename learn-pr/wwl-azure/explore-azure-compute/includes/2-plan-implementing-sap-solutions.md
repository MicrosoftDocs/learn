Given the wide variety of Azure infrastructure options, nearly all existing SAP NetWeaver and S/4HANA systems can be hosted in Azure. Azure supports VM SKUs with terabytes of memory and more than 200 CPUs. For even more demanding workloads, Azure offers SAP HANA on Azure (Large Instances) (HLI), which allow for HANA deployments that can scale up to 24 TB and scale-out to 120 TB.

To successfully deploy SAP systems into Azure IaaS (or IaaS in general), it's important to understand the differences between the offerings of traditional outsourcers or hosters and IaaS offerings. While the traditional hoster or outsourcer adapts infrastructure (network, storage and server type) to the workload a customer wants to host. It's the customer's or partner's responsibility to identify the workload’s requirement and choose the correct Azure components of VMs, storage, and network for IaaS deployments.

As the first step, customers need to verify the following items:

 -  The SAP supported VM and HLI types of Azure
 -  The SAP supported products/releases on Azure
 -  The supported OS and DBMS releases for the specific SAP releases in Azure
 -  SAPS throughput provided by different Azure VM and HLI SKUs

The answers to these questions can be found in [SAP Note \#1928533](https://launchpad.support.sap.com/#/notes/1928533), which is described in more detail elsewhere. As mentioned there, as part of your initial planning, you also need to choose between the two-tier or three-tier architecture. Three-tier architecture separates the **presentation tier**, the **application tier**, and the **database tier**. The presentation tier hosts user interface components, such as SAP GUI, Fiori User Experience, or Web Dynpro. The application tier consists of the SAP Central Services instance that is part of either the ABAP or Java stack, and application servers, with one primary instance and zero or more additional instances. In two-tier configurations, you install the database and all SAP components on the same VM to avoid network contention and minimize latency. With three-tier configurations, the separation of the database and SAP application components facilitates several high-availability deployments. The three-tier architecture is implied in HLI.

As the second step, Azure IaaS resource and bandwidth limitations need to be compared to actual resource consumption of on-premises systems. Therefore, customers need to be familiar with the different capabilities of the Azure VMs and HLI supported with SAP in:

 -  **CPU and memory resources**
 -  **Storage IOPS and throughput**
 -  **Network bandwidth and latency**

The relevant information can be found in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes) (and at [Available SKUs for HANA Large Instances](/azure/virtual-machines/workloads/sap/hana-available-skus) for HLI).

Keep in mind that the Azure VM limits provided in the documentation referenced above constitute upper limits. As the result, they might not be representing the actual resource availability under all circumstances. The exceptions are the CPU and memory resources of a chosen VM type. For the VM types supported by SAP, the CPU and memory resources are reserved and as such available at any point in time for consumption within the VM. For others, such as storage or network, resources are shared between tenants. Intelligent throttling and quota logic are used to prevent one tenant from impacting the performance of another tenant in a significant way. Though logic in Azure tries to keep variances in bandwidth experienced small, highly shared platforms tend to introduce larger variances in resource/bandwidth availability than customers might experience in their on-premises deployments. The probability that an SAP system on Azure could experience larger variances than in an on-premises system needs to be considered.

The next step is to evaluate resiliency requirements. In order to mitigate the rare cases where VMs are affected by planned maintenance or a platform-related issue, and to facilitate patching guest OS or DBMS components, you need to design high availability and disaster recovery for your production SAP systems.

In addition, your planning should account for manageability, data protection and security, authentication, authorization, and access control, as well as monitoring, licensing, support, and pricing considerations.

The planning process differs depending on the architecture and components of the intended deployment. We will review them in the context of the following deployment models:

 -  SAP NetWeaver with AnyDB on Azure VMs
 -  SAP S/4HANA on Azure VMs

> [!NOTE]
> HLI is described in more detail later.
