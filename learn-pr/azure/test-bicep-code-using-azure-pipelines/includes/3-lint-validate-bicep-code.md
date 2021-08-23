Now that you know what pipeline stages are for, let's consider the steps that make sense to add to a validation stage in your Bicep deployment pipeline.

In this unit, you'll learn about validating Bicep templates. 

## What does it mean for a Bicep file to be valid?

A valid Bicep file is one that you can confidently deploy to your Azure environment. The file itself doesn't contain any syntax errors. Also, the definitions for the Azure resources you plan to deploy are valid. And when the resources defined in the file are deployed, they stay within the quotas and limits that exist in your Azure subscription.

Some of the validation steps are performed on your Bicep file in isolation, like the checks for syntax errors, for valid Azure resource definitions, and for code quality. These steps are called *linting*. To check for other problems, you need to request that the Azure Resource Manager service verifies your template against your Azure environment.

A valid Bicep template has a greater chance of deploying successfully. You'll get feedback without actually deploying your Bicep template. This is a good practice because, if you deploy a Bicep file that isn't valid, Azure might only deploy or change a subset of the resources described in your template. This could mean that the state of your environment is inconsistent and it might not behave the way you expect.

## Building and linting Bicep code

When you deploy a Bicep file, the Bicep tooling first runs some basic validation steps. These steps are the same ones that run when you modify your file using Visual Studio Code. They check that you've used Bicep's language keywords correctly and that you've defined your Azure resources according to the rules for each resource type.

In addition, the Bicep linter validates your files. Linting is the process of checking your code against a set of recommendations. The Bicep linter looks at your file and verifies you've followed best practices for maintainability, correctness, flexibility and extensibility. A linter contains a pre-defined set of rules for checking rules in each of these categories. Some example linter rules include:

- **Unused parameters.** To reduce confusion in your template, it's good practice to delete any parameters that are defined but not used. This check finds any parameters that aren't used anywhere in the Bicep file. By eliminating unused parameters, you also make it easier to deploy your template because you don't have to provide unnecessary values.
- **String interpolation.** The linter checks if your file uses the `concat()` function instead of Bicep string interpolation. String interpolation makes your Bicep files more readable.
- **Defaults for secure parameters.** Avoid setting default values for secure parameters. This is a bad practice since it will give the secure parameter a human-readable value, and people might not change it before they deploy.

The Bicep linter runs automatically when you use the Bicep tooling. Every time you build a Bicep file, the linter checks it against its best practices. This happens automatically when you deploy a Bicep file to Azure. But in a pipeline, you typically want to run the validation and linting steps before you deploy the file. So, you can tell Bicep to verify your file by using the `bicep build` command:

```cli
bicep build main.bicep
```

> [!NOTE]
> When you run the `bicep build` command, Bicep also transpiles your Bicep code to a JSON ARM template. Often, you don't need the file it outputs, so you can ignore it.

## Customize the linter's behavior

<!-- TODO here down -->

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
