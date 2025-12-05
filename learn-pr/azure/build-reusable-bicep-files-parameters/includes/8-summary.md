Your company's HR department is migrating an on-premises web application to Azure. The application will handle information about all of the toy company employees, so security is important.

You created a Bicep template to deploy an Azure App Service plan, an application, and an Azure SQL server and database. You parameterized the template to make it generalizable for deploying across multiple environments. You applied parameter decorators to control the allowed parameter values. Finally, you created a parameter file with Azure Key Vault references to keep the administrator login and password secure.

Imagine how much work it would be to deploy these resources for each environment. You'd have to manually provision the resources and remember to configure them correctly each time. Manually deploying Azure infrastructure might lead to inconsistency and security risks.

Bicep makes it easy to describe your Azure resources and create reusable templates. You can parameterize the templates and use parameter files to automate and secure your deployments.

Now, when you want to deploy your infrastructure for other environments, you can use the Bicep template and parameter file that you created. Your company can safely and consistently provision Azure resources.

## Learn more

- [Bicep parameters](/azure/azure-resource-manager/templates/bicep-file#parameters)
- [Parameters in Bicep](/azure/azure-resource-manager/bicep/parameters)
- [Create Bicep parameter file](/azure/azure-resource-manager/bicep/parameter-files)
- [Azure Key Vault references](/azure/azure-resource-manager/bicep/key-vault-parameter)
