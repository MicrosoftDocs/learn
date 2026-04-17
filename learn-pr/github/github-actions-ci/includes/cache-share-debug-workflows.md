In this unit, you'll learn how to optimize performance, pass data between jobs, and troubleshoot workflows using logs and tokens.

To implement this process, you'll learn how to:

- Cache dependencies for faster workflows.
- Pass artifact data between jobs.
- Enable debug logging for workflows. 
- Access workflow logs from the GitHub UI and REST API.
- Use installation tokens for GitHub App authentication.

## Cache dependencies with the cache action

When you build out a workflow, you often need to reuse the same outputs or download dependencies from one run to another. Instead of downloading these dependencies over and over again, you can cache them to make your workflow run faster and more efficiently. Caching dependencies reduces the time it takes to run certain steps in a workflow, because jobs on GitHub-hosted runners start in a clean virtual environment each time.

To cache dependencies for a job, use GitHub's `cache` action. This action retrieves a cache identified by a unique key that you provide. When the action finds the cache, it then retrieves the cached files to the path that you configure. To use the `cache` action, you need to set a few specific parameters:

| Parameter | Description | Required |
| --- | --- | --- |
| `Key` | Refers to the key identifier created when saving and searching for a cache. | Yes |
| `Path` | Refers to the file path on the runner to cache or search. | Yes |
| `Restore-keys` | Consists of alternative existing keys to cache if the desired cache key isn't found. | No |

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

In the preceding example, the `path` is set to `~/.npm` and the `key` includes the runner's operating system and the SHA-256 hash of the `package-lock.json` file. Prefixing the key with an ID (`npm-cache` in this example) is useful when you're using the `restore-keys` fallback and have multiple caches.

## Pass artifact data between jobs

Similar to the idea of caching dependencies within your workflow, you can pass data between jobs inside the same workflow. You can pass the data by using the `upload-artifact` and `download-artifact` actions. Jobs that are dependent on a previous job's artifacts must wait for the previous job to complete successfully before they can run. This approach is useful if you have a series of jobs that need to run sequentially based on artifacts uploaded from an earlier job. For example, `job_2` requires `job_1` by using the `needs: job_1` syntax.

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

This example has two jobs. `job_1` writes some text in the `file.txt` file. Then it uses the `actions/upload-artifact@v2` action to upload this artifact and store the data for future use within the workflow. `job_2` requires `job_1` to complete by using the `needs: job_1` syntax. It then uses the `actions/download-artifact@v2` action to download that artifact, and then print the contents of `file.txt`.

## Enable step debug logging in a workflow

In some cases, default workflow logs don’t provide enough detail for you to diagnose why a specific workflow run, job, or step fails. In these scenarios, you can enable more debug logging for two options: *runs* and *steps*. Enable this diagnostic logging by setting two repository secrets that require `admin` access to the repository to `true`.

- To enable run diagnostic logging, set the `ACTIONS_RUNNER_DEBUG` secret in the repository that contains the workflow to `true`.
- To enable step diagnostic logging, set the `ACTIONS_STEP_DEBUG` secret in the repository that contains the workflow to `true`.

## Access the workflow logs in GitHub

When you think about successful automation, you aim to spend the least amount of time looking at what's automated so that you can focus on what's relevant. But sometimes things don't go as planned, and you need to review what happened. That debugging process can be frustrating.

GitHub has a clear, structured layout to help you quickly move between jobs while you retain the context of the current debugging step.

To view the logs of a workflow run in GitHub:

1. In your repository, go to the **Actions** tab.
1. In the left pane, select the workflow.
1. In the list of workflow runs, select the run.
1. Under **Jobs**, select the job.
1. Read the log output.

If you have several runs inside a workflow, you can select the **Status** filter after you select your workflow and set it to **Failure** to display only the failed runs in that workflow.

## Access the workflow logs from the REST API

In addition to viewing logs via GitHub, you can use the GitHub REST API to view logs for workflow runs, rerun workflows, or even cancel workflow runs. To view a workflow run's log by using the API, send a `GET` request to the logs endpoint. Keep in mind that anyone with read access to the repository can use this endpoint. If the repository is private, you must use an access token with the `repo` scope.

For example, a `GET` request to view a specific workflow run log follows this path:

```http
GET /repos/{owner}/{repo}/actions/runs/{run_id}/logs
```


## Identify when to use an installation token from a GitHub app

When your GitHub app is installed on an account, you can authenticate it as an app installation by using the `installation access token` for REST and GraphQL API requests. This step allows the app to access resources owned by the installation, assuming that the app was granted the required repository access and permissions. REST or GraphQL API requests made by an app installation are attributed to the app.

In the following example, you replace `INSTALLATION_ACCESS_TOKEN` with the installation access token:

```bash
curl --request GET \
--url "https://api.github.com/meta" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer INSTALLATION_ACCESS_TOKEN" \
--header "X-GitHub-Api-Version: 2022-11-28"
```

You can also use an installation access token to authenticate for HTTP-based Git access. Your app must have the `Contents` repository permission. You can then use the installation access token as the HTTP password.

You replace `TOKEN` in the example with the installation access token:

```bash
git clone https://x-access-token:TOKEN@github.com/owner/repo.git
```
