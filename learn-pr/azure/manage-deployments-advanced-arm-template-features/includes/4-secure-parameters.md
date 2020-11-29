_Infrastructure as code_ (IaC) is concept where you describe your infrastructure requirements as human-readable text files. ARM templates are a form of IaC.

Just like application code, you can manage your infrastructure code in a version control system such as Git. Doing so enables you to collaborate with others and trace changes to your infrastructure requirements as they evolve.

Like application code, you shouldn't hard-code sensitive information such as passwords and API keys into your ARM templates. Otherwise, anyone with read access to your repository will have access to this secret information.

While only authorized individuals in your organization should have access to sensitive information, your ARM templates require this information as well. Azure Key Vault is one way to help protect sensitive information.

## How can Azure Key Vault help protect sensitive information?

Azure Key Vault is a cloud service that works as a secure store for secrets. Key Vault allows you to create multiple secure containers, called vaults. These vaults are backed by hardware security modules (HSMs). Vaults help reduce the chances of accidental loss of security information by centralizing the storage of application secrets. Vaults also control and log the access to anything stored in them.

Key Vault is capable of storing both keys and secrets. Its numerous features make it a good choice for managing your secrets, but also a good choice to use for your deployment process. Lets list some of the most compelling reasons of the Key Vault service:

- **RBAC, Role-Based Access Control**. You can manage your Key Vault using various roles so you can ensure it's usable by apps as well as different levels of admins.

- **Allowing users and/or service principals**. The Key Vault can be configured so that both specific users as well as apps can have access to the Key Vault. The way to let apps have access is to create a service principal. In fact, you can configure your Key Vault so that only service principals have access to it.

   > [!NOTE]
   > A service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources. The idea is to restrict access to resources by only assigning the principal a role or a subset of roles with limited access rights. This approach gives you a more granular control over what and how much something can access your resources.

- **Can interact with an ARM template**. This feature is probably the one that makes Azure Key Vault the most compelling for usage in this scenario. A Key Vault can be read from during deployment of an ARM template, even if there's a little configuration needed to make it work.

It's clear that the Key Vault service fulfills the needs we have to both manage secrets and is also capable of interacting with the deployment process. For the Key Vault service to be able to work with the deployment process, you need to add a little configuration. Let's look into detail what type of configuration that is and how to add it in the next section.

## Configure permissions

You've chosen a Key Vault as a service where you will store your credentials. From there, you want to be able _read_ secrets during deployment so that you can set the password of a virtual machine for example.

There are several configuration steps you need to perform to set up the Key Vault so that it can be read from during deployment. The steps are:

- **Enable Key Vault for deployment**. The Key Vault needs to be allowed to be read from during deployment. You can pass this setting at creation or amend it later.

- **User needs deployment permission on resource group**. This is no different than other deployment. However, if you haven't created the resource group, you can assign a role to ensure you can deploy to it.

- **User needs proper access to the Key Vault**. You must ensure that you have the proper access to the Key Vault when you read from it during deployment.  

### Configure Key Vault for deployment

The Key Vault instance needs to be configured so that credentials can be read from it during deployment of an ARM template.

To enable the Key Vault for deployment, there's a setting you can pass, either during creation of the Key Vault instance or something you can amend at a later point. The setting is a flag that if you are using PowerShell is called **-EnabledForTemplateDeployment** and in Azure CLI it's called **--enabled-for-template-deployment**. 

> [!NOTE]
> Azure CLI additionally requires you to pass a boolean with the value `true`.

### Ensure User has deployment permission on the resource group

The user deploying the template needs to have deployment permission on the resource group that will be used for the deployment.

To grant this permission, you need to define a custom role in a JSON file where the permission `Microsoft.KeyVault/vaults/deploy/action` is specified. Thereafter you need to assign this role to the user.

### User needs to have an allowed role on the Key Vault

For the Key Vault that means that the user needs to have one of two roles:

- `Owner`, if you created the Key Vault you automatically have this role.
- `Contributor`, this role you can be assigned to your user. The role grants you access to manage all the secrets. The only thing you can't do with this role is assigning roles via Azure RBAC.

## Configure the deployment template  

The deployment template file needs to be configured as well. It needs to point out the following things to be able to read a secrets value and assign it to the template:

- **Identify the Key Vault**. The first step is to point to a Key Vault that you have deployment permission to.
- **Read a specific secret**. Once you've managed to point to a specific Key Vault, you need to specify what secrets you are interested in. You point out the secret by name. During deployment, this configuration will resolve into the secrets value.
- **Assign that to a resource**. Finally, once you've managed to read out the secret's value you need to assign it a resource's password, for example.

You can set a parameter to read from a specific Key Vault and a particular secret if you have the Key Vault ID and the name of the secret. Instead of letting the value of parameter rely on a user's terminal input you can instead add the parameters in a parameter file. Below is the parameter `myPassword` being assigned a JSON object with the needed information to read a Key Vault's secret:

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

In the above JSON, you specify the full ID to the Key Vault and go on to ask for the secret `databaseSecret`. The value of this secret is then extracted and assigned to the `myPassword` parameter.
