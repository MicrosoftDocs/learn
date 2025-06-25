Recall that your goal is to automate the code build and publish process so that features are updated each time a developer adds a change to the code base.

To implement this process, you learn how to:

- Create a workflow from a template.
- Avoid duplication by using reusable workflows.
- Test against multiple targets.
- Separate build and test jobs.

## Create a workflow from a template

To create a workflow, it's common to begin by using a template. A template has common jobs and steps preconfigured for the specific type of automation you're implementing. If you're not familiar with workflows, jobs, and steps, check out the [Automate development tasks by using GitHub Actions](/training/modules/github-actions-automate-tasks/) module.

On the main page of your GitHub repository, select **Actions**, and then select **New workflow**.

On the **Choose a workflow** page, you can choose from many types of templates. One example is the Node.js template. The *Node.js template* installs Node.js and all dependencies, builds the source code, and runs tests for different versions of Node.js. Another example is the *Python package* template, which installs Python and its dependencies, and then runs tests, including lint, in multiple versions of Python.

To begin with the Node.js workflow template, in the search box, enter **Node.js**.

:::image type="content" source="../media/2-workflow-template-search.png" alt-text="Screenshot that shows the GitHub Actions tab with the search box highlighted and with the text Node.js.":::

In the search results, in the **Node.js** pane, select **Configure**.

:::image type="content" source="../media/2-workflow-template-node-js.png" alt-text="Screenshot that shows the GitHub Actions tab with the Node.js pane highlighted and the Configure button selected.":::

A `node.js.yml` file for your project is created from the template:

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

As seen in the `on` attribute, this example workflow runs in response to either a push to the repository or when a pull request is created against the main branch.

This workflow runs one job, indicated by the `job` attribute.

The `runs-on` attribute specifies that, for the operating system, the workflow runs on `ubuntu-latest`. The `node-version` attribute specifies that there are three builds, one each for Node.js version 14.x, 16.x, and 18.x. The `matrix` attribute is described in depth later in the module.

In the `jobs` attribute, the steps use the GitHub Actions [actions/checkout@v3](https://github.com/actions/checkout?azure-portal=true) action to get the code from your repository into a virtual machine (VM) and [actions/setup-node@v3](https://github.com/actions/setup-node?azure-portal=true) to set up the correct version of Node.js. You specify that you want to test three versions of Node.js by using the `${{ matrix.node-version }}` attribute. This attribute references the matrix that you defined earlier. The `cache` attribute specifies a package manager for caching in the default directory.

The last part of this step executes commands that Node.js projects use. The `npm ci` command installs dependencies from the `package-lock.json` file. `npm run build --if-present` runs a build script if it exists. `npm test` runs the testing framework. This template includes both build and test steps in the same job.

To learn more about npm, check out the npm documentation:

- [npm install](https://docs.npmjs.com/cli/v11/commands/npm-install?azure-portal=true)
- [npm run](https://docs.npmjs.com/cli/v11/commands/npm-run?azure-portal=true)
- [npm test](https://docs.npmjs.com/cli/v11/commands/npm-test?azure-portal=true)

A team of developers can benefit from using reusable workflows to streamline and standardize repeated automation steps. By using reusable workflows, you can reduce redundancy, improve maintainability, and ensure consistency across your continuous integration/continuous deployment (CI/CD) pipelines.


## Avoid duplication by using reusable workflows

As teams scale and projects grow, it's common to see the same steps repeated across multiple workflow files. These steps might include code checkout, dependency installation, testing, and deployment. This kind of duplication not only clutters your code base but also increases maintenance time when code changes are required. Reusable workflows solve this problem by allowing you to define automation logic once, and then call the logic from other workflows.

Reusable workflows are special GitHub Actions workflows that other workflows can call, similar to functions in programming. You create them to share repeated logic like build steps, testing procedures, or deployment strategies. After you create a reusable workflow, you can reference it from any other workflow in the same repository or even in different repositories.

:::image type="content" source="../media/reusable-workflow.png" alt-text="Diagram that shows the concept of reusable workflows in GitHub Actions. Multiple repositories or workflows can reference a central workflow." border="false":::

### Why use reusable workflows?

These are the benefits of using reusable workflows:

- **Consistency.** Teams can follow the same automation standards across all projects.
- **Efficiency.** Instead of copying and pasting steps, you just point to a reusable workflow.
- **Easier updates.** When a process changes, such as by adding a test step, you update it in one location. Then all workflows that use the workflow benefit automatically.
- **Scalability.** Reusable workflows are ideal for platform or DevOps teams that manage multiple services.

Next, explore how to use reusable workflows to improve your projects.

### Implement reusable workflows

To use reusable workflows:

1. In your repository folder, create a reusable workflow. The file includes the automation steps you want to share, like common steps involved in testing, building, and deploying.
1. Explicitly enable a workflow to be reusable by configuring it with the `workflow_call` event.
1. In your main workflows (caller workflows), reference this reusable file and provide any required inputs or secrets.

To illustrate the advantages of reusable workflows, consider the following real-world scenario.

### Example

Imagine that your organization has 10 microservices. All 10 microservices need the same steps to:

- Run tests
- Lint code
- Deploy to a specific environment

Without reusable workflows, every repo contains duplicated logic that list the repeated steps in each workflow.

If you use reusable workflows:

- You define the process once in a central file (for example, in `ci-standard.yml`).
- You call this file from every microservice’s own workflow, passing in variables like environment or the application name.

If a new security step or tool is added, such as to scan for vulnerabilities, you add it only once in the reusable workflow. All 10 microservices immediately begin to use the updated process. You don't have to modify the 10 microservices.

By understanding how reusable workflows function and their benefits, you can adopt best practices to maximize their effectiveness and ensure seamless integration with your CI/CD pipelines.

### Best practices

- Centralize your reusable workflows in one repository if you plan to share them across teams.
- Use branches or tags to version your workflows (for example, use `@v1`), so you can easily roll back changes if it's necessary.
- Document inputs and secrets clearly. Reusable workflows often rely on inputs and secrets. Teams need to know what information to use.
- If you need to reuse only a few steps, combine reusable workflows with composite actions instead of creating a full workflow.

Reusable workflows are a powerful way to enforce consistency, reduce duplication, and scale DevOps practices in any engineering team. Whether you're managing a single repository, microservices, or open-source libraries, reusable workflows can simplify automation, so your CI/CD is faster, cleaner, and easier for you to manage.

## Customize workflow templates

At the beginning of this module, you considered a scenario in which you need to set up CI for your team of developers. The Node.js template is a great start, but you want to customize it to better suit your team's requirements. You want to target different versions of Node.js and different operating systems. You also want the build and test steps to be separate jobs.

Here's an example of how of a customized workflow:

```yml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node-version: [16.x, 18.x]
```

In this example, you configure a [build matrix](https://docs.github.com/enterprise-server@3.14/actions/writing-workflows/about-workflows#using-a-build-matrix) for testing across multiple operating systems and language versions. This matrix produces four builds, one for each operating system paired with each version of Node.js.

Four builds and their tests produce a large amount of log data. It might be difficult to sort through it all. In the following sample, you move the test step to a dedicated test job. This job tests against multiple targets. Separating the build and test steps makes it easier to work with the log data.

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
