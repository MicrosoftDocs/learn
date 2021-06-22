Template specs provide a convenient way to publish and share templates within your organization. As you use template specs more, it becomes important to understand how to manage them.

In this unit you learn about versioning, as well as how to modify and delete template specs, and how to control access to your template specs.

## Add versions

You've already learned that a single template spec can have multiple versions. A template spec acts as a container for one or more versions, and each version is associated with a template file. When you deploy a template spec you need to specify the version you want to use, so that Azure Resource Manager knows which template file to retrieve. The Azure CLI and Azure PowerShell make it easy to work with multiple versions - in fact, you've already been working with versions when you deployed the template spec in the previous exercise.

It's a good idea to give careful consideration to how you plan to version your template specs. Two key decisions you need to make are the *versioning scheme* and the *versioning policy* to use.

### Versioning schemes

Your versioning scheme determines how you generate version numbers. There are some common versioning schemes, such as:

- **Basic integers** can be used as version numbers. For example, your first version might be called `1`, your second version `2`, and so forth.
- **Dates** also make good version numbers. For example, if you publish the first version of your template spec on January 16, 2021 then you might name the version `2021-01-16` (using *yyyy-mm-dd* format). When you publish another version on March 3, you could name it `2021-03-03`.
- **Semantic versioning** is a versioning system often used in software, where a single version number contains multiple parts, each of which signals different information about the nature of the change.

Although you can use any versioning scheme you like, it's a good idea to choose something that will be sorted into a meaningful order, which is why numbers and dates are often good choices.

> [!NOTE]
> Azure stores the date that each version is created, so even if you don't use date-based versioning, you can still see this information.

### Versioning policies

Template specs give you the flexibility to choose when to create new versions or to update an existing version. For example, you could effectively opt out of versioning by creating and publishing a single version named `latest`. Whenever you need to change your template spec, you simply update that version. Although this works, it's not good practice. Conversely, if you make a small change to an existing template that doesn't really affect how it's used, it's probably not a good idea to create a new version since you need to communicate the new version number to anyone who uses the template spec.

Here's a versioning policy that often works well:

- Whenever you make significant changes to a template spec, create a new version. Significant changes include anything that might make a difference to the user who deploys your template spec, like adding another resource to the template, or changing a resource's properties significantly.
- Whenever you make small changes to a template spec, which are sometimes called a _hotfix_, update the existing template spec version.
- Delete old versions when they're no longer relevant or when you don't want anyone to use them.

> [!TIP]
> Consider the users of your template spec, and make sure you think about what they expect will happen. If a user has deployed your template spec multiple times and gets one result, then deploys it again after a hotfix and gets a different result, they will probably be surprised. Try to minimize the likelihood that your users will get a result they don't expect.

### Version descriptions

When you create a new version of a template spec, you can optionally give it a version description. Although it's not required, it's a good practice to do this. Use the version description to give a brief description of the change that you've made, to help anyone who uses your template spec to select the version that best fits their needs.

## View, update, and delete a template spec

Template specs are Azure resources, so you can manage them like any other resource. This means you can view the details of a template spec, update it, and delete it just like normal.

::: zone pivot="biceppowershell,jsonpowershell"

For example, to list the versions of a template spec, use the `Get-AzTemplateSpec` cmdlet:

:::code language="azurepowershell" source="code/6-get-templatespec-1.ps1" :::

The same cmdlet is used to view a template spec version. Add the `-Version` parameter to get the details of a particular version:

:::code language="azurepowershell" source="code/6-get-templatespec-2.ps1" highlight="4" :::

You can access the JSON template by reading the `Template` property from within the `Versions` array:

:::code language="azurepowershell" source="code/6-get-templatespec-3.ps1" highlight="5" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

For example, to list the versions of a template spec, use the `az ts show` command:

:::code language="azurecli" source="code/6-get-templatespec-1.sh" :::

The same command is used to view a template spec version. Add the `--version` argument to get the details of a particular version:

:::code language="azurecli" source="code/6-get-templatespec-2.sh" highlight="4" :::

The JSON template is included in the output.

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

> [!NOTE]
> When you publish a Bicep file to a template spec, it's converted to JSON. You can't see the original Bicep file, so it's a good idea to keep this somewhere else.

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

To update an existing template spec, you use the `Set-AzTemplateSpec` cmdlet. For example, you can use this cmdlet to apply a hotfix to a version you've already published:

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

To update an existing template spec, you use the `az ts update` command. For example, you can use this command to apply a hotfix to a version you've already published:

```azurecli
az ts update \
  --resource-group MyResourceGroup \
  --name MyTemplateSpec \
  --version 1.0 \
  --template-file azuredeploy.json
```

And you can delete a template spec version by using the `az ts delete` commmand:

```azurecli
az ts delete \
  --resource-group MyResourceGroup \
  --name MyTemplateSpec \
  --version 1.0
```

::: zone-end

## Export a template spec

Once you've published a template as a template spec, you can _export_ it. Exporting a template spec downloads the template file to your local computer so you can edit it, or just inspect it so you can understand what the template does.

::: zone pivot="jsoncli,jsonpowershell"

> [!TIP]
> If your template spec includes linked templates, then exporting a template spec also downloads the linked templates - and it even maintains the folder structure.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

[!INCLUDE [Note that Bicep template specs are not roundtrippable](./code/note-bicep-roundtrip.md)]

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

To export a template spec, use the `Export-AzTemplateSpec` cmdlet, and specify the `-OutputFolder` you want to save the template files to:

```azurepowershell
Export-AzTemplateSpec `
  -ResourceGroupName MyResourceGroup `
  -Name MyTemplateSpec `
  -Version 1.0 `
  -OutputFolder ./mytemplate
```

::: zone-end

::: zone pivot="jsoncli,bicepcli"

To export a template spec, use the `az ts export` command, and specify the `--output-folder` you want to save the template files to:

```azurecli
az ts export \
  --resource-group MyResourceGroup \
  --name MyTemplateSpec \
  --version 1.0 \
  --output-folder ./mytemplate
```

::: zone-end

## Control access to a template spec

Since template specs are Azure resources, they use Azure's identity and access management (IAM). When a user deploys a template spec, Azure checks they have access to read the template spec first.

> [!NOTE]
> To be able to deploy a template spec, a user needs access to read the template spec, and also access to deploy to the resource group or other scope they are asking to deploy to. Azure checks both conditions before the deployment starts.
