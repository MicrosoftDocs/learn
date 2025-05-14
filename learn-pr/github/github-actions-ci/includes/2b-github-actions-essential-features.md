Here, you learn how to use default and custom environment variables, custom scripts, cache dependencies, and pass artifact data between jobs. And learn how to access the workflow logs from both the GitHub website and REST API endpoints.

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

This example is using the `github.ref` context to check the branch that triggered the workflow. If the branch is `main`, the runner is executed and prints "Deploying to production server on branch $GITHUB_REF". The default environment variable `$GITHUB_REF` is used in the runner to refer to the branch. Notice that default environment variables are all uppercase where context variables are all lowercase.

<!-- INFOMAGNUS UPDATES for sub OD 1.4.2 go here. Source Material: https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs --> 

## The contextual information available in a workflow

Contexts allow you to access information about workflow runs, variables, runner environments, jobs, and steps.  Each context is is an object that contains properties which can be other objects or strings.  The contexts available include: `github`, `env`, `vars`, `job`, `jobs`, `steps`, `runner`, `secrets`, `strategy`, `matrix`, `needs` and `inputs`.  Here is a table presents these contexts with their descriptions.

| Context |	Description |
:---------|:---------------------------------------------------------------------------------
github | Information about the workflow run. For more information, see [github context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#github-context).
env |	Contains variables set in a workflow, job, or step. For more information, see [env context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#env-context).
vars |	Contains variables set at the repository, organization, or environment levels. For more information, see [vars context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#vars-context).
job	|	Information about the currently running job. For more information, see [job context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#job-context).
jobs |	For reusable workflows only, contains outputs of jobs from the reusable workflow. For more information, see [jobs context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#jobs-context).
steps	|	Information about the steps that ran in the current job. For more information, see [steps context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#steps-context).
runner	|	Information about the runner that is running the current job. For more information, see [runner context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#runner-context).
secrets	|	Contains the names and values of secrets that are available to a workflow run. For more information, see [secrets context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#secrets-context).
strategy	|	Information about the matrix execution strategy for the current job. For more information, see [strategy context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#strategy-context).
matrix	|	Contains the matrix properties defined in the workflow that apply to the current job. For more information, see [matrix context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#matrix-context).
needs	|	Contains the outputs of all jobs that are defined as a dependency of the current job. For more information, see [needs context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#needs-context).
inputs	|	Contains the inputs of a reusable or manually triggered workflow. For more information, see [inputs context](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#inputs-context).


The different contexts are available throughout a workflow run. For example, the secrets context may only be used at certain places within a job.  In addition, you may only use some functions in certain places. For example, the `hashFiles` function is not available everywhere.

The following table lists the restrictions on where each context and special function can be used within a workflow. The listed contexts are only available for the given workflow key, and you may not use them anywhere else. Unless listed in the table here, you may use a function anywhere.

|Workflow Key | Context | Special Functions|
:--------------------|:----------|:------------------
run-name  | github, inputs, vars |None |
concurrency | github, inputs, vars | None|
env  | github, secrets, inputs, vars | None |
jobs.<job_id>.concurrency | github, needs, strategy, matrix, inputs, vars | None |
jobs.<job_id>.container |	github, needs, strategy, matrix, vars, inputs |	None
jobs.<job_id>.container.credentials |	github, needs, strategy, matrix, env, vars, secrets, inputs |	None
jobs.<job_id>.container.env.<env_id> |	github, needs, strategy, matrix, job, runner, env, vars, secrets, inputs |	None
jobs.<job_id>.container.image	|	github, needs, strategy, matrix, vars, inputs |	None
jobs.<job_id>.continue-on-error	|	github, needs, strategy, vars, matrix, inputs	|	None
jobs.<job_id>.defaults.run	|	github, needs, strategy, matrix, env, vars, inputs	|	None
jobs.<job_id>.env	|	github, needs, strategy, matrix, vars, secrets, inputs	|	None
jobs.<job_id>.environment	|	github, needs, strategy, matrix, vars, inputs	|	None
jobs.<job_id>.environment.url	|	github, needs, strategy, matrix, job, runner, env, vars, steps, inputs	|	None
jobs.<job_id>.if	|	github, needs, vars, inputs	|	always, cancelled, success, failure
jobs.<job_id>.name	|	github, needs, strategy, matrix, vars, inputs	|	None
jobs.<job_id>.outputs.<output_id>	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	None
jobs.<job_id>.runs-on	|	github, needs, strategy, matrix, vars, inputs	|	None
jobs.<job_id>.secrets.<secrets_id>	|	github, needs, strategy, matrix, secrets, inputs, vars	|	None
jobs.<job_id>.services	|	github, needs, strategy, matrix, vars, inputs	|	None
jobs.<job_id>.services.<service_id>.credentials	|	github, needs, strategy, matrix, env, vars, secrets, inputs	|	None
jobs.<job_id>.services.<service_id>.env.<env_id>	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, inputs	|	None
jobs.<job_id>.steps.continue-on-error	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.steps.env	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.steps.if	|	github, needs, strategy, matrix, job, runner, env, vars, steps, inputs	|	always, cancelled, success, failure, hashFiles
jobs.<job_id>.steps.name	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.steps.run	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.steps.timeout-minutes	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.steps.with	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.steps.working-directory	|	github, needs, strategy, matrix, job, runner, env, vars, secrets, steps, inputs	|	hashFiles
jobs.<job_id>.strategy	|	github, needs, vars, inputs	|	None
jobs.<job_id>.timeout-minutes	|	github, needs, strategy, matrix, vars, inputs	|	None
jobs.<job_id>.with.<with_id>	|	github, needs, strategy, matrix, inputs, vars	|	None
on.workflow_call.inputs.<inputs_id>.default	|	github, inputs, vars	|	None
on.workflow_call.outputs.<output_id>.value	|	github, jobs, vars, inputs	|	None

<!-- INFOMAGNUS 1.4.2 END

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

<!-- INFOMAGNUS UPDATES for sub OD 1.4.3, 1.4.6, and 1.4.7 go here. Source Material: Infomagnus team to find source material and cite sources when they update material , https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables , https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/workflow-commands-for-github-actions#setting-an-environment-variable --> 
## Setting custom environment variables in a workflow

You can define environment variables that are scoped to the entire workflow utilizing `env` at the top level of the workflow file.  Scoping the contents of a job within a workflow using `jobs.<job_id>.env`.  As well you can scope an environment variable within at a specific step within a job utilizing `jobs.<job_id>.steps[*].env`.

Next is an example displaying all three scenarios in a workflow file:

```yml
name: Greeting on variable day

on:
  workflow_dispatch

env:
  DAY_OF_WEEK: Monday

jobs:
  greeting_job:
    runs-on: ubuntu-latest
    env:
      Greeting: Hello
    steps:
      - name: "Say Hello Mona it's Monday"
        run: echo "$Greeting $First_Name. Today is $DAY_OF_WEEK!"
        env:
          First_Name: Mona
```


## Use default context in a workflow

Default environment variables are set by GitHub and not defined in a workflow.  They are thus available to use in a workflow in the appropriate context.  Most of these variables, other than `CI`, begin with `GITHUB_*` or `RUNNER_*`.  The latter two types cannot be overwritten.  As well, these default variables have a corresponding, and similarly named, context property. For instance, the `RUNNER_*` series of default variables have a matching context property of `runner.*`.  An example of accessing default variables in a workflow applying these methods can be viewed here:

```yml
on: workflow_dispatch

jobs:
  if-Windows-else:
    runs-on: macos-latest
    steps:
      - name: condition 1
        if: runner.os == 'Windows'
        run: echo "The operating system on the runner is $env:RUNNER_OS."
      - name: condition 2
        if: runner.os != 'Windows'
        run: echo "The operating system on the runner is not Windows, it's $RUNNER_OS."
```

For more information, see [Default environment variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables#default-environment-variables) in the GitHub user documentation.

## Pass custom environment variables to a workflow

You can pass customer environment variables from one step of a workflow job to subsequent steps within the job. Simply generate a value in one step of a job, and assign the value to an existing or new environment variable.  Next, you write the variable/value pair to the GITHUB_ENV environment file. The environment file can be used by an action, or from a shell command in the workflow job by using the `run` keyword. 

The step that creates or updates the environment variable doesn't have access to the new value, but all subsequent steps in a job have access.

You can view an example here:

```yml
steps:
  - name: Set the value
    id: step_one
    run: |
      echo "action_state=yellow" >> "$GITHUB_ENV"
  - name: Use the value
    id: step_two
    run: |
      printf '%s\n' "$action_state" # This will output 'yellow'
```

<!-- INFOMAGNUS UPDATES for sub OD 1.6.5 go here. Source Material: Infomagnus team to find source material and cite sources when they update material  https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/using-environments-for-deployment#about-environments , https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/managing-environments-for-deployment  -->

## Add environment protections

You can add protection rules for environments defined for your GitHub repository. To add an environment, in your repository:

**1.** Click on **Settings**
![Navigation bar of a web interface with tabs like Code, Issues, and Wiki; 'Settings' is highlighted."](../media/2b-settings.png)
   
**2.** Click on **Environment** on the left panel.

![Screenshot of a settings menu under 'General' with sections for Access, Code and automation, Security, and Integrations. The 'Environments' option is highlighted in red.](../media/2b-environments.png)   

**3.** Use the **New environment** button to add and configure an environment and add protections.
![GitHub repository settings page showing the 'Environments' section with a message indicating no environments exist and a 'New environment' button highlighted.](../media/2b-newenvironment.png)

### About environments

Environments are used to describe a general deployment target like production, staging, or development. When a GitHub Actions workflow deploys to an environment, the environment is displayed on the main page of the repository. You can use environments to require approval for a job to proceed, restrict which branches can trigger a workflow, gate deployments with custom deployment protection rules, or limit access to secrets.

Each job in a workflow can reference a single environment. Any protection rules configured for the environment must pass before a job referencing the environment is sent to a runner. The job can access the environment's secrets only after the job is sent to a runner.

When a workflow references an environment, the environment will appear in the repository's deployments. 

### Environment protection rules

Environment deployment protection rules require specific conditions to pass before a job referencing the environment can proceed. You can use deployment protection rules to require a manual approval, delay a job, or restrict the environment to certain branches. You can also create and implement custom protection rules powered by GitHub Apps to use third-party systems to control deployments referencing environments configured on GitHub. Next you will find further explanation of these protection rules:

1. **Required reviewers protection rules**: Use required reviewers to require a specific person or team to approve workflow jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed.

    You also have the option to prevent self-reviews for deployments to protected environments. If you enable this setting, users who initiate a deployment cannot approve the deployment job, even if they're a required reviewer. By enabling self-reviews, it ensures that deployments to protected environments are always reviewed by more than one person.

    For more information on reviewing jobs that reference an environment with required reviewers, see [Reviewing deployments](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/reviewing-deployments#bypassing-environment-protection-rules).

2. **Wait timer projection rules:** You can use a wait timer protection rule to delay a job for a specific amount of time after the job is initially triggered before the environment deployment is allowed to proceed. The time (in minutes) must be an integer between 1 and 43,200 (30 days).The wait time will not count towards your billable time.

3. **Branch and tag protection rules:** You can use deployment branch and tag protection rules to restrict which branches and tags are utilized to deploy to the environment. You have several options for deployment branch and tag protection rules for an environment.

- **No restriction** sets no restriction on which branch or tag can deploy to the environment.  **Protected branches only** allows only branches with branch protection rules enabled to deploy to the environment. If no branch protection rules are defined for any branch in the repository, then all branches can deploy. The **Selected branches and tags** setting ensures Only branches and tags that match your specified name patterns can deploy to the environment.

- If you specify `releases/*` as a deployment branch or tag rule, only a branch or tag whose name begins with `releases/` can deploy to the environment. (Wildcard characters will not match `/`. To match branches or tags that begin with `release/` and contain an additional single slash, use `release/*/*`.) If you add `main` as a branch rule, a branch named `main` can also deploy to the environment. 

4. **Custom deployment protection rules:** You can enable your own custom protection rules to gate deployments with third-party services. For instance, you can use observability systems, change management systems, code quality systems, or other manual configurations that you use to assess readiness and provide automated approvals for deployments to GitHub. 

    Once custom deployment protection rules have been created and installed on a repository, you can enable the custom deployment protection rule for any environment in the repository.

   !["Settings page for configuring 'Environment1' with options for reviewers, wait timer, custom rules, and branch restrictions.](../media/2b-protectionrules.png)

> **Note**
> If you are on a GitHub Free, GitHub Pro, or GitHub Team plan, the enviroment deployment projection rules are only available for public repositories; with the exception of branch & tag protection rules.  For users of GitHub Pro or GitHub Team plans, branch and tag protection rules are also available for private repositories.
>
<!-- INFOMAGNUS END -->

## Scripts in your workflow

In the preceding workflow snippet examples, the `run` keyword is used to print a string of text. Because the `run` keyword tells the job to execute a command on the runner, you use the `run` keyword to run actions or scripts.

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
| Restore-keys | Consists of alternative existing keys to caches if the desired cache key isn't found. | No |

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

The preceding example has two jobs. `job_1` writes some text into the file `file.txt`. Then it uses the `actions/upload-artifact@v2` action to upload this artifact and store the data for future use within the workflow. `job_2` requires `job_1` to complete by using the `needs: job_1` syntax. It then uses the `actions/download-artifact@v2` action to download that artifact, and then print the contents of `file.txt`.

## Enable step debug logging in a workflow

In some cases, the default workflow logs won't provide enough detail to diagnose why a specific workflow run, job, or step has failed. For these situations, you can enable additional debug logging for two options: *runs* and *steps*. Enable this diagnostic logging by setting two repository secrets that require `admin` access to the repository to `true`:

- To enable runner diagnostic logging, set the `ACTIONS_RUNNER_DEBUG` secret in the repository that contains the workflow to `true`.
- To enable step diagnostic logging, set the `ACTIONS_STEP_DEBUG` secret in the repository that contains the workflow to `true`.

## Access the workflow logs from the user interface

When you think about successful automation, you aim to spend the least amount of time looking at what's automated so you can focus your attention on what's relevant. However, sometimes things don't go as planned, and you need to review what happened. That debugging process can be frustrating. GitHub provides a clear layout structure that enables a quick way to navigate between the jobs, while keeping the context of the currently debugging step. To view the logs of a workflow run in GitHub, you can follow these steps:

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

<!-- INFOMAGNUS UPDATES for sub OD 1.4.4 go here. Source Material: Infomagnus team to find source material and cite sources when they update material   https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-an-installation-access-token-for-a-github-app  ,  https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-as-a-github-app-installation -->

## Identify when to use an installation token from a GitHub App

Once your GitHub App is installed on an account, you can authenticate it as an app installation using the 'installation access token' for REST and GraphQL API requests. This allows the app to access resources owned by the installation, assuming the app was granted the necessary repository access and permissions. REST or GraphQL API requests made by an app installation are attributed to the app.  In the following example, you replace `INSTALLATION_ACCESS_TOKEN` with the installation access token:

```
curl --request GET \
--url "https://api.github.com/meta" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer INSTALLATION_ACCESS_TOKEN" \
--header "X-GitHub-Api-Version: 2022-11-28"
```

You can also use an installation access token to authenticate for HTTP-based Git access. Your app must have the 'Contents' repository permission. You can then use the installation access token as the HTTP password. You replace TOKEN in the example with the installation access token: 

```
git clone https://x-access-token:TOKEN@github.com/owner/repo.git
```
