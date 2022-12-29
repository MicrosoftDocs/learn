Your company recently acquired a smaller competitor that has created a toy truck. This company uses Azure to host its application infrastructure, but it deployed its resources by using the Azure portal and JSON ARM templates. Your company standardized on Bicep for infrastructure as code, and you needed to migrate all Azure resources to use Bicep for deployments.

In this module, you learned about the process and recommended workflow for migrating your Azure resources to Bicep. The workflow consists of five phases: convert, migrate, refactor, test, and deploy. You learned about the limitations within this workflow and how to bring your templates in line with your team's code standards and best practices. You also learned about tools and resources that can help you complete the workflow.

You exported the toy truck's back-end virtual machine to a JSON ARM template. You used the Bicep `decompile` command to convert the JSON template to a Bicep file. After the conversion, you migrated the resources to a deployable Bicep file. You refactored the Bicep file to adjust the symbolic names, parameters, and variables. Parameter descriptions were added to provide detail about the individual settings. You tested the refactored template by using the what-if operation, made adjustments, and tested again. Finally, you deployed your template to your Azure environment.

After you successfully deploy your production environment by using your Bicep code, you're done! The next steps are to use a pipeline and automated deployments.

## References

- [Bicep documentation](/azure/azure-resource-manager/bicep/overview)
- [Bicep on GitHub](https://github.com/Azure/bicep)
- [Bicep deployment what-if operation](/azure/azure-resource-manager/bicep/deploy-what-if)
- [Azure Quickstart Templates](/samples/browse/?expanded=azure&products=azure-resource-manager)
- [Azure ARM template reference](/azure/templates/)
- [ARM template deployment what-if operation](/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell)
- [Export a template](/azure/azure-resource-manager/templates/export-template-portal)
