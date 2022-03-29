While Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge have their distinct use cases, it might be sometimes difficult to determine which of them is optimal in a given scenario.

:::image type="content" source="../media/stack-overview-image-large-1-dca21d7e.png" alt-text="Diagram shows the differences between global Azure, Azure Stack Hub, and Azure Stack HCI capabilities.":::


Use the same application model, self-service portals, and APIs with Azure Resource Manager to deliver cloud-based capabilities whether your business uses global Azure or on-premises resources.

This unit summarizes the differences between global Azure, Azure Stack Hub, and Azure Stack HCI capabilities. It provides common scenario recommendations to help you make the best choice for delivering Microsoft cloud-based services for your organization.

:::image type="content" source="../media/stack-overview-image-large-2-0cf17c6d.png" alt-text="Diagram shows Azure Stack portfolio.":::


## Azure Stack portfolio

The three products of the Azure Stack portfolio help you address the following needs:

 -  **Azure Stack Hub**: Run your own private, autonomous, cloud-native applications in the cloud—connected or disconnected on-premises environment.
 -  **Azure Stack HCI**: Consolidate and modernize virtualized workloads by using on-premises hyperconverged infrastructure and integrate them with Azure.
 -  **Azure Stack Edge**: Get immediate insights into your on-premises data with an Azure-managed, edge computing appliance by using hardware-accelerated machine learning.
    
    :::image type="content" source="../media/azure-family-updated-1-3872bb63.png" alt-text="Diagram of the Azure ecosystem overview.":::
    

To compare the three products, review the following table:

:::row:::
  :::column:::
    **Characteristic**
  :::column-end:::
  :::column:::
    **Azure Stack Hub**
  :::column-end:::
  :::column:::
    **Azure Stack HCI**
  :::column-end:::
  :::column:::
    **Azure Stack Edge**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Number of nodes
  :::column-end:::
  :::column:::
    4-16
  :::column-end:::
  :::column:::
    2-16
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Hardware
  :::column-end:::
  :::column:::
    OEM
  :::column-end:::
  :::column:::
    OEM
  :::column-end:::
  :::column:::
    Microsoft
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support disconnected scenarios.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Modernize aging storage.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud billing for on-premises data workloads
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Provide Azure Consistent IaaS and PaaS.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Build modern apps across cloud and on-premises using Azure services.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Small-footprint branch office scenarios
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Ruggedized form-factors in harsh or remote environments
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support for repurposed hardware
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes. Customers have the option of reusing their existing hardware if provides the required capabilities, as defined by the Azure Stack HCI catalog.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Trusted enterprise virtualization
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    High availability for virtual machines
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Built-in disaster recovery capabilities
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Local Azure Resource Manager control plane
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Built-in multi-tenancy and tenant isolation
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Form-factor choice
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Pre-configured private cloud
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure virtual machines supported through IaaS
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support for Kubernetes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    GPU support
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    FPGA support
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure-managed appliance
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
