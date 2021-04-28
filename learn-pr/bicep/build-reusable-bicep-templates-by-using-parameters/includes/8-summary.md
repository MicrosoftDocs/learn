Your company's Human Resources department is migrating an on-premises web application to Azure. The application will handle information about all of the employees of the toy company, so security is important.

You've created a template that will deploy a website and database securely. This template is reusable for deploying across multiple environments in accordance with company's requirement.

You created a Bicep template to deploy an Azure App Service plan, an application, and an Azure SQL server and database. You parameterized the template to make it generalizable for deploying across multiple environments. You then applied parameter decorators to control input parameters. Finally, you created a parameter file with Azure Key Vault reference to be used in automated deployment.

Imagine how much work it would be to deploy these resources for each environment. You'd have to manually provision the resources and remember to configure them correctly each time. Manually deploying Azure infrastructure may lead to inconsistency and security risk.

Bicep makes it easy to describe your Azure resources and create reusable templates. You can parameterize the templates and use parameter files to automate and secure your deployments.

Now, when you want to deploy your infrastructure for other environments, you can use the Bicep template and parameter file that you created. Your company can safely and consistently provision Azure resources.

## References

- [Template reference for each Azure resource type](/azure/templates/)
- [Template functions](/azure/azure-resource-manager/templates/template-functions)
- [Azure resources naming rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules)