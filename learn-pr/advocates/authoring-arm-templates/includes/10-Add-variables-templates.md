#### Add variables to your template.

Variables in ARM templates are used to simplify things. Rather than repeating complicated expressions throughout the template, you define a variable that contains the expression. Then, you reference that variable as needed throughout your template. Resource Manager resolves variables before starting the deployment operations. Wherever a variable is used in the template, the Resource Manager replaces it with the resolved value.

There are three types of variables you can utilize:

1. Strings
1. Objects
1. Arrays

They can be used for:

1. Standard variable definitions where you construct a variable value, and it will returns that values.
1. To store objects that will be referred to, such as [configuration variables](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-variables#configuration-variables), that hold related values for configuring an environment. You define the variable as an object with the required values. For example, you can have a variable that contains the values for two environments - test and prod.
1. To build an array where you stored multiple values and it will returns each of those values based on the index you request when calling the variable.


You can find the [documentation](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-variables) and [examples](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-variables#example-templates) of their usage in the documentation.

The following sample will show you numerous uses of variables types and their output.

:::code language="JSON" source="../samples/variable-samples.json" highlight="5-66":::

The output would be as follows:

:::code language="JSON" source="../samples/variable-sample-output.json":::

In the next exercise, you will be replacing some of the items in your template with variables to simplify it and its deployment.
