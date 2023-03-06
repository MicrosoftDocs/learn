You now understand what Bicep registries are, and how they can be helpful when you're sharing modules in your organization. In this unit, you'll learn how to publish a module to a private registry.

## Module paths

When you've worked with modules in the past, you've probably used the module's file path to refer to it in your templates. When you work with modules and private registries, you need to use a different module path so that Bicep knows how to locate the module in your registry.

Here's an example path for a module in a private Azure container registry:

:::image type="content" source="../media/4-private-module-path.png" alt-text="Diagram that shows a module path." border="false":::

The path contains four segments:

- **Scheme**: Bicep supports several module types, which are called _schemes_. When you work with Bicep registries, the scheme is `br`.
- **Registry**: The name of the registry that contains the module you want to use. In the preceding example, the registry name is `toycompany.azurecr.io`, which is the name of the container registry.
- **Module identifier**: The full path to the module within the registry.
- **Tag**: Tags typically represent versions of modules, because a single module can have multiple versions published. You'll learn more about tags and versions shortly.

When you publish your own module identifier, use a meaningful identifier that indicates the purpose of the module. You can optionally use _namespaces_, where you use slashes (`/`) to distinguish between parts of a name. However, Azure Container Registry and Bicep don't understand a hierarchy. They treat the module identifier as a single value.

## Tags and versions

A tag represents the version of a module. A single module in a registry can have multiple versions. All of the versions share a module identifier, but they have different tags. When you use a module, you need to use a tag to specify the version that you want to use, so that Bicep knows which module file to retrieve.

It's a good idea to carefully plan how you'll version your modules. Two key decisions that you need to make are the _versioning scheme_ and the _versioning policy_ to use.

### Versioning schemes

Your versioning scheme determines how you generate version numbers. Common versioning schemes include:

- _Basic integers_ can be used as version numbers. For example, your first version might be called `1`, your second version `2`, and so forth. Or, you might add a prefix to each version number, such as `v1` and `v2`.
- _Dates_ also make good version numbers. For example, if you publish the first version of your module on January 16, 2022, you might name the version `2022-01-16` (using _yyyy-mm-dd_ format). When you publish another version on March 3, you could name it `2022-03-03`.
- _Semantic versioning_ is a versioning system often used in software, where a single version number contains multiple parts. Each part signals different information about the nature of the change.

Although you can use any versioning scheme you like, it's a good idea to choose something that can be sorted into a meaningful order. Numbers and dates are often good choices.

> [!NOTE]
> Azure Container Registry stores the date that each tag is created. Even if you don't use date-based versioning, you can still see this information.

### Versioning policies

Modules give you the flexibility to choose when to create new versions or update an existing version. For example, you can effectively opt out of versioning by creating and publishing a single version named `latest`. Whenever you need to change your module, you simply update that version. Although this policy works, it's not a good practice.

Conversely, if you make a small change to an existing module that doesn't affect how it's used, creating a new version is probably not a good idea. You would need to communicate the new version number to anyone who uses the module.

Here's a versioning policy that often works well:

- Whenever you make significant changes to a module, create a new version. Significant changes include anything that might make a difference to somebody who uses your module. Examples include adding another resource to the module or changing a resource's properties.
- Whenever you make small changes to a module, which are sometimes called a _hotfix_, update the existing module version.
- Delete old versions when they're no longer relevant or when you don't want anyone to use them.

> [!TIP]
> Consider the users of your module, and be sure to think about what they expect will happen. If someone uses your module multiple times and gets one result, and then uses it again after a hotfix and gets a different result, they'll probably be surprised. Try to avoid surprising your users.

## Publish your module

When you create a Bicep module that you want to share, you author the Bicep file as normal. You then _publish_ the file to a registry by using the `bicep publish` command. When you publish, you need to specify the module path to save the module to:

::: zone pivot="cli"

```azurecli
az bicep publish \
   --file module.bicep \
   --target 'br:toycompany.azurecr.io/mymodules/modulename:moduleversion'
```

::: zone-end

::: zone pivot="powershell"

```cmd
bicep publish `
   module.bicep `
   --target 'br:toycompany.azurecr.io/mymodules/modulename:moduleversion'
```

::: zone-end

The publish operation performs the same validation steps that happen when you build or deploy a Bicep file. These steps include:

- Checking that your code doesn't have any syntactical errors.
- Verifying that you're specifying valid resource definitions.
- Running the Bicep linter to verify that your code passes a series of quality checks.

If the validation steps pass, the module is published to your registry.
