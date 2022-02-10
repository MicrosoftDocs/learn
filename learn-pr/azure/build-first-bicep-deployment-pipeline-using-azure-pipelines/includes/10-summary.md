Your toy company regularly updates its website, and it was becoming time-consuming for you to manually deploy updated Bicep files. You also were the only person in your company who knew how to deploy the website infrastructure.

In this module, you learned how to use Azure Pipelines to create an automated deployment process. You built a pipeline that automatically deploys your resources to Azure by using Bicep templates. You also learned how to trigger pipelines for every change that is made to your Bicep code, on a set schedule, or both. The process you successfully completed in the exercises can be scaled from a single person to an entire organization.

Thanks to your efforts, anyone on your website team can automatically deploy changes to your Azure environment, and they run through the same process for every change.

## References

- [Tasks](/azure/devops/pipelines/tasks/?azure-portal=true)
  - [Azure CLI](/azure/devops/pipelines/tasks/deploy/azure-cli?azure-portal=true)
  - [Azure PowerShell](/azure/devops/pipelines/tasks/deploy/azure-powershell?azure-portal=true)
- [Pipeline variables](/azure/devops/pipelines/process/variables?tabs=yaml?azure-portal=true)
  - [Predefined variables](/azure/devops/pipelines/build/variables?tabs=yaml?azure-portal=true)
- [Pipeline triggers](/azure/devops/pipelines/build/triggers?azure-portal=true)
  - [Batching](/azure/devops/pipelines/repos/azure-repos-git?azure-portal=true#batching-ci-runs)
- [Agents and self-hosted agents](/azure/devops/pipelines/agents/agents?azure-portal=true)
- [Service connections](/azure/devops/pipelines/library/service-endpoints?azure-portal=true)
