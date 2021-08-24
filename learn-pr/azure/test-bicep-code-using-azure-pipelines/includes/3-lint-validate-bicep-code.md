Now that you know what pipeline stages are for, let's consider the steps that make sense to add to a validation stage in your Bicep deployment pipeline. In this unit, you'll learn about validating Bicep templates, and the two activities that a validation stage typically performs: linting and preflight validation.

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

Because you would like your Bicep templates to be linted each time anyone checks in code to your repository, you can add a validation job to your pipeline:

:::image type="content" source="../media/3-stages-lint.png" alt-text="TODO" border="false":::

You express this in your pipeline YAML file like this:

:::code language="yaml" source="code/3-lint.yml" highlight="7" :::

> [!NOTE]
> By default the linter emits a warning when it discovers a Bicep file has violated a rule. Warnings emitted by the Bicep linter won't be treated as a failure, so they won't stop the execution of your pipeline or stop subsequent stages from running.
>
> You can change this default behavior by configuring Bicep to treat the linter rule violations as errors instead of warnings. You do this by add a *bicepconfig.json* file to the same directory that holds your templates. If you reconfigure the linter to emit errors, then whenever the linter detects an issue, your pipeline stops execution and subsequent jobs or stages don't execute. 

## Preflight validation

You also should check whether your Bicep template is likely to deploy to your Azure environment successfully. This is called *preflight validation*, and it runs additional checks that need Azure to provide information. These kinds of checks include:

- Are the names you've specified for your Bicep resources valid?
- Are the names you've specified for your Bicep resources already taken?
- Are the regions you're deploying your resources to valid?

Preflight validation requires communication with Azure, but it doesn't actually deploy any resources.

:::image type="content" source="../media/3-stages-preflight.png" alt-text="TODO" border="false":::

You use the `az deployment group validate` command to submit a Bicep file for preflight validation:

:::code language="yaml" source="code/3-preflight.yml" highlight="7-9" :::

This command is very similar to the `az deployment group create` command, but it doesn't actually deploy any resources. However, it performs extra checks against the resources that are being used in your template. For example, suppose your Bicep file contains a storage account. Preflight validation will check whether the name you've specified has already been taken by another storage account. It also checks whether the name you chose for the storage account complies with storage account naming conventions. 

> [!TIP]
> The preflight validation command runs the Bicep linter too. However, it's usually a good idea to run the linter separately. That way, if there are any linter errors, you'll detect them quickly instead of waiting for the validation process to complete, which takes longer.

> [!IMPORTANT]
> When you run a preflight validation, each of the Azure resource providers performs their own checks. Some resource providers currently don't run many checks, while others do. This means that you can't rely on preflight validation to give any certainty that your file is valid. Nevertheless, it's a useful tool and is worth including in your pipeline.

By adding validation stages to your pipeline to run the linter and perform a preflight validation, you'll have more confidence before you actually deploy your Bicep file.
