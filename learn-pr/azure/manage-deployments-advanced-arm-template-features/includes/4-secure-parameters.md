_Infrastructure as code_ (IaC) is concept where you describe your infrastructure requirements as human-readable text files. ARM templates are a form of IaC.

Just like application code, you can manage your infrastructure code in a version control system such as Git. Doing so enables you to collaborate with others and trace changes to your infrastructure requirements as they evolve.

Like application code, you shouldn't hard-code sensitive information such as passwords and API keys into your ARM templates. Otherwise, anyone with read access to your repository will have access to this secret information.

While only authorized individuals in your organization should have access to sensitive information, your ARM templates require this information as well. Azure Key Vault is one way to help protect sensitive information.

## How can Azure Key Vault help protect sensitive information

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

To enable the Key Vault for deployment, there's a setting you can pass, either during creation of the Key Vault instance or something you can amend at a later point. In PowerShell it's a switch called   **-EnabledForTemplateDeployment**. In Azure CLI it's a parameter called **--enabled-for-template-deployment** that needs the value `true` to be passed as well.

> [!NOTE]
> Azure CLI additionally requires you to pass a boolean with the value `true`.

### User needs deployment permission on Key Vault and resource group

Before you attempt to deploy and read secrets from the Key Vault, you have to ensure you have a so called _deployment permission_. There are two roles that both give you this permission:

- `Owner`, if you created the Key Vault you automatically have this role.
- `Contributor`, this role you can be assigned to your user. The role grants you access to manage all the secrets. The only thing you can't do with this role is assigning roles via Azure RBAC.

If you didn't create the Key Vault, the easiest approach is to give you the `Contributor` role.

Another choice is to create and assign a custom role and ensure that role contains a permission looking like so:

```bash
Microsoft.KeyVault/vaults/deploy/action
```

## Configure the deployment parameters file  

Instead of specifying each parameter and corresponding values as key-value pairs during deployment, you could use a parameters file.

When reading a secret from a Key Vault, a parameter in this parameters file would need to be modified to specify which Key Vault and which secret in that Key Vault you are interested in. You would then update the deployment template to use said parameter.

> [!NOTE]
> The template does not have any notion of a Key Vault or its secret, its in the parameter file that the configuration takes place.

The steps you would need to take to configure everything are:

- **Configure Key Vault and secret for a parameter**. In the parameter file, and for a specific parameter, point to a Key Vault that you have deployment permission to. Next, specify what secret you are interested in. You point out the secret by name. During deployment, this configuration will resolve into the secrets value. Here's a parameter called `myPassword` being configured to use a specific Key Vault and using a secret called `databaseSecret`.

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

- **Assign parameter to resource's password**

   This step is not really related to the Key Vault but is about ensuring the intended resource makes use of the parameter configured to read the secret's value from the Key Vault. Below is a shortened snippet from a VM, in the template file, that shows the `adminPassword` element reading from the parameter `myPassword`. Thereby the secret's value will be read from the Key Vault at deployment time and be assigned to the element `adminPassword`.

   ```json
   {
     "osProfile": {
       "adminPassword": "[parameters('myPassword')]"
     }
   }
   ```
