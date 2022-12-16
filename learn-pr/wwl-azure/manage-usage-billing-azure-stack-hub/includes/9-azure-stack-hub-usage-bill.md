Below are frequently asked questions on usage and billing for Azure Stack Hub.

### Which Azure Stack Hub deployments are charged?

Resource usage is free for the ASDK. Azure Stack Hub multi-node systems, workload virtual machines, storage services, and App Services are charged.

### Are users charged for the infrastructure virtual machines?

No. Usage data for some Azure Stack Hub resource provider virtual machines are reported to Azure, but there are no charges for these virtual machines, nor for the virtual machines created during deployment to enable the Azure Stack Hub infrastructure.

Users are only charged for virtual machines that run under tenant subscriptions. All workloads must be deployed under tenant subscriptions to comply with the licensing terms of Azure Stack Hub.

### I have a Windows Server license I want to use on Azure Stack Hub, how do I do it?

Using the existing licenses avoids generating usage meters. Existing Windows Server licenses can be used in Azure Stack Hub. In order to use their existing licenses, customers must deploy their Windows Server virtual machines as described in [Hybrid benefit for Windows Server license](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).

### Which subscription is charged for the resources consumed?

The subscription that's provided when registering Azure Stack Hub with Azure is charged.

### What types of subscriptions are supported for usage data reporting?

For Azure Stack Hub multi-node, Enterprise Agreement (EA) and CSP subscriptions are supported. For the ASDK, Enterprise Agreement (EA), pay-as-you-go, CSP, and MSDN subscriptions support usage data reporting.

### Does usage data reporting work in sovereign clouds?

In the ASDK, usage data reporting requires subscriptions that are created in the global Azure system. Subscriptions created in one of the sovereign clouds (the Azure Government, Azure Germany, and Azure China 21Vianet clouds) can't be registered with Azure, so they don't support usage data reporting.

### Why doesn't the usage reported in Azure Stack Hub match the report generated from Azure Account Center?

There's always a delay between the usage data reported by the Azure Stack Hub usage APIs and the usage data reported in the Azure Account Center. This delay is the time required to upload usage data from Azure Stack Hub to Azure commerce. Because of this delay, usage that occurs shortly before midnight might appear in Azure the following day. If you use the Azure Stack Hub usage APIs and compare the results to the usage reported in the Azure billing portal, you can see a difference.
