Azure Batch is a powerful service for running large jobs at scale and in parallel. All the management and scheduling is done for you, and it's a free management plane on top of the underlying Azure Compute that's used to execute your jobs.

You've seen in this module how convenient it is to use the Azure CLI to create all the components of the Azure Batch workflow -- accounts, pools, jobs, and tasks -- and monitor their status, progress, and outputs. Powerful use cases can be accomplished without writing any code. If you need more programmatic and granular control, other options are available and include .NET and node.js.

You've also seen how you can use Batch Explorer to view the status of the accounts, pools of worker nodes, jobs, and tasks that you created via the CLI.

## Cleanup

It is recommended to delete the resource group holding any resources you created in the exercises to ensure resources don't continue to run and potentially incur costs.

## Learn more

- [Batch Documentation](https://docs.microsoft.com/azure/batch/)
- [What is Azure Batch?](https://docs.microsoft.com/azure/batch/batch-technical-overview)
- [Quickstart: Run your first Batch job with the Azure CLI](https://docs.microsoft.com/azure/batch/quick-create-cli)
- [Manage Batch resources with Azure CLI](https://docs.microsoft.com/azure/batch/batch-cli-get-started)
- [Batch Explorer](https://azure.github.io/BatchExplorer/)