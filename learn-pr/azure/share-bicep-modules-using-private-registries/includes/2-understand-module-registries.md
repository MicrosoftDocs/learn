In this unit, you'll learn what Bicep registries are and why they're useful for sharing your Bicep code. You'll also learn how to create a registry for your own organization.

## Why do you share Bicep modules?

When you work with Bicep, you often use similar resources repeatedly. Also, it's common to create combinations of resources that you deploy in multiple places. Bicep modules provide a convenient way to create reusable Bicep files. Each module typically defines a set of resources with a predefined configuration.

One of the benefits of using modules is that you can share them with others, and you can benefit from the modules that others share with you. For example, you might invest time in building and testing a Bicep file to deploy a set of resources that you often use together. When you share your file as a Bicep module, your colleagues can use the module to quickly deploy the same resources.

A Bicep _registry_ is the place where modules are stored and shared. Anyone can create their own registry. In the future, Microsoft plans to support publishing more types of Bicep content to registries, in addition to modules.

> [!TIP]
> Microsoft maintains a public Bicep module registry. The public registry contains modules that anybody in the community can use. Over time, the public registry will contain modules to help to achieve some common scenarios in Bicep.
>
> This Learn module focuses on sharing your own modules by using private registries. The summary unit has a link to more information about the public registry.

## How do registries compare to template specs?

You can save an Azure Resource Manager template (ARM template) as a _template spec_. A template spec is a way to make your templates reusable and share them through your organization.

Modules stored in Bicep registries and template specs are both ways of adding reusability to your deployment code. But they're optimized for different things:

- Bicep modules are intended to be combined into a larger deployment. Template specs are designed to be deployable as a complete template. You can deploy template specs by using the Azure portal, along with tooling like the Azure CLI and Azure PowerShell. But if you've created a template spec, Bicep also enables you to use it as a module if you want.
- Template specs are stored in Azure as resources. Modules in registries are stored as _container artifacts_.
- Template specs provide access control capabilities. When you work with a private registry, you need to control the access to your modules in other ways. You'll learn more about access control in a later unit.

When you're deciding between template specs and Bicep modules, a good rule of thumb is: if the template is going to be deployed as is throughout your organization, template specs are probably a good fit. But if you're likely to reuse this template within multiple parent templates, Bicep modules might serve your needs better. A registry is a good way to share modules.

## Private registries

Bicep registries are built on a technology called _container registries_.

If your organization uses Kubernetes or another containerization technology, you might already be familiar with registries. However, you don't need to use containers or Kubernetes to work with Bicep. Registries provide a generic and convenient way to store and share artifacts. Think of them as being analogous to storage accounts.

Currently, Bicep supports Azure Container Registry. In the future, Microsoft plans to support other registries, such as Docker Hub.

Azure Container Registry provides multiple service tiers, with different capabilities and limits. When you provision your own registry, you'll need to select the tier that suits your requirements. There are links to more information in the summary unit.

Soon, you'll learn how to publish modules to a registry.

> [!TIP]
> In Azure Container Registry, a module is called a _repository_. Don't confuse this with a Git repository. The terms are the same, but the meaning is different.

## Access control

Because Azure Container Registry provides a private registry for your organization, you can control who has access to it. Azure Container Registry provides several options for managing access, including Microsoft Entra ID and keys that you issue to individual users.

When you work with Bicep, the easiest approach is to use Microsoft Entra authentication. Bicep automatically detects the Microsoft Entra identity that you use in the Azure CLI or Azure PowerShell, so you don't need to sign in again. You'll see how authentication works in the next exercise. When you use a Bicep module registry from a pipeline, you use a special type of identity called a _service principal_.

You can separately control who has permission to write modules to your registry and who has permission to read modules.
