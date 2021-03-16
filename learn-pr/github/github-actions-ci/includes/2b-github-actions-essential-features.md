Here, you learn how to use default and custom environment variables, accessing the workflow logs from both the GitHub UI and REST API endpoints, and using scripts within a workflow run. 

## Default environment variables and contexts

Within the GitHub Actions workflow, there are several default environment variables that are available for you to use, but only within the runner that is executing a job. These default variables are case-sensitive, and refer to configuration values for the system and the current user. It is recommended that these default environment variables are used to reference the filesystem rather than using hardcoded file paths. To use a default environment variable, input `$` followed by the environment variable.

```yml
jobs:
  prod-check:
    steps:
      - run: echo "Deploying to production server on branch $GITHUB_REF"
```

For a list of available default environment variables, check out [Default environment variables](https://docs.github.com/en/actions/reference/environment-variables#default-environment-variables).

In addition to default environment variables, you can use defined variables as contexts. Contexts are similar to default variables in that they provide access to environment information, but they're slightly nuanced from each other. While default environment variables can only be used within the runner, context variables can be used at any point within the workflow. For example, context variables allow you to run an `if` statement to evaluate an expression before the runner is executed.

```yml
name: CI
on: push
jobs:
  prod-check:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying to production server on branch $GITHUB_REF"
```

This example is using the `github.ref` context to check the branch that triggered the workflow. If the branch is `main`, the runner is executed and prints out "Deploying to production server on branch $GITHUB_REF". The default environment variable `$GITHUB_REF` is used in the runner to refer to the branch. Notice that default environment variables are all uppercase where context variables are all lowercase.

For more information and a list of available context variables, check out [Contexts](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#contexts).

## Using custom environment variables

Similar to using default environment variables, you can use custom environment variables in your workflow file. To create a custom variable, you need to define it in your workflow file using the `env` context. If you want to use the value of an environment variable inside a runner, you can use the runner operating system's normal method for reading environment variables.

```yml
name: CI
on: push
jobs:
  prod-check:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Nice work, $First_Name. Deploying to production server on branch $GITHUB_REF"
        env:
          First_Name: Mona
```

## Accessing the workflow logs from the user interface

When we think about successful automation, we aim to spend the least amount of time looking at what’s automated, so we can focus our attention on what’s relevant. But sometimes things don’t go as planned, and we are required to review what happened. That debugging process can be frustrating; but the GitHub UI provides a clear layout structure that enables a quick way to navigate between the jobs while keeping the context of the currently debugging step. To view the logs of a workflow run in the GitHub UI, you can follow the below steps:

  1. Navigate to the **Actions** tab in your repository.
  2. In the left sidebar, click the desired workflow.
  3. From the list of workflow runs, select the desired run.
  4. Under **Jobs**, select the desired job.
  5. Read the log output.

If you have several runs within a workflow, you can also select the **status** filter after choosing your workflow and set it to **Failure** to only display the failed runs within that workflow.

For more information on viewing logs for your workflow runs, checkout [Using workflow run logs](https://docs.github.com/en/actions/managing-workflow-runs/using-workflow-run-logs#searching-logs).

## Accessing the workflow logs from the REST API

In addition to viewing logs using the GitHub UI, you can also use GitHub's REST API to view logs for workflow runs, re-run workflows, or even cancel workflow runs. To view a workflow run's log using the API, you need to send a `GET` request to the logs endpoint. Keep in mind that anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the `repo` scope.

For example, a `GET` request to view a specific workflow run log would follow the below path:

```bash
GET /repos/{owner}/{repo}/actions/runs/{run_id}/logs
```

For more information on using the GitHub API to view workflow logs, check out [Workflow runs](https://docs.github.com/en/rest/reference/actions#workflow-runs).

## Enable step debug logging in a workflow

In some cases, the default workflow logs won't provide enough detail to diagnose why a specific workflow run, job, or step has failed. For these situations, you can enable additional debug logging for two options; runs and steps. Enabling this additional logging is done by setting some repository secrets that require `admin` access to the repository to `true`. Below are the two options for additional diagnostic logging.

- To enable runner diagnostic logging, set the `ACTIONS_RUNNER_DEBUG` secret in the repository that contains the workflow to `true`.
- To enable step diagnostic logging, set the `ACTIONS_STEP_DEBUG` secret in the repository that contains the workflow to `true`.

For more information on additional debug logging, check out [Enabling debug logging](https://docs.github.com/en/actions/managing-workflow-runs/enabling-debug-logging#enabling-step-debug-logging).

## Using scripts in your workflow

In the above workflow snippet examples, the `run` keyword is used to simply echo a string of text. Since the `run` keyword tells the job to execute a command on the runner, you use the `run` keyword to run actions or scripts.

```yml
jobs:
  example-job:
    steps:
      - run: npm install -g bats
      - 
```

In this example, you are using npm to install the bats software testing package using the `run` keyword. You can also run a script as an action. You can store the script in your repository, often done in a `.github/scripts/` directory, and then supply the path and shell type using the `run` keyword.

```yml
jobs:
  example-job:
    steps:
      - name: Run build script
        run: ./.github/scripts/build.sh
        shell: bash
```

For more information on adding customized scripts to your workflow, check out [Essential features of GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/essential-features-of-github-actions). 

