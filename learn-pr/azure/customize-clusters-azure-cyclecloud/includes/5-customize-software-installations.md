Azure CycleCloud templates facilitate setting up HPC clusters by abstracting implementation details of the underlying infrastructure, allowing you to focus on workload management. However, that workload typically has several software-related dependencies, which require additional customization steps. Fortunately, Azure CycleCloud also provides a framework for implementing these steps through its support for provisioning and configuration-management tasks applied directly to cluster nodes. 

Your goals include the need for deploying custom images and using in-house developed configuration scripts you've been using in your on-premises HPC environment. You want to determine how you can use the Azure CycleCloud capabilities to accomplish these goals.

## How to implement configuration management with Azure CycleCloud?

Azure CycleCloud offers three main methods that you can combine in an arbitrary manner to customize operating system and software on cluster nodes according to your own requirements or preferences:

- Custom images
- Projects
- Cloud-init

### How to use custom images with Azure CycleCloud?

Azure CycleCloud supports cluster nodes running most common Linux distributions, and, depending on the scheduler, Windows Server. The built-in templates are preconfigured with the recommended defaults, but you're free to choose Azure Marketplace images or provision nodes based on custom images. The latter option might be preferable if you want to minimize delay associated with post-deployment setup of the operating system and any additional dependencies of your HPC workloads. It might also be required to satisfy business, security, or compliance needs.

Custom images allow you to have full control over the preinstalled software and the initial operating-system configuration. Their primary drawback is the overhead associated with maintaining multiple images to accommodate different combinations of applications and their versions, especially in development scenarios.

### How to use Azure CycleCloud projects for software installation?

An Azure CycleCloud project is a collection of files that you reference when defining configurations of cluster nodes through templates. Projects have the following directory structure:

```ini
\project
      |- project.ini
      |- blobs
      |- templates
      |- specs
      |      | 
      |    default
      |      |- cluster-init
      |            |- scripts
      |            |- files
      |            |- tests
      |      | - chef
      |            |- site-cookbooks
      |            |- data_bag
      |            |- roles

```

The **project.ini** file contains the project's metadata, including its name, label, version, and type. The supported types include scheduler and application. The first is used to install and initialize scheduler daemons on head nodes and compute nodes, while the latter defines cluster workloads.

The blobs directory contains project blobs, such as binary files for an open-source project that can be freely redistributed, and user blobs, which must be excluded from the project redistribution because of licensing constraints.

The templates directory contains templates, while the specs directory hosts specifications defining configurations to be applied to target cluster nodes.

> [!NOTE]
> As an example, a Slurm project contains, at minimum, two specs: one for the scheduler head nodes and the other for the compute nodes.

Within the specs directory, there are two subdirectories named *cluster-init* and *custom Chef*. Cluster-init contains scripts that run automatically on the target node. Raw data files that are copied to the target node, and tests that will be run when a cluster is started in the testing mode. The custom Chef subdirectory contains Chef-specific files, including cookbook-, data bag-, and role-definition files. You can use Chef cookbooks and recipes for configuring nodes. Cluster-init specs maps to Chef roles and cookbooks.

> [!NOTE]
> Azure CycleCloud uses Chef as the configuration-management tool for preparing and configuring each node. CycleCloud uses Chef in a standalone mode that doesn't rely on a centralized Chef server. Instead, all cookbooks destined for the managed cluster nodes are downloaded from the locker during the operating system boot phase. At that point, Chef processes the list of recipes defined in the node's cluster-init specs, effectively converting the underlying VM into a working HPC node.

To provision a cluster based on a project, you need to upload the project's content to an Azure CycleCloud locker. Then, whenever the target node starts, it automatically downloads the required project files from the locker and processes the required specs.

### How to use cloud-init with Azure CycleCloud?

Azure CycleCloud supports cloud-init as a way of configuring cluster nodes during the boot phase, before project-related specs are applied. This provides a convenient method to address any infrastructure or software-related dependencies, such as configuring network settings or applying operating system package updates.

While you can define cloud-init configuration by using a template, you can also accomplish this directly from the Azure CycleCloud graphical interface. When creating or editing a cluster, you'll find the relevant settings on the tab labeled **Cloud-Init**, where you can enter the scripts for each node type.

> [!NOTE]
> Since cloud-init runs before any CycleCloud project specs, the scheduler and the configuration which Azure CycleCloud applies to a node might overwrite changes made via cloud-init. If you need to ensure that your commands run after the scheduler is installed, you should use Azure CycleCloud project specs instead.
