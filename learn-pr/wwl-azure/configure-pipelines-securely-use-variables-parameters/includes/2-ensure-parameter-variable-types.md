Parameters and variables are essential components for customizing pipeline behavior. These enable passing runtime values to pipeline tasks and scripts and defining variables for use across different pipeline stages. When using parameters and variables in pipelines, it's crucial to define their data types correctly to avoid any unexpected behavior that could affect the project's security or pipeline execution.

## Parameter and variable types

Parameters and variables are critical to pipeline customization, as they allow for flexibility and enable pipeline scripts to be more dynamic. You can use it to store values such as connection strings, environment variables, and other sensitive data. Properly defining their data types is also essential to avoid unexpected errors or vulnerabilities arising from incorrect usage.

## Add a parameter or variable to your pipeline

```YAML
parameters:
- name: myParameterName
  type: myDataType
  default: myDefaultValue

variables:
- name: myReadOnlyVar
  value: myValue
  readonly: true
```

Replace `myParameterName`, `myDataType`, `myDefaultValue`, `myReadOnlyVar`, and `myValue` with your desired values.

Example:

```YAML
parameters:
- name: image
  displayName: Pool Image
  type: string
  default: ubuntu-latest
  values:
  - windows-latest
  - ubuntu-latest
  - macOS-latest

variables:
 - name: eShopOnWeb
   value: myValue   
```

## Use the correct data types when defining your parameters

Azure Pipelines supports the following data types:

- string
- boolean
- number
- object
- step

Unlike variables, pipeline parameters can't be changed by a pipeline while it's running. Parameters have data types such as `number` and `string`, and they can be restricted to a subset of values. Restricting the parameters is useful when a user-configurable part of the pipeline should take a value only from a constrained list. The setup ensures that the pipeline won't take arbitrary data.

## Define secrets as secret variables or as a part of a variable group

You can use Azure Key Vault to store secrets and then reference them in your pipeline script.

Example:

```YAML
variables:
 - name: eShopOnWeb
   value: myValue

# You can define variable groups to reuse variables across pipelines
# and to manage sensitive data centrally.

variables:
- group: eShopOnWeb
- name: ConnectionStrings.CatalogConnection
  value: '$(CatalogConnectionToken)'

```

## Use the `readonly` property to ensure that variables aren't changed by a pipeline while it's running

It's useful when you want to ensure that a variable isn't changed by a pipeline while it's running. For example, you can use this property to ensure that a variable isn't changed by a pipeline while it's running.

Example:

```YAML
variables:
- name: eShopOnWeb
  value: myValue
  readonly: true
```

## Challenge yourself

A great way to practice ensuring parameter and variable types is to create a pipeline that uses parameters and variables. Define your parameters and variables using the correct syntax and type-safe language. Then, use parameter validation to ensure that the pipeline runs correctly. Finally, use secure variable groups to protect any sensitive information. Test your pipeline to ensure it works as expected, and use the pipeline logs to troubleshoot any issues.

Also, try to create a YAML pipeline that includes a parameter with an incorrect type and run it. Then, correct the error by declaring the correct type for the parameter and rerunning the pipeline. It helps you understand the importance of retaining the type of parameters and variables in the pipeline code.

For more information about variables and parameters, see:

- [Securing Azure Pipelines.](https://learn.microsoft.com/azure/devops/pipelines/security/overview/)
- [How to securely use variables and parameters in your pipeline.](https://learn.microsoft.com/azure/devops/pipelines/security/inputs/)
- [Recommendations to secure shared infrastructure in Azure Pipelines.](https://learn.microsoft.com/azure/devops/pipelines/security/infrastructure/)
- [Runtime parameters.](https://learn.microsoft.com/azure/devops/pipelines/process/runtime-parameters/)
- [Use a variable group's secret and nonsecret variables in an Azure Pipeline.](https://learn.microsoft.com/azure/devops/pipelines/scripts/cli/pipeline-variable-group-secret-nonsecret-variables)
- [Define variables.](https://learn.microsoft.com/azure/devops/pipelines/process/variables/)
