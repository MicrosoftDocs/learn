Here, you'll learn how to use default and custom environment variables, custom scripts, cache dependencies, and pass artifact data between jobs. You'll also learn how to access the workflow logs from both the GitHub website and REST API endpoints.

## Default environment variables and contexts

Within the GitHub Actions workflow, there are several default environment variables that are available for you to use, but only within the runner that's executing a job. These default variables are case-sensitive, and they refer to configuration values for the system and for the current user. We recommend that you use these default environment variables to reference the filesystem rather than using hard-coded file paths. To use a default environment variable, specify `$` followed by the environment variable's name.

```yml
jobs:
  prod-check:
    steps:
      - run: echo "Deploying to production server on branch $GITHUB_REF"
```

In addition to default environment variables, you can use defined variables as contexts. Contexts and default variables are similar in that they both provide access to environment information, but they have some important differences. While default environment variables can only be used within the runner, context variables can be used at any point within the workflow. For example, context variables allow you to run an `if` statement to evaluate an expression before the runner is executed.

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

## Custom environment variables

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

## Scripts in your workflow

In the preceding workflow snippet examples, the `run` keyword is used to simply print a string of text. Because the `run` keyword tells the job to execute a command on the runner, you use the `run` keyword to run actions or scripts.

```yml
jobs:
  example-job:
    steps:
      - run: npm install -g bats
```

In this example, you're using npm to install the `bats` software testing package by using the `run` keyword. You can also run a script as an action. You can store the script in your repository, often done in a `.github/scripts/` directory, and then supply the path and shell type using the `run` keyword.

```yml
jobs:
  example-job:
    steps:
      - name: Run build script
        run: ./.github/scripts/build.sh
        shell: bash
``` 

## Cache dependencies with the cache action

When building out a workflow, you'll often find the need to reuse the same outputs or download dependencies from one run to another. Instead of downloading these dependencies over and over again, you can cache them to make your workflow run faster and more efficiently. This can dramatically reduce the time it takes to run certain steps in a workflow, because jobs on GitHub-hosted runners start in a clean virtual environment each time. Caching dependencies will help speed up the time it takes to recreate these dependency files.

To cache dependencies for a job, use GitHub's `cache` action. This action retrieves a cache identified by a unique key that you provide. When the action finds the cache, it then retrieves the cached files to the path that you configure. To use the `cache` action, you'll need to set a few specific parameters:

| Parameter | Description | Required |
| --- | --- | --- |
| Key | Refers to the key identifier created when saving and searching for a cache. | Yes |
| Path | Refers to the file path on the runner to cache or search. | Yes |
| Restore-keys | consists of alternative existing keys to caches if the desired cache key is not found. | No |

```yml
steps:
  - uses: actions/checkout@v2

  - name: Cache NPM dependencies
    uses: actions/cache@v2
    with:
      path: ~/.npm
      key: ${{ runner.os }}-npm-cache-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-npm-cache-
```

In the preceding example, the `path` is set to `~/.npm` and the `key` includes the runner's operating system and the SHA-256 hash of the `package-lock.json` file. Prefixing the key with an ID (`npm-cache` in this example) is useful when you are using the `restore-keys` fallback and have multiple caches.

## Pass artifact data between jobs

Similar to the idea of caching dependencies within your workflow, you can pass data between jobs within the same workflow. You can do this by using the `upload-artifact` and `download-artifact` actions. Jobs that are dependent on a previous job's artifacts must wait for the previous job to complete successfully before they can run. This is useful if you have a series of jobs that need to run sequentially based on artifacts uploaded from a previous job. For example, `job_2` requires `job_1` by using the `needs: job_1` syntax.

```yml
name: Share data between jobs
on: push
jobs:
  job_1:
    name: Upload File
    runs-on: ubuntu-latest
    steps:
      - run: echo "Hello World" > file.txt
      - uses: actions/upload-artifact@v2
        with:
          name: file
          path: file.txt

  job_2:
    name: Download File
    runs-on: ubuntu-latest
    needs: job_1
    steps:
      - uses: actions/download-artifact@v2
        with:
          name: file
      - run: cat file.txt
```

The preceding example has two jobs. `job_1` writes some text into the file `file.txt` and then uses the `actions/upload-artifact@v2` action to upload this artifact and store the data for future use within the workflow. `job_2` requires `job_1` to complete by using the `needs: job_1` syntax, then uses the `actions/download-artifact@v2` action to download that artifact and then print the contents of `file.txt`.

## Enable step debug logging in a workflow

In some cases, the default workflow logs won't provide enough detail to diagnose why a specific workflow run, job, or step has failed. For these situations, you can enable additional debug logging for two options: *runs* and *steps*. Enable this diagnostic logging by setting two repository secrets that require `admin` access to the repository to `true`:

- To enable runner diagnostic logging, set the `ACTIONS_RUNNER_DEBUG` secret in the repository that contains the workflow to `true`.
- To enable step diagnostic logging, set the `ACTIONS_STEP_DEBUG` secret in the repository that contains the workflow to `true`.

## Access the workflow logs from the user interface

When you think about successful automation, you aim to spend the least amount of time looking at what’s automated so you can focus your attention on what’s relevant. But sometimes, things don’t go as planned, and you need to review what happened. That debugging process can be frustrating, but GitHub provides a clear layout structure that enables a quick way to navigate between the jobs while keeping the context of the currently debugging step. To view the logs of a workflow run in GitHub, you can follow these steps:

  1. Navigate to the **Actions** tab in your repository.
  2. In the left sidebar, click the desired workflow.
  3. From the list of workflow runs, select the desired run.
  4. Under **Jobs**, select the desired job.
  5. Read the log output.

If you have several runs within a workflow, you can also select the **Status** filter after choosing your workflow and set it to **Failure** to only display the failed runs within that workflow.

## Access the workflow logs from the REST API

In addition to viewing logs using GitHub, you can also use GitHub's REST API to view logs for workflow runs, re-run workflows, or even cancel workflow runs. To view a workflow run's log using the API, you need to send a `GET` request to the logs endpoint. Keep in mind that anyone with read access to the repository can use this endpoint. If the repository is private, you must use an access token with the `repo` scope.

For example, a `GET` request to view a specific workflow run log would follow this path:

```http
GET /repos/{owner}/{repo}/actions/runs/{run_id}/logs
```
