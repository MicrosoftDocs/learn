Part of _Infrastructure as code_ means checking in deployment templates into a global repository like, for example, GitHub. You also need to ensure your global resources are protected by secure credentials.  However, sensitive credentials should not be listed explicitly in your templates so you need to find an approach that works.

Let's try to distill the problem a bit:

- **Templates need to be checked in**. Your infrastructure is now expressed as text files. You also check in those files into a global repository like GitHub. Assume therefore that what gets checked into GitHub could be read by anyone with a read access.
- **Secure credentials need to be stored in safe way**. Credentials like passwords, API keys and more should be stored in a safe way. Only specific individuals in your company should have access to them.
- **Secrets should be easy to change with minimal service interruption**. It should be easy to _rotate keys_ at a regular interval. A change in a credential should not stop services in production.  
- **The deployment template needs to be able read credentials**. As part of a deployment, the deployment process will need to have access to whatever service you are using to store your credentials.

## Why use Azure KeyVault service

An Azure KeyVault is capable of storing both keys and secrets. It's numerous features make it a good choice for managing your secrets, but also a good choice to use for your deployment process. Let's list some of the most compelling reasons of the Azure KeyVault service:

- **RBAC, Role-Based Access Control**. You can manage your KeyVault using various roles so you can ensure it's usable by apps as well as different levels of admins.
- **Allowing users and/or service principals**. The KeyVault can be configured so that both specific users as well as apps can have access to the KeyVault. The way to let apps have access is to create a so called Service principal. In fact, you can configure your KeyVault so that only Service principals have access to it.
- **Can interact with an ARM template**. This feature is probably the one that makes Azure KeyVault the most compelling for usage in this scenario. Azure KeyVault can be read from during deployment of an ARM template, even if there's a little configuration needed to make it work.

It's clear that Azure KeyVault service fulfills the needs we have to both manage secrets and is also capable of interacting with the deployment process. For the Azure KeyVault service to be able to work with the deployment process, you need to add a little configuration. Let's look into detail what type of configuration that is and how to add it in the next section.

## Configure permissions

You've chosen an Azure KeyVault as a service where you will store your credentials. From there, you want to be able read secrets during deployment so that you can set the password of a virtual machine for example. For that to be possible you need to ensure the KeyVault is set up in a way that it can be accessed. There are two dimensions you need to consider:

- **Configure KeyVault for deployment**. The Azure KeyVault instance needs to be configured so that credentials can be read from it during deployment of an ARM template. Enabling the KeyVault for deployment is a setting you can pass either during creation of the KeyVault instance or something you can amend at a later point. The setting is a flag that if you are using PowerShell is called **-EnabledForTemplateDeployment** and in Azure CLI it's called **--enabled-for-template-deployment**. Azure CLI additionally requires you to pass a boolean with the value `true`.

- **User needs deployment permission on the resource group**. The user deploying the template needs to have the deployment permission on the resource group that will be used for the deployment. To grant this permission you need to define a custom role in a JSON file where the permission `Microsoft.KeyVault/vaults/deploy/action` is specified. Thereafter assign this role to the user.

- **User needs to have an allowed role on the KeyVault**. For the KeyVault that means that the user needs to have one of two roles:

   - `Owner`, if you created the KeyVault you automatically have this role.
   - `Contributor`, this role you can be assigned to your user. The role grants you access to manage all the secrets. The only thing you can't do with this role is assigning roles via Azure RBAC.

## Configuring the deployment template  

The deployment template file needs to be configured as well. It needs to point out the following things to be able to read a secrets value and assign it to the template:

- **Identify the KeyVault**. The first step is to point to a KeyVault that you have deployment permission to.
- **Read a specific secret**. Once you've managed to point to a specific KeyVault, you need to what secrets you are interested in. You point out the secret by name. During deployment this will resolve into the secrets value.
- **Assign that to a resource**. Finally, once you've managed to read out the secret's value you need to assign it a resource's password, for example.

You can set a parameter to read from a specific KeyVault and a particular secret if you have the KeyVault ID and the name of the secret. Instead of letting the value of parameter rely on a user's terminal input you can instead add the parameters in a parameter file. Below is the parameter `myPassword` being assigned a JSON object with the needed information to read a KeyVault's secret:

```json
"myPassword" : {
  "reference": {
    "keyVault": {
      "id": "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.KeyVault/vaults/<vault-name>",
      "secretName": "databaseSecret"
    }
  }
}
```

In the above JSON, you specify the full ID to the KeyVault and go on to ask for the secret `databaseSecret`. The value of this secret is then extracted and assigned to the `myPassword` parameter.
