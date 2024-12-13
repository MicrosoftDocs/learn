You now need to determine what kind of virtual machine (VM) nodes you need and how many nodes you need to run.

## What size virtual machines do you need?

In Azure Kubernetes Service (AKS), each node in your cluster is an Azure VM. VMs come in various specifications to help support the demands of different types of applications. Some applications might need more processing power or memory, or faster storage. You need to select a VM category and instance that meets the needs of your application.

You want to make sure the type has enough memory and processing power for your application. Keep in mind that not all of the memory and processing power is available for your application. Some of this power is needed for the operating system and for Kubernetes system components. AKS automatically reserves a certain amount of memory and processing power to ensure these critical system components can operate as needed.

The default VM type deployed as part of an AKS cluster is the *D2 v3 general purpose virtual machine*, a two core VM with 8 gigabytes of memory. AKS reserves 100 millicores of processor and 3.55 GiB of memory, leaving 1,900 millicores (1.9 cores) and 5.45Gi of memory free for your application.

> [!TIP]
> The amount of reserved processor and memory varies depending on the type of VM you select. This amount becomes proportionally smaller as the VM size increases.

Another consideration is *stranded resources*. Imagine that you deploy three applications to a D2 v3 node. Each of those applications requires 600 millicores of processor and 500Mi of memory. Once you deploy those applications, 100 millicores of processor remains, and there's about 2.05 GiB of unused memory. If you deployed a fourth instance of the application, you would need to send it to a new node because the remaining 100 millicores aren't sufficient. However, that leaves 2 GiB of memory on the node that can't be used. That memory resource is referred to as *stranded*.

An ideal VM choice is one with enough capacity to run your workloads without leaving resources stranded. If workloads scale up and down dynamically, you want enough resources to cover typical usage scenarios, but the flexibility to scale up when needed.

## How many nodes do you need?

Your application should always be available and able to handle failure of the underlying nodes. You can provide resilience with multiple replicas of the application spread across multiple nodes.

AKS has *node pools*, which are groups of VMs of the same type. You can have multiple node pools. For example, you could have a node pool that contains general purpose VMs, a node pool with memory-optimized VMs, and a node pool with GPU-equipped VMs. You can then use the native Kubernetes scheduling feature to ensure your workloads are deployed to the appropriate node pool and VM type.

Node pools can support one of two modes: *System* or *User*. *System node pools* run critical system pods that are essential to the operation of your Kubernetes cluster, including services such as storage drivers, DNS, or metrics servers. *User node pools* run your applications.

In a default configuration, an AKS cluster contains a single System node pool, which is used to run everything. If you want, you can add extra System or User node pools and configure your application pods to run exclusively in the User node pools. Critical system pods run only in the System node pools. Using System and User node pools can prevent incorrectly configured applications from affecting the operation of critical system services and potentially causing the cluster to fail.

Kubernetes can also add or remove nodes when necessary. If you plan to use this feature, you need to define an upper limit for the maximum number of nodes that Kubernetes can scale up to. Then, plan your network design around that maximum number. Keep in mind that you need to account for at least one extra node per cluster to allow for the update process to run properly.

> [!TIP]
> You can configure the number of nodes updated at a given time, with *one* being the default value. Upgrading more than one node at a time can decrease the overall time taken to upgrade a cluster. You need to account for extra nodes as part of your planning.

## How many nodes should you run?

To determine the number of nodes to run, you need to understand the application's processor and memory requirements. The development team provided you with the results of their performance testing with details of how much processor and memory the services need. The results include the baseline requirements along with the maximum amounts for busier periods:

Service | Processor min / max | Memory min / max
--- | --- | ---
Website front end | 250 m / 1000 m | 250 Mi / 1 Gi
Identity API | 100 m / 500 m | 250 Mi / 500 Mi
Catalog API | 500 m - 1000 m | 1 Gi / 1 Gi
Orders API | 100 m - 1000 m | 100 Mi / 1 Gi
Orders helper | 100 m - 1000 m | 100 Mi / 1 Gi
Basket API | 100 m - 1000 m | 500 Mi / 500 Mi
Marketing API | 250 m - 750 m | 500 Mi / 1 Gi
Locations API | 100 m - 500 m | 100 Mi / 500 Mi

> [!TIP]
>
> * Kubernetes measures processor usage in millicores, or thousandths of a core. Therefore, 100m equates to a tenth of a core, and 1000m equates to one single processor core.
> * You can measure memory in a number of ways. The examples in the performance testing results chart use Mi and Gi, which are the power of two equivalents of Megabyte and Gigabyte. 500Mi is generally referred to as 500 Megabytes and 1Gi is generally referred to as 1 Gigabyte.

## Sizing your nodes

You determined the minimum number of replicas that each service should run and the minimum number of processor cores and memory that each service requires. This calculation gives you a figure of 1.5 cores and 2.8Gi of memory as the starting point. When the application scales up to its maximum number of replicas and is using its maximum number of processor cores and amount of memory, it needs 53 cores and 50 GB of memory.

In this scenario, the workloads are CPU intensive. If you go with the default D2 v3 general purpose VM, you would need a large number of them to meet the workload's processor requirements. This configuration would result in a large amount of unused memory across the VMs. Let's consider a VM type intended for compute intensive workloads. For example, something from the Fsv2-series would need fewer VMs to meet the processor requirements and would have a lower amount of unused memory.

The F8s v2 VM type has 8 cores and 16 GB of memory. With the AKS resource reservations, you have 7820 millicores and 12.65Gi for each node. When running at maximum scale, you would need seven VMs to handle the workloads.

Now, you need to take a look at the network.
