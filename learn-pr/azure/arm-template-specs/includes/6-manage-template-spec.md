Template specs provide a convenient way to publish and share templates within your organization. As you use template specs more, it becomes important to understand how to manage them.

In this unit, you learn about versioning, how to modify and delete template specs, and how to control access to template specs.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## Add versions

You learned that a single template spec can have multiple versions. A template spec acts as a container for one or more versions, and each version is associated with a template file. When you deploy a template spec, you need to specify the version that you want to use, so that Azure Resource Manager knows which template file to retrieve. 

The Azure CLI and Azure PowerShell make it easy to work with multiple versions. In fact, you already worked with versions when you deployed the template spec in the previous exercise.

It's a good idea to carefully plan how you'll version your template specs. Two key decisions to make are the *versioning scheme* and the *versioning policy* to use.

### Versioning schemes

Your versioning scheme determines how you generate version numbers. Common versioning schemes include:

- *Basic integers* can be used as version numbers. For example, your first version might be called `1`, your second version `2`, and so forth.
- *Dates* also make good version numbers. For example, if you publish the first version of your template spec on January 16, 2021, you might name the version `2021-01-16` (using *yyyy-mm-dd* format). When you publish another version on March 3, you could name it `2021-03-03`.
- *Semantic versioning* is a versioning system often used in software, where a single version number contains multiple parts. Each part signals different information about the nature of the change.

Although you can use any versioning scheme you like, it's a good idea to choose something that can be sorted into a meaningful order such as numbers and dates.

> [!NOTE]
> Azure stores the date that each version is created. Even if you don't use date-based versioning, you can still see this information.

### Versioning policies

Template specs give you the flexibility to choose when to create new versions or to update an existing version. For example, you can effectively opt out of versioning by creating and publishing a single version named `latest`. Whenever you need to change your template spec, you simply update that version. Although this policy works, it's not a good practice.

Conversely, if you make a small change to an existing template that doesn't affect its use, creating a new version is probably not a good idea. You would need to communicate the new version number to anyone who uses the template spec.

Here's a versioning policy that often works well:

- Whenever you make significant changes to a template spec, create a new version. Significant changes to your template spec include anything that might make a difference to the user who deploys it. Examples include adding another resource to the template or changing a resource's properties.
- Whenever you make small changes to a template spec, which are sometimes called a *hotfix*, update the existing template spec version.
- Delete old versions when they're no longer relevant or when you don't want anyone to use them.

> [!TIP]
> Consider the users of your template spec, and make sure you think about what they expect will happen. If a user deploys your template spec multiple times and gets one result, and then deploys it again after a hotfix and gets a different result, they'll probably be surprised. Try to minimize the likelihood that your users will get a result they don't expect.

### Version descriptions

When you create a new version of a template spec, you can optionally give it a version description. Providing a version description is good practice, even if it isn't required. The version description summarizes the changes that you made, to help anyone who uses your template spec to select the version that best fits their needs.

## Making changes to a template spec

Template specs are Azure resources, so you can manage them like any other resource. This means you can view the details of a template spec, update it, and delete it, just like normal.

::: zone pivot="biceppowershell,jsonpowershell"

For example, to list the versions of a template spec, use the `Get-AzTemplateSpec` cmdlet:

:::code language="azurepowershell" source="code/6-get-templatespec-1.ps1" :::

The same cmdlet is used to view a template spec version. Add the `-Version` parameter to get the details of a version:

:::code language="azurepowershell" source="code/6-get-templatespec-2.ps1" highlight="4" :::

You can access the JSON template by reading the `MainTemplate` property from within the `Versions` array:

:::code language="azurepowershell" source="code/6-get-templatespec-3.ps1" highlight="5" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

For example, to list the versions of a template spec, use the `az ts show` command:

:::code language="azurecli" source="code/6-get-templatespec-1.sh" :::

The same command is used to view a template spec version. Add the `--version` argument to get the details of a version:

:::code language="azurecli" source="code/6-get-templatespec-2.sh" highlight="4" :::

The JSON template is included in the output.

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

> [!NOTE]
> When you publish a Bicep file to a template spec, it's converted to JSON. You can't see the original Bicep file, so it's a good idea to keep that somewhere else.

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

To update an existing template spec, you use the `Set-AzTemplateSpec` cmdlet. For example, you can use this cmdlet to apply a hotfix to a version you already published:

```azurepowershell
Set-AzTemplateSpec `
  -ResourceGroupName MyResourceGroup `
  -Name MyTemplateSpec `
  -Version 1.0 `
  -TemplateFile azuredeploy.json
```

And you can delete a template spec version by using the `Remove-AzTemplateSpec` cmdlet:

```azurepowershell
Remove-AzTemplateSpec `
  -ResourceGroupName MyResourceGroup `
  -Name MyTemplateSpec `
  -Version 1.0
```

::: zone-end

::: zone pivot="jsoncli,bicepcli"

To update an existing template spec, you use the `az ts update` command. For example, you can use this command to apply a hotfix to a version you already published:

```azurecli
az ts update \
  --resource-group MyResourceGroup \
  --name MyTemplateSpec \
  --version 1.0 \
  --template-file azuredeploy.json
```

And you can delete a template spec version by using the `az ts delete` command:

```azurecli
az ts delete \
  --resource-group MyResourceGroup \
  --name MyTemplateSpec \
  --version 1.0
```

::: zone-end

## Export a template spec

After you publish a template as a template spec, you can *export* it. Exporting a template spec downloads the template file to your local computer. There, you can either edit the template file or just inspect it so you can understand what it does.

::: zone pivot="jsoncli,jsonpowershell"

> [!TIP]
> If your template spec includes linked templates, then exporting a template spec also downloads the linked templates. It even maintains the folder structure.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

[!INCLUDE [Note that Bicep template specs are not roundtrippable](./code/note-bicep-roundtrip.md)]

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

To export a template spec, use the `Export-AzTemplateSpec` cmdlet. Use the `-OutputFolder` value to specify where you want to save the template files:

```azurepowershell
Export-AzTemplateSpec `
  -ResourceGroupName MyResourceGroup `
  -Name MyTemplateSpec `
  -Version 1.0 `
  -OutputFolder ./mytemplate
```

::: zone-end

::: zone pivot="jsoncli,bicepcli"

To export a template spec, use the `az ts export` command. Use the `--output-folder` value to specify where you want to save the template files:

```azurecli
az ts export \
  --resource-group MyResourceGroup \
  --name MyTemplateSpec \
  --version 1.0 \
  --output-folder ./mytemplate
```

::: zone-end

## Control access to a template spec

Because template specs are Azure resources, they use Azure's identity and access management (IAM). When a user deploys a template spec, Azure checks that the user has access to read the template spec first.

> [!NOTE]
> To deploy a template spec, a user needs:
> 
> - Access to read the template spec.
> - Access to deploy to the resource group or other scope that they're asking to deploy to. 
>
> Azure checks both conditions before the deployment starts.
