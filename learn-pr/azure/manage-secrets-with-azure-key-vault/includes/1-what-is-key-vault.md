If you want to understand what can go wrong with managing an application's configuration secrets, look no further than the story of Steve the senior developer.

Steve had been in his job at a pet food delivery company for a few weeks. He was exploring the details of the company's web app &mdash; a .NET Core web application that used an Azure SQL database for storing order information and third-party APIs for credit card billing and mapping customer addresses &mdash; when he accidentally pasted the connection string for the orders database into a public forum.

Days later, accounting noticed that the company was delivering a lot of pet food that nobody had paid for. Someone had used the connection string to access the database, reverse-engineered the schema, and placed orders without going through the website.

After realizing the mistake, Steve logged directly into the application server and changed the configuration instead of redeploying. Hoever the server was now showing failed requests.

Steve had forgotten that multiple instances of the app ran on different servers, and he had only changed the configuration for one. Downtime and a full redeployment was needed which caused 30 minutes of downtime.

Unprotected keys can give an attacker openings to steal user data, cause financial harm and likely downtime for your applications.

---

Accidentally leaking a database connection string, API key or service password is a mistake that's easy to make often goes unnoticed. Sometimes it's not accidental; it's done by someone who shouldn't have had access to your  secrets. Unfortunately, secret values often need to be deployed in multiple places simultaneously and changed at inopportune times. And you have to store them *somewhere!* Let's see how we can make all of this secure.

## Key Vault

Key Vault is a *secret store*: a centralized cloud service for storing application secrets. Key Vault helps prevent the above scenarios by keeping application secrets in a single central location and providing secure access, permissions control, and access logging.

An individual vault is an Azure resource with its own configuration and security policy that you can create with any of the standard Azure management tools like the Azure portal or the CLI. Secret access and vault management is accomplished via a REST API. Every vault has a unique URL where its API is hosted.

> [!IMPORTANT]
> **Key Vault is designed to store configuration secrets for server applications.** It's not intended for storing data belonging to your app's users, and it shouldn't be used in the client-side part of an app. This is reflected in its performance characteristics, API and cost model.
>
> User data should be stored elsewhere, such as in an Azure SQL database with Transparent Data Encryption, or a storage account with Storage Service Encryption. Secrets used by your application to access those data stores can be kept in Key Vault.

## What is a secret in Key Vault?

In Key Vault, a secret is a name-value pair of strings. Secret names must be 1-127 characters long, contain only alphanumerics and dashes, and must be unique within a vault. A secret value can be any UTF-8 string up to 25KB in size.

> [!TIP]
> Secret names don't need to be considered especially secret themselves. You can store them in your app's configuration if your implementation calls for it. The same is true of vault names and URLs.

> [!NOTE]
> Key Vault supports two additional kinds of secrets beyond strings &mdash; *keys* and *certificates* &mdash; and provides useful functionality specific to their use cases. This module does not cover these features and concentrates on secret strings like passwords and connection strings.
