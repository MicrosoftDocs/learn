Part of _Infrastructure as code_ means checking in deployment templates into a global repository like, for example,  GitHub. You need to also ensure your global resources are protected by secure credentials.  Sensitive credentials should not be listed explicitly in your templates so you need to find an approach that works.

Let's try to distill the problem a bit:

- **Templates need to be checked in**. Your infrastructure is now expressed as text files. You also check in those files into a global repository like GitHub. Assume therefore that what gets checked into GitHub could be read by anyone.
- **Secure credentials need to be stored in safe way**. Credentials like passwords, API keys and more should be stored in a safe way. Only specific individuals in your company should have access to them. It should be easy to _rotate keys_ at a regular interval. A change in a credential should not stop services in production.  
- **The deployment template needs to be able read credentials**. The templates need to be checked into a version control system. As part of a _deployment_ the deployment process will need to have access to whatever service you are using to store your credentials. You could handle that with something like PowerShell scripts or go for an approach involving ARM templates and an Azure service.

## Why use an Azure KeyVault

An Azure KeyVault is capable of storing both keys and secrets. Some features of Azure KeyVault are:

- **RBAC. Role-Based Access Control**, you can manage your KeyVault using various roles so you can ensure it's usable by apps as well as different levels of admins
- **Allowing users and/or service principals**. The KeyVault can be configured so that both specific users as well as apps can have access to the KeyVault. The way to let apps have access is to create a so called Service principal. In fact, you can configure your KeyVault so that only Service principals have access to it.
- **Can interact with an ARM template**. This feature is probably the one that makes Azure KeyVault the most compelling for usage in this scenario. Azure KeyVault can be read from ARM template, even if there's a little configuration needed to make it work.
- **Key rotation**. A rotation, a switch of your keys and secrets values can be done at a regular interval. The reason for wanting to do so is that a secret, or key might be compromised and switching out the values at regular intervals is a good practice to mitigate such events. Because of the way Azure KeyVault works it, consumers of it only deals with the name of the secrets rather than the actual values and you therefore have no downtime when a rotation happens.

There's many more reasons why Azure KeyVault is a good place to store keys and secrets but above are some of the most compelling reasons for your scenario you need to solve for.

## Configure permissions

You've chosen an Azure KeyVault as a service where you will store your credentials. From there, you want to be able read secrets during deployment so that you can set the password of a virtual machine for example. For that to be possible you need to ensure the KeyVault is set up in a way that it can be accessed. There are two dimensions you need to consider:

- **KeyVault can be used for deployment**. KeyVault needs to be configured so that credentials can be read from it during deployment of an ARM template. You can pass a parameter `--enabled-for-template-deployment` and set it to `true`, either during creation of the KeyVault or the KeyVault can be updated later to enable this setting.

- **User needs deployment permission on the resource group**. The user deploying the template needs to have the deployment permission on the resource group that will be used for the deployment. To grant this permission you need to define a custom role in a JSON file where the permission `Microsoft.KeyVault/vaults/deploy/action` is specified. Thereafter assign this role to the user.

- **User needs to have an allowed role on the KeyVault**. For the KeyVault that means that the user needs to have one of two roles:

   - `Owner`, if you created the KeyVault you automatically have this role.
   - `Contributor`, this role you can be assigned to your user. The role grants you access to manage all the secrets. The only thing you can't do with this role is assigning roles via Azure RBAC.

## Configuring the deployment template  

At this point, everything has been configured so the deployment user has the necessary permissions to both resource group and KeyVault. The focus is now on the deployment template file. You need to accomplish the following things:

1. **Identify the KeyVault**. The first step is to point to a KeyVault that you have permission to.
1. **Read a specific secret**. Once you've managed to point to a specific KeyVault, you need to be able to retrieve a specific secret by name.
1. **Assign that to a resource**. Finally, once you've managed to read out the secret's value you need to assign it a resource's password, for example.

You can set a parameter to read from a specific KeyVault and a particular secret if you have the KeyVault ID and the name of the secret. Instead of letting the value of parameter rely on a user's input you can instead assign the parameters a JSON object like so:

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

In the above JSON, you specify the full id to the KeyVault and go on to ask for the secret `databaseSecret`. The value of this secret is then extracted to bee assigned to the `myPassword` parameter.

KeyVault secure parameters - 
https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/key-vault-parameter?tabs=azure-cli 

  

https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-use-key-vault 