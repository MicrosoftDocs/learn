In this module, you'll take an existing ASP.NET web application and configure it to retrieve sensitive information, such as connection strings, from Azure Key Vault. Using Azure Key Vault helps to protect security information that could otherwise be used by a malicious application to attack your system.

The scenario used by this module revolves around an existing .NET Framework web application that runs on-premises. You'll start by migrating this application to Azure App Service. Next, you'll store the secrets required by this application to connect to resources such as a database in Azure Key Vault. Finally, you'll configure the application using a *ConfigurationBuilder* object that retrieves information from Azure Key Vault. 

## Learning objectives

- Explain the purpose of the ConfigurationBuilder mechanism to avoid storing sensitive configuration information in easily accessible locations
- How to use ConfigurationBuilder to retrieve access keys from Azure Key Vault at runtime

## Prerequisites

- An Azure subscription. If you don't have an Azure account, you can [create a free trial subscription here](https://azure.microsoft.com/free/)
- Some C# programming experience
- Familiarity with ASP.NET development

