You've been asked to evaluate whether infrastructure as code might be a valuable approach to resource provisioning at your company. You're reviewing the available options for deployment, including:

- Azure portal
- Azure CLI
- Azure PowerShell
- Azure Resource Manager templates (JSON and Bicep)

You're looking for a repeatable option, and you need to decide which technology to use to deploy your Azure infrastructure.

In this unit, you'll learn how and why infrastructure as code can help you deploy your Azure infrastructure in an automated and repeatable way.

Azure CLI commands are used to illustrate concepts. You'll learn more about using commands to deploy resources in other modules of the Bicep learning path.

## Defining infrastructure as code

Your company designs new toys for release to the market, and most new toys require some assembly after purchase. The company's design team creates instruction manuals to include with each toy. Each manual provides details about how to properly assemble the toy.

You can think of infrastructure as code as being like the instruction manual for your infrastructure. The manual details the end configuration of your resources and how to reach that configuration state.

Infrastructure as code is the process of automating your infrastructure provisioning. It uses a descriptive coding language and versioning system that's similar to what's used for source code. When you create an application, your source code generates the same result each time it's compiled. In a similar manner, infrastructure-as-code deployments are automated, consistent, and repeatable. Infrastructure as code can automate the deployments of your infrastructure resources, like virtual networks, virtual machines, applications, and storage.

:::image type="content" source="../media/iac.svg" alt-text="Diagram that shows the infrastructure as code process using a source code repository with a template that deploys Azure resources." border="false" :::

If you recall the instruction manual for the new toy, there are multiple ways to write the instruction manual. One option is to detail each step of the build process. Another option is to show an exploded view of the pieces and parts needed to assemble the toy. Later in this unit, you'll learn about the differences between imperative and declarative code and how they relate to your company's instruction manuals.

## Why use infrastructure as code?

Adopting an infrastructure as code approach offers many benefits to resource provisioning. With infrastructure as code, you can:

- Increase confidence in your deployments.
- Manage multiple environments.
- Better understand your cloud resources.

### Increase confidence

One of the benefits of using infrastructure as code is the level of confidence you gain in your deployments from improvements in consistency and security.

- **Integration with current processes**: If your organization already uses standard software development practices, you can adopt those same processes for your infrastructure deployments. For example, peer reviews can help in detecting problems in configurations that may be difficult to detect when making manual changes.

- **Consistency**: Adopting an infrastructure as code approach helps your team follow well-established processes to deploy infrastructure. By following these processes, responsibility shifts from a small group of individuals to your automation process and tooling. Infrastructure as code helps reduce human error in resource provisioning and ensure consistent deployments.

- **Automated scanning**: Infrastructure-as-code configurations can be scanned by automated tooling that can check for errors in the code. Automated tooling can also review proposed changes to ensure that security and performance practices are followed.

- **Secret management**: Many solutions require secrets, like connection strings, encryption keys, client secrets, and certificates. In Azure, an Azure Key Vault is the service that's used to securely store these secrets. Many infrastructure-as-code tools can integrate with Key Vault to access these secrets securely at deployment.

- **Access control**: With infrastructure-as-code deployments, you have the option of using managed identities or service accounts to automate resource provisioning. This process ensures that cloud resources are modified only by these identities. It also helps prevent incorrect configurations deployed to production. If necessary, you can override this process by using an emergency access account (often called a _break glass account_) or by using the Microsoft Entra ID Privileged Identity Management feature.

- **Avoid configuration drift**: _Idempotence_ is a term that's frequently associated with infrastructure as code. When an operation is idempotent, it means that it provides the same result each time it's run. If you choose tooling that uses idempotent operations, you can avoid configuration drift.

As an example of idempotence, consider the following Azure CLI command. The command creates an Azure resource group named `storage-resource-group` in the East US region.

```azurecli
az group create \
  --name storage-resource-group \
  --location eastus
```

If you run this command a second time, you receive the exact same output because this Azure CLI command was designed to be idempotent. You don't receive an error or a duplicate resource group.

When you use infrastructure as code, you can redeploy your environment at each release of your solution. These releases might incorporate small configuration changes or even significant updates. This process helps avoid configuration drift. If an accidental change is made to a resource, it can be corrected by redeploying the configuration. By following this approach, you're documenting your environment by using code.

### Manage multiple environments

Many organizations maintain multiple application environments. The developers in your toy company might have multiple versions of application code staged in a repository for release to different environments. The environments might include development, testing, and production. Some organizations maintain multiple production environments for applications that are distributed globally. Other organizations, like independent software vendors (ISVs), maintain multiple tenant environments for their customers.

Here are some of the key ways infrastructure as code can help you manage your environments:

- **Provision new environments**: One of the main benefits of cloud computing is the ability to scale. Infrastructure as code can help you scale to multiple instances of your application. These instances can help during times of increased load, or you can deploy them for users in other areas of the world. This agility also can be beneficial when you test your application, like during penetration testing, load testing, and bug testing. With a well-defined code base, you can dynamically provision these new environments in a consistent manner.

- **Nonproduction environments**: A common problem organizations face is differentiation between production and non-production environments. When you manually provision resources in separate environments, it's possible that the end configurations won't match. An example is when you deploy a new feature to a nonproduction environment that differs from the production environment. It's possible that the new feature won't work as expected in the production environment because of the differences between the two environments. Using infrastructure as code can help minimize these problems. You can use the same configuration files for each environment but supply different input parameters to create uniqueness.

- **Disaster recovery**: In some situations, infrastructure as code can be used as part of an organization's disaster recovery plan. For example, you might need to re-create your environment in another region because of a service outage. By using infrastructure as code, you can quickly provision a new instance to fail over to instead of manually deploying and reconfiguring everything.

### Better understand your cloud resources

Infrastructure as code can help you better understand the state of your cloud resources:

- **Audit trail**: Changes to your infrastructure-as-code configurations are version controlled in the same way as your application source code. These changes are tracked in your tooling, like with Git's version history. This audit trail means that you can review the details of each change, who made the change, and when the change was made.

- **Documentation**: You can use many infrastructure-as-code configurations to add metadata, like comments, which describe the purpose of the code in your configuration. If your organization already follows a code documentation process, consider adopting these same procedures with your infrastructure code.

- **Unified system**: Many times, when a developer is working on a new feature, they must make changes to application code and infrastructure code. When you use a common system, your organization can better understand the relationship between your applications and your infrastructure.

- **Better understanding of cloud infrastructure**: When you use the Azure portal to provision resources, many of the processes are abstracted from view. Infrastructure as code can help provide a better understanding of how Azure works and how to troubleshoot issues that might arise. For example, when you create a virtual machine by using the Azure portal, some created resources are abstracted from view. Managed disks and network interface cards are deployed behind the scenes. When you deploy the same virtual machine by using infrastructure as code, you have complete control over all resources that are created.

## Imperative and declarative code

You can write an instruction manual for new toy assembly in different ways. When you automate the deployment of services and infrastructure, you can take two approaches: imperative and declarative.

- With _imperative code_, you execute a sequence of commands, in a specific order, to reach an end configuration. This process defines what the code should accomplish, and it defines how to accomplish the task. The imperative approach is like a step-by-step instruction manual.

- With _declarative code_, you specify only the end configuration. The code doesn't define how to accomplish the task. The declarative approach is like the exploded view instruction manual.

When you choose between using an imperative approach and a declarative approach to resource provisioning, consider the tools that might already be in use in your organization. Also consider which approach might match your own skills.

### Imperative code

In Azure, an imperative code approach is accomplished programmatically by using a scripting language like Bash or Azure PowerShell. The scripts execute a series of steps to create, modify, and even remove your resources.

This example shows two Azure CLI commands that create a resource group and a storage account.

```azurecli
#!/usr/bin/env bash
az group create \
  --name storage-resource-group \
  --location eastus

az storage account create \
  --name mystorageaccount \
  --resource-group storage-resource-group \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2 \
  --access-tier Hot \
  --https-only true
```

The first command creates a resource group named `storage-resource-group` in the East US region. The second command creates a storage account named `mystorageaccount` in the `storage-resource-group` resource group that was created in the first command. The second command also configures some properties for the storage account, including the kind of storage account and its access tier.

You can use an imperative approach to fully automate resource provisioning, but the approach has some disadvantages. As your architecture matures, scripts can become complex to manage. Commands could be updated or deprecated, which requires reviews of existing scripts.

### Declarative code

In Azure, a declarative code approach is accomplished by using  _templates_. Many types of templates are available to use, including:

- JSON
- Bicep
- Ansible, by RedHat
- Terraform, by HashiCorp

> [!NOTE]
> This module focuses on using Bicep templates.

Take a look at the following example of a Bicep template that configures a storage account. The configuration of the storage account matches the Azure CLI example.

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'mystorageaccount'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}
```

The resources section defines the storage account configuration. This section contains the name, location, and properties of the storage account, including its SKU and the kind of account.

You might notice that the Bicep template doesn't specify how to deploy the storage account. It specifies only what the storage account needs to look like. The actual steps that are executed behind the scenes to create this storage account or to update it to match the specification are left for Azure to decide.
