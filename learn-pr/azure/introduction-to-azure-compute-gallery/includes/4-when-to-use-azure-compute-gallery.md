Now that you know a bit about how Azure Compute Gallery works, let's discuss when you should use a gallery.

Azure Compute Gallery should be used when you have a large number of virtual machine images or applications that you need to maintain and make available throughout your organization. In this scenario, you can use Azure Compute Gallery as a repository.

| Azure Compute Gallery feature | Architecture consideration |
| --- | --- |
| **Support for virtual machine images** | Do you need to store, manage, or share large numbers of custom virtual machine images? Azure Compute Gallery can serve as your image repository, and you can control access to your images. |
| **Support for virtual machine applications** | Do you rely on pre-installing your virtual machine applications on the images? You can use Azure Compute Gallery to separate your application installation from your images. |
| **Scaling** | Do you need to deploy a large number of virtual machines? Azure Compute Gallery allows you to deploy up to 1,000 instances in a scale set. |
| **High availability** | Do you need resilience against Availability zone failures? Azure Compute Gallery supports Azure Zone Redundant Storage. |
| **Replication** | Do you need to be able to replicate your Azure virtual machines resources across Azure regions? You can enable Azure Compute Gallery to do this automatically when you deploy your resources. |
| **Sharing** | Do you need to share your images across people, groups, subscriptions? Do you want to make them publicly available? Azure Compute Gallery has three ways to share your gallery, depending on the needs of your scenario. |

## Limits

There are limits, per subscription, for deploying resources using Azure Compute Galleries. You should keep them in mind when deciding if Azure Compute Gallery is right for your architecture:
- 100 galleries, per subscription, per region
- 1,000 image definitions, per subscription, per region
- 10,000 image versions, per subscription, per region
- 100 replicas per image version however 50 replicas should be sufficient for most use cases
- Any disk attached to the image must be less than or equal to 1 TB in size
- Resource move isn't supported for Azure compute gallery resources
