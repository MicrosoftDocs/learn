_Infrastructure as code_ (IaC) refers to describing your infrastructure requirements as human-readable text files. Azure Resource Manager (ARM) templates are a form of IaC.

Just like application code, you can manage your infrastructure code in a version control system such as Git. Doing so enables you to collaborate with others and trace changes to your infrastructure requirements as they evolve.

As with your application code, you shouldn't hard-code sensitive information such as passwords and API keys into your ARM templates. Otherwise, anyone with read access to your repository will have access to this secret information.

Although only authorized individuals in your organization should have access to sensitive information, your ARM templates require this information as well. Azure Key Vault is one way to help protect sensitive information.

## Azure Key Vault helps protect sensitive information

Azure Key Vault is a cloud service that works as a secure store for secrets. Key Vault allows you to create multiple secure containers, called vaults. These vaults are backed by hardware security modules (HSMs). Vaults help reduce the chances of accidental loss of security information by centralizing the storage of application secrets. Vaults also control and log the access to anything stored in them.

Key Vault is capable of storing both keys and secrets. Its numerous features make it a good choice for managing your secrets, but also a good choice to use for your deployment process. 

- **Role-based access control**. You can manage your key vault by using various roles, so you can ensure it's usable by apps as well as different levels of admins.

- **Allowing users and apps**. You can configure your key vault so that both specific users as well as apps can have access to the key vault. For apps, you create a *service principal*. In fact, you can configure your key vault so that only service principals have access to it.

   > [!NOTE]
   > A service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources. You restrict access to resources by only assigning the principal a role or a subset of roles with limited access rights. This approach gives you a more granular control over what and how much something can access your resources.

- **Can interact with an ARM template**. During deployment of an ARM template, you can read from a key vault. There's a little configuration needed to make it work. The next section provides further details.

## Configure permissions

You've chosen Key Vault as a service where you will store your credentials. From there, you want to be able read secrets during deployment so that, for example, you can set the password of a virtual machine.

There are several configuration steps you need to perform to set up Key Vault so that it can be read from during deployment. The steps are:

1. **Enable Key Vault for deployment**. Key Vault needs to be allowed to be read from during deployment. You can pass this setting at creation or amend it later.

1. **The user needs deployment permission on the resource group**. This is no different than other deployments. However, if you haven't created the resource group, you can assign a role to ensure you can deploy to it.

1. **The user needs proper access to the key vault**. You must ensure that you have the proper access to the key vault when you read from it during deployment. When you create a key vault, it creates an access policy giving the user rights to manage all the secrets, keys, and certificates.

### Configure Key Vault for deployment

Configure your instance of Key Vault so that credentials can be read from it during deployment of an ARM template.

To enable Key Vault for deployment, there's a setting you can pass, either during creation of the Key Vault instance or something you can amend at a later point. In PowerShell, it's a switch called   `-EnabledForTemplateDeployment`. In the Azure CLI, it's an argument called `--enabled-for-template-deployment` that needs the value `true` to be passed as well.

> [!NOTE]
> Azure CLI additionally requires you to pass a Boolean with the value `true`.

### User needs deployment permission on Key Vault and resource group

Before you attempt to deploy and read secrets from the key vault, you have to ensure that you have _deployment permission_. There are two roles that both give you this permission:

- `Owner`: If you created the key vault, you automatically have this role.
- `Contributor`: This role grants you access to manage all the secrets. If you didn't create the key vault, the easiest approach is to give yourself the `Contributor` role.

Another choice is to create and assign a custom role, and ensure that role contains the **Microsoft.KeyVault/vaults/deploy/action** permission.

## Configure the deployment parameter file  

Instead of specifying each parameter and corresponding values as key-value pairs during deployment, you can use a parameter file.

In this parameter file, you specify which key vault and which secret in that key vault you're interested in. You do this by modifying a parameter, and then updating the deployment template to use this parameter.

> [!NOTE]
> The template doesn't have any notion of a key vault or its secret. The configuration you're making takes place in the parameter file.

### Configure a key vault and secret for a parameter

In the parameter file, and for a specific parameter, point to a key vault that you have deployment permission to. Next, specify what secret you're interested in. You point out the secret by name. During deployment, this configuration will resolve into the secret's value. Here's a parameter called `myPassword` being configured to use a specific key vault, and to use a secret called `databaseSecret`.

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

   In the preceding JSON, you specify the full ID to the key vault, and go on to ask for the secret `databaseSecret`. The value of this secret is then extracted and assigned to the `myPassword` parameter.

### Assign the parameter to the resource's password

This step is not related to the key vault. It's about ensuring that the intended resource makes use of the parameter configured to read the secret's value from the key vault. The following is a shortened snippet from a VM, in the template file, that shows the `adminPassword` element reading from the parameter `myPassword`. The secret's value will then be read from the key vault at deployment time, and be assigned to the element `adminPassword`.

   ```json
   {
     "osProfile": {
       "adminPassword": "[parameters('myPassword')]"
     }
   }
   ```
