You developed an understanding of the Bicep template language and the benefits that it provides for template authoring. Before you begin the process of writing Bicep templates to provision your resources, you want to learn more about how Bicep works.

In this unit, you learn about how Bicep works with Azure Resource Manager.

## Bicep deployment

In the preceding unit, you learned that Bicep is designed for a specific scenario or *domain*, which makes it a domain-specific language. Bicep is built to make it easy to deploy and configure Azure resources.

When you deploy a resource or series of resources to Azure, you submit the Bicep template to Resource Manager, which still requires JSON templates. The tooling built into Bicep converts your Bicep template into a JSON template. This process is known as *transpilation*, which essentially treats the ARM template as an intermediate language. The conversion happens automatically when you submit your deployment, or you can do it manually.

:::image type="content" source="../../includes/media/bicep-to-json.png" alt-text="Diagram that shows the workflow from a template author, a Bicep template, an emitted JSON template, and a deployment to Azure." border="false" :::

> [!NOTE]
> Transpilation is the process of converting source code written in one language into another language.

The latest versions of Azure CLI and Azure PowerShell have built-in Bicep support. You can use the same deployment commands to deploy Bicep and JSON templates. For example, the following command deploys a Bicep template to a resource group named `storage-resource-group`:

```azurecli
az deployment group create \
  --template-file main.bicep \
  --resource-group storage-resource-group
```

After this deployment is submitted, Resource Manager looks at the resources currently deployed in Azure. It then looks at what you're trying to deploy, and it sets up a sequence of steps to achieve this state. All these activities involve invoking the Resource Manager API.

You can view the JSON template you submitted to Resource Manager by using the `bicep build` command. In the next example, a Bicep template is converted into its corresponding JSON template:

```bash
bicep build main.bicep
```

## Comparing JSON and Bicep

Bicep provides a simpler syntax to use when you're writing templates. Look at the following examples of two templates. The template on the left side of the screen is a Bicep template. The template on the right side of the screen is a JSON template.

:::image type="content" source="../media/bicep-json-comparison-inline.png" alt-text="Screenshot that compares Bicep code on the left side of the screen and the corresponding JSON code on the right side of the screen." lightbox="../media/bicep-json-comparison-expanded.png":::

Notice that the Bicep template contains less code. The syntax is easier to read and comprehend, and there are no complex expressions like in the JSON template on the right.

> [!NOTE]
> To view equivalent JSON and Bicep files side by side, see [Bicep Playground](https://aka.ms/bicepdemo).
