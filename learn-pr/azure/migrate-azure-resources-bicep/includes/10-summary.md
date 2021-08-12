You're preparing to convert a series of ARM JSON templates and deployed Azure resources to Bicep. Your company has standardized on Bicep for infrastructure as code, and you want to have a consistent code base for your Azure resources.

In this module, you learned about the process and recommended workflow for migrating your Azure resources to Bicep. The workflow consisted of five phases: convert, migrate, refactor, test, and deploy. You learned about the limitations within this workflow and how to bring your templates in line with your team's code standards and best practices. Additionally, you learned about the tools and resources available to help you through the workflow.

To practice this workflow, you created a virtual machine via the Azure portal and exported the resources to a JSON ARM template. You used the Bicep `decompile` command to convert the JSON template to a Bicep file. After the conversion, you migrated the resources to a deployable Bicep file. You refactored the Bicep file to adjust the symbolic names, parameters, and variables. Parameter descriptions were added to provide detail about the individual settings. You tested the refactored template using the what-if operation, made adjustments, and tested again. Finally, you deployed your template to your Azure environment.

Once you've successfully deployed your production environment through your Bicep code, you're done! Now go use a pipeline and automated deployments.

## References

- [Bicep at Microsoft Docs](/azure/azure-resource-manager/bicep/overview)
- [Bicep on GitHub](https://github.com/Azure/bicep)
- [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/)
- [Azure ARM Template Reference](/azure/templates/)
- [Azure Resource Explorer](/azure/azure-resource-manager/templates/view-resources#use-resource-explorer)
- [Azure Resource Manager Template Deployment What-if Operation](/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell)
