Let's look at how you create and publish a template spec.

## Create a template

To create a template for use as a template spec, you write an Azure Resource Manager template (ARM template) just like you normally do. You can include parameters, variables, resources, and outputs.

::: zone pivot="jsoncli,jsonpowershell"

You might use _linked templates_, which enable you to define parts of your deployment in separate files. When you work with template specs, linked templates can be embedded into the template spec and referenced from your main template.

It's important that your template is easy for anyone in your organization to understand and use, especially its parameters. Make sure you use clear and understandable parameter names. Use parameter properties and template metadata to provide information about the values that you expect your parameters to include, like in this example:

:::code language="json" source="code/3-parameter.json" highlight="7-10, 12, 16, 18, 24, 29, 31" :::

In the example, the template parameters use the `allowedValues`, `maxValue`, and `description` properties to make clear what the parameters are for and what the effect of setting their values is. The template also includes the `secureString` type to indicate that the `key` parameter contains secret data.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

It's important that your template is easy for anyone in your organization to understand and use, especially the parameters. Make sure you use clear and understandable parameter names. Use parameter decorators to provide information about the values that you expect your parameters to include, like in this example:

:::code language="bicep" source="code/3-parameter.bicep" highlight="1-5, 8-9, 12, 15-16" :::

In the example, the template parameters use the `@allowed`, `@maxValue`, and `@description` decorators to make clear what the parameters are for and what the effect of setting their values is. The template also includes the `secure` decorator to indicate that the `key` parameter contains secret data.

::: zone-end

When someone deploys a template spec by using the Azure portal, the portal:

- Shows the parameter name and description.
- Hides the text entry for secure parameters.
- Enforces the allowed values, length limits, and value limits that you define.

This screenshot illustrates the entry of parameter values:

:::image type="content" source="../media/3-portal-parameters.png" alt-text="Screenshot that shows the Azure portal interface for entering parameter values for a template spec deployment." border="true":::

It's important to think about how users use your template spec, and ensure that your parameters are clear and understandable.

## Publish the template spec to Azure

After your template is written, instead of submitting the template to Azure for deployment, you publish the template spec.

::: zone pivot="bicepcli,biceppowershell"

[!INCLUDE [Note that Bicep template specs are not roundtrippable](./code/note-bicep-roundtrip.md)]

::: zone-end

::: zone pivot="biceppowershell,jsonpowershell"

To create a template spec, use the `New-AzTemplateSpec` cmdlet. The following example shows how you can create a template spec for your storage account template:

::: zone-end

::: zone pivot="biceppowershell"

:::code language="azurepowershell" source="code/3-create.ps1" range="1-6, 8" :::

::: zone-end

::: zone pivot="jsonpowershell"

:::code language="azurepowershell" source="code/3-create.ps1" range="1-7" :::

::: zone-end

::: zone pivot="biceppowershell,jsonpowershell"

Let's look at each of the parameters:

- `-Name` is the resource name of the template spec, which can't include spaces.
- `-Location` is the location in which the template spec metadata should be created. You can deploy the template spec into any region though.
- `-DisplayName` is a human-readable name, which can include spaces.
- `-Description` is a human-readable description, which you can use to provide detail about the contents of the template spec and when someone might use it.
- `-Version` is the version of the template spec. You learn about versions later in this module.
- `-TemplateFile` is the path to the ARM template to create the template spec for.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

To create a template spec, use the `az ts create` command. The following example shows how you can create a template spec for your storage account template:

::: zone-end

::: zone pivot="bicepcli"

:::code language="azurecli" source="code/3-create.sh" range="1-6, 8" :::

::: zone-end

::: zone pivot="jsoncli"

:::code language="azurecli" source="code/3-create.sh" range="1-7" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

Let's look at each of the arguments:

- `--name` is the resource name of the template spec, which can't include spaces.
- `--location` is the location in which the template spec metadata should be created. You can deploy the template spec into any region though.
- `--display-name` is a human-readable name, which can include spaces.
- `--description` is a human-readable description, which you can use to provide detail about the contents of the template spec and when someone might use it.
- `--version` is the version of the template spec. You learn about versions later in this module.
- `--template-file` is the path to the ARM template to create the template spec for.

::: zone-end

> [!TIP]
> You can also define a template spec within an ARM template! Because a template spec is itself an Azure resource, you can deploy a template that defines a resource with the type `Microsoft.Deployments/templateSpecs`.
