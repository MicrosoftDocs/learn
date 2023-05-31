We've looked at the number of pods that our application requires. Now, we need to decide what kind of virtual machine nodes we need. We also need to know how many nodes to run.

## What size virtual machines do you need?

With the Azure Kubernetes Service, each node in your cluster is an Azure Virtual Machine. Virtual machines come in various specifications to help support the demands of different types of applications. Some applications may need more processing power, more memory, or faster storage. You need to select a category and instance of virtual machine that meets the needs of your application.

You want to make sure the virtual machine type has enough memory and processing power for your application. Not all of the memory and processing power of the virtual machine is available for your application. Some is needed for the operating system and for Kubernetes system components. The Azure Kubernetes Service automatically reserves a certain amount of processor and memory to ensure these critical system components can operate as required.

The default virtual machine type deployed as part of an Azure Kubernetes Service cluster is the D2 v3 general purpose virtual machine. It's a two core virtual machine with 8 gigabytes of memory. AKS reserves 100 millicores of processor and 3.55 GiB of memory, leaving 1900 millicores (1.9 cores) and 5.45Gi of memory free for your applications.

> [!TIP]
> The exact amount of processor and memory reserved varies depending on the type of virtual machine selected and becomes proportionally smaller as the virtual machine size increases.

Another consideration is the concept of stranded resources. Let's imagine we deploy three applications to a D2 v3 node. Each of those applications requires 600 millicores of processor and 500Mi of memory. Once those applications are deployed, there are 100 millicores of processor left, but around 2.05 GiB of unused memory. If a fourth instance of the application is deployed it would have to be sent to a new node, as the remaining 100 millicores aren't sufficient. However, there are now 2 GiB of memory on the node that can never be used. That memory resource is now said to be stranded.

The ideal virtual machine choice is one with enough capacity to run your workloads without leaving resources stranded. If workloads scale up and down dynamically, you want enough resources to cover typical every day usage scenarios, but the flexibility to scale up when needed.

## How many nodes do you need?

Deciding what size of virtual machines to use is an important step, but you also have to decide on how many.

Your application should always be available and able to handle failure of the underlying nodes. You can provide resilience with multiple copies (replicas) of the application spread across multiple nodes.

The Azure Kubernetes Service also has the concept of node pools, which groups virtual machines of the same type together. You could have multiple node pools, with one node pool that contains general purpose virtual machines, another node pool with memory optimized virtual machines, or a node pool with GPU equipped virtual machines. You then use the native scheduling features of Kubernetes to ensure workloads are deployed to the appropriate node pool and virtual machine type.

Node pools can support one of two modes, either System mode or User mode. System node pools run critical system pods, essential to the operation of your Kubernetes cluster, including services such as storage drivers, DNS, or metrics servers. User node pools run your applications.

In a default configuration, an Azure Kubernetes Service cluster contains a single System mode node pool, which is used to run everything. However, you can add extra System or User mode node pools. Then, you can configure things so your application pods run exclusively in the User mode node pools. And critical system pods run only in the System mode node pools. Using System and User mode node pools can prevent incorrectly configured applications from affecting the operation of critical system services and potentially causing the cluster to fail.

Along with scaling the number of pods in response to demand, Kubernetes can also add or remove nodes when necessary. If you plan to use this feature, define an upper limit for the maximum number of nodes that Kubernetes can scale up to. Then, plan your network design around that maximum number.

Your Kubernetes cluster is updated frequently. Updates keep the cluster safe from security problems and add new features for both the operating system and Kubernetes components. The update process avoids affecting the normal running of the cluster by temporarily adding new nodes to the cluster. The new nodes maintain the distribution of workloads while nodes are being updated. So, you need to account for at least one extra node per cluster.

> [!TIP]
> The number of nodes updated at a time is configurable, with one being the default value. Upgrading more than one node at a time can decrease the overall time taken to upgrade a cluster, but you'll need to account for those extra nodes as part of your planning.

## How many nodes should you run?

Calculating the number of nodes to run, means we need to understand our application's processor and memory requirements. Ask the development teams to provide you with the results of their performance testing and details of how much processor and memory the services need. The results include the baseline requirements along with the maximum amounts that could be reached during busier periods.

Service | Processor Min / Max | Memory Min / Max
--- | --- | ---
Website Front End | 250 m / 1000 m | 250 Mi / 1 Gi
Identity API | 100 m / 500 m | 250 Mi / 500 Mi
Catalog API | 500 m - 1000 m | 1 Gi / 1 Gi
Orders API | 100 m - 1000 m | 100 Mi / 1 Gi
Orders Helper | 100 m - 1000 m | 100 Mi / 1 Gi
Basket API | 100 m - 1000 m | 500 Mi / 500 Mi
Marketing API | 250 m - 750 m | 500 Mi / 1 Gi
Locations API | 100 m - 500 m | 100 Mi / 500 Mi

> [!TIP]
> In Kubernetes, processor usage is measured in millicores, or thousandths of a core. Therefore 100m equates to a tenth of a core and 1000m equates to one single processor core.
>
> Memory can be measured in a number of ways, the examples in the previous chart are using Mi and Gi, which are the power of two equivalents of Megabyte and Gigabyte. So, 500Mi will generally be referred to as 500 Megabytes and 1Gi is normally referred to as 1 Gigabyte.

## Sizing your nodes

We've determined the minimum number of replicas that each service should run. We also know the minimum number of processor cores and memory that each service requires. Summing up gives us a figure of 1.5 cores and 2.8Gi of memory as our starting point. When our applications scale up to their maximum number of replicas and are using their maximum amounts of processor cores and memory, they're going to need 53 cores and 50 GB of memory.

In our scenario, the workloads are CPU intensive. If we go with the default D2 v3 general purpose virtual machine, we'd need a large number of them to meet the workload's processor requirements. It would also result in a large amount of unused memory across those virtual machines. We could consider a virtual machine type that's intended for compute intensive workloads. For example, something from the Fsv2-series would need fewer virtual machines to meet the processor requirements. It would also have a lower amount of unused memory.

The F8s v2 virtual machine type has 8 cores and 16 GB of memory. With the resource reservations that the Azure Kubernetes Service makes, that gives us 7820 millicores and 12.65Gi usable for each node. When running at maximum scale, we would need seven virtual machines to handle our workloads.

We're making good progress and have now tackled what is probably the hardest part of designing a network. We know how many pods our application needs, the type of virtual machines we want and how many nodes. Next, we take a look at the network.
