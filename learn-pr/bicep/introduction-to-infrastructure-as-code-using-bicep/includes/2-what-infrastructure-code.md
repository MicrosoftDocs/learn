You've been asked to evaluate whether infrastructure as code could be a valuable approach to resource provisioning at your company. You're reviewing the available options for deployment, including:

- Azure portal
- Azure CLI
- Azure PowerShell
- ARM templates (JSON and Bicep)

You're looking for a repeatable option, and need to decide which technology to use to deploy your Azure infrastructure.

In this unit, you'll learn how and why infrastructure as code can help you deploy your Azure infrastructure in an automated and repeatable way.

## Defining infrastructure as code

Your company designs new toys for release to the market, and most new toys require some assembly after purchase. The company's design team creates instruction manuals to include with each toy. Each manual provides details on how to assemble the toy properly.

You can think of infrastructure as code, or IaC, as being like the instruction manual for your infrastructure. The manual details the end configuration of your resources and how to reach that configuration state.

IaC is the process of automating your infrastructure provisioning. It uses a descriptive coding language and versioning system that is similar to what is used for source code. When creating an application, your source code generates the same result each time it's compiled. In a similar manner, IaC deployments are automated, consistent, and repeatable. IaC can automate the deployments of your infrastructure resources such as virtual networks, virtual machines, applications, and storage.

![Infrastructure as code](../media/iac.svg)

Thinking back to the instruction manual for the new toy, there are multiple ways that the instruction manual can be written. One option is to detail each step of the build process. Another option is to show an exploded view of the pieces and parts needed to assemble the toy. Later in this unit, you'll learn about the differences between imperative and declarative code, and how they relate to your company's instruction manuals.

## Why use infrastructure as code?

There are many benefits to adopting an infrastructure as code approach to resource provisioning. With IaC you can:

- Gain higher confidence in your deployments.
- Manage multiple environments.
- Better understand your cloud resources.

### Gain higher confidence

One of the benefits of IaC is the level of confidence you gain in your deployments, including consistency and security.

- **Integration with current processes** - If your organization is already using standard software development practices, you can adopt those same processes for your infrastructure deployments. For example, peer reviews can help in detecting problems in configurations that may be difficult to detect when making manual changes.

- **Consistency** - Adopting an IaC approach helps your team follow well-established processes to deploy infrastructure. By following these processes, responsibility shifts from a small group of individuals to your automation process and tooling. IaC helps reduce human error in resource provisioning, and ensure consistent deployments.

- **Automated scanning** - IaC configurations can be scanned by automated tooling that can check for errors in the code. They can also review proposed changes to ensure that security and performance practices are followed.

- **Secret management** - Many solutions require secrets, such as connection strings, encryption keys, client secrets, and certificates. In Azure, Key Vault is the service used to store these secrets securely. Many IaC tools can integrate with Key Vault to access these secrets securely at the time of deployment.

- **Access control** - With IaC deployments, you have the option of using managed identities or service accounts to automate resource provisioning. This process ensures that cloud resources are only modified by these identities. It also helps prevent incorrect configurations deployed to production. If necessary, you can override this process by using a emergency access account (often called a break glass account) or by using Azure Active Directory's Privileged Identity Management feature.

- **Avoid configuration drift** - _Idempotence_ is a term frequently associated with IaC. When an operation is idempotent, it means that it provides the same result each time it's run. If you choose tooling that uses idempotent operations, you can avoid configuration drift.

Consider the Azure CLI as an example. The following command creates an Azure resource group named `storage-resource-group` in the East US region.

```azurecli
az group create \
    --name storage-resource-group \
    --location eastus
```

If you run this command a second time, you receive the exact same output. You don't receive an error or a duplicate resource group. That's because this Azure CLI command was designed to be idempotent.

When using IaC, you can redeploy your environment at each release of your solution. These releases may incorporate small configuration changes or even significant updates. This process helps to avoid configuration drift. If an accidental change is made to a resource, it can be corrected by redeploying the configuration. By following this approach, you're documenting your environment, with code.

### Manage multiple environments

Many organizations maintain multiple application environments. The developers in your toy company may have multiple versions of application code staged in a repository for release to different environments. These environments could include development, testing, and production. Some organizations will maintain multiple production environments for applications that are distributed globally. Other organizations, such as Independent Software Vendors (ISVs), maintain multi-tenanted environments for their customers.

Here are some of the key ways that IaC can help you manage your environments.

- **Provision new environments** - One of the main benefits of cloud computing is the ability to scale. IaC can help you scale to multiple instances of your application. These instances can help during times of increased load, or they can be deployed for users in other areas of the world. This agility can also be beneficial when testing your application, such as penetration testing, load testing, and bug testing. With a well-defined code base, you can dynamically provision these new environments in a consistent manner.

- **Non-production environments** - A common problem that organizations face is differentiation between production and non-production environments. When provisioning resources in separate environments manually, it's possible that the end configurations won't match. For example, when you deploy a new feature to a non-production environment that differs from production. It's possible that the new feature will not work as expected in the production environment because of their differences. Using IaC can help to minimize these problems. You can use the same configuration files for each environment, but supply different input parameters to create uniqueness.

- **Disaster recovery** - In certain situations, IaC can be used as part of an organization's disaster recovery plan. For example, you may need to recreate your environment in another region because of a service outage. By using IaC, you can quickly provision a new instance to fail over to, rather than manually deploying and reconfiguring everything.

### Better understand your cloud resources

Infrastructure as code can help you better understand the state of your cloud resources.

- **Audit trail** - Changes to your IaC configurations are version-controlled in the same way as your application source code. These changes are tracked in your tooling, such as with Git's version history. This audit trail means you can review the details of each change, who made the change, and when the change was made.

- **Documentation** - Many IaC configurations allow you to add metadata, such as comments. These comments describe the purpose of the code in your configuration. If your organization already follows a code documentation process, consider adopting these same procedures with your infrastructure code.

- **Unified system** - Many times when a developer is working on a new feature, it requires changes to application code and infrastructure code. By using a common system, your organization can better understand the relationship between your applications and infrastructure.

- **Better understanding of cloud infrastructure** - When using the Azure portal to provision resources, many of the processes are abstracted from view. IaC can help provide a better understanding of how Azure works, and how to troubleshoot issues that may arise. For example, when creating a virtual machine using the Azure portal, some created resources are abstracted from view. Managed disks and network interface cards are deployed behind the scenes. When deploying the same virtual machine using IaC, you have complete control over all resources that are created.

## Imperative and declarative code

Thinking back to the instruction manual for the new toy, the manual can be written in different ways. When automating the deployment of services and infrastructure, you can take two approaches: imperative and declarative.

- With imperative code, you execute a sequence of commands, in a specific order, to reach an end configuration. This process defines what the code should accomplish, and it also defines how to accomplish the task. The imperative approach is like the step-by-step instruction manual.

- With declarative code, you specify only the end configuration. It doesn't define how to accomplish the task. The declarative approach is like the exploded view instruction manual.

When choosing between an imperative and declarative approach to resource provisioning, consider the tools that may be in use in your organization. Also consider which approach may match your own skills.

### Imperative code

In Azure, an imperative code approach is accomplished programmatically by using a scripting language such as Bash or Azure PowerShell. These scripts execute a series of steps to create, modify, and even remove your resources.

Take a look at the example below that uses the Azure CLI to create a resource group and a storage account.

```azurecli
#!/usr/bin/env bash
az group create \
    --name storage-resource-group \
    --location eastus

az storage account create \
    --name mystorageaccount \
    --resource-group storage-resource-group \
    --kind StorageV2 \
    --access-tier hot \
    --https-only true
```

The example above executes two Azure CLI commands. The first command creates a resource group named, `storage-resource-group` in the East US region. The second command creates a storage account named, `mystorageaccount`, in the resource group named, `storage-resource-group`, created in the first command. It also configures a couple of properties for the storage account, including the kind and access tier.

An imperative approach can be used to fully automate resource provisioning, but it has some disadvantages. As your architecture matures, scripts can become complex to manage. Commands may be updated or deprecated, which requires reviews of existing scripts.

### Declarative code

In Azure, a declarative code approach is accomplished by using _templates_. There are many types of templates available for use including:

- JSON
- Bicep
- Ansible, by RedHat
- Terraform, by HashiCorp

> [!NOTE]
> This module will be focused on the use of Bicep templates.

Take a look at the example below of a Bicep template that configures a storage account. The configuration of the storage account matches the Azure CLI example above.

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'mystorageaccount'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'hot'
    supportsHttpsTrafficOnly: true
  }
}
```

The resources section defines the configuration of the storage account. This section contains the name, location, and properties of the storage account, including its SKU and account kind.

You may notice that the Bicep template doesn't specify how to deploy the storage account - it just specifies what the storage account needs to look like. The actual steps that are executed behind the scenes to create this storage account, or update it to match the specification, are left for Azure to decide.
