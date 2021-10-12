[Azure Batch](/azure/batch/batch-technical-overview) runs large-scale applications efficiently in the cloud. You can schedule compute-intensive tasks and dynamically adjust resources for your solution without managing infrastructure. Azure Batch can create and manage a pool of compute nodes (virtual machines). Azure Batch can also install the application that you want to run, and schedule jobs to run on the compute nodes.

:::image type="content" source="../media/select-azure-batch.png" alt-text="Flowchart for selecting Azure batch.":::

 
### When to use Azure Batch

Azure Batch works well with applications that run independently (parallel workloads). Azure Batch is also effective for applications that need to communicate with each other (tightly coupled workloads). For example, you can use Batch to build a service that runs a Monte Carlo simulation for a financial services company or a service to process images.

Azure Batch enables large-scale parallel and high-performance computing (HPC) batch jobs with the ability to scale to tens, hundreds, or thousands of VMs. When you're ready to run a job, Batch does the following.

- Starts a pool of compute VMs for you.

- Installs applications and staging data.

- Runs jobs with as many tasks as you have.

- Identifies failures.

- Requeues work.

- Scales down the pool as work completes.

 

### How Azure Batch works

As shown in the following diagram, a typical real-world scenario for Azure Batch requires data and application files. The Batch workflow begins with uploading the data and application files to an Azure storage account. Based on the demand, you create a Batch pool with as many Windows or Linux virtual compute nodes as needed. If the demand increases, compute nodes can be automatically scaled.

:::image type="content" source="../media/azure-batch.png" alt-text="Azure Batch uploads, downloads, creates, and monitors tasks.":::


You can think of the diagram in two parts:

- **Your service** that uses Azure as the platform. The platform is for completing computationally intensive work and then retrieving results. You can also monitor jobs and task progress. 

- **Batch as the compute platform behind your service.** Batch uses Azure Storage to fetch applications or data needed to complete a task. Azure Batch writes output to Azure storage. Behind the scenes, there are collections (pools) of virtual machines. Pools are the resources that jobs, and tasks are executed on.

 

### Best practices and useful tips for using the Azure Batch service

Best practices for Azure Batch are grouped into pools, nodes, and jobs. 

- **Pools.** If your jobs consist of short-running tasks, don’t create a new pool for each job. The overhead to create new pools will diminish the run time of the job. Also, it's best to have your jobs use pools dynamically. If your jobs use the same pool for everything, there's a chance that jobs won't run if something goes wrong with the pool.

- **Nodes.** Individual nodes aren’t guaranteed too always be available. If your Batch workload requires deterministic, guaranteed progress, you should allocate pools with multiple nodes. Consider using isolated VM sizes for workloads with compliance or regulatory requirements.

- **Jobs.** Uniquely name your jobs so you can accurately monitor and log the activity. Consider grouping your tasks into efficiently sized jobs. For example, it's more efficient to use a single job containing 1000 tasks rather than creating 100 jobs that contain 10 tasks each. 

> [!TIP]
> We’ve covered just a few best practices. Take a few minutes to read more about [Best practices - Azure Batch | Microsoft Docs](/azure/batch/best-practices).