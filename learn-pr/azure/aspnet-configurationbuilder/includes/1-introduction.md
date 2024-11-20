In this module, you configure an existing ASP.NET web app to retrieve sensitive information, such as connection strings, from your Azure key vault. By using Azure Key Vault, you help protect security information that a malicious application could use to attack your system.

The scenario in this module involves an existing .NET Framework web app that runs on-premises. You start by migrating this application to a web app built using Azure App Service. Next, you store the secrets that the application requires to connect to resources such as a database in your key vault. Finally, you configure the application by using a *ConfigurationBuilder* object that retrieves information from the key vault.

## Learning objectives

By the end of this module, you're able to use ConfigurationBuilder to retrieve access keys from your Azure key vault at runtime.

## Prerequisites

- Some C# programming experience.
- Familiarity with ASP.NET development.
- A development environment that has Windows 10 and Visual Studio 2019 with the latest updates.
- Git for Windows installed on your desktop.
