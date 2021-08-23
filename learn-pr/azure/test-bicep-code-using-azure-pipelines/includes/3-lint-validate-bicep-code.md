Now that you know what pipeline stages are for, let's consider the steps that make sense to add to a validation stage in your Bicep deployment pipeline.

In this unit, you'll learn about validating Bicep templates. 

## What does it mean for a Bicep template to be valid?

A valid Bicep template is one that you can confidently deploy to your Azure environment without errors. The template file itself doesn't contain any syntax errors. Also, the definitions for the Azure resources you plan to deploy are valid. And it stays within the quotas and limits that exist in your Azure subscription.

Some of the validation steps are performed on your Bicep file, like the checks for syntax errors and for valid usage of Azure resource definitions. This is called *linting*. To check for other problems, you need to request that the Azure Resource Manager service verifies your Bicep template against your Azure environment.

A valid Bicep template has a greater chance of deploying successfully. You'll get faster feedback to validate it without actually deploying your Bicep template. This is a good practice because, if you deploy a Bicep file that isn't valid, Azure might only deploy some of the resources described in your template. This could mean that the state of your environment is inconsistent and it might not behave the way you expect.

## What is linting and why would you do it in a pipeline?

A first step in validating a Bicep template is called _linting_. Linting is the process of checking code, like your Bicep template, against a set of recommendations. It check your templates against best practices for maintainability, correctness, flexibility and extensibility. A linter contains a pre-defined set of rules for checking rules in each of these categories.

The Bicep linter runs automatically when you use the Bicep tooling. Every time you build a Bicep file, the linter checks it against its best practices. This happens automatically when you deploy a Bicep file to Azure. You can also run the linter separately by using the `bicep build` command:

```cli
bicep build main.bicep
```

Running the build command checks your Bicep template against a set of pre-defined rules. 

> [!NOTE]
> When you run the `bicep build` command, Bicep also transpiles your Bicep code to a JSON ARM template. Often, you don't need the file it outputs, so you can ignore it.

Some example linter rules include:

- **no-hardcoded-env-urls**: The linter checks whether you are using hardcoded environment urls. These are urls like "management.azure.com" or "database.windows.net". In case any of these urls are hard coded in your Bicep template, the linter will emit a warning. A better practice is to use the environment() function in your Bicep template. The 2 mentioned urls are available as environment().resourceManager and environment().sqlServerHostname respectively. 
- **no-unused-params**: The linter checks for any unused parameters. In case there are unused parameters, the linter will emit a warning. To reduce confusion in your template, delete any parameters that are defined but not used. This test finds any parameters that aren't used anywhere in the template. Eliminating unused parameters also makes it easier to deploy your template because you don't have to provide unnecessary values.
- **no-unused-vars**: The linter checks for any unused variables. To reduce confusion in your template, delete any variables that are defined but not used. 
- **prefer-interpolation**: The linter emits a warning in case it sees usage of the concat function instead of string interpolation. Using string interpolation will lead to a more readable Bicep template. 
- **secure-parameter-default**: The linter emits a warning in case you set a default value to a secure parameter. This is a bad practice since it will give the secure parameter a human-readable value. You are allowed to give the secure parameter an empty string value or asign a GUID to it by using the newGuid() function.
- **simplify-interpolation**: In case you are using string interpolation to reference a single parameter or value, the linter will emit a warning. Using the parameter or variable directly, without the string interpolation will make the template better readable. 

By default the linter emits a warning for all of the above rules. You can change this default behavior by adding a *bicepconfig.json* file to the same directory that holds your templates. In this file you could then define to emit an error on each of the above rule violations and hence make the linter more strict: 

```json
{
  "analyzers": {
    "core": {
      "enabled": true,
      "verbose": true,
      "rules": {
        "no-hardcoded-env-urls": {
          "level": "error"
        },
        "no-unused-params": {
          "level": "error"
        },
        "no-unused-vars": {
          "level": "error"
        },
        "prefer-interpolation": {
          "level": "error"
        },
        "secure-parameter-default": {
          "level": "error"
        },
        "simplify-interpolation": {
          "level": "error"
        }
      }
    }
  }
}
```

> [!NOTE]
> The *bicepconfig.json* file also controls how Visual Studio Code shows errors and warnings in the editor. It displays red and yellow squiggly lines under misconfigured parts in your Bicep template. This gives you even quicker feedback when you're writing your Bicep code, further reducing the chance of an error.

Because you would like your Bicep templates to be linted each time anyone checks in code to your repository, you can add a validation job to your pipeline: 

```yaml
stages:
- stage: Validate
  jobs: 
  - job: Validate
    steps:
      - script: |
          bicep build deploy/main.bicep
```

Warnings emitted by the Bicep linter won't stop the execution of your pipeline. If you reconfigure the linter to emit errors, then whenever the linter detects an issue, your pipeline stops execution and subsequent jobs or stages don't execute.

## What is preflight validation and why would you do it in a pipeline?

You also should check whether your Bicep template is likely to deploy in your Azure environment successfully. This is called *preflight validation*, and it runs additional checks that need Azure to provide information. These kinds of checks include:

- Are the names you've specified for your Bicep resources valid?
- Are the names you've specified for your Bicep resources already taken?
- Are the regions you're deploying your resources to valid?

Preflight validation requires communication with Azure, but it doesn't actually deploy any resources. You use the `az deployment group validate` command to submit a Bicep file for preflight validation:

```cli
az deployment group create --resource-group RESOURCEGROUP_NAME --template-file deploy/main.bicep -p environmentType=$(environment)
```

This command is very similar to the `az deployment group create` command, but it doesn't actually deploy any resources. It will, however, perform the same linter rule validation as the `bicep build` command, and it also performs the extra checks against the resources that are being used in your template. 

For example, suppose your Bicep file contains a storage account. Preflight validation will check whether the name you've specified has already been taken by another storage account. It also checks whether the name you chose for the storage account complies with storage account naming conventions. 

> [!NOTE]
> When you run a preflight validation, each of the Azure resource providers performs their own checks. Some resource providers currently don't run many checks, while others do. This means that you can't rely on preflight validation to give any certainty that your file is valid. Nevertheless, it's a useful tool and is worth including in your pipeline.

By adding a validation stage to your pipeline, which checks the linter rules and performs a preflight validation, you'll have more confidence before you actually deploy your Bicep file.
