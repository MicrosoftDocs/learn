If you want to understand what can go wrong with managing an app's configuration secrets, look no further than the story of Steve, a senior developer.

Steve was working at a pet food delivery company for a few weeks. While exploring the details of the company's web app&mdash;a .NET Core web app that used an Azure SQL database for storing order information and third-party APIs for credit card billing and mapping customer addresses&mdash;Steve accidentally pasted the connection string for the orders database into a public forum.

Days later, the accounting department noticed that the company was delivering a lot of pet food that hadn't been paid for. Someone used the connection string to access the database and create orders by updating the database directly.

After Steve realized his mistake, he hurriedly changed the database password to lock out the attacker. After Steve changed the password, the website started returning errors to users. The app server needed an updated configuration with the new password. Steve logged directly into the app server and changed the app configuration instead of redeploying, but the server was still showing failed requests.

Steve forgot that multiple instances of the app ran on different servers. He only changed the configuration for one. A full redeployment was needed, causing another 30 minutes of downtime.

Fortunately for Steve, the accounting department was able to correct the errors quickly, and only one day's worth of orders were affected. Steve might not be so lucky in the future, though, and needs to find a way to improve the security and maintainability of the app.

Leaking a database connection string, API key, or service password can be catastrophic. Stolen or deleted data, financial harm, app downtime, and irreparable damage to business assets and reputation are all potential results. Unfortunately, secret values often need to be deployed in multiple places simultaneously and changed at inopportune times. And you have to store them *somewhere*! See how Steve can reduce risk and improve the security and maintainability of his app with Azure Key Vault.

## Learning objectives

In this module, you will:

- Explore what types of information can be stored in Azure Key Vault
- Create an Azure Key Vault and use it to store secret configuration values
- Enable secure access to the Azure Key Vault from an Azure App Service web app with managed identities for Azure resources
- Implement a web app that retrieves secrets from the Azure Key Vault
