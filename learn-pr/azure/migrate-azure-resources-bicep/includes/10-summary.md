Your company recently acquired a smaller competitor that has created a toy truck. This company uses Azure to host its application infrastructure, but its resources were deployed by using the Azure portal and JSON ARM templates. Your company standardized on Bicep for infrastructure as code, and you need to migrate all Azure resources to use Bicep for deployments.

In this module, you learned about the process and recommended workflow for migrating your Azure resources to Bicep. The workflow consists of five phases: convert, migrate, refactor, test, and deploy. You learned about the limitations within this workflow and how to bring your templates in line with your team's code standards and best practices. You also  learned about the tools and resources available to help you through the workflow.

You exported the toy truck's backend virtual machine to a JSON ARM template. You used the Bicep `decompile` command to convert the JSON template to a Bicep file. After the conversion, you migrated the resources to a deployable Bicep file. You refactored the Bicep file to adjust the symbolic names, parameters, and variables. Parameter descriptions were added to provide detail about the individual settings. You tested the refactored template using the what-if operation, made adjustments, and tested again. Finally, you deployed your template to your Azure environment.

Once you've successfully deployed your production environment through your Bicep code, you're done! Now go use a pipeline and automated deployments.

## References

- [Bicep at Microsoft Docs](/azure/azure-resource-manager/bicep/overview?azure-portal=true)
- [Bicep on GitHub](https://github.com/Azure/bicep?azure-portal=true)
- [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates?azure-portal=true)
- [Azure ARM Template Reference](/azure/templates/?azure-portal=true)
- [Azure Resource Explorer](/azure/azure-resource-manager/templates/view-resources?azure-portal=true#use-resource-explorer)
- [Azure Resource Manager Template Deployment What-if Operation](/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell&azure-portal=true)
