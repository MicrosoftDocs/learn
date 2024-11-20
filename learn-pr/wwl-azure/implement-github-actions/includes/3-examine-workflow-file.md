GitHub Actions use YAML syntax to define the workflow. Each workflow is stored as a separate YAML file in your code repository, in a directory named `.github/workflows`. The following workflow example is triggered whenever code is pushed to a repository. The workflow performs the following steps:

1. Checks out the pushed code.
1. Installs Node.js.
1. Installs the Bash Automated Testing System (Bats) testing framework.
1. Runs a command to output the Bats version: `bats -v`.

```yml
name: learn-github-actions
run-name: ${{ github.actor }} is learning GitHub Actions
on: [push]
jobs:
  check-bats-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm install -g bats
      - run: bats -v

```

## Understanding the workflow file

To help you understand how YAML syntax is used to create a workflow file, this section explains each line of the previous example:

```yml
# Optional - The name of the workflow as it will appear in the "Actions" tab of the GitHub repository. If this field is omitted, the name of the workflow file will be used instead.
name: learn-github-actions

# Optional - The name for workflow runs generated that appear in the list of workflow runs on your repository's "Actions" tab. This example uses an expression with the 'github' context to display the username of the actor that triggered the workflow run. 
run-name: ${{ github.actor }} is learning GitHub Actions

# Specifies the trigger for this workflow. This example uses the 'push' event, so a workflow run is triggered every time someone pushes a change to the repository or merges a pull request.
on: [push]

# Groups together all the jobs that run in the 'learn-github-actions' workflow.
jobs:

# Defines a job named 'check-bats-version'. The child keys will define properties of the job.
  check-bats-version:

# Configures the job to run on the latest version of an Ubuntu Linux runner. This means that the job will execute on a fresh virtual machine hosted by GitHub.
    runs-on: ubuntu-latest

# Groups together all the steps that run in the 'check-bats-version' job. Each item nested under this section is a separate action or shell script.
    steps:

# The 'uses' keyword specifies that this step will run 'v4' of the 'actions/checkout' action. This is an action that checks out your repository onto the runner, allowing you to run scripts or other actions against your code (such as build and test tools). You should use the checkout action any time your workflow will use the repository's code.
      - uses: actions/checkout@v4

# This step uses the 'actions/setup-node@v4' action to install the specified version of the Node.js. (This example uses version 20.) This puts both the 'node' and 'npm' commands in your PATH.
      - uses: actions/setup-node@v4
        with:
          node-version: '20'

# The 'run' keyword tells the job to execute a command on the runner. In this case, you are using 'npm' to install the 'bats' software testing package.
      - run: npm install -g bats

# The 'bats' command with a parameter that outputs the software version.
      - run: bats -v

```

## View the activity for a workflow run

When a workflow is triggered, a workflow run is created that executes the workflow. After a workflow run starts, you can see a visualization graph of the run's progress and view each step's activity on GitHub. Follow these steps to view the activity:

1. Navigate to the main page of the repository.

1. Select **Actions** located under the repository name.
    :::image type="content" source="../media/github-nav-actions.png" alt-text="Screenshot showing the Actions button location.":::
1. In the left sidebar, select the workflow you want to see.
1. From the list of workflow runs, select the name of the run to see the workflow run summary.
1. In the left sidebar or in the visualization graph, select the job you want to see.
1. Select a step to view detailed results.

Now that you understand the workflow file components you can see how developers can customize the file for a variety of use cases.
