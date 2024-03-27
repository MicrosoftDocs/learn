
When using Actions to create CI or CD workflows, you'll typically need to pass variable values to the actions. It's done by using Environment Variables.

## Built-in environment variables

GitHub provides a series of built-in environment variables. It all has a GITHUB\_ prefix.

> [!NOTE]
> Setting that prefix for your variables will result in an error.

Examples of built-in environment variables are:

**GITHUB\_WORKFLOW** is the name of the workflow.

**GITHUB\_ACTION** is the unique identifier for the action.

**GITHUB\_REPOSITORY** is the name of the repository (but also includes the name of the owner in owner/repo format)

## Using variables in workflows

Variables are set in the YAML workflow files. They're passed to the actions that are in the step.

```YAML
jobs:
    verify-connection:
        steps:
            - name: Verify Connection to SQL Server
            - run: node testconnection.js
        env:
            PROJECT_SERVER: PH202323V
            PROJECT_DATABASE: HAMaster

```

For more information on environment variables, including a list of built-in environment variables, see [Environment variables](https://docs.github.com/actions/learn-github-actions/environment-variables).
