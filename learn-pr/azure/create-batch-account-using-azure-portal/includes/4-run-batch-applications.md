## Run tasks concurrently by using the Batch REST API

Azure Batch uses parallel tasks to split a job across compute nodes. Azure Batch is especially well suited to running large-scale parallel and high-performance computing batch jobs. The Batch service handles everything for you, which includes managing and scheduling all the nodes and applications that are required to run your scenarios.

With a smaller number of nodes in a pool, you can maximize the resource usage by running more than one task simultaneously. Certain workloads might see shorter job times and lower costs when multiple tasks share compute nodes.

Some scenarios might require you to minimize data transfers for tasks that can share data. You can dramatically reduce the data transfer charges by copying shared data to a smaller number of nodes and run tasks in parallel on each node. This approach reduces the time taken to transfer data to all nodes instead of sharing data to a large number of nodes.

## Enable parallel task execution

Parallel task execution controls how many tasks a single node can handle concurrently in one pool.

In Batch, slots control parallel task execution. Tasks have a property called `RequiredSlots`, which denotes how resource intensive a task is. Resource-intensive tasks require more slots than resource-light tasks do.

When you create a pool, you specify how many task slots are available per node by setting the `taskSlotsPerNode` property. This property governs the resource intensity of the tasks that can run concurrently on a node.

For example, if a pool's `taskSlotsPerNode` property is set to 16, the tasks running concurrently on a node will never require more than 16 slots. This setting means that, for example:

- Two tasks that require eight slots can run at the same time because the number of slots equals 16 (2 * 8 = 16)
- Three tasks that require five slots can run at the same time because the number of slots is less than 16 (3 * 5 = 15)
- Five tasks that require four slots can't run at the same time because the number of slots is more than 16 (5 * 4 = 20)

At maximum, the `taskSlotsPerNode` property can be up to four times the number of vCPUs that a node has. To figure out how many vCPUs are available on a node, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

> [!NOTE]
> After you've set the `taskSlotsPerNode` property, you can't modify it. Changing it requires creating a new pool.

Set the `RequiredSlots` property based on how much CPU or memory you expect the task to need, or how I/O intensive you expect a task to be. Additionally, set the `taskSlotsPerNode` property based on how many tasks can run concurrently without degrading task execution times.

## Add an application package and run a container application on Azure Batch

### Application packages

Within Azure Batch, an *application* refers to a set of versioned binaries that can be automatically downloaded to the compute nodes in your pool. An application contains one or more application packages, which represent different versions of the application.

You can specify application packages at the pool or task level. Pool application packages are appropriate when all the nodes in a pool will run a job's tasks.

You can specify more than one application package when you create a pool. Applications are deployed when a node joins a pool and when the node is restarted or reimaged. To install a new package to an existing pool, you must restart its nodes.

If you choose to deploy an application package at the task level, it'll be useful in shared-pool environments. In those environments, different jobs run on one pool, and the pool isn't deleted when a job finishes. If your job has fewer tasks than nodes in the pool, task application packages can minimize data transfer, because your application is deployed only to the nodes that run tasks.

You can use the Azure portal or the Batch Management APIs to manage the application packages in your Batch account. To use application packages, you must link an Azure storage account to your Batch account. The Batch service uses the associated storage account to store your application packages. We recommend that you create a storage account specifically for use with your Batch account.

### Container applications

Containers are becoming the preferred way to package, deploy, and manage cloud applications. Azure Container Instances is a great solution for any scenario that can operate in isolated containers, including simple applications, task automation, and build jobs.

Using containers provides an easy way to run Batch tasks without having to manage an environment and dependencies to run applications. Containers deploy applications as lightweight, portable, self-sufficient units that can run in several different environments. Container-based tasks in Batch can also take advantage of features of non-container tasks, including application packages and management of resource files and output files.

You can create a container-enabled pool with or without a prefetched container image. The prefetch process lets you preload container images from either Docker Hub or another container registry (like [Azure Container Registry](https://azure.microsoft.com/services/container-registry/)) on the internet.

The advantage of prefetching container images is that when tasks first start running, they don't have to wait for the container image to download. The container configuration pulls container images to the virtual machines when the pool is created. Tasks that run on the pool can then reference the list of container images and container run options.
