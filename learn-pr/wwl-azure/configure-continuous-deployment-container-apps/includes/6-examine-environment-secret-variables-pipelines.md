Variables give you a convenient way to get key bits of data into various parts of the pipeline. The most common use of variables is to define a value that you can then use in your pipeline. All variables are strings and are mutable. The value of a variable can change from run to run or job to job of your pipeline.

When you define the same variable in multiple places with the same name, the most locally scoped variable wins. So, a variable defined at the job level can override a variable set at the stage level. A variable defined at the stage level overrides a variable set at the pipeline root level. A variable set in the pipeline root level overrides a variable set in the Pipeline settings UI.

You can use variables with expressions to conditionally assign values and further customize pipelines.

Variables are different from runtime parameters. Runtime parameters are typed and available during template parsing.

## Variable types

### User-defined variables

When you define a variable, you can use different syntaxes (macro, template expression, or runtime) and what syntax you use determines where in the pipeline your variable renders.

In YAML pipelines, you can set variables at the root, stage, and job level. You can also specify variables outside of a YAML pipeline in the UI. When you set a variable in the UI, that variable can be encrypted and set as secret.

User-defined variables can be set as read-only. There are naming restrictions for variables (example: you can't use secret at the start of a variable name).

You can use a variable group to make variables available across multiple pipelines.

### System variables

In addition to user-defined variables, Azure Pipelines has system variables with predefined values.

System variables get set with their current value when you run the pipeline. Some variables are set automatically. As a pipeline author or end user, you change the value of a system variable before the pipeline runs.

System variables are read-only.

### Environment variables

Environment variables are specific to the operating system you're using. They're injected into a pipeline in platform-specific ways. The format corresponds to how environment variables get formatted for your specific scripting platform.

On UNIX systems (macOS and Linux), environment variables have the format `$NAME`. On Windows, the format is `%NAME%` for batch and `$env:NAME` in PowerShell.

System and user-defined variables also get injected as environment variables for your platform. When variables convert into environment variables, variable names become uppercase, and periods turn into underscores. For example, the variable name any.variable becomes the variable name `$ANY_VARIABLE`.

There are variable naming restrictions for environment variables (example: you can't use `secret` at the start of a variable name).

## Set secret variables

Secret variables are encrypted variables that you can use in pipelines without exposing their value. Secret variables can be used for private information like passwords, IDs, and other identifying data that you wouldn't want to have exposed in a pipeline. Secret variables are encrypted at rest with a 2048-bit RSA key and are available on the agent for tasks and scripts to use.

The recommended ways to set secret variables are in the UI, in a variable group, and in a variable group from Azure Key Vault. You can also set secret variables in a script with a logging command but this approach isn't recommended since anyone who can access your pipeline is able to also see the secret.

Secret variables set in the pipeline settings UI for a pipeline are scoped to the pipeline where they're set. You can use variable groups to share secret variables across pipelines.

### Secret variable in the UI

To set secrets in the Azure DevOps interface, follow these steps:

1. Go to the Pipelines page, select the appropriate pipeline, and then select Edit.

1. Locate the Variables for this pipeline.

1. Add or update the variable.

1. Select the Secret lock icon to store the variable in an encrypted manner.

1. Save the pipeline.
