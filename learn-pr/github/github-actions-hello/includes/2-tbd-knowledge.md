Here, you learn about GitHub Actions and GitHub Workflows to automate your software development life cycle tasks.

## What is GitHub Actions?

A *Github Action* is a packaged script used to automate your software workflow in GitHub.

There are two types of GitHub Actions, *container actions* and *JavaScript actions*. With container actions, the environment is part of the action's code. These actions can only be run in a Linux environment that GitHub hosts. JavaScript actions don't include the environment in the code. This means you'll have to specify the environment to execute this action. You can use a VM in the cloud, or on-premises. GitHub Actions support any language, and Linux, MacOS, and Windows environments.

You can find GitHub actions in [GitHub Marketplace](https://github.com/marketplace?type=actions&azure-portal=true), in open source projects on GitHub, and in the GitHub [actions](https://github.com/actions?azure-portal=true) organization.

Here is an example of an action that checks out code in the repository. This action, [actions/checkout@v1](https://github.com/actions/checkout?azure-portal=true), is part of a step in a workflow. This step also builds the node.js code that was checked out. We will talk about workflows, jobs, and steps in the next section.

    ```yml
    steps:
      - uses: actions/checkout@v1
      - name: npm install and build webpack
        run: |
          npm install
          npm run build
    ```

Soon, you'll be using a container action to run containerized code. Your action will look like this:

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

In the ```runs``` section, notice you specify *docker* in the using attribute. When you do this, you'll need to provide the path to the docker image file. Here, it's called *Dockerfile*. The Dockerfile will then We won't get into the specifics of Docker here, but if you would like more information, check out the [Introduction to Docker Containers](https://docs.microsoft.com/en-us/learn/modules/intro-to-docker-containers/?azure-portal=true) module.

The last section, *branding* is to personalize your action in the GitHub Marketplace if you were to publish it there.

A complete list of action metadata can be found at [Metadata syntax for GitHub Actions](https://help.github.com/en/actions/building-actions/metadata-syntax-for-github-actions?azure-portal=true).

## What is a GitHub Workflow?

A *GitHub Workflow* is a an automated process that you set up in your repository to automate software development life cycle. With it, you can build, test, package, release, or deploy any project on GitHub.

To create a workflow, you add actions to a .yml file in the ```.github/workflows``` directory in your GitHub repository.

In the exercise, your workflow file, *main.yml*, will look like this:

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

Notice the ```on:``` attribute. This is a *trigger* to specify when this workflow will run. Here, it triggers a run when there is a push event to your repository. You can specify single events, an array of events, or an event configuration map.

A workflow must have at least one *job*. A job is a section of the workflow that will be associated with a *runner*. A runner can be GitHub-hosted or self-hosted and the job can run on a machine or in a container. You specify the runner with the ```runs-on:``` attribute. Here, you are telling the workflow to run this job on ```ubuntu-latest```.

Each job will have steps to complete. In this step you use the action *actions/checkout@v1* that we mentioned earlier to checkout the repository, but the interesting part here is the ```./action-a``` using attribute value. This is the path to the container action that you will build in an *action.yml* file. We went over the contents of this file in the **What is GitHub Actions?** section above.

The last part of this workflow file sets the MY_NAME variable value for this workflow. Recall the container action took an input called MY_NAME.

For more information on workflow syntax check out [Workflow syntax for GitHub Actions](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions?azure-portal=true)

### Usage limits

GitHub Actions usage has some limits depending on if your runner is GitHub-hosted or self-hosted, and your GitHub plan. For more information on usage limits, check out [Usage limits](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#usage-limits?azure-portal=true) in the GitHub documentation.
