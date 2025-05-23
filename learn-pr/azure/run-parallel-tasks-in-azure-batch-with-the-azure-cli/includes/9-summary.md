Azure Batch is a powerful service for running large jobs at scale and in parallel. All the management and scheduling is done for you, and it's a free management plane on top of the underlying Azure Compute that's used to execute your jobs.

In this module, you learned how to use the Azure CLI to conveniently create all the components of the Azure Batch workflow: accounts, pools, jobs, and tasks. You also learned how to monitor the status, progress, and outputs of these components. You can accomplish powerful use cases without writing any code. If you need more programmatic and granular control, other options are available including .NET and node.js.

Finally, you used Batch Explorer to view the status of the accounts, pools of worker nodes, jobs, and tasks that you created with Azure CLI.

## Cleanup

We recommend that you delete the resource group holding any resources you created in the exercises. This action ensures that your resources don't continue to run and potentially incur costs.

## Learn more

- [Batch Documentation](/azure/batch/)
- [What is Azure Batch?](/azure/batch/batch-technical-overview)
- [Quickstart: Use the Azure CLI to create a Batch account and run a job](/azure/batch/quick-create-cli)
- [Manage Batch resources with Azure CLI](/azure/batch/batch-cli-get-started)
- [Batch Explorer](https://azure.github.io/BatchExplorer/)