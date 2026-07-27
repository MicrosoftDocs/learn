Now that you know the components of a workflow file, let's explore how to customize workflows for various scenarios. This unit focuses on using variables and scripts to optimize a workflow. Variables provide a way to store and reuse nonsensitive configuration information. You can store configuration data such as compiler flags, usernames, or server names as variables. The runner interpolates variables when it runs your workflow. Commands in actions or workflow steps can create, read, and modify variables.

You can set your own custom variables or use the default environment variables that GitHub sets automatically. You can create a custom variable in two ways.

* To define an environment variable for use in a single workflow, you can use the `env` key in the workflow file.
* To define a configuration variable across multiple workflows, you can define it at the organization, repository, or environment level.

## Define environment variables for a single workflow

To set a custom environment variable for a single workflow, you can define it using the `env` key in the workflow file. The scope of a custom variable set by this method is limited to the element where it's defined. You can define variables that are scoped for:

* The entire workflow, by using `env` at the top level of the workflow file.
* The contents of a job within a workflow, by using `jobs.<job_id>.env`.
* A specific step within a job, by using `jobs.<job_id>.steps[*].env`.

> [!NOTE]
> Both `jobs.<job_id>.env` and `jobs.<job_id>.steps[*].env` use workflow syntax that a later unit covers in more detail.

The following workflow example implements two variables, `DAY_OF_WEEK` and `Greeting` to produce a greeting when it's run.

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
      - name: "Say Hello"
        run: echo "$Greeting, today is $DAY_OF_WEEK!"
```

### Naming conventions for environment variables

When you set an environment variable, you can't use any of the default environment variable names. If you attempt to override the value of one of these default variables, the assignment is ignored.

> [!TIP]
> For a complete list of default environment variables, visit [Default environment variables](https://docs.github.com/actions/learn-github-actions/variables#default-environment-variables).

## Create configuration variables for a repository

To create repository variables in a personal account repository, you must be a repository collaborator. For an organization repository, you must have `write` access. Environment-level configuration variables require repository owner access for a personal account repository or `admin` access for an organization repository. Only organization owners can create organization-level variables. REST API requirements depend on the variable scope, endpoint, and token permissions.

### Configuration variable precedence

If a variable with the same name exists at multiple levels, the variable at the lowest level takes precedence. For example, if an organization-level variable has the same name as a repository-level variable, then the repository-level variable takes precedence. Similarly, if an organization, repository, and environment all have a variable with the same name, the environment-level variable takes precedence.

## Add scripts to your workflow

You can use a GitHub Actions workflow to run scripts and shell commands, which are then executed on the assigned runner. The following example demonstrates how to use the `run` keyword to execute the command `npm install -g bats` on the runner.

```yml
jobs:
  example-job:
    runs-on: ubuntu-latest
    steps:
      - run: npm install -g bats
```

To run a script stored in your repository, you can first check out the repository to the runner. The following example checks out the repository and sets the default working directory to the script's location. The final step runs the `my-script.sh` script.

```yml
jobs:
  example-job:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./scripts
    steps:
      - name: Check out the repository to the runner
        uses: actions/checkout@v7
      - name: Run a script
        run: ./my-script.sh
```

You can run a script file directly after making it executable. Alternatively, you can pass the script path to an interpreter, such as `run: bash script.sh`.
