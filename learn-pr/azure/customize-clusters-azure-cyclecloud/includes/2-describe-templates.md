Azure CycleCloud provides template-based deployment of HPC clusters. By default, the Azure CycleCloud application includes several built-in templates for deploying the most common cluster schedulers, including Slurm, PBSPro, LSF, Grid Engine, and HT-Condor. Azure CycleCloud GitHub repositories offer many scheduler-specific projects, which you can customize and import into your Azure CycleCloud instance. You also have the option of implementing template-based provisioning for your own, in-house developed schedulers by using CycleCloud autoscaling plugins.

Templates facilitate implementing a wide range of Azure CycleCloud features, including support for custom virtual machine (VM) images, autoscaling, and Spot VMs. They also minimize overhead associated with provisioning and maintaining multiple deployments of identically configured clusters, commonly used to isolate the production, development, and test environments.

These benefits align with your objectives for implementing the new Azure-resident cluster for Contoso. To optimize the extent of these benefits, you decide to learn more about the format and the process of implementing Azure CycleCloud templates.

## What is the format of Azure CycleCloud templates?

Templates are INI-formatted files that use the declarative syntax to describe the structure and configuration of a CycleCloud cluster, including cluster node roles and their respective relationships. Templates consist of named sections, with headers designated by one or more pairs of square brackets. The sections form a hierarchy, corresponding to the hierarchy of cluster objects and their corresponding parameters. The number of square brackets represents a tier within that hierarchy, increasing sequentially with each tier.

``` ini
[cluster]
  [[node, nodearray]]
    [[[volume]]]
    [[[network-interface]]]
    [[[cluster-init]]]
    [[[input-endpoint]]]
    [[[configuration]]]
[environment]
[noderef]
[parameters]
  [[parameters]]
    [[[parameter]]]
```

Effectively, the `[cluster]` section might contain one or more `[[node]]` sections, which might contain multiple `[[[volume]]]` sections. Similarly, within the same template, within the `[cluster]` section, you can define one or more `[[nodearray]]` sections, each with its own `[[[configuration]]]`.

> [!NOTE]
> The order of sections within the same tier is arbitrary.

### What are the main sections of a template?

A template consists of the following main sections:

- **Cluster**: The `[cluster]` section contains a definition of an Azure CycleCloud cluster object. A template must include at least one `[cluster]` section, which contains one or more `[[node]]` and `[[nodearray]]` sections describing child objects of that cluster.
- **Node**: This represents a single, platform-provisioned VM.
- **Nodearray**: This represents one or more Azure virtual machine scale sets.

> [!NOTE]
> Clusters comprise nodes serving their designated roles in processing clustered workloads. From the implementation standpoint, Azure CycleCloud relies on Azure Resource Manager to provision them as either individual Azure VMs or as members of a virtual machine scale set. The latter represents a collection of identically configured VMs, which, unlike Azure VMs, support horizontal autoscaling. Azure CycleCloud uses virtual machine scale sets to implement nodearrays. Effectively, the `[[node]]` section describes properties of the underlying, platform-provisioned VMs, which can be a standalone Azure VM or belong to an Azure virtual machine scale set. The `[[nodearray]]` section describes an Azure virtual machine scale set.

> [!NOTE]
> A nodearray can consist of multiple Azure virtual machine scale sets, with each of them comprising differently configured VMs. However, all nodes in a nodearray perform the same role in the cluster, such as providing resources to a single queue of the cluster scheduler.

- **Volume** defines an Azure managed disk that should be attached to individual cluster nodes or nodes forming a nodearray. It's a child object of a node or a nodearray object.
- **Network-interface** defines an Azure network interface that should be attached to individual cluster nodes or nodes forming a nodearray. It's a child object of a node or a nodearray object.
- ***Configuration*** defines the configurable properties of a node or nodearray. It's a child object of a node or a nodearray object.
- **Cluster-init** defines the Azure CycleCloud project specs to apply to a cluster node. A project is a collection of resources that defines node configurations in the form of project specs. When a node starts, it's automatically configured by processing these specs. Cluster-init is a child object of a node or a nodearray object.
- **Environment** defines an Azure Resource Manager deployment, which provisions or modifies Azure resources to be used by the cluster. It's an optional top-level object.
- **Noderef** references a node within the template to express resource dependencies. It's an optional top-level object.
- **Parameters** let you make a template portable, allowing you to use it for deployment of multiple clusters with matching object hierarchy but different configuration settings. It's an optional top-level object, but you have an option of creating a nested parameters hierarchy. For each parameter, you can define its default value. Parameters also allow you to expose configurable variables in a cluster via the CycleCloud Web interface.

Each section contains several key-value pairs that provide configuration details about the corresponding object, represented by the section header. For example, such details for a nodearray could include the `ImageName` key with the value designating the Azure VM image to be used for its nodes, or the `Azure.MaxScalesetSize` key specifying the maximum allowed virtual machine scale set size as its value. Similarly, the node or nodearray sections can include one or more `[[[configuration]]]` sections.

## How to provision a cluster based on a template?

After you identify the template that you intend to use to provision an Azure CycleCloud cluster, you can apply any of the following implementation methods:

- Use Azure CycleCloud CLI to import the template into your Azure CycleCloud application, then use the application's graphical interface to provision the cluster. To trigger the import, run the `cyclecloud import_template -f <template_file>` command (where the `<template_file>` placeholder represents the name of the file containing the template). If the template contains multiple cluster definitions, specify the name of the cluster you want to import by referencing it as the value of the `-c` parameter.
- Use Azure CycleCloud CLI to import the template into your Azure CycleCloud application, then to provision the cluster. To trigger the import, run the `cyclecloud import_template -t -f <template_file>` command (where the `<template_file>` placeholder represents the name of the file containing the template). After the import completes, run the `cyclecloud create_cluster` command. For example, to create a cluster named `lab-cluster` from an imported template named `lab-template`, you'd run `cyclecloud create_cluster lab-template lab-cluster`.
- Use Azure CycleCloud CLI to provision the cluster without explicitly importing the template. To trigger the import, run the `cyclecloud import_cluster` command.

Regardless of the method you choose, you'll need to provide values of any required parameters during cluster provisioning. When using Azure CycleCloud CLI, you can provide them by referencing a JSON-formatted parameters file.

> [!NOTE]
> The file consists of key-value pairs, where the key represents the parameter name. To review its format for an existing cluster, use the `cyclecloud export_parameters <cluster_name> > params.json` command, where the `<cluster_name>` placeholder represents the name of the existing cluster.

> [!NOTE]
> Before you deploy a cluster based on an imported template, you also need to upload the content of the corresponding project into an Azure CycleCloud locker. To perform an upload, use the `cyclecloud project upload <locker_name>` Azure CycleCloud CLI command (where the `<locker_name>` placeholder represents the name of the locker). To list available lockers, run the `cyclecloud locker list` Azure CycleCloud CLI command. The locker name is referenced in the `[[[cluster-init]]]` section.

> [!NOTE]
> One of the steps when setting up an Azure CycleCloud installation is the creation of a blob container in an Azure storage account. This container serves as the locker that the CycleCloud server uses to stage CycleCloud projects for cluster nodes. Subsequently, nodes of the Azure CycleCloud-managed clusters are configured to download CycleCloud projects from this locker as part of their boot process.
