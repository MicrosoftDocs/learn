Most networked applications need to work with secrets, such as database connection strings or passwords. When perform machine learning on Azure, we normally use secrets to access training data or look at results. Particularly when working with private data, it’s important to make sure the secrets are properly managed.

## Don’t store secrets in source code

Storing secrets in source code is impractical and a security anti-pattern. This is for multiple reasons:

* Changing passwords means updating source code, which can mean rebuilding and re-publishing applications.
* Hard-coded secrets make it awkward to work with different environments, such as staging and production environments. This also increases the risk of inadvertent modification or destruction of production environment data during development. 
* All people with access to the source code gain access to all secrets. This makes it near impossible to ensure that only senior team members have access to sensitive resources. It also means that any sharing, or leak, of your source code also provides outside parties with your security keys.
* Source control, such as git, will typically retain old passwords in history. This means future team members gain access to all historical passwords.

One of the best alternatives to storing secrets in source code is to make them available in the application environment. In this pattern, your application requests secrets from the environment and then uses these to connect to the requisite resources. The aforementioned drawbacks of storing secrets in source code are eliminated, so long as each environment has different secret values, such as different passwords to access certain resources.

## Azure Key Vault

Azure Key Vault provides secure storage of generic secrets for applications in Azure-hosted environments. Any type of secret can be stored, so long as its value is no larger than 25kb and it can be read and returned as a string. Secrets are named, and their content type (such as password or certificate) can optionally be stored alongside the value to provide a hint that assists in its interpretation when retrieved.  

Secrets stored in Azure Key Vault are encrypted, optionally at the hardware level. This is handled transparently, and requires no action from the user or the application requesting the secrets. They can also be temporarily disabled, and automatically activate or expire on a certain date.

## How Key Vault works with Azure ML

When you create an Azure ML workspace, this automatically creates a Key Vault. To view the Azure Key Vault associated with your workspace, open the workspace’s Overview tab. Your key vault appears on the right hand side.

![A generic image of a key vault authenticator.](../media/4-key-vault.png)