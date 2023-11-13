Here, you'll learn about the basic components of a GitHub Actions workflow file.

## The components of GitHub Actions

:::image type="content" source="../media/github-actions-workflow-components.png" alt-text="Screenshot of a GitHub Actions workflow file showing the job, step, and action components." border="false":::

There are several components that work together to run tasks or jobs within a GitHub Actions workflow. In short, an event triggers the *workflow*, which contains a *job*. This job then uses *steps* to dictate which *actions* will run within the workflow. To better see how these components work together, let's take a quick look at each one.

### Workflows

A workflow is an automated process that you add to your repository. A workflow needs to have at least one job, and different events can trigger it. You can use it to build, test, package, release, or deploy your repository's project on GitHub.

### Jobs

The job is the first major component within the workflow. A job is a section of the workflow that will be associated with a runner. A runner can be GitHub-hosted or self-hosted, and the job can run on a machine or in a container. You'll specify the runner with the `runs-on:` attribute. Here, you're telling the workflow to run this job on `ubuntu-latest`. We'll talk more about runners in the next unit.

### Steps

A step is an individual task that can run commands in a job. In our preceding example, the step uses the action `actions/checkout@v2` to check out the repository. What's interesting is the `uses: ./action-a` value. This is the path to the container action that you'll build in an `action.yml` file.

### Actions

The actions inside your workflow are the standalone commands that are executed. These standalone commands can reference GitHub actions such as using your own custom actions, or community actions like the one we use in the preceding example, `actions/checkout@v2`. You can also run commands such as `run: npm install -g bats` to execute a command on the runner.
