Given the variety of Azure infrastructure options, nearly all existing SAP NetWeaver and S/4HANA systems can be hosted in Azure. Azure supports virtual machine SKUs with terabytes of memory and more than 200 CPUs.

## Verify workload deployment requirements

To successfully deploy SAP systems into Azure IaaS (or IaaS in general), it's important to understand the differences between the offerings of traditional outsourcers or hosters and IaaS offerings. While the traditional hoster or outsourcer adapts infrastructure (network, storage and server type) to the workload a customer wants to host. It's the customer's or partner's responsibility to identify the workload’s requirement and choose the correct Azure components of virtual machines, storage, and network for IaaS deployments.

## SAP supported products and Azure Virtual Machine types

As the first step, customers need to verify the following items:

- The SAP supported virtual machine types of Azure
- The SAP supported products/releases on Azure
- The supported OS and DBMS releases for the specific SAP releases in Azure
- SAPS throughput provided by different Azure Virtual Machine SKUs

The answers to these questions can be found in [SAP Note \#1928533](https://me.sap.com/notes/1928533), which is described in more detail elsewhere. As mentioned there, as part of your initial planning, you also need to choose between the two-tier or three-tier architecture. Three-tier architecture separates the **presentation tier**, the **application tier**, and the **database tier**. The presentation tier hosts user interface components, such as SAP GUI, Fiori User Experience, or Web Dynpro. The application tier consists of the SAP Central Services instance that's part of either the ABAP or Java stack, and application servers, with one primary instance and zero or more other instances. In two-tier configurations, you install the database and all SAP components on the same virtual machine to avoid network contention and minimize latency. With three-tier configurations, the separation of the database and SAP application components facilitates several high-availability deployments.

## Verify bandwidth limitations

As the second step, Azure IaaS resource and bandwidth limitations need to be compared to actual resource consumption of on-premises systems. Therefore, customers need to be familiar with the different capabilities of the Azure Virtual Machines supported with SAP in:

- **CPU and memory resources**
- **Storage IOPS and throughput**
- **Network bandwidth and latency**

The relevant information can be found in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

Keep in mind that the Azure Virtual Machine limits, provided in the previous reference link, constitutes upper limits. As the result, they might not be representing the actual resource availability under all circumstances. The exceptions are the CPU and memory resources of a chosen virtual machine type. For the virtual machine types supported by SAP, the CPU and memory resources are reserved and as such available at any point in time for consumption within the virtual machine. For others, such as storage or network, resources are shared between tenants. Intelligent throttling and quota logic are used to prevent one tenant from impacting the performance of another tenant in a significant way. Though logic in Azure tries to keep variances in bandwidth experienced small, highly shared platforms tend to introduce larger variances in resource/bandwidth availability than customers might experience in their on-premises deployments. The probability that an SAP system on Azure could experience larger variances than in an on-premises system needs to be considered.

> [!NOTE]
> Some Azure subscriptions limits are managed at a regional level. An example is vCPUs. To request a quota increase with support for vCPUs, you must decide how many vCPUs you want to use in which regions. You then request an increase in vCPU quotas for the amounts and regions that you want. For help in how to determine your current quotas for specific regions, see [Resolve errors for resource quotas](/azure/azure-resource-manager/templates/error-resource-quota). To request a quota increase, go to the portal and [file a support issue](/azure/azure-portal/supportability/how-to-create-azure-support-request). In the support issue, request an increase in your quota for the region into which you want to deploy.

## Resiliency requirements and other considerations

The next step is to evaluate resiliency requirements. In order to mitigate the rare cases where virtual machines are affected by planned maintenance or a platform-related issue, and to facilitate patching guest OS or DBMS components, you need to design high availability and disaster recovery for your production SAP systems.

In addition, your planning should account for manageability, data protection and security, authentication, authorization, and access control, as well as monitoring, licensing, support, and pricing considerations.

The planning process differs depending on the architecture and components of the intended deployment, explored in the context of the following deployment models:

- SAP NetWeaver with AnyDB on Azure Virtual Machines
- SAP S/4HANA on Azure Virtual Machines

## Microsoft Well Architected framework based review

The [SAP on Azure Architecture Guide](/azure/architecture/reference-architectures/sap/sap-overview) describes a set of guiding tenets that are used to help ensure the quality of SAP workloads running on Azure. The guide is based on the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/index), but the recommendations are specific to deployments of SAP solutions. The SAP on Azure Architecture Guide covers five pillars of excellence: cost, DevOps, resiliency, scalability, and security. You can access these pillars for your solutions using the [Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment).
