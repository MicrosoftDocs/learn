Recall that your goal is to automate the code build and publish process so that features are updated each time a developer adds a change to the code base.

To implement this process, you learn how to:

- Identify the event that triggered a workflow.
- Use GitHub Actions workflow logs.
- Save and access build artifacts.
- Automate adding a label to a pull request after a review.

## Identify the event that triggered a workflow

Understanding what triggered a GitHub Actions workflow is crucial for debugging, auditing, and improving CI/CD pipelines. Type of triggers include a push to a branch, a pull request created or updated, a scheduled job, or a manual dispatch. You can identify the triggering event by examining the workflow run, the repository changes, and the related GitHub issue or pull request.

:::image type="content" source="../media/workflow-triggers.png" alt-text="Diagram that shows various workflow triggers in GitHub Actions, such as push, pull request, schedule, and manual dispatch." border="false":::

### What is a workflow trigger?

A workflow trigger is an event that causes a workflow to run. GitHub supports various types of triggers, including:

- `push` or `pull_request` (based on code changes)
- `workflow_dispatch` (a manual trigger)
- `schedule` (cron jobs)
- `repository_dispatch` (external systems)
- Issue, discussion, and pull request events (for example, `issues.opened`, `pull_request.closed`)

### Identify the trigger event

You can identify a workflow trigger event in multiple ways:  

- Use the GitHub Actions UI:

  1. In your repository, select the **Actions** tab.
  1. Select a workflow run.

  An event type, such as `push`, `pull_request`, or `workflow_dispatch`, appears at the top of the workflow run summary.

- Use `github.event_name` in the logs or in a workflow.

  - GitHub exposes context data during a workflow run. The `github.event_name` variable tells you which event triggered the workflow.
  - You can print the information in a step for debugging:

    ```yml
    -name: Show event trigger
      run: echo "Triggered by ${{ github.event_name }}"
    ```

- Use workflow run details:

  - If you inspect workflow runs programmatically, such as by using API, the run object includes an `event` property that specifies the trigger.
  - You can find the commit Secure Hash Algorithm (SHA), actor, and timestamp to trace what caused the trigger.

### Infer the trigger from repository effects

You might not have direct access to the workflow run, but you still want to infer what triggered the workflow run based on repository activity:

| Observed behavior                                       | Trigger event           |
|---------------------------------------------------------|--------------------------|
| A new commit was pushed to `main` and the workflow ran.          | `push` event             |
| A pull request was opened or updated.                | `pull_request` event     |
| A contributor manually ran a workflow.                   | `workflow_dispatch`      |
| The workflow runs daily at a specific time.            | `schedule` (cron)        |
| The workflow ran after an external service call.             | `repository_dispatch`    |
| The workflow ran when a label or comment was added to an issue.  | `issues.*` event         |

By reviewing timestamps, pull request activity, and commit history, you can often pinpoint what action caused the workflow to run.

To summarize how to identify what triggered a workflow:

- Check the workflow run summary on the **Actions** tab.
- Print or log `github.event_name` inside the workflow for visibility.
- Compare timestamps and repository activity (commits, pull requests, issues) to infer the trigger.
- Use the full `event` context for deeper investigation.

These practices help you debug, audit, and improve workflow reliability across your development and deployment pipelines.

## Understand a workflow effect by reading its configuration file

To understand a workflow's effects from reading its configuration file, analyze the structure and contents of the `.yml` file stored in `.github/workflows/`.

The workflow configuration file specifies the following information about the workflow:

- When it runs (in the `on` section).
- What it does (in `jobs` and `steps`).
- Where it runs (the `runs-on` section).
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

   For example:

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

1. Identify or set optional features that affect how the workflow runs:

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
    - If there are environment variables (`env`) or conditionals (`if`) that affect execution.
    - If the failure is due to a missing dependency, syntax error, or misconfigured step.

    If a step fails, check for the following causes:

    - Were dependencies installed successfully in the preceding step?
    - Do test files exist and pass locally?

### Common failure scenarios

The following table describes common workflow failure scenarios:

| Symptom | Likely cause |
|--------|--------------|
| A step fails and returns `command not found`l | Missing dependency or wrong setup |
| `npm install` fails. | Corrupt `package-lock.json` file or a network issue |
| A test step failsl | Unit test issues, missing configuration file, or invalid test syntax |
| `Permission denied` appears. | Incorrect file permissions or missing secrets |

## Identify how to access workflow logs in GitHub

1. In your repository, go to the **Actions** tab.

1. In the list of workflows, select the relevant workflow.

   For example, if your `.yml` file has the following code, a link titled **CI Workflow** appears in the list:

   ```yml
   name: CI Workflow
   ```

1. Select a specific run.

    In the list of runs that show status, select the timestamp or commit message of the specific run you want to inspect.

1. Expand each job and step.

    The run summary page displays jobs as they're defined in the workflow file, such as build or test:

    1. Select a job to expand it.
    1. Inside the job, expand individual steps, such as "Install dependencies" or "Run tests."

1. View log output.

   To view the full log output, including console logs, error messages, and debug information, select a workflow step. You can copy, search, and download the logs.

The following table summarizes the steps you take to access workflow logs:

| Action | Purpose |
|--------|---------|
| **Actions tab** | View all workflow runs. |
| **Select the workflow name** | Filter runs by workflow. |
| **Select a run** | See specific job and step results. |
| **Expand steps** | View detailed logs. |
| **Download logs** | Download logs for offline or team troubleshooting. |

## Action logs for the build

When a workflow runs, it produces a log that includes the details of what happened and any errors or test failures.

If an error occurs or if a test fails, a red X instead of a green checkmark appears in the logs. You can examine the details of the error or failure to investigate what happened.

:::image type="content" source="../media/2-log-details.png" alt-text="Screenshot of GitHub Actions log with details on a failed test.":::

## Customize workflow templates

At the beginning of this module, you considered a scenario in which you need to set up CI for your team of developers. The Node.js template is a great start, but you want to customize it to better suit your team's requirements. You want to target different versions of Node.js and different operating systems. You also want the build and test steps to be separate jobs.

Here's an example of how of a customized workflow:

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



## Work with artifacts

When a workflow produces something other than a log entry, the product is called an *artifact*. For example, the Node.js build produces a Docker container that can be deployed. The container is an artifact that you can upload to storage by using the [actions/upload-artifact](https://github.com/actions/upload-artifact?azure-portal=true) action. You can later download the artifact from storage by using [actions/download-artifact](https://github.com/actions/download-artifact?azure-portal=true).

Storing an artifact preserves it between jobs. Each job uses a fresh instance of a VM, so you can't reuse the artifact by saving it on the VM. If you need your artifact in a different job, you can upload the artifact to storage in one job, and download it for the other job.

### Artifact storage

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

For more information about using artifacts in workflows, see [Storing workflow data as artifacts](https://docs.github.com/enterprise-cloud@latest/actions/using-workflows/storing-workflow-data-as-artifacts).

## Automate reviews in GitHub by using workflows

In addition to starting a workflow via GitHub events like `push` and `pull-request`, you can run a workflow on a schedule or after some event outside GitHub.

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
