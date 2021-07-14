Your toy company's website is going through regular changes, and it was becoming time-consuming for you to deploy the updated Bicep files repeatedly. You also were the only person in your company who knew how to deploy your infrastructure.

In this module you learned how Azure Pipelines can be used to build an automated deployment process. You built an Azure pipeline that automatically deploys your resources to Azure by using Bicep templates. You learned how pipelines can be triggered for every change that is made to your Bicep code. This way of working can be scaled from a single person to an entire organization.

Thanks to your efforts, anyone in your website team can automatically deploy changes to your Azure environment, and they run through the same process for every change.

## References

[Azure CLI](https://github.com/microsoft/azure-pipelines-tasks/blob/master/Tasks/AzureCLIV2/Readme.md)
[Azure PowerShell](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-powershell?view=azure-devops)
[Pipeline variables](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/variables?view=azure-devops&tabs=yaml%2Cbatch)
[Pipeline triggers](https://docs.microsoft.com/en-us/azure/devops/pipelines/repos/azure-repos-git?view=azure-devops&tabs=yaml#ci-triggers)
TODO self-hosted agents