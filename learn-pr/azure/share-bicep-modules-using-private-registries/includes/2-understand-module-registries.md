In this unit, you'll learn what Bicep registries are, why they're useful for sharing your Bicep code, and how you can create a registry for your own organization.

## Why do you share Bicep modules?

When you work with Bicep, you often use similar resources repeatedly. Also, it's common to create combinations of resources that you deploy in multiple places. Bicep modules provide a convenient way to create reusable Bicep files. Each module typically defines a set of resources with a predefined configuration.

One of the benefits of using modules is that you can share them with others, and you can benefit from the modules that others share with you. For example, you might invest time in building and testing a Bicep file to deploy a set of resources that you often use together. When you share your file as a Bicep module, your colleagues can use the module to quickly deploy the same resources.

A Bicep *registry* is the place that modules are stored and shared. Anyone can create their own registry. In future, registries will support more types of Bicep content in addition to modules.

## How do registries compare to template specs?

Azure Resource Manager also enables you to save an Azure Resource Manager template (ARM template) as a *template spec*. This is a way of making your templates reusable and sharing them through your organization. Modules stored in Bicep registries and template specs are both ways of adding reusability to your deployment code, but they're optimized for different things:

- Bicep modules are intended to be combined into a larger deployment. Template specs are designed to be deployable as a complete template. You can deploy template specs by using Azure portal as well as tooling like the Azure CLI and Azure PowerShell. However, if you have created a template spec, Bicep also enables to use it as a module if you want.
- Template specs are stored in Azure as resources. Modules in registries are stored as *container artifacts*, which you'll learn about later in this unit.
- Template specs provide access control capabilities. When you work with a private registry, you need to control the access to your modules in other ways. You'll learn more about this later in the module.

When you're deciding between template specs and Bicep modules, a good rule of thumb is: if the template is going to be deployed as is throughout your organization, template specs are probably a good fit. But if you're likely to reuse this template within multiple parent templates, Bicep modules might serve your needs better, and a registry is a good way to share modules.

## Private registries

Bicep registries are built on a technology called *container registries*.

If your organization uses Kubernetes or another containerization technology, you might already be familiar with registries. However, you don't need to use containers or Kubernetes to work with Bicep - registries simply provide a generic and convenient way to store and share artifacts. Think of them as being analogous to storage accounts.

<!-- TODO I think we only support ACR today -->
You can create a Bicep registry by using several different container registry services. In Azure, the easiest approach is to use Azure Container Registry. You'll use this approach throughout this module, but you can use other services including Docker Hub for your own registries if you prefer.

Azure Container Registry provides multiple service tiers, with different capabilities and limits. When you provision your own registry, you'll need to select the tier that suits your requirements. We provide links to more information in the summary.

## Access control

Because Azure Container Registry provides a private registry for your organization, you can control who has access to it. Azure Container Registry provides several options for managing access, including by using Azure Active Directory (Azure AD) and by using keys that you issue to individual users. When you work with Bicep, the easiest approach is to use Azure AD authentication. Bicep automatically detects the Azure AD identity that you use in the Azure CLI or Azure PowerShell, so you likely don't even need to sign in again. You'll see how this works in the next exercise.

When you use a Bicep module registry from a pipeline, you'll use a special type of identity called a *service principal*. You'll learn more about service principals and pipelines in future modules.
