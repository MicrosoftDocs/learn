Your toy company's website is updated regularly, and it was becoming time-consuming for you to deploy the updated Bicep files manually. You also were the only person in your company who knew how to deploy your infrastructure.

In this module, you learned how Azure Pipelines supports an automated deployment process. You built a pipeline that automatically deploys your resources to Azure by using Bicep templates. You also learned how pipelines can be triggered for every change that is made to your Bicep code. This way of working can be scaled from a single person to an entire organization.

Thanks to your efforts, anyone in your website team can automatically deploy changes to your Azure environment, and they run through the same process for every change.

## References

- [Tasks](/azure/devops/pipelines/tasks/)
  - [Azure CLI](/azure/devops/pipelines/tasks/deploy/azure-cli)
  - [Azure PowerShell](/azure/devops/pipelines/tasks/deploy/azure-powershell)
- [Pipeline variables](/azure/devops/pipelines/process/variables?tabs=yaml)
  - [Predefined variables](/azure/devops/pipelines/build/variables?tabs=yaml)
- [Pipeline triggers](/azure/devops/pipelines/build/triggers)
- [Agents and self-hosted agents](/azure/devops/pipelines/agents/agents)
- [Service connections](/azure/devops/pipelines/library/service-endpoints)
