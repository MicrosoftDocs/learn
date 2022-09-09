Azure Policy offers built-in policy definitions to help you quickly configure control conditions for your resources. In addition to the built-in policies, you can also create your own definitions, or import definitions from other sources.

## Access built-in policy definitions

You can sort the [list of built-in definitions](/azure/governance/policy/samples/built-in-policies) by category to search for policies that meet your business needs. 

:::image type="content" source="../media/policy-definition-3ce7a058.png" alt-text="Screenshot that shows a list of built-in policy definitions in Azure Policy.":::

Here are some examples of built-in policy definitions:

- **Allowed virtual machine size SKUs**: Specify a set of VM size SKUs that your organization can deploy. This policy is located under the Compute category.

- **Allowed locations**: Restrict the locations users can specify when deploying resources. Use this policy to enforce your geo-compliance requirements. This policy is located under the General category.

- **Configure Azure Device Update for IoT Hub accounts to disable public network access**: Disable public network access for your Device Update for IoT Hub resources. This policy is located under the Internet of Things category.

## Add new policy definitions

If you don't find a built-in policy to meet your business needs, you can add or create a new definition. Policy definitions can also be imported into Azure Policy from [GitHub](https://github.com/Azure/azure-policy/tree/master/samples). New policy definitions are added to the samples repository almost daily.

:::image type="content" source="../media/new-policy-definition-46cb3ecb.png" alt-text="Screenshot that shows how to add a new policy definition, and the option to import a sample policy definition from GitHub.":::

> [!Note]
> When you add or create a policy definition, be sure the definition uses the specific JSON format required by Azure. For more information, see [Azure Policy definition structure](/azure/governance/policy/concepts/definition-structure).