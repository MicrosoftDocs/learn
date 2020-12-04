In the previous unit, you added some custom behavior to our Azure Resource Manager (ARM) template to stage starting content in a storage account for a new application environment. This solved a very specific problem for one application team. One way to make deployment scripts more adaptable would be to provide data to the script. You have two options, command line arguments and environment variables.

## Using command-line arguments

The first option for passing data into our `deploymentScripts` resources is to customize the `arguments` property. The `arguments` property takes a string of arguments just like you would supply at the command line. These arguments get supplied to the `command` property of the Azure Container Instance (ACI) that will run our script.

> [!NOTE]
> There is some parsing that happens, so test some variations of your `arguments`.  It'll be broken up into an array of strings the same way that [the Windows Shell parses command lines](https://docs.microsoft.com/windows/win32/api/shellapi/nf-shellapi-commandlinetoargvw).

:::code language="json" source="code/example-parameters-template.json" range="21-22,33-36,39-44" highlight="2,5-6" :::

## Using environment variables

Our second option is to create environment variables that can be accessed by our scripts.

:::code language="json" source="code/example-parameters-template.json" range="21-26,31-37,39-44" highlight="3-8,13" :::

One benefit of using environment variables is you can use [the `secureValue` option](https://docs.microsoft.com/azure/container-instances/container-instances-environment-variables#secure-values) for secrets that may need to be passed in to deployment scripts.

:::code language="json" source="code/example-parameters-template.json" range="21-44" highlight="3,8-11,18" :::

## Passing through parameters

As you've seen, parameter values can be set directly in the properties of the deployment script. There are several other options for values that can be passed in. You can use dynamic values coming from previously created resources, variables declared in the template, or parameters passed directly in to the template at deployment time.

These scenarios are available by using template functions either in our `arguments` or `environmentVariables` properties.  You can use any of the existing functions like `reference`, `parameters`, or `variables` to access values and pass them in to the template.
