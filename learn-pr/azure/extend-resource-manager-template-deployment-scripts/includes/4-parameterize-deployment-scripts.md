In the previous unit, you added some custom behavior to an Azure Resource Manager (ARM) template to stage starting content in a storage account for a new application environment. This solved a specific problem for one application team.

One way to make deployment scripts more adaptable is to provide data to the script. You have two options, command-line arguments and environment variables.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## Using command-line arguments

The first option for passing data into the `deploymentScripts` resources is to customize the `arguments` property. The `arguments` property takes a string of arguments just like the ones you'd supply at the command line. These arguments are supplied to the `command` property of the Azure container instance that will run the script.

> [!NOTE]
> Some parsing happens, so test some variations of your `arguments` property. It'll be broken up into an array of strings the same way that [the Windows shell parses command lines](/windows/win32/api/shellapi/nf-shellapi-commandlinetoargvw).

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/4-example-parameters-template.json" range="21-22,33-36,39-44" highlight="2,5-6" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/4-example-parameters-template.bicep" range="11-12,23-26,29-34" highlight="2,5-6" :::

::: zone-end

## Using environment variables

Your second option is to create environment variables that your scripts can access.

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/4-example-parameters-template.json" range="21-26,31-37,39-44" highlight="3-8,13" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/4-example-parameters-template.bicep" range="11-17,22-27,29-34" highlight="3-8,13" :::

::: zone-end

One benefit of using environment variables is that you can use [the `secureValue` option](/azure/container-instances/container-instances-environment-variables#secure-values) for secrets that might need to be passed into deployment scripts.

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/4-example-parameters-template.json" range="21-44" highlight="3,8-11,18" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/4-example-parameters-template.bicep" range="11-34" highlight="3,8-11,18" :::

::: zone-end

## Passing through parameters

As you've learned, you can set parameter values directly in the properties of the deployment script. There are several other options for values that can be passed in. You can use dynamic values coming from previously created resources, variables declared in the template, or parameters passed directly in to the template at deployment time.

::: zone pivot="jsoncli,jsonpowershell"

These scenarios are available through template functions in the `arguments` or `environmentVariables` property. You can use any of the ARM template functions to access values and pass them in to the template. These functions include `reference`, `parameters`, or `variables`.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

These scenarios are available through template functions in the `arguments` or `environmentVariables` property. You can use any of the Bicep features to access values and pass them in to the template, such as refer to properties from other resources by using their symbolic names, and refer to parameters and variables.

::: zone-end
