A crucial step towards modernization is integrating SAP managed environments, like RISE with SAP Enterprise Cloud Services (ECS) and SAP S/4HANA Cloud private edition (PCE) in Azure, with your existing Azure ecosystem.

## Enablement of SAP RISE integration scenarios with Azure

It's important to distinguish SAP and customer responsibilities when enabling certain Azure scenarios. The following diagram illustrates the most common scenarios:

:::image type="content" source="../media/sap-rise-integration-table.png" alt-text="Diagram showing the breakdown of responsibility between customer and S A P for different aspects of enablement of integration scenarios.":::

Although there are circumstances when an initial request needs to be placed with SAP RISE for enablement, most Azure scenarios depend on open network communication to available SAP interfaces and activities entirely within the customer's area of responsibility.

## Support in Azure

For SAP RISE customers using Azure, the SAP landscape is within an Azure subscription owned and operated by SAP. This subscription and all associated Azure resources for your SAP environment are exclusively visible to and managed by SAP. Your Azure environment houses applications that interact with these SAP systems, including elements like the following:

- Virtual networks
- Network security groups
- Firewalls
- Routing

Additionally, Azure services such as Azure Data Factory and others operate within your subscription to access the SAP-managed landscape.

Only the resources within your personal Azure subscriptions are eligible for assistance from Azure support. For issues concerning any resources managed in SAP's Azure subscriptions for your SAP RISE workload, you should contact SAP support directly.

:::image type="complex" source="./media/sap-rise-support.png" alt-text="Diagram shows the separation of Azure support between S A P and customer's environments.":::
   This diagram shows a split of different Azure subscriptions. On one side, are all customers subscriptions with customer managed workload. Other half with S A P E C S / RISE subscription containing customer's S A P workload, managed by S A P. Each side responsible themselves to contact Azure support, with no crossed responsibilities.
:::image-end:::

As part of your RISE project, document the interfaces and transfer points between your own Azure environment, the SAP workload managed by SAP RISE, and on-premises. The document should include network information such as the address space, firewalls and routing, file shares, Azure services, DNS, and others. Document the ownership of any interface partners and where any resources are running, to ensure that this information can be accessed quickly during troubleshooting. Contact SAP support for services running in SAP's Azure subscriptions.

> [!IMPORTANT]
> For all details about RISE with SAP and SAP S/4HANA Cloud private edition, contact your SAP representative.

## RISE architecture

SAP creates and manages the entire SAP RISE architecture running in SAP's subscription and Azure tenant. SAP also decides, validates, and deploys all technical elements and details used by SAP for RISE in Azure. Microsoft and SAP work together to create the Azure infrastructure architectures optimized to support the RISE SLAs, to apply Azure best practices by Microsoft, and to adapt best practices to the challenges of SAP RISE managed services. The cooperation on Azure architecture as experienced by RISE customers includes continuous optimizations and adoption of new Azure functionalities to provide added value for RISE customers. Microsoft documents the integration part with SAP RISE in these documents, but not the details about SAP's used architecture, which is intellectual property of SAP. SAP might use modifications and optimizations in their employed architecture that differ from Microsoft's recommended architecture, to fulfill RISE SLAs and customer expectations. Work with SAP on the configuration and customization of your deployed RISE landscape, to fit your organization's requirements.

SAP is responsible for creating and managing the entire RISE architecture, which operates within SAP's subscription and Azure tenant. All technical elements and details utilized by SAP for RISE in Azure are decided upon, validated, and deployed by SAP.

Microsoft and SAP continuously collaborate to develop Azure infrastructure architectures that are optimized to support the RISE Service Level Agreements (SLAs). Together, Microsoft and SAP apply Azure best practices as documented by Microsoft, and adapt these practices to meet the unique challenges posed by the RISE-managed services.

The collaboration on Azure architecture provides RISE customers with continuous optimizations and the adoption of new Azure functionalities. While Microsoft documents the integration aspect with SAP RISE, it doesn't disclose the specifics of SAP's used architecture, which is SAP's intellectual property.

SAP may modify and optimize Microsoft's recommended architecture to meet RISE SLAs and customer expectations. Additionally, SAP works with customers to configure and customize the deployed RISE landscape to suit their organization's specific requirements.
