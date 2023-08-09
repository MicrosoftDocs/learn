
You might have micro git repositories providing utilities used in multiple pipelines within your project. Pipelines often rely on various repositories.

You can have different repositories with sources, tools, scripts, or other items that you need to build your code. By using multiple checkout steps in your pipeline, you can fetch and check out other repositories to the one you use to store your YAML pipeline.

Previously Azure Pipelines hasn't offered support for using multiple code repositories in a single pipeline. Using artifacts or directly cloning other repositories via script within a pipeline, you can work around it. It leaves access management and security down to you.

Repositories are now first-class citizens within Azure Pipelines. It enables some exciting use cases, such as checking out specific repository parts and checking multiple repositories.

There's also a use case for not checking out any repository in the pipeline. It can be helpful in cases where you're setting up a pipeline to do a job that has no dependency on any repository.

## Specify multiple repositories

Repositories can be specified as a repository resource or in line with the checkout step. Supported repositories are Azure Repos Git, GitHub, and BitBucket Cloud.

The following combinations of checkout steps are supported.

 -  If there are no **checkout** steps, the default behavior is checkout: self is the first step.
 -  If there's a single **checkout: none** step, no repositories are synced or checked out.
 -  If there's a single **checkout: self** step, the current repository is checked out.
 -  If there's a single **checkout** step that isn't **self** or **none**, that repository is checked out instead of self.
 -  If there are multiple **checkout** steps, each named repository is checked out to a folder named after the repository. Unless a different path is specified in the checkout step, use **checkout: self** as one of the **checkout** steps.

## Repository resource - How to do it?

If your repository type requires a service connection or other extended resources field, you must use a repository resource.

Even if your repository type doesn't require a service connection, you may use a repository resource.

For example, you have a repository resource defined already for templates in a different repository.

In the following example, three repositories are declared as repository resources. The repositories and the current self-repository containing the pipeline YAML are checked out.

```YAML
resources:
  repositories:

  - repository: MyGitHubRepo # The name used to reference this repository in the checkout step.
    type: github
    endpoint: MyGitHubServiceConnection
    name: MyGitHubOrgOrUser/MyGitHubRepo

  - repository: MyBitBucketRepo
    type: bitbucket
    endpoint: MyBitBucketServiceConnection
    name: MyBitBucketOrgOrUser/MyBitBucketRepo

  - repository: MyAzureReposGitRepository
    type: git
    name: MyProject/MyAzureReposGitRepo

trigger:

- main

pool:
  vmImage: 'ubuntu-latest'

steps:

- checkout: self
- checkout: MyGitHubRepo
- checkout: MyBitBucketRepo
- checkout: MyAzureReposGitRepository


- script: dir $(Build.SourcesDirectory)

```

If the self-repository is named CurrentRepo, the script command produces the following output: CurrentRepo MyAzureReposGitRepo MyBitBucketRepo MyGitHubRepo.

In this example, the repositories' names are used for the folders because no path is specified in the checkout step.

## Inline - How to do it?

If your repository doesn't require a service connection, you can declare it according to your checkout step.

```YAML
steps:

- checkout: git://MyProject/MyRepo # Azure Repos Git repository in the same organization

```

The default branch is checked out unless you choose a specific ref.

If you're using inline syntax, choose the ref by appending @ref. For example:

```YAML

- checkout: git://MyProject/MyRepo@features/tools # checks out the features/tools branch
- checkout: git://MyProject/MyRepo@refs/heads/features/tools # also checks out the features/tools branch.
- checkout: git://MyProject/MyRepo@refs/tags/MyTag # checks out the commit referenced by MyTag.

```

## GitHub repository

Azure Pipelines can automatically build and validate every pull request and commit to your GitHub repository.

When creating your new pipeline, you can select a GitHub repository and then a YAML file in that repository (self repository). By default, this is the repository that your pipeline builds.

Azure Pipelines must be granted access to your repositories to trigger their builds and fetch their code during builds.

There are three authentication types for granting Azure Pipelines access to your GitHub repositories while creating a pipeline.

 -  GitHub App.
 -  OAuth.
 -  Personal access token (PAT).

You can create a continuous integration (CI) trigger to run a pipeline whenever you push an update to the specified branches or push selected tags.

YAML pipelines are configured by default with a CI trigger on all branches.

```YAML
trigger:
    - main
    - releases/*

```

You can configure complex triggers that use **exclude** or **batch**.

```YAML
# specific branches build
trigger:
    branches:
        include:
            - master
            - releases/*
        exclude:
            - releases/old*

```

Also, it's possible to configure pull request (PR) triggers to run whenever a pull request is opened with one of the specified target branches or when updates are made to such a pull request.

You can specify the target branches when validating your pull requests.

To validate pull requests that target main and releases/\* and start a new run the first time a new pull request is created, and after every update made to the pull request:

```YAML
pr:
    - main
    - releases/*
```

You can specify the full name of the branch or a wildcard.

For more information and guidance about GitHub integration, see:

 -  [Build GitHub repositories](/azure/devops/pipelines/repos/github).
