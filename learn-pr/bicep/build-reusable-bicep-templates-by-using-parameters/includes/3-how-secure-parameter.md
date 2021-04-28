In this unit, you'll learn how to secure parameters. You may want to pass sensitive value into Bicep as a parameter. When passing sensitive value, you want to avoid entering plaintext into a terminal. This leads to leaking of sensitive information. The value can be easily retrieved from the terminal command history and the deployment logs. You can protect sensitive value by applying the @secure decorator when declaring a parameter.

## Secure parameters

Sometimes, you need to pass sensitive values into your deployments, like logins and passwords. To secure these values, use parameters with the `@secure` decorator. You can apply `@secure` decorator to only string or object type parameters.

When you're prompted for a secure parameter, you can type in text as normal but the terminal will not display the text on your screen. The deployment logs also don't include any secure parameter values.

As part of the HR application migration, you need to deploy an Azure SQL server and database. You will provision the server with an administrative login and password. These values are sensitive, and you need the deployment to be secured. Here is an example declaration of a secure parameter for a string parameter:

```bicep
@secure()
param sqlServerAdministratorPassword string
```

> [!TIP]
> * Always use parameters for usernames, passwords, API keys, certificates, and any other secrets.
> * Use the `@secure` decorator for all secret parameters.
> * Don't provide default values for usernames, passwords, or any other secure parameters.
> * Make sure you never create an output for sensitive data. Output values can be accessed by anyone who has access to the deployment history.
