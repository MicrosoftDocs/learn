Azure CycleCloud is an application that provides a simple, secure, and scalable way to create, customize, and manage high-performance computing (HPC) clusters in Azure.

## Scenario

Contoso, Ltd. is an oceanographic and meteorological services company based in Houston, Texas. Its research team relies heavily on an on-premises HPC cluster to run Slurm-based tasks.

The newly initiated project involves several simulations that track storms moving through the US Gulf Coast during storm season. Unfortunately, an initial assessment determined that the existing on-premises HPC cluster doesn't have sufficient compute capacity to run the simulations.

As the lead research engineer, you want to use Contoso's existing Azure subscription to provision a new HPC cluster. To use your team's technical expertise, you want to ensure that the cluster you deploy in Azure closely matches the architecture and software stack of the on-premises cluster. At the same time, you need to consider the directives from your management team, who stressed the importance of keeping the cluster's cost within the project's budget.

You start exploring the options for deploying, operating, and monitoring HPC clusters in Azure. To simplify these tasks, you decide to evaluate the functionality of Azure CycleCloud.

## What will we be doing?

In this module, you'll first deploy an Azure VM hosting the Azure CycleCloud application and configure it to work with your Azure subscription. Then, you'll use the graphical interface of the newly deployed Azure CycleCloud application to create an HPC cluster based on built-in Slurm templates and then validate its basic functionality. To address directives from your management team, you'll also configure budget alerts, terminate the cluster after you complete your evaluation, and delete all resources you provisioned during this module to avoid any unnecessary costs.

## What is the main goal?

By the end of this module, you'll know more about how to install and configure Azure CycleCloud, describe its integration options with non-Microsoft schedulers, and use it to deploy a basic HPC cluster in Azure.
