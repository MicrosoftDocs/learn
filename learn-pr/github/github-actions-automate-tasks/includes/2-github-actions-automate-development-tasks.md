Here, you are introduced to GitHub Actions and workflows. You learn the types of actions you can use and where to find them. You also look at examples of these types of actions and how they fit in a workflow.

## GitHub decreases time from idea to deployment

GitHub is designed to help teams of developers and DevOps engineers build and deploy applications quickly.  There are many features in GitHub that enable this, but they generally fall into one of two categories:

- **Communication** - Consider all of the ways that GitHub makes it easy for a team of developers to communicate about the software development project: code reviews in pull requests, GitHub issues, project boards, wikis, notifications, and so on.  
- **Automation** - GitHub Actions enables your team to automate workflows at every step in the software development process, from integration to delivery to deployment, or even adding labels to pull requests and checking for stale issues and pull requests.

When combined, these features have enabled thousands of development teams to effectively decrease the amount of time it takes from their initial idea to deployment.

## Leverage automation of workflows to decrease development time

In this module, we'll focus on automation, so let's take a moment to understand how teams can leverage automation to reduce the amount of time it takes to complete a typical development and deployment workflow.

Consider all of the tasks that must happen *after* the code is written but before the code can be reliably used for its intended purpose.  Depending on your organization's goals, you will likely need to perform one or more of the following tasks:

- Ensure the code passes all unit tests
- Perform code quality and compliance checks to ensure the source code meets the organization's standards
- Check the code and its dependencies for known security issues
- Build the code integrating new source from (potentially) multiple contributors
- Ensure the software passes integration tests
- Version the new build
- Deliver the new binaries to the appropriate filesystem location
- Deploy the new binaries to one or more servers
- If any of these tasks do not pass, report the issue to the proper individual or team for resolution

The challenge is to do these tasks reliably and in a sustainable manner.  This is an ideal job for workflow automation.  If you're already relying on GitHub, you'll likely want to setup your workflow automation using GitHub Actions.

### What is GitHub Actions?

*GitHub Actions* are packaged scripts to automate tasks in a software development workflow in GitHub.  GitHub Actions can be configured to trigger complex workflows that meet your organization's needs each time developers check new source code into a specific branch, at timed intervals, or manually.  The result is of reliable and sustainable automated workflow is a significant decrease in development time.

## Where can you find GitHub Actions?

GitHub Actions are scripts that adhere to a yml data format.  Each repository has an Actions tab that provides a quick and easy way to get started with setting up your first script.  If you see a workflow that you think might be a great starting point, you simply need to click the "Set up this workflow" button to add the script and begin editing the source yml.

:::image type="content" source="../media/github-actions-automate-development-tasks-01.png" alt-text="Screenshot of the GitHub Actions Actions tab displaying a Simple workflow and a button to set up this workflow.":::

However, beyond those GitHub Actions featured on the Actions tab, you can:

- Search for GitHub Actions in the [GitHub Marketplace](https://github.com/marketplace?type=actions&azure-portal=true). The GitHub Marketplace allows you to discover and purchase tools that extend your workflow.
- Search for open-source projects.  For example, the [GitHub Actions](https://github.com/actions?azure-portal=true) organization features many popular open source repos containing GitHub Actions you can use.
- Write your own GitHub Actions from scratch.  Furthermore, if you want, you could make them open source, or even publish them to the GitHub Marketplace.

## Two types of GitHub Actions

There are two types of GitHub Actions, container actions and JavaScript actions. 

With **container actions**, the environment is part of the action's code. These actions can only be run in a Linux environment that GitHub hosts. Container actions support many different languages. 

**JavaScript actions** don't include the environment in the code. This means you'll have to specify the environment to execute these actions. You can run in a VM in the cloud or on-premises. JavaScript actions support Linux, macOS and Windows environments.

### The anatomy of a GitHub Action

Here is an example of an action that performs a git checkout of a repository. This action, [actions/checkout@v1](https://github.com/actions/checkout?azure-portal=true), is part of a step in a workflow. This step also builds the Node.js code that was checked out. We will talk about workflows, jobs, and steps in the next section.

```yml
steps:
    - uses: actions/checkout@v1
    - name: npm install and build webpack
    run: |
        npm install
        npm run build
```

Suppose you want to use a container action to run containerized code. Your action might look like this:

```yml
name: "Hello Actions"
description: "Greet someone"
author: "octocat@github.com"

inputs:
    MY_NAME:
    description: "Who to greet"
    required: true
    default: "World"

runs:
    using: "docker"
    image: "Dockerfile"

branding:
    icon: "mic"
    color: "purple"
```

Notice the ```inputs``` section. Here you are getting the value of a variable called MY_NAME. This variable will be set in the workflow that runs this action.

In the ```runs``` section, notice you specify *docker* in the ```using``` attribute. When you do this, you'll need to provide the path to the docker image file. Here, it's called *Dockerfile*. We won't get into the specifics of Docker here, but if you would like more information, check out the [Introduction to Docker Containers](https://docs.microsoft.com/learn/modules/intro-to-docker-containers/?azure-portal=true) module.

The last section, *branding*, personalizes your action in the GitHub Marketplace if you decide to publish it there.

You can find a complete list of action metadata at [Metadata syntax for GitHub Actions](https://help.github.com/en/actions/building-actions/metadata-syntax-for-github-actions?azure-portal=true).

## What is a GitHub Actions workflow?

A *GitHub Actions workflow*  is a process that you set up in your repository to automate software development life cycle tasks, including GitHub Actions. With a workflow, you can build, test, package, release, or deploy any project on GitHub.

To create a workflow, you add actions to a .yml file in the ```.github/workflows``` directory in your GitHub repository.

In the exercise coming up, your workflow file, *main.yml*, will look like this.

```yml
name: A workflow for my Hello World file
on: push
jobs:
    build:
    name: Hello world action
    runs-on: ubuntu-latest
    steps:
        - uses: actions/checkout@v1
        - uses: ./action-a
        with:
            MY_NAME: "Mona"
```

Notice the ```on:``` attribute. This is a *trigger* to specify when this workflow will run. Here, it triggers a run when there is a push event to your repository. You can specify single events like ```on: push```, an array of events like ```on: [push, pull_request]```, or an event configuration map that schedules a workflow or restricts the execution of a workflow to specific files, tags, or branch changes.. The map might look something like this:

```yml
on:
  # Trigger the workflow on push or pull request,
  # but only for the master branch
  push:
    branches:
      - master
  pull_request:
    branches:
      - master
  # Also trigger on page_build, as well as release created events
  page_build:
  release:
    types: # This configuration does not affect the page_build event above
      - created
```

An event will trigger on all activity types for the event unless you specify the type or types. For a comprehensive list of events and their activity types see: [Events that trigger workflows](https://help.github.com/actions/reference/events-that-trigger-workflows?azure-portal=true) in the GitHub documentation.

A workflow must have at least one *job*. A job is a section of the workflow that will be associated with a *runner*. A runner can be GitHub-hosted or self-hosted and the job can run on a machine or in a container. You specify the runner with the ```runs-on:``` attribute. Here, you are telling the workflow to run this job on ```ubuntu-latest```.

Each job will have steps to complete. In our example, the step uses the action *actions/checkout@v1* to checkout the repository. What's interesting is the ```using: ./action-a``` value. This is the path to the container action that you build in an *action.yml* file. We went over the contents of this file in the **What is GitHub Actions?** section above.

The last part of this workflow file sets the MY_NAME variable value for this workflow. Recall the container action took an input called MY_NAME.

For more information on workflow syntax check out [Workflow syntax for GitHub Actions](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions?azure-portal=true)


### GitHub Actions may have usage limits

GitHub Actions usage has some limits depending on if your runner is GitHub-hosted or self-hosted, and your GitHub plan. For more information on usage limits, check out [Usage limits](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#usage-limits?azure-portal=true) in the GitHub documentation.
