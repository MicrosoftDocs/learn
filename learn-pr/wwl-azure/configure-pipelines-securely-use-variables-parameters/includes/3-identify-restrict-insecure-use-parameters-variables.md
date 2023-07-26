In Azure Pipelines, parameters and variables can be used to pass runtime values to pipeline tasks and scripts and to define variables that can be used across different pipeline stages. However, if not correctly secured, parameters and variables can become a security vulnerability, as they can store sensitive information such as connection strings, API keys, and other credentials.

In this unit, identify and restrict insecure use of parameters and variables in Azure Pipelines.

## Why is secure usage of parameters and variables important?

Secure usage of parameters and variables is essential to ensure the security of your pipeline and the projects it supports. Insecure parameters and variables can lead to data breaches, unauthorized access, and other security risks. They can also lead to unexpected behavior or errors that can impact the reliability and stability of your pipeline.

## Identify insecure use of parameters and variables

Here are some steps to identify insecure use of parameters and variables in Azure Pipelines:

- Check your pipeline YAML file for any parameters or variables storing sensitive information, such as connection strings or credentials.
- Check that the values of these parameters or variables aren't hard-coded in the pipeline tasks or script used by your tasks, for example, bash, PowerShell, etc. Instead, they should be defined as secure pipeline inputs, such as a secure file or variable group.
- Use the Azure DevOps Pipeline Audit log to monitor the usage of parameters and variables in your pipeline and identify any potential security risks or vulnerabilities.
- Check your template files for any parameters or variables storing sensitive information.
- Check your repository for any parameters or variables storing sensitive information, for example, `appconfig.json`, `appsettings.json`, `secrets.json`, etc.

## Restrict insecure use of parameters and variables

Here are some steps to restrict the insecure use of parameters and variables in Azure Pipelines:

- Define your parameters and variables as secure pipeline inputs, such as a secure file, secret variables or variable group.
- Use Azure Key Vault to store sensitive data, such as connection strings or API keys, certificates and then reference them in your pipeline script.
- Link your Azure Key Vault to your Azure DevOps organization and then use the Azure Key Vault task to retrieve the secrets from your Azure Key Vault and use them in your pipeline.
- Use service connections with service principal authentication.
- Restrict access to sensitive data by setting appropriate permissions and access control policies. For example, limit access to pipeline variables and parameters to specific users or groups.

## Challenge yourself

Create a YAML pipeline that deploys a web application to an Azure App Service. Add parameters and variables to the pipeline that define the target environment, database connection string, and other sensitive data. Use the steps described in this unit to ensure that the parameter and variable usage is secure and that sensitive data is securely stored and managed. Test the pipeline, and make sure that the pipeline executes as expected while maintaining the security of the sensitive data in your log and validating the Audit Log.

For more information about variables and parameters, see:

- [Securing Azure Pipelines.](https://learn.microsoft.com/azure/devops/pipelines/security/overview/)
- [Runtime parameters.](https://learn.microsoft.com/azure/devops/pipelines/process/runtime-parameters/)
- [Security best practices.](https://learn.microsoft.com/azure/devops/organizations/security/security-best-practices/)
