You want to start automating the deployment for your toy company's website and as a first step you need to create a first pipeline in Azure DevOps.

In this exercise, you'll:

> [!div class="checklist"]
> * Create an Azure DevOps organization and project.
> * Create a basic pipeline.
> * Execute your basic pipeline.

## Create an Azure DevOps organization, project and repository

To work with Azure DevOps service, you will first need to create an Azure DevOps organization. An organization can hold one or more Azure DevOps projects. To create a new Azure DevOps organization you will need the following steps: 

<TODO: John, include Azure DevOps org and project creation>


## Create a Repository

Since a pipeline is a YAML file, that is stored in your repository, you will also need to initialize this repository in Azure DevOps. 

1. On the project page, select the **Repos** menu item.

<TODO: Insert image>

2. Select the **Initialize** button at the bottom to initialize your repository with a README file. 

These steps will create a repository for you with one file, README.md in it. This repository will be used in the next step to commit your YAML pipeline file to. 

## Create a starter YAML pipeline

Now that you have your organization, project and repository created, you will need to create a starter pipeline. 

1. On the project page, select the **Pipelines** menu item. 

<TODO: Insert menu image>

2. Select the **Create Pipeline** button.

<TODO: Insert pipeline image>

3. Select the **Azure Repos Git (`YAML`)** option from the list.

<TODO: Insert image>

4. Select the **Repository** you just created from the list. This will be the same name as the name you used for your project. 

<TODO: Insert image>

5. Select **Starter pipeline** from the list. 

<TODO: Insert image>

6. Copy the following in the file: 

```YAML
trigger: none

pool:
  vmImage: ubuntu-latest

jobs:
- job: 
  steps:
  - script: echo Hello, world!
    displayName: 'Run a one-line script'

  - script: |
      echo Add other tasks to build, test, and deploy your project.
      echo See https://aka.ms/yaml
    displayName: 'Run a multi-line script'
```

## Manually execute the pipeline and look at the results.

1. Select the **Save and run** button. 

<TODO: Insert image>

2. In the pop out window you will see that this file and changes will be saved by a commit to your repository. Select **Save and run**.

<TODO: Insert image>


## Inspect pipeline output

Once you hit Save and run in the previous step, you will see the Pipelines - Run screen: 

1. Take note of the commit ID this pipeline run is based on. 

<TODO: Insert image>

1. Select the **Job**.

<TODO: Insert image>

1. This will show you the different steps that got executed as part of your job. Select the **Checkout** step. You will see that as a first step in your pipeline your source code, which in this case only holds the README.md file and your YAML file, will be downloaded to your agent machine. 

> [!NOTE]
> It sometimes can take a little time for your pipeline to start. This is because Azure Pipelines needs to wait for an agent to become available.

<TODO: Insert image>

1. Select the **Run a one line script** step. This will display the output of this step. 

<TODO: Insert image>

1. Select the **Run a multi-line script** step and inspect the output. 

<TODO: Insert image>


## Inspect how pipeline execution can be linked back to a commit

1. Navigate back to the Repository overview screen by selecting the **Repos** option in the right menu.

<TODO: Insert image>

1. In the Repos overview you will see that your YAML file is part of the repository. It got committed and added when you selected Save and run in one of the previous steps. Select your **YAML** file in the file tree to confirm that it contains your pipeline code. 

<TODO: Insert image>

2. Navigate back to the Pipelines overview screen by selecting the **Pipelines** option in the right menu.

<TODO: Insert image>

1. Select the pipeline your just created.

<TODO: Insert image>

1. Select the **Run pipeline** button. 


<TODO: Insert image>

1. Select the **Run** button.

<TODO: Insert image>

1. In the Pipelines - Run screen that appears, take note of the commit number, this is the same hash as previously. There were no new changes in your repository, so the run is started based on the same version and files. 

<TODO: Insert image>

1. Select the **Commit hash**. This will show you the screen with an overview of the changes that are linked to this run. 

<TODO: Insert image>
