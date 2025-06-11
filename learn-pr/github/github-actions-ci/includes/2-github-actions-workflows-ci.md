Recall that your goal is to automate the code build and publish process so that features are updated each time a developer adds a change to the code base.

To implement this process, you learn how to:

- Create a workflow from a template.
- Understand GitHub Actions workflow logs.
- Test against multiple targets.
- Separate build and test jobs.
- Save and access build artifacts.
- Automate labeling a pull request on review.

## Create a workflow from a template

To create a workflow, it's common to begin by using a template. A template has common jobs and steps preconfigured for the specific type of automation you're implementing. If you're not familiar with workflows, jobs, and steps, check out the [Automate development tasks by using GitHub Actions](/training/modules/github-actions-automate-tasks/) module.

On the main page of your GitHub repository, select **Actions**, and then select **New workflow**.

On the **Choose a workflow** page, you can choose from many types of templates. One example is the Node.js template. The *Node.js template* installs Node.js and all dependencies, builds the source code, and runs tests for different versions of Node.js. Another example is the *Python package* template, which installs Python and its dependencies, and then runs tests, including lint, across different versions of Python.

To begin with the Node.js workflow template, In the search box, enter **Node.js**.

:::image type="content" source="../media/2-workflow-template-search.png" alt-text="Screenshot that shows the GitHub Actions tab with the search box highlighted and with the text Node.js.":::

In the search results, in the **Node.js** pane, select **Configure**.

:::image type="content" source="../media/2-workflow-template-node-js.png" alt-text="Screenshot that shows the GitHub Actions tab with the Node.js pane highlighted and the Configure button selected.":::

A `node.js.yml` file for your project is created from the template:

```yml
name: Node.js CI

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build:

    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [14.x, 16.x, 18.x]

    steps:
    - uses: actions/checkout@v3
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version }}
        cache: 'npm'
    - run: npm ci
    - run: npm run build --if-present
    - run: npm test
```

Notice the `on` attribute. This workflow is triggered on a push to the repository and when a pull request is made against the main branch.

There's one `job` in this workflow. Let's review what it does.

The `runs-on` attribute specifies that, for the operating system, the workflow runs on `ubuntu-latest`. The `node-version:` attribute specifies that there are three builds, one each for Node.js version 14.x, 16.x, and 18.x. We describe the `matrix` portion in depth later when we customize the workflow.

The `steps` in the job use the GitHub Actions [actions/checkout@v3](https://github.com/actions/checkout?azure-portal=true) action to get the code from your repository into the virtual machine, and the [actions/setup-node@v3](https://github.com/actions/setup-node?azure-portal=true) action to set up the correct version of Node.js. You specify that you want to test three versions of Node.js by using the `${{ matrix.node-version }}` attribute. This attribute references the matrix that you defined earlier. The `cache` attribute specifies a package manager for caching in the default directory.

The last part of this step executes commands used by Node.js projects. The `npm ci` command installs dependencies from the *package-lock.json* file, `npm run build --if-present` runs a build script if it exists, and `npm test` runs the testing framework. Notice that this template includes both the build and test steps in the same job.

To learn more about npm, check out the npm documentation:

- [npm install](https://docs.npmjs.com/cli/v11/commands/npm-install?azure-portal=true)
- [npm run](https://docs.npmjs.com/cli/v11/commands/npm-run?azure-portal=true)
- [npm test](https://docs.npmjs.com/cli/v11/commands/npm-test?azure-portal=true)

Beyond individual npm commands, teams can benefit from reusable workflows to streamline and standardize repeated automation steps. By leveraging reusable workflows, you can reduce redundancy, improve maintainability, and ensure consistency across your CI/CD pipelines.

<!-- InfoMagnus Starts -->
<!-- INFOMAGNUS UPDATES for sub OD 1.5.9. Source Material: https://docs.github.com/en/actions/sharing-automations/reusing-workflows -->
## Avoid duplication by using reusable workflows

As teams scale and projects grow, it's common to see the same steps, such as code checkout, dependency installation, testing, and deployment—repeated across multiple workflow files. This kind of duplication not only clutters your codebase but also increases maintenance time when changes are needed. Reusable workflows solve this problem by allowing you to define automation logic once and call it from other workflows.

Reusable workflows are special GitHub Actions workflows that can be called by other workflows, much like functions in programming. You create them to share repeated logic like build steps, testing procedures, or deployment strategies. Once created, you can reference them from any other workflow in the same repository or even across different repositories.

:::image type="content" source="../media/reusable-workflow.png" alt-text="Diagram illustrating the concept of reusable workflows in GitHub Actions, showing how a central workflow can be referenced by multiple repositories or workflows." border="true":::

### Why use them?

- Consistency: Teams can follow the same automation standards across all projects.
- Efficiency: Instead of copying and pasting steps, you just point to a reusable workflow.
- Ease of Updates: When a process changes (e.g., a new test step), you update it in one place, and all workflows using it benefit automatically.
- Scalability: Ideal for platform or DevOps teams managing multiple services.

Let's explore how to use reusable workflows to improve your projects.

### Implement reusable workflows

To utilize reusable workflows:

- Create a reusable workflow in your repo’s folder. This file will include the automation steps you want to share—like testing, building, or deploying.
- You must explicitly enable a workflow to be reusable by configuring it with the workflow_call event.
- In your main workflows (caller workflows), you then reference this reusable file and provide any required inputs or secrets.

To illustrate the advantages of reusable workflows, consider the following real-world scenario.

### Real-world example

Imagine your organization has 10 microservices and all of them need the same steps to:

- Run tests
- Lint code
- Deploy to a specific environment

Without reusable workflows, every repo contains duplicated logic. With reusable workflows, you:

- Define the process once in a central file (e.g., ci-standard.yml)
- Call this file from every service’s own workflow, passing in variables like environment or app name

Now, if a new security step or tool is added (like scanning for vulnerabilities), you only need to add it once in the reusable workflow. All 10 services will immediately use the updated process without modifying each one.

By understanding how reusable workflows function and their benefits, you can adopt best practices to maximize their effectiveness and ensure seamless integration into your CI/CD pipelines.

### Best practices

- Centralize your reusable workflows in one repository if you plan to share them across teams.
- Use branches or tags to version your workflows (e.g., use @v1), so changes won’t break everything unexpectedly.
- Document inputs and secrets clearly—reusable workflows often rely on inputs and secrets, and teams need to know what to supply.
- Combine with composite actions if you only need to reuse a few steps, not a full workflow.

### Summary

Reusable workflows are a powerful way to enforce consistency, reduce duplication, and scale DevOps practices in any engineering team. Whether you're managing a monorepo, microservices, or open-source libraries, reusable workflows can simplify automation, making CI/CD faster, cleaner, and easier to manage.

<!-- INFOMAGNUS UPDATES for sub OD 2.1.1, 2.1.2, 2.1.3, and 2.1.4 go here. Source Material: Infomagnus team to find source material and cite it.
https://docs.github.com/en/actions/writing-workflows/about-workflows , https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs , https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow , https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/monitoring-workflows/viewing-workflow-run-history , https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/troubleshooting-workflows/about-troubleshooting-workflows -->

## Identify the event that triggered a workflow from its effects

Understanding what triggered a GitHub Actions workflow, whether it was a push to a branch, a pull request, a scheduled job, or a manual dispatch, is crucial for debugging, auditing, and improving CI/CD pipelines. You can identify the triggering event by examining the workflow run, the repository changes, or the issue/pull request involved.

:::image type="content" source="../media/workflow-triggers.png" alt-text="Diagram illustrating various workflow triggers in GitHub Actions, such as push, pull request, schedule, and manual dispatch." border="true":::

### What is a workflow trigger?

A workflow trigger is an event that causes a workflow to start. GitHub supports various types of triggers, including:

- `push` or `pull_request` (based on code changes)
- `workflow_dispatch` (manual trigger)
- schedule (cron jobs)
- `repository_dispatch` (external systems)
- Issue, discussion, and PR events (e.g., issues.opened, pull_request.closed)

### Where to identify the trigger event?

You can identify a trigger event in multiple ways:  

- From the GitHub Actions UI:

   1. In your repository, select the **Actions** tab.
   1. Select a workflow run.

      An event type, such as `push`, `pull_request`, or `workflow_dispatch`, appears at the top of the workflow run summary.

- Use `github.event_name` in the logs or in a workflow.

  - GitHub exposes context data during a workflow run. The `github.event_name` variable tells you which event triggered the workflow.
  - You can print it in a step for debugging:

    ```yml
    -name: Show event trigger
      run: echo "Triggered by ${{ github.event_name }}"
    ```

- Use workflow run details:

  - If you inspect workflow runs programmatically, such as by using the API, the run object includes an event property that specifies the trigger.
  - You can also find the commit SHA, actor, and timestamp to trace what caused the trigger.

### Infer the trigger from repository effects

You might not have direct access to the workflow run, but you still want to infer what triggered the workflow run based on repository activity.

Here's how:

| Observed behavior                                       | Trigger event           |
|---------------------------------------------------------|--------------------------|
| A new commit pushed to `main` and the workflow ran.          | `push` event             |
| A pull request was opened or updated.                | `pull_request` event     |
| A contributor manually ran a workflow.                   | `workflow_dispatch`      |
| The workflow runs daily at a specific time.            | `schedule` (cron)        |
| The workflow ran after an external service call.             | `repository_dispatch`    |
| The workflow ran when a label or comment was added to an issue.  | `issues.*` event         |

By reviewing timestamps, pull request activity, or commit history, you can often pinpoint what action caused the workflow to run.

### Summary

To identify what triggered a workflow:

- Check the workflow run summary on the **Actions** tab.
- Print or log github.event_name inside the workflow for visibility.
- Compare timestamps and repo activity (commits, PRs, issues) to infer the trigger.
- Use the full event context for deeper investigation.

These practices help with debugging, auditing, and improving workflow reliability across your development and deployment pipelines.

## Describe a workflow effect by reading its configuration file

To describe a workflow's effects from reading its configuration file, you need to analyze the structure and contents of the `.yml` file stored in `.github/workflows`/.

The workflow configuration file identifies the following information about the workflow:

- When it runs (in the `on` section).
- What it does (in `jobs` and `steps`).
- Where it runs (`runs-on`).
- Why it runs (its purpose, such as testing, deploying, or linting).
- How it behaves in specific conditions (environment, filters, logic).

### Interpret a workflow effect

1. Identify the trigger.

   To identify what action initiated the workflow, see the `on` section of the workflow.

   For example:

   ```yml
   on:
     push:
       branches: [main]
     pull_request:
       types: [opened, synchronize]
     workflow_dispatch:
   ```

   This example workflow:

   - Runs automatically when code is pushed to the main branch (`push`).
   - Runs when a pull request is created or updated (`pull_request`).
   - Can be triggered manually by a user (`workflow_dispatch`).

1. Identify the workflow jobs and steps.

   To determine what the workflow does, see the `jobs` and `steps` sections of the workflow.

   For example::

   ```yml
   jobs:
     test:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout code
           uses: actions/checkout@v3
         - name: Install dependencies
           run: npm install
         - name: Run tests
           run: npm test
   ```

   This example workflow:

   - Uses a Linux virtual environment (`runs-on`).
   - Checks out the repository's code (`steps` > `name`).
   - Installs project dependencies (`steps` > `name`).
   - Runs automated tests (`steps` > `name`).

1. Evaluate the workflow's purpose and outcome.

   By reading the configuration file, you can describe the intended outcome of the workflow:

   “This workflow is a continuous integration (CI) pipeline. It ensures that any new code that is pushed to the repository or submitted via pull request is automatically tested. If tests fail, the GitHub workflow UI displays this result to help you maintain code quality.”

1. Identify or set optional features that affect how the workflow runs.

   - `env` sets environment variables.
   - `if` adds conditional logic to run specific steps only when criteria are met.
   - `timeout-minutes` or `continue-on-error` set workflow execution and error handling.

## Diagnose a failed workflow run

1. In your repository, go to the **Actions** tab.

1. Find the failed run (typically indicated by a red **X**).

1. Select the failed workflow to open the run summary.

1. In the workflow logs, review the error.

   1. In the run summary, expand each job and step until you find the one that indicates failure.
   1. Select the job or step to view its logs.
   1. Look for:

      - Error messages
      - Stack traces
      - Exit codes

For example, a failed test might show `npm ERR! Test failed` or `exit code 1`.

1. Check the workflow configuration file.

    Use the `.yml` file to determine:

    - What was each step trying to do?
    - If there are environment variables (`env`) or conditionals (`if`) affecting execution.
    - If the failure is due to a missing dependency, syntax error, or misconfigured step.

    If this step failed, check for the following causes:

    - Were dependencies installed successfully in the previous step?
    - Do test files exist and pass locally?

### Common failure scenarios

The following table describes common workflow failure scenarios:

| Symptom | Likely cause |
|--------|--------------|
| A step fails and returns `command not found` | Missing dependency or wrong setup |
| `npm install` fails | Corrupt `package-lock.json` file or a network issue |
| Test step fails | Unit test issues, missing configuration file, or invalid test syntax |
| `Permission denied` | Incorrect file permissions or missing secrets |

## Identify ways to access the workflow logs from the user interface

1. In your repository, go to the **Actions** tab.

1. In the list of workflows, select the relevant workflow.

   For example, if your `.yml` file has the following code, a link titled **CI Workflow** appears in the list:

   ```yml
   name: CI Workflow
   ```

1. Select a specific run.

    In the list of runs with status indicators, select the timestamp or commit message of the specific run you want to inspect.

1. Expand each job and step.

    The run summary page displays jobs as they are defined in the workflow file, such as build or test.

    1. Select a job to expand it.
    1. Inside the job, expand individual steps, such as "Install dependencies" or "Run tests".

1. View log output.

   To view the full log output, including console logs, error messages, and debug information, select a workflow step. You can copy, search, and download the logs.

The following table summarizes the steps you take to access the workflow logs:

| Action | Purpose |
|--------|---------|
| **Actions tab** | View all workflow runs. |
| **Select workflow name** | Filter runs by workflow. |
| **Click on a run** | See specific job and step results. |
| **Expand steps** | View detailed logs. |
| **Download logs** | Download for offline or team troubleshooting. |

## Action logs for the build

When a workflow runs, it produces a log that includes the details of what happened and any errors or test failures.

If there's an error or if a test fails, you see a red X rather than a green check mark in the logs. You can examine the details of the error or failure to investigate what happened.

:::image type="content" source="../media/2-log-details.png" alt-text="Screenshot of GitHub Actions log with details on a failed test." border="true":::

## Customize workflow templates

At the beginning of this module, we described a scenario where you need to set up CI for your team. The Node.js template is a great start, but you want to customize it to better suit your own team's requirements. You want to target different versions of Node.js and different operating systems. You also want the build and test steps to be separate jobs.

Here's an example of how to customize a workflow:

```yml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node-version: [16.x, 18.x]
```

In this example, you configure a [build matrix](https://docs.github.com/enterprise-server@3.14/actions/writing-workflows/about-workflows#using-a-build-matrix) for testing across multiple operating systems and language versions. This matrix produces four builds, one for each operating system paired with each version of Node.js.

Four builds and their tests produce a large amount of log data. It might be difficult to sort through it all. In the following sample, you move the test step to a dedicated test job. This job tests against multiple targets. Separating the build and test steps makes it easier to work with the log data.

```yml
test:
  runs-on: ${{ matrix.os }}
  strategy:
    matrix:
      os: [ubuntu-latest, windows-latest]
      node-version: [16.x, 18.x]
  steps:
  - uses: actions/checkout@v3
  - name: Use Node.js ${{ matrix.node-version }}
    uses: actions/setup-node@v3
    with:
      node-version: ${{ matrix.node-version }}
  - name: npm install, and test
    run: |
      npm install
      npm test
    env:
      CI: true
```

<!-- INFOMAGNUS UPDATES for sub OD 2.2.1 go here. Source Material: Infomagnus team to find source material and cite sources when they update material 
https://docs.github.com/en/actions/writing-workflows/about-workflows -->

## Locate a workflow in a repository

<!-- InfoMagnus END -->

## What are artifacts?

When a workflow produces something other than a log entry, the product is called an *artifact*. For example, the Node.js build produces a Docker container that can be deployed. The container is an artifact that you can upload to storage by using the [actions/upload-artifact](https://github.com/actions/upload-artifact?azure-portal=true) action. You can later downloaded the artifact from storage by using [actions/download-artifact](https://github.com/actions/download-artifact?azure-portal=true).

Storing an artifact preserves it between jobs. Each job uses a fresh instance of a virtual machine (VM), so you can't reuse the artifact by saving it on the VM. If you need your artifact in a different job, you can upload the artifact to storage in one job, and download it for the other job.

## Artifact storage

Artifacts are stored in storage space on GitHub. The space is free for public repositories, and some storage is free for private repositories, depending on the account. GitHub stores your artifacts for 90 days.

In the following workflow snippet, notice that in the `actions/upload-artifact@main` action there's a `path` attribute. The value of this attribute is the path to store the artifact. In this example, you specify *public/* to upload everything to a directory. If you wanted only to upload a single file, use something like *public/mytext.txt*.

```yml
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: npm install and build webpack
        run: |
          npm install
          npm run build
      - uses: actions/upload-artifact@main
        with:
          name: webpack artifacts
          path: public/
```

To download the artifact for testing, the build must complete successfully and upload the artifact. In the following code, you specify that the test job depends on the build job.

```yml
test:
    needs: build
    runs-on: ubuntu-latest
```

In the following workflow snippet, you download the artifact. Now the test job can use the artifact for testing.

```yml
steps:
    - uses: actions/checkout@v3
    - uses: actions/download-artifact@main
      with:
        name: webpack artifacts
        path: public
```

For more information about using artifacts in workflows, see [Storing workflow data as artifacts](https://docs.github.com/en/enterprise-cloud@latest/actions/using-workflows/storing-workflow-data-as-artifacts).

## Automate reviews in GitHub using workflows

In addition to starting a workflow via GitHub events like `push` and `pull-request`, you can run a workflow on a schedule or after some event outside of GitHub.

You might want a workflow to run only after a user completes a specific action, such as after a reviewer approves a pull request. For this scenario, you can trigger on `pull-request-review`.

Another action you can take is to add a label to the pull request. In this case, use the [pullreminders/label-when-approved-action](https://github.com/pullreminders/label-when-approved-action?azure-portal=true) action.

For example:

```yml
    steps:
     - name: Label when approved
       uses: pullreminders/label-when-approved-action@main
       env:
         APPROVALS: "1"
         GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
         ADD_LABEL: "approved"
```

In the `env` block, you set the environment variables for the action. For example, you can set the number of approvers required to run the workflow. In this example, it's one. The `secrets.GITHUB_TOKEN` authentication variable is required because the action must make changes to your repository by adding a label. Finally, you enter the name of the label to add.

Adding a label might be an event that starts another workflow, such as a merge. We cover this event in the next module, which describes using continuous delivery in GitHub Actions.
