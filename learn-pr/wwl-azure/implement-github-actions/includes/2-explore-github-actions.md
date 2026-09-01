GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipelines. It enables you to create workflows that automatically build, test, and deploy your code to any platform. Let's explore GitHub Actions and how developers use them.

## Components of GitHub Actions

You can run a GitHub Actions *workflow* manually, or configure it to be triggered when an event occurs in your repository. For example, a pull request could trigger a workflow that performs a validation check as part of a review process.

A workflow contains the following components:

* **Workflows:** Contain one or more jobs that can run in sequential order or in parallel.
* **Jobs:** Contain one or more steps that either run a script that you define, or run an *action*. Jobs run inside their own virtual machine *runner*, or inside a container.
* **Steps:** Define the specific tasks that the workflow performs.

Each step executes a single shell script, or *action* that is a reusable extension that can simplify your workflow.

### Workflows

A workflow is a configurable automated process that runs one or more jobs. Workflows are defined by a YAML file checked in to your repository. They execute when triggered by an event, run manually, or run at a defined schedule.

Workflows are defined in the `.github/workflows` directory in a repository, and a repository can have multiple workflows, each of which can perform a different set of tasks. For example, you can have one workflow to build and test pull requests, a workflow to deploy your application every time a release is created, and a workflow that adds a label every time someone opens a new issue.

### Events

An event is a specific activity in a repository that triggers a workflow run. For example, activity can originate from GitHub when someone creates a pull request, opens an issue, or pushes a commit to a repository. You can also trigger a workflow to run on a schedule, by posting to a REST API, or manually.

### Jobs

A job contains a set of steps that a runner executes. Each step runs either a shell script or an action. The runner executes the steps in order, so later steps can depend on earlier steps. Because each step runs on the same runner, you can share data from one step to another. For example, you can have one step build your application and a later step test that build.

You can configure dependencies between jobs. By default, jobs have no dependencies and run in parallel. A dependent job waits for every required job to complete successfully. For example, you might have multiple build jobs for different architectures and a packaging job that depends on those jobs. The build jobs run in parallel. After they complete successfully, the packaging job starts.

### Actions

An action is a custom application for the GitHub Actions platform that performs a complex but frequently repeated task. Use an action to help reduce the amount of repetitive code that you write in your workflow files. An action can pull your git repository from GitHub, set up the correct toolchain for your build environment, or set up the authentication to your cloud provider.

You can write your own actions, or you can find actions to use in your workflows in the [GitHub Marketplace](https://github.com/marketplace?type=actions).

### Runners

A runner is a server that runs your workflows when they're triggered. Each runner can run a single job at a time. GitHub provides Ubuntu Linux, Microsoft Windows, and macOS runners to run your workflows; each workflow run executes in a fresh, newly provisioned virtual machine. GitHub also offers [larger runners](https://docs.github.com/actions/using-github-hosted-runners/using-larger-runners), which are available in larger configurations.

If you need a different operating system or require a specific hardware configuration, you can [host your own runners](https://docs.github.com/actions/hosting-your-own-runners).

Now that you understand the components of GitHub Actions, let's examine a workflow file.
