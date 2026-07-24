GitHub Actions use YAML syntax to define the workflow. Each workflow is stored as a separate YAML file in your code repository, in a directory named `.github/workflows`. The following workflow example is triggered whenever code is pushed to a repository. The workflow performs the following steps:

> [!NOTE]
> Major version tags such as `actions/checkout@v7` are commonly used for actions maintained by GitHub. For third-party actions, a full-length commit SHA is the only immutable reference. For example, you can replace `owner/action@v1` with `owner/action@<full-length-commit-sha> # v1.2.3` after verifying that the commit belongs to the action's repository.

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
      - uses: actions/checkout@v7
      - uses: actions/setup-node@v7
        with:
          node-version: '24'
      - run: npm install -g bats
      - run: bats -v

```

## Understand the workflow file

To help you understand how YAML syntax creates a workflow file, this section explains each line of the previous example. The following annotated version connects each YAML key to the behavior that GitHub Actions applies during a workflow run.

```yml
# Optional workflow name displayed on the repository's Actions tab.
# If omitted, GitHub displays the workflow file path.
name: learn-github-actions

# Optional name for each workflow run. The github.actor context identifies
# the user or app that initiated the run.
run-name: ${{ github.actor }} is learning GitHub Actions

# Trigger the workflow whenever commits or tags are pushed to the repository.
on: [push]

# Group all jobs that belong to this workflow.
jobs:
  # Define the unique ID for this job.
  check-bats-version:
    # Run the job on a new GitHub-hosted Ubuntu virtual machine.
    runs-on: ubuntu-latest

    # Run each step in order on the same runner.
    steps:
      # Check out the repository so later steps can access its files.
      - uses: actions/checkout@v7

      # Install Node.js and add the node and npm commands to PATH.
      - uses: actions/setup-node@v7
        with:
          # Select the Node.js version to install.
          node-version: '24'

      # Install the Bash Automated Testing System globally through npm.
      - run: npm install -g bats

      # Display the installed Bats version.
      - run: bats -v

```

## View the activity for a workflow run

Each time an event triggers a workflow, GitHub creates a workflow run. After the run starts, you can use its visualization graph to follow the progress and view each step's activity. You can follow these steps to view the activity:

1. You can navigate to the main page of the repository.

1. You can select **Actions** under the repository name.
    :::image type="content" source="../media/github-nav-actions.png" alt-text="Screenshot showing the Actions button location.":::
1. In the left sidebar, you can select the workflow you want to see.
1. From the list of workflow runs, you can select the run name to see its summary.
1. In the left sidebar or visualization graph, you can select the job you want to see.
1. You can select a step to view detailed results.

Now that you understand the workflow file components, you can see how developers customize the file for various use cases.
