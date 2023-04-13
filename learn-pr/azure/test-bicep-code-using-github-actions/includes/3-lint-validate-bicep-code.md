Now that you know what workflow jobs are for, let's consider the first set of validation steps that you can add to your Bicep deployment workflow. In this unit, you'll learn about validating Bicep templates. You'll also learn about the two validation activities that are commonly used: linting and preflight validation.

## What is a valid Bicep file?

A valid Bicep file doesn't contain any syntax errors. Also, the definitions for the Azure resources that you plan to deploy are valid. And when the resources defined in the file are deployed, they stay within the quotas and limits that exist in your Azure subscription.

Some of the checks are performed on your Bicep file in isolation, like the checks for syntax errors, for valid Azure resource definitions, and for code quality. These steps are part of a process called _linting_. To check for other problems, you need to request that the Azure Resource Manager service validates your template and takes your Azure environment into consideration.

A valid Bicep template has a greater chance of deploying successfully. You'll get feedback without actually deploying your Bicep template. Validation is a good practice because if you deploy a Bicep file that isn't valid, Azure might deploy or change only a subset of the resources described in your template. A partial deployment could mean that the state of your environment is inconsistent and might not behave the way you expect.

## Building and linting Bicep code

When you deploy a Bicep file, the Bicep tooling first runs some basic validation steps. These steps are the same ones that run when you modify your file by using Visual Studio Code. They check that you've used Bicep's language keywords correctly and that you've defined your Azure resources according to the requirements for each resource type.

In addition, Bicep runs a _linter_ over your files. Linting is the process of checking your code against a set of recommendations. The Bicep linter looks at your file and verifies that you've followed best practices for maintainability, correctness, flexibility, and extensibility.

A linter contains a predefined set of rules for each of these categories. Example linter rules include:

- **Unused parameters**. The linter scans for any parameters that aren't used anywhere in the Bicep file. By eliminating unused parameters, you make it easier to deploy your template because you don't have to provide unnecessary values. You also reduce confusion when someone tries to work with your Bicep file.
- **String interpolation**. The linter checks if your file uses the `concat()` function instead of Bicep string interpolation. String interpolation makes your Bicep files more readable.
- **Default values for secure parameters**. The linter warns you if you set default values for parameters marked with the `@secure()` decorator. Setting defaults for secure parameters is a bad practice because it gives the secure parameter a human-readable value, and people might not change it before they deploy.

The Bicep linter runs automatically when you use the Bicep tooling. Every time you build a Bicep file, the linter checks it against its best practices. This check happens automatically when you deploy a Bicep file to Azure.

But in a workflow, you typically want to run the validation and linting steps before you deploy the file. You can tell Bicep to verify your file by manually building the Bicep file through the Bicep CLI:

::: zone pivot="cli"

```azurecli
az bicep build --file main.bicep
```

::: zone-end

::: zone pivot="powershell"

```powershell
bicep build main.bicep
```

::: zone-end

> [!NOTE]
> When you run the `build` command, Bicep also transpiles your Bicep code to a JSON ARM template. You generally don't need the file that it outputs, so you can ignore it.

Because you want your Bicep templates to be linted each time anyone checks in code to your repository, you can add a lint job to your workflow:

:::image type="content" source="../media/3-jobs-lint.png" alt-text="Diagram that shows a workflow with a lint job containing a single job that runs the linter on the file." border="false":::

You express this addition in your workflow YAML file like this:

:::code language="yaml" source="code/3-lint.yml" highlight="7" :::

### Linter warnings and errors

By default, the linter emits a warning when it discovers that a Bicep file has violated a rule. Warnings that the Bicep linter emits aren't treated as an error, so they won't stop the workflow run or stop subsequent jobs from running.

You can change this behavior by configuring Bicep to treat the linter rule violations as errors instead of warnings. You do this configuration by adding a _bicepconfig.json_ file to the folder that contains your Bicep file. You can decide which linter issues should be treated as errors and which should remain as warnings. You'll configure the linter later in this module.

> [!TIP]
> The _bicepconfig.json_ file also controls how Visual Studio Code shows errors and warnings in the editor. It displays red and yellow squiggly lines under misconfigured parts in your Bicep template. These indicators give you even quicker feedback when you're writing your Bicep code, further reducing the chance of an error.

After you reconfigure the linter to emit errors, whenever the linter detects a problem, your workflow stops running and subsequent jobs don't run. This configuration helps ensure that problematic Bicep code won't be deployed.

## Preflight validation

You also should check whether your Bicep template is likely to deploy to your Azure environment successfully. This process is called _preflight validation_, and it runs checks that need Azure to provide information. These kinds of checks include:

- Are the names that you've specified for your Bicep resources valid?
- Are the names that you've specified for your Bicep resources already taken?
- Are the regions that you're deploying your resources to valid?

Preflight validation requires communication with Azure, but it doesn't actually deploy any resources.

:::image type="content" source="../media/3-jobs-validate.png" alt-text="Diagram that shows a workflow with lint and validate jobs, each containing a single job. The validate job communicates with Azure." border="false":::

To submit a Bicep file for preflight validation, you use the `arm-deploy` action, and set the `deploymentMode` to `Validate`:

:::code language="yaml" source="code/3-preflight.yml" range="1, 9-23" highlight="16" :::

You can also use the Azure CLI's `az deployment group validate` command.

Preflight validation is similar to a normal deployment, but it doesn't actually deploy any resources. It performs extra checks against the resources that are being used in your template.

For example, suppose your Bicep file contains a storage account. Preflight validation will check whether another storage account has already taken the name you chose. It also checks whether the name you chose for the storage account complies with naming conventions.

The preflight validation command runs the Bicep linter too. However, it's usually a good idea to run the linter separately. That way, if there are any linter errors, you'll detect them quickly instead of waiting for the validation process to finish. Validation takes longer.

> [!IMPORTANT]
> When you run a preflight validation, each of the Azure resource providers performs its own checks. Some resource providers don't run many checks, whereas others do. So you can't rely on preflight validation to be certain that your file is valid. Nevertheless, it's a useful tool and is worth including in your workflow.

By adding validation jobs to your workflow to run the linter and perform a preflight validation, you'll have more confidence before you deploy your Bicep file.
