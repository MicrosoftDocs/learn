Azure CycleCloud lets you customize and manage high-performance computing (HPC) clusters in Azure.

## Scenario

Contoso is an oceanographic and meteorological services company based in Houston, Texas. Contoso's research team relies heavily on its on-premises HPC cluster to run Slurm-based jobs.

There's a newly initiated project that involves several simulations that will track storms moving through the US Gulf Coast during storm season. Unfortunately, an initial assessment determined that the existing on-premises HPC cluster doesn't have sufficient compute capacity to run the simulations.

As the lead research engineer, you provisioned a new HPC cluster in Azure using Contoso's existing Azure subscription. To simplify the provisioning process, you implemented Azure CycleCloud and used it to deploy a new cluster.

Now, you must customize your deployment to optimize it for the new project. You have existing custom images and scripts you've been using in your on-premises HPC environment. You want to reuse these images and scripts when provisioning the scheduler and compute nodes. You're also exploring options to streamline your deployment process, because you plan to configure matching development and production clusters. You're planning to use the capabilities of Azure CycleCloud to accomplish these goals.

## What will we be doing?

You'll start this module by testing the process of implementing a cluster by using a customized Azure CycleCloud template. For this purpose, you'll download an existing template from the Azure CycleCloud template GitHub repository, change the definition of the storage configuration in the template, import the newly modified template, and use Azure CycleCloud graphical interface to create a cluster.

Next, you'll use the same template to add an extra nodearray and partition in the cluster definition, ensure that the corresponding cluster resources are configurable through the Azure CycleCloud web interface, export the properties of the newly deployed cluster, update it with the newly configured settings, and import the modified template to apply its configuration to the existing cluster.

Finally, you'll implement a cloud-init script for use with Azure CycleCloud. You'll first add the script to both the scheduler and compute nodes, then start the cluster to verify that the cloud-init changes took place.

## What is the main goal?

By the end of this module, you'll know more about how to customize the architecture of HPC clusters running in Azure by using Azure CycleCloud templates. You'll also learn how to modify the configuration of the cluster nodes by using cloud-init script.
