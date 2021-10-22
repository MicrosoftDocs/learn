When you work with Bicep code in your own organization, you often create reusable modules that your colleagues would benefit from. These modules might create resources in a way that fits your organization's requirements, such as by using your defined naming conventions and configuring resources so that they meet your security requirements. Private Bicep registries provide an easy way for you to share these modules within your organization. In this unit, you'll learn about private registries and how to use them.

## Create an organizational registry

Bicep registries are built on a technology called *container registries*.

> [!NOTE]
> If your organization uses Kubernetes or another containerization technology, you might already be familiar with registries. However, you don't need to use containers or Kubernetes to work with Bicep - registries simply provide a generic and convenient way to store and share artifacts.

You can create a Bicep registry by using several different container registry services. In Azure, the easiest approach is to use Azure Container Registry. You'll use this approach throughout this module, but you can use other services including Docker Hub for your own registries if you prefer.

Azure Container Registry provides multiple service tiers, with different capabilities and limits. When you provision your own registry, you'll need to select the tier that suits your requirements. We provide links to more information in the summary.

### Access control

Because Azure Container Registry provides a private registry for your organization, you can control who has access to it. Azure Container Registry provides several options for managing access, including by using Azure Active Directory (Azure AD) and by using keys you issue to individual users. When you work with Bicep, the easiest approach is to use Azure AD authentication. Bicep automatically detects the Azure AD identity that you use in the Azure CLI or Azure PowerShell, so you likely don't even need to sign in again. You'll see how this works in the next exercise.

> [!NOTE]
> When you use a Bicep module registry from a pipeline, you'll use a special type of identity called a *service principal*. You'll learn more about service principals and pipelines in future modules.

## Module paths

Module paths for private registries have the same structure as paths for the public registry. Here's an example path for a module in a private Azure container registry:

:::image type="content" source="../media/4-private-module-path.png" alt-text="Diagram showing a module path." border="false":::

Just like you've previously seen, you use the `br` scheme for Bicep registries. In the example above, the registry name is `toycompany.azurecr.io`, which is the name of the Azure container registry.

When you publish your own module identifier, use a meaningful name that indicates the purpose of the module. You can optionally use a *namespaces*, where you use slashes (`/`) to distinguish between parts of a name. However, Azure Container Registry and Bicep don't understand a hierarchy and they treat the module identifier as a single value.

> [!TIP]
> In Azure Container Registry, the module identifier is called a *repository*.

### Aliases 
TODO more here

You can use a *registry alias* to define the registry in the *bicepconfig.json* file, and then use the alias in your Bicep code. You'll see how this works in the next exercise.

## Tags and versions

A tag represents the version of a module. A single module in a registry can have multiple versions. All of the versions share a module identifier, but they have different tags. When you use a module, you need to use a tag to specify the version that you want to use, so that Bicep knows which module file to retrieve. 

It's a good idea to carefully plan how you'll version your modules. Two key decisions that you need to make are the *versioning scheme* and the *versioning policy* to use.

### Versioning schemes

Your versioning scheme determines how you generate version numbers. Common versioning schemes include:

- *Basic integers* can be used as version numbers. For example, your first version might be called `1`, your second version `2`, and so forth. Or, you might add a prefix to each version number, such as `v1` and `v2`.
- *Dates* also make good version numbers. For example, if you publish the first version of your module on January 16, 2021, you might name the version `2021-01-16` (using *yyyy-mm-dd* format). When you publish another version on March 3, you could name it `2021-03-03`.
- *Semantic versioning* is a versioning system often used in software, where a single version number contains multiple parts. Each part signals different information about the nature of the change.

Although you can use any versioning scheme you like, it's a good idea to choose something that will be sorted into a meaningful order. That's why numbers and dates are often good choices.

> [!NOTE]
> Azure Container Registry stores the date that each tag is created. Even if you don't use date-based versioning, you can still see this information.

### Versioning policies

Modules give you the flexibility to choose when to create new versions or to update an existing version. For example, you can effectively opt out of versioning by creating and publishing a single version named `latest`. Whenever you need to change your module, you simply update that version. Although this policy works, it's not a good practice.

Conversely, if you make a small change to an existing module that doesn't affect how it's used, creating a new version is probably not a good idea. You would need to communicate the new version number to anyone who uses the module.

Here's a versioning policy that often works well:

- Whenever you make significant changes to a module, create a new version. Significant changes include anything that might make a difference to somebody who uses your module. Examples include adding another resource to the module or changing a resource's properties.
- Whenever you make small changes to a template spec, which are sometimes called a _hotfix_, update the existing module version.
- Delete old versions when they're no longer relevant or when you don't want anyone to use them.

> [!TIP]
> Consider the users of your module, and make sure you think about what they expect will happen. If a user uses your module multiple times and gets one result, and then uses it again after a hotfix and gets a different result, they'll probably be surprised. Try to minimize the likelihood that your users will get a result they don't expect.

## Publish your module

When you create a Bicep module that you want to share, you author the Bicep file as normal. You then *publish* the file to a registry by using the `bicep publish` command. When you publish, you need to specify the module path to save the module to:

```cmd
bicep publish module.bicep --target 'br:toycompany.azurecr.io/modulerepo/modulename:moduleversion'
```

The publish operation performs the same validation steps that happen when you build or deploy a Bicep file, including:

- Checking that your code doesn't have any syntactical errors.
- Verifying that you're specifying valid resource definitions.
- Running the Bicep linter to verify that your code passes a series of quality checks.

If the validation steps pass, the module is published to your registry.
