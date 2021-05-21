You needed to determine if Azure CycleCloud will allow you to customize the cluster you deployed into Contoso's Azure subscription by modifying its compute and storage resources. You also wanted to validate whether you will be able to configure the operating system on the head and compute nodes by running custom scripts. 

Throughout this module, you stepped through the process of applying changes to a cluster configuration by modifying Azure CycleCloud templates. You started by customizing the storage configuration of a template available from the Azure CycleCloud GitHub repository, imported the template into Azure CycleCloud application, and used the application's graphical interface to create a new cluster. Next, you modified the template further by adding an extra nodearray and partition in the cluster definition and, after reimporting the template, you applied the changes again. Finally, you implemented a cloud-init script and validated its functionality by running it on the head and compute nodes. 

Implementing the equivalent functionality on your own, without the abstraction layer that Azure CycleCloud provides, would be more complex, requiring you to  directly manage the configuration of Azure resources that form building blocks of your clusters. Azure CycleCloud templates offer the declarative provisioning model that helps you minimize administrative overhead associated with deploying and maintaining custom HPC environments in Azure.

## References

* [Cluster Templates](https://docs.microsoft.com/azure/cyclecloud/how-to/cluster-templates)
* [Add a Node Array to a Cluster](https://docs.microsoft.com/azure/cyclecloud/how-to/add-node-array)
* [Managed Disks](https://docs.microsoft.com/azure/cyclecloud/how-to/add-disk)
* [Mounting Volumes](https://docs.microsoft.com/azure/cyclecloud/how-to/mount-disk)
* [Cloud-Init](https://docs.microsoft.com/azure/cyclecloud/how-to/cloud-init)
