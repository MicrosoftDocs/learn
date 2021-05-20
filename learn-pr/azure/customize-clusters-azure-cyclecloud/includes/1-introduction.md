Azure CycleCloud enables you to customize and manage HPC clusters in Azure.

## Example scenario

Contoso is an oceanographic and meteorological services company based in Houston, TX. Contoso's research team relies heavily on its on-premises High Performance Computing (HPC) cluster to run Slurm-based jobs.

The newly initiated project involves several simulations that will track storms moving through the US Gulf Coast during storm season. Unfortunately, an initial assessment determined that the existing on-premises HPC cluster doesn't have sufficient compute capacity to run the simulations. 

As the lead research engineer, you provisioned a new HPC cluster in Azure, using Contoso's existing Azure subscription. To simplify the provisioning process, you implemented Azure CycleCloud and used it to deploy a new cluster. 

Now you must customize your deployment to optimize it for the new project. You have existing custom images and scripts you've been using in your on-premises HPC environment. You want to reuse these when provisioning the scheduler and compute nodes. You're also exploring options to streamline your deployment process, because you plan to configure matching development and production clusters. You are planning to leverage the capabilities of Azure CycleCloud to accomplish these goals.

## What will we be doing?

You'll start this module by testing the process of implementing a cluster by using a customized Azure CycleCloud template. For this purpose, you will download an existing template from the Azure CycleCloud template GitHub repository, change the definition of the storage configuration in the template, import the newly modified template, and use Azure CycleCloud graphical interface to create a cluster. 

Next you'll use the same template to add an extra nodearray and partition in the cluster definition, ensure that the corresponding cluster resources are configurable via the Azure CycleCloud web interface, export the properties of the newly deployed cluster, update it with the newly configured settings, and import the modified template to apply its configuration to the existing cluster. 

Finally, you will implement a cloud-init script for use with Azure CycleCloud. You will first add the script to both the scheduler and compute nodes, and then start the cluster to verify the cloud-init changes took place.

## What is the main goal?

By the end of this session <!--- Would it make sense to replace word "session" with "module"? --->, you'll be able to customize architecture of HPC clusters running in Azure by using Azure CycleCloud templates. You will also learn how to modify configuration of the cluster nodes by using cloud-init script.
