This unit provides tips for optimizing and troubleshooting when you're working with CodeQL and code scanning.

## Optimize CodeQL analysis runtimes

There are several reasons why your CodeQL analysis might take too long to complete:

- If you use self-hosted runners for CodeQL analysis, you can increase the memory or the number of cores.
- Problems can occur when a repository contains multiple languages. You can modify your workflow to use a matrix that speeds up the analysis of multiple languages. The analysis of each language runs in parallel with the default CodeQL analysis workflow. You might need to configure advanced workflows similarly if they're set up to run language initialization and analysis sequentially.
- The amount of code that you're analyzing might cause long runtimes. Analysis time is typically proportional to the amount of code that's being analyzed. You can reduce the size of the code by excluding test code or breaking the code into multiple workflows to analyze only a subset with each scan.
- You might want to trigger analysis on the `schedule` event only if your analysis is too slow during `push` or `pull_request` events.

### Optimizing CodeQL queries

Some performance problems might arise from custom queries. You can find common problems and how to troubleshoot them in the [CodeQL documentation about troubleshooting query performance](https://codeql.github.com/docs/writing-codeql-queries/troubleshooting-query-performance/).

Here are important points to keep in mind while you're working with CodeQL and the QL query language:

- CodeQL predicates and classes are evaluated to database tables. Large predicates generate large tables with many rows, so they're expensive to compute.
- The QL language is implemented through standard database operations and relational algebra, such as join, projection, and union.
- Queries are evaluated *bottom up*, which means that a predicate is not evaluated until all of the predicates that it depends on are evaluated.

### Debug artifacts

You can obtain artifacts to help you debug problems with CodeQL code scanning. Modify the `init` step of your CodeQL workflow file and set `debug: true`. The debug artifacts are uploaded to the workflow run as an artifact named `debug-artifacts`. The data contains the CodeQL logs, CodeQL databases, and any SARIF files that the workflow produces.

## Troubleshoot the CodeQL extension for VS Code

The VS Code extension's log files have detailed information to help you troubleshoot.

Progress and error messages appear as notifications in the lower-right corner of the workspace. You can use the **CodeQL Extension Log** dropdown list to select the logs that you need.

:::image type="content" source="../media/log-files.png" alt-text="Screenshot that shows the selection of logs in the Output view." border="false":::

## Common error messages

To troubleshoot your CodeQL workflow, familiarize yourself with the following common error messages.

### Error: "Server error"

If a workflow run for code scanning fails because of a server error, a transient communication problem might be the cause. Try running the workflow again. If the problem persists, contact GitHub support.

### Error: "Out of disk" or "Out of memory"

CodeQL might run out of disk or memory on the runner for very large projects. If it's a hosted GitHub Actions runner, contact GitHub support to investigate the problem. If it's a self-hosted runner, you might need to make adjustments to the server's specifications. For more information, see the [CodeQL documentation about recommended hardware for running CodeQL](https://docs.github.com/en/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/recommended-hardware-resources-for-running-codeql).

### Error: 403 "Resource not accessible by integration" when using Dependabot

Dependabot is considered untrusted when it triggers a workflow run. The workflow runs with read-only scopes. Uploading code-scanning results for a branch usually requires the `security_events: write scope`. However, code scanning always allows the uploading of results when the `pull_request` event triggers the action run. For Dependabot branches, we recommend that you use the `pull_request` event instead of the `push` event.

A simple approach is to run on pushes to the default branch and any other important long-running branches, along with pull requests opened against this set of branches.

Here's an example:

>
```
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
```

### Error: "SARIF Upload Rejected Because of Default Setup"

You get an error if a process tries to upload a SARIF file that contains results of CodeQL analysis to a repository where CodeQL default setup is enabled. This issue includes uploads through the REST API and the CodeQL CLI. SARIF uploads are blocked when CodeQL default setup is enabled, to reduce the potential for user confusion when multiple systems generate similar code-scanning alerts.

This error occurs only for SARIF files that contain results that you create by using CodeQL. To fix this error, disable CodeQL in the repository and then retry uploading the SARIF file.

### Further reading

For more information about troubleshooting, see the [CodeQL documentation for troubleshooting code scanning](https://docs.github.com/en/code-security/code-scanning/troubleshooting-code-scanning).
