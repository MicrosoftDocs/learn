#### Add outputs to your template

In the Outputs section of your template, you can specify values that will be returned after a successful deployment.

there are certain elements that make up the outputs section.

:::code language="azurecli" source="../samples/output-format-sample.json":::

- output-name: Must be a valid JavaScript identifier.
- condition: (Optional)	Is a boolean value that indicates whether this output value is returned. When true, the value is included in the output for the deployment. When false, the output value is skipped for this deployment. When not specified, the default value is true.
- Type: The types of the output value are support the same as the types of template input parameters.
    - NOTE: If you specify securestring for the output type, the value isn't displayed in the deployment history and can't be retrieved from another template. To use a secret value in more than one template, store the secret in a Key Vault and reference the secret in the parameter file. For more information, see Use Azure Key Vault to pass secure parameter value during deployment.
- Value: (Optional) Template language expression that is evaluated and returned as output value.
- Copy: (Optional) the Copy is used to return more than one value for an output.

for more details and the documentation you can refer to [Output iteration in Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/copy-outputs).

And for a complete set of examples of outputs, refer to the [Outputs in Azure Resource Manager template](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-outputs) document.