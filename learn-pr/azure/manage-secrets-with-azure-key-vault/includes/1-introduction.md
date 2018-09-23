If you want to understand what can go wrong with managing an application's configuration secrets, look no further than the story of Steve the senior developer.

Steve had been in his job at a pet food delivery company for a few weeks. He was exploring the details of the company's web app &mdash; a .NET Core web application that used an Azure SQL database for storing order information and third-party APIs for credit card billing and mapping customer addresses &mdash; when he accidentally pasted the connection string for the orders database into a public forum.

Days later, accounting noticed that the company was delivering a lot of pet food that nobody had paid for. Someone had used the connection string to access the database, reverse-engineered the schema, and placed orders without going through the website.

After realizing his mistake, Steve hurriedly changed the database password to lock out the attacker, breaking the website. He logged directly into the application server and changed the app configuration instead of redeploying, but the server was still showing failed requests.

Steve had forgotten that multiple instances of the app ran on different servers, and he had only changed the configuration for one. A full redeployment was needed, causing another 30 minutes of downtime.

Leaking a database connection string, API key, or service password can be catastrophic. Stolen or deleted data, financial harm, application downtime, and irreparable damage to business assets and reputation are all potential results. Unfortunately, secret values often need to be deployed in multiple places simultaneously and changed at inopportune times. And you have to store them *somewhere*! Let's see how we can make all of this secure with Azure KeyVault.

## Learning objectives

In this module, you will:

- Explore what types of information can be stored in Azure Key Vault
- Create an Azure Key Vault and use it to store secret configuration values
- Enable secure access to the vault from an Azure App Service web app with managed identities for Azure resources
- Implement a web application that retrieves secrets from the vault
