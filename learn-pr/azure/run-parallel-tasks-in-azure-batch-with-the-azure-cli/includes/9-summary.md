Azure Batch is a powerful service for running large jobs at scale and in parallel. All the management and scheduling is done for you, and it's a free management plane on top of the underlying Azure Compute that's used to execute your jobs.

You've learned in this module how convenient it is to use the Azure CLI to create all the components of the Azure Batch workflow—accounts, pools, jobs, and tasks—and monitor their status, progress, and outputs. You can accomplish powerful use cases without writing any code. If you need more programmatic and granular control, other options are available and include .NET and node.js.

You've also learned how you can use Batch Explorer to view the status of accounts, pools of worker nodes, jobs, and tasks that you created by using the Azure CLI.

## Cleanup

We recommend that you delete the resource group holding any resources you created in the exercises to ensure resources don't continue to run and potentially incur costs.

## Learn more

- [Batch Documentation](/azure/batch/)
- [What is Azure Batch?](/azure/batch/batch-technical-overview)
- [Quickstart: Use the Azure CLI to create a Batch account and run a job](/azure/batch/quick-create-cli)
- [Manage Batch resources with Azure CLI](/azure/batch/batch-cli-get-started)
- [Batch Explorer](https://azure.github.io/BatchExplorer/)