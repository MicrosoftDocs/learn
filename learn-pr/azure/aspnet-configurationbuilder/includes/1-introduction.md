In this module, you configure an existing ASP.NET web app to retrieve sensitive information, such as connection strings, from your Azure key vault. By using Azure Key Vault, you help protect security information that could otherwise be used by a malicious application to attack your system.

The scenario in this module involves an existing .NET Framework web app that runs on-premises. You start by migrating this application to a web app that's built by using Azure App Service. Next, you store the secrets that are required by this application to connect to resources such as a database in your key vault. Finally, you configure the application by using a *ConfigurationBuilder* object that retrieves information from the key vault. 

## Learning objectives

By the end of this module, you will be able to use ConfigurationBuilder to retrieve access keys from your Azure key vault at runtime.

## Prerequisites

- Some C# programming experience
- Familiarity with ASP.NET development
- A development environment that has Windows 10 and Visual Studio 2019 with the latest updates
- Git for Windows installed on your desktop 
