 Here, you learn about GitHub Ac. ions and workflows for CI. 

You learn how to:

- Create a workflow from a template.
- Understand the GitHub Actions logs.
- Test against multiple targets.
- Separate build and test jobs.
- Save and access build artifacts.
- Automate labeling a PR on review.

## Create a workflow from a template

To create a workflow, you start by using a template. A template has common jobs and steps preconfigured for the particular type of automation you're implementing. If you're not familiar with workflows, jobs, and steps, check out the [Automate development tasks by using GitHub Actions](/training/modules/github-actions-automate-tasks/) module.

On the main page of your repository, select the **Actions** tab and then select **New workflow**.

On the **Choose a workflow** page, you can choose from many different templates. One example is the *Node.js* template, which does a clean install of node dependencies, builds the source code, and runs tests for different versions of Node. Another example is the *Python package* template, which installs Python dependencies, and runs tests, including lint, across different versions of Python.

In the search box, enter **Node.js**.

:::image type="content" source="../media/2-workflow-template-search.png" alt-text="Screenshot showing GitHub Actions tab with the search box highlighted and containing the text 'Node.js'." border="true":::

In the search results, in the Node.js pane, select **Configure**.

:::image type="content" source="../media/2-workflow-template-node-js.png" alt-text="Screenshot showing GitHub Actions tab with the Node.js pane highlighted and the Node.js template selected." border="true":::

You see this default Node.js template workflow, in the newly created file node.js.yml.

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

Notice the `on:` attribute. This workflow is triggered on a push to the repository, and when a pull request is made against the main branch.

There's one `job` in this workflow. Let's review what it does.

The `runs-on:` attribute specifies that, for the operating system, the workflow runs on `ubuntu-latest`. The `node-version:` attribute specifies that there are three builds, one each for Node version 14.x, 16.x, and 18.x. We describe the `matrix` portion in depth later, when we customize the workflow.

The `steps` in the job use the GitHub Actions [actions/checkout@v3](https://github.com/actions/checkout?azure-portal=true) action to get the code from your repository into the VM, and the [actions/setup-node@v3](https://github.com/actions/setup-node?azure-portal=true) action to set up the right version of Node.js. We specify that we're going to test three versions of Node.js with the `${{ matrix.node-version }}` attribute. This attribute references the matrix we previously defined. The `cache` attribute specifies a package manager for caching in the default directory.

The last part of this step executes commands used by Node.js projects. The `npm ci` command installs dependencies from the *package-lock.json* file, `npm run build --if-present` runs a build script if it exists, and `npm test` runs the testing framework. Notice that this template includes both the build and test steps in the same job.

To learn more about npm, check out the npm documentation:

- [npm install](https://docs.npmjs.com/cli/install?azure-portal=true)
- [npm run](https://docs.npmjs.com/cli/run-script?azure-portal=true)
- [npm test](https://docs.npmjs.com/cli/test.html?azure-portal=true)

<<!-- InfoMagnus Starts -->
<!-- INFOMAGNUS UPDATES for sub OD 1.5.9. Source Material: https://docs.github.com/en/actions/sharing-automations/reusing-workflows -->
## How to Utilize Reusable Workflows to Avoid Duplication
 As teams scale and projects grow, it's common to see the same steps such as code checkout, dependency installation, testing, and deployment—repeated across multiple workflow files. This kind of duplication not only clutters your codebase but also increases maintenance time when changes are needed. Reusable workflows solve this problem by allowing you to define automation logic once and call it from other workflows. Reusable workflows are special GitHub Actions workflows that can be called by other workflows, much like functions in programming. You create them with the purpose of sharing repeated logic like build steps, testing procedures, or deployment strategies. Once created, you can reference them from any other workflow in the same repository or even across different repositories.
###  Why Use Them?
- Consistency: Teams can follow the same automation standards across all projects.
- Efficiency: Instead of copying and pasting steps, you just point to a reusable workflow.
- Ease of Updates: When a process changes (e.g., a new test step), you update it in one place, and all workflows using it benefit automatically.
- Scalability: Ideal for platform or DevOps teams managing multiple services.

###  How to Implement Reusable Workflows
To utilize reusable workflows:
- Create a reusable workflow in your repo’s folder. This file will include the automation steps you want to share—like testing, building, or deploying.
- You must explicitly enable a workflow to be reusable by configuring it with the workflow_call event.
- In your main workflows (caller workflows), you then reference this reusable file and provide any required inputs or secrets.

### Real-World Example
Imagine your organization has 10 microservices and all of them need the same steps to:
- Run tests
- Lint code
- Deploy to a specific environment

Without reusable workflows, every repo contains duplicated logic. With reusable workflows, you:
- Define the process once in a central file (e.g., ci-standard.yml)
- Call this file from every service’s own workflow, passing in variables like environment or app name

Now, if a new security step or tool is added (like scanning for vulnerabilities), you only need to add it once in the reusable workflow. All 10 services will immediately use the updated process without modifying each one.

### Best Practices
- Centralize your reusable workflows in one repository if you plan to share them across teams.
- Use branches or tags to version your workflows (e.g., use @v1), so changes won’t break everything unexpectedly.
- Document inputs and secrets clearly—reusable workflows often rely on inputs and secrets, and teams need to know what to supply.
- Combine with composite actions if you only need to reuse a few steps, not a full workflow.

### Summary 
Reusable workflows are a powerful way to enforce consistency, reduce duplication, and scale DevOps practices in any engineering team. Whether you're managing a monorepo, microservices, or open-source libraries, reusable workflows can simplify automation, making CI/CD faster, cleaner, and easier to manage.

<!-- INFOMAGNUS UPDATES for sub OD 2.1.1, 2.1.2, 2.1.3, and 2.1.4 go here. Source Material: Infomagnus team to find source material and cite it.
https://docs.github.com/en/actions/writing-workflows/about-workflows , https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs , https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow , https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/monitoring-workflows/viewing-workflow-run-history , https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/troubleshooting-workflows/about-troubleshooting-workflows -->

## Identify the Event that Triggered a Workflow from its Effects in a Repository, Issue, or Pull Request
Understanding what triggered a GitHub Actions workflow—whether it was a push to a branch, a pull request, a scheduled job, or a manual dispatch—is crucial for debugging, auditing, and improving CI/CD pipelines. You can identify the triggering event by examining the workflow run, the repository changes, or the issue/pull request involved.
###  What Is a Workflow Trigger?
A workflow trigger is an event that causes a workflow to start. GitHub supports various types of triggers, including:
- push or pull_request (based on code changes)
- workflow_dispatch (manual trigger)
- schedule (cron jobs)
- repository_dispatch (external systems)
- Issue, discussion, and PR events (e.g., issues.opened, pull_request.closed)

### Where to Identify the Trigger Event
You can identify the trigger event in several ways:
1 . From the GitHub Actions UI
- Navigate to the Actions tab in your repository.
- Click on a workflow run.
- The event type (e.g., push, pull_request, workflow_dispatch) is displayed at the top of the workflow run summary.

2 . Using github.event_name in Logs or Workflow
- GitHub exposes context data during a workflow run. The github.event_name variable tells you which event triggered the workflow.
- You can print it in a step for debugging:

```yml
-name: Show event trigger
  run: echo "Triggered by ${{ github.event_name }}"
```
3 . Using Workflow Run Details
- If you're inspecting workflow runs programmatically (e.g., via the API), the run object includes an event property that specifies the trigger.
- You can also find the commit SHA, actor, and timestamp to trace what caused the trigger.

### Inferring the Trigger from Repository Effects
Sometimes you may not have direct access to the workflow run but want to infer what triggered it based on repository activity. Here's how:
| Effect Seen | Likely Trigger |
|-------------|----------------|
| A new commit pushed to `main` and workflow ran | `push` event |
| A new pull request opened or updated | `pull_request` event |
| A contributor manually ran a workflow | `workflow_dispatch` |
| Workflow runs every night at a specific time | `schedule` (cron) |
| Workflow ran after an external service call | `repository_dispatch` |
| Workflow ran when an issue was labeled or commented on | `issues.*` event |

By reviewing timestamps, pull request activity, or commit history, you can often pinpoint what action caused the workflow to run.
### Summary
To identify what triggered a workflow:
- Check the workflow run summary in the Actions tab.
- Print or log github.event_name inside the workflow for visibility.
- Compare timestamps and repo activity (commits, PRs, issues) to infer the trigger.
- Use the full event context for deeper investigation.

These practices help with debugging, auditing, and improving workflow reliability across your development and deployment pipelines.
## Describe a Workflow's Effects from Reading its Configuration File
To describe a workflow's effects from reading its configuration file, you need to analyze the structure and contents of the .yml file stored in .github/workflows/. This file outlines when the workflow runs, what it does, and how it behaves under different conditions.
### How to Interpret a workflow's effects:
1 . Identify the Trigger (on:)
This section tells you when the workflow is initiated. For example:
```yml
on:
  push:
    branches: [main]
  pull_request:
    types: [opened, synchronize]
  workflow_dispatch:
```
Effect:
- Runs automatically when code is pushed to the main branch.
- Runs when a pull request is created or updated.
- Can also be triggered manually by a user

2 . Understand the Jobs and Steps (jobs:)
Jobs describe what the workflow will do. For instance:
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
Effect:
- Uses a Linux virtual environment (ubuntu-latest).
- Checks out the repository's code.
- Installs project dependencies.
- Runs automated tests.

3 . Evaluate the Purpose and Outcome
By reading the configuration, you can describe the intended outcome of the workflow:
“This workflow is a Continuous Integration (CI) pipeline. Its effect is to ensure that any new code pushed to the repository or submitted via pull request is automatically tested. If tests fail, the workflow will indicate this in the GitHub UI, helping maintain code quality.”

4 . Optional Features Affecting Behavior
- env: sets environment variables.
- if: adds conditional logic to run certain steps only when criteria are met.
- timeout-minutes: or continue-on-error: influence execution behavior and error handling.

### Summary
From reading a workflow’s configuration file, you can describe its effects by identifying:
- When it runs (on: section),
- What it does (jobs and steps),
- Where it runs (runs-on),
- Why it runs (its purpose: testing, deploying, linting, etc.),
- How it behaves under certain conditions (environment, filters, logic).

## Diagnose a Failed Workflow Run
### 1. Go to the Actions Tab
Navigate to the Actions tab of your repository, then:
- Find the failed run (usually marked with a red)
- Click the failed workflow to open the run summary.

### 2. Review the Error in Logs
In the run summary:
- Expand each job and step until you find the one marked as failed.
- Click to view its logs.

Look for:
- Error messages
- Stack traces
- Exit codes

For example, a failed test might show npm ERR! Test failed. or exit code 1.

### 3. Check the Workflow Configuration File
Use the .yml file to determine:
- What each step was trying to do.
- If there are environment variables (env:) or conditionals (if:) affecting execution.
- If the failure is due to a missing dependency, syntax error, or misconfigured step.

If this step failed, check:
- Were dependencies installed successfully in the previous step?
- Do test files exist and pass locally?

### 4. Common Failure Scenarios
| Symptom | Likely Cause |
|--------|--------------|
| Step fails with `command not found` | Missing dependency or wrong setup |
| `npm install` fails | Corrupt `package-lock.json`, network issue |
| Test step fails | Unit test issues, missing config or invalid test syntax |
| `Permission denied` | Incorrect file permissions or missing secrets |

## Identify Ways to Access the Workflow Logs from the User Interface

### 1. Go to the Repository
Navigate to the repository that contains the workflow. 
### 2. Click on the Actions Tab
- Located in the top navigation bar of the repo.
- This shows a history of all workflow runs for that repository.

### 3. Select the Workflow Name
- Choose the relevant workflow from the list.
For example, if your .yml file has:
```yml
name: CI Workflow
```
You'll see a link named CI Workflow in the list.
### 4. Choose a Specific Run
- You’ll see a list of runs with status indicators
- Click on the timestamp or commit message of the specific run you want to inspect.

### 5.  Expand Each Job and Step
- The run summary page displays jobs as defined in the workflow file (e.g., build, test).
- Click on a job to expand it.
- Inside the job, expand individual steps (e.g., "Install dependencies", "Run tests").

### 6. View Log Output
- Clicking a step shows the full log output (e.g., console logs, error messages, debug info).
- You can copy, search, or download these logs.

### Summary
| Action | Purpose |
|--------|---------|
| **Actions tab** | View all workflow runs |
| **Select workflow name** | Filter runs by workflow |
| **Click on a run** | See specific job/step results |
| **Expand steps** | View detailed logs |
| **Download logs** | For offline or team troubleshooting |


<<!-- InfoMagnus END -->

## Action Logs for the build

When a workflow runs, it produces a log that includes the details of what happened and any errors or test failures.

If there's an error or if a test fails, you see a red rather than a green check mark in the logs. You can examine the details of the error or failure to investigate what happened.
 :::image type="content" source="../media/2-log-details.png" alt-text=" GitHub Actions log with details on a failed test." border="true":::
 
## Customize workflow templates

At the beginning of this module, we described a scenario where you need to set up CI for your team. The Node.js template is a great start, but you want to customize it to better suit your own team's requirements. You want to target different versions of Node and different operating systems. You also want the build and test steps to be separate jobs.

Let's take a look at how you customize a workflow.

```yml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node-version: [16.x, 18.x]
```

Here, we configured a [build matrix](https://docs.github.com/enterprise-server@3.14/actions/writing-workflows/about-workflows#using-a-build-matrix) for testing across multiple operating systems and language versions. This matrix produces four builds, one for each operating system paired with each version of Node.

Four builds, along with all their tests, produce quite a bit of log information. It might be difficult to sort through it all. In the following sample, we show you how to move the test step to a dedicated test job. This job tests against multiple targets. Separating the build and test steps makes it easier to understand the log.

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

When a workflow produces something other than a log entry, the product is called an *artifact*. For example, the Node.js build produces a Docker container that can be deployed. This artifact, the container, can be uploaded to storage by using the action [actions/upload-artifact](https://github.com/actions/upload-artifact?azure-portal=true) and later downloaded from storage by using the action [actions/download-artifact](https://github.com/actions/download-artifact?azure-portal=true).

Storing an artifact preserves it between jobs. Each job uses a fresh instance of a virtual machine (VM), so you can't reuse the artifact by saving it on the VM. If you need your artifact in a different job, you can upload the artifact to storage in one job, and download it for the other job.

## Artifact storage

Artifacts are stored in storage space on GitHub. The space is free for public repositories and some amount is free for private repositories, depending on the account. GitHub stores your artifacts for 90 days.

In the following workflow snippet, notice that in the `actions/upload-artifact@main` action there's a `path:` attribute. The value of this attribute is the path to store the artifact. Here, we specify *public/* to upload everything to a directory. If we just wanted to upload a single file, we use something like *public/mytext.txt*.

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

To download the artifact for testing, the build must complete successfully and upload the artifact. In the following code, we specify that the test job depends on the build job.

```yml
test:
    needs: build
    runs-on: ubuntu-latest
```

In the following workflow snippet, we download the artifact. Now the test job can use the artifact for testing.

```yml
steps:
    - uses: actions/checkout@v3
    - uses: actions/download-artifact@main
      with:
        name: webpack artifacts
        path: public
```

For more information about using artifacts in workflows, see [Storing workflow data as artifacts](https://docs.github.com/en/enterprise-cloud@latest/actions/using-workflows/storing-workflow-data-as-artifacts) in the GitHub documentation.

<!-- INFOMAGNUS UPDATES for sub OD 1.6.4 go here. Source Material: Infomagnus team to find source material and cite sources when they update material 
https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/monitoring-workflows/adding-a-workflow-status-badge -->

## Add a workflow status badge

<!-- InfoMagnus END -->

## Automate reviews in GitHub using workflows

So far, we described starting the workflow with GitHub events such as *push* or *pull-request*. We could also run a workflow on a schedule, or on some event outside of GitHub.

Sometimes, we want to run the workflow only after a person performs an action. For example, we might only want to run a workflow after a reviewer approves the pull request. For this scenario, we can trigger on `pull-request-review`.

Another action we could take is to add a label to the pull request. In this case, we use the [pullreminders/label-when-approved-action](https://github.com/pullreminders/label-when-approved-action?azure-portal=true) action.

```yml
    steps:
     - name: Label when approved
       uses: pullreminders/label-when-approved-action@main
       env:
         APPROVALS: "1"
         GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
         ADD_LABEL: "approved"
```

Notice the block called `env:`. This block is where you set the environment variables for this action. For example, you can set the number of approvers needed. Here, it's one. The `secrets.GITHUB_TOKEN` authentication variable is required because the action must make changes to your repository by adding a label. Finally, you supply the name of the label to add.

Adding a label could be an event that starts another workflow, such as a merge. We cover this event in the next module on continuous delivery with GitHub Actions.

<!-- INFOMAGNUS UPDATES for sub OD 2.2.2 go here. Source Material: Infomagnus team to find source material and cite sources when they update material -->

## Contrast disabling and deleting of workflows

<!-- INFOMAGNUS UPDATES for sub OD 1.3.1 ,1.3.2, and 1.4.1 go here. Source Material: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository -->

## Configure Actions and Workflow permissions

## Set up Secrets and variables for Actions

## Use encrypted secrets to store sensitive information

<!-- InfoMagnus END -->
