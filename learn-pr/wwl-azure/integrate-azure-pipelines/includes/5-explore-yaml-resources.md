
Resources in YAML represent sources of pipelines, repositories, and containers. For more information on Resources, [see here](/azure/devops/pipelines/process/resources).

## General schema

```YAML
resources:
  pipelines: [ pipeline ]
  repositories: [ repository ]
  containers: [ container ]

```

## Pipeline resource

If you have an Azure pipeline that produces artifacts, your pipeline can consume the artifacts by using the pipeline keyword to define a pipeline resource.

```YAML
resources:
  pipelines:

  - pipeline: MyAppA
    source: MyCIPipelineA

  - pipeline: MyAppB
    source: MyCIPipelineB
    trigger: true

  - pipeline: MyAppC
    project:  DevOpsProject
    source: MyCIPipelineC
    branch: releases/M159
    version: 20190718.2
    trigger:
      branches:
        include:

        - master
        - releases/*
        exclude:

        - users/*

```

## Container resource

Container jobs let you isolate your tools and dependencies inside a container. The agent launches an instance of your specified container then runs steps inside it. The container keyword lets you specify your container images.

Service containers run alongside a job to provide various dependencies like databases.

```YAML
resources:
  containers:

  - container: linux
    image: ubuntu:16.04

  - container: windows
    image: myprivate.azurecr.io/windowsservercore:1803
    endpoint: my_acr_connection

  - container: my_service
    image: my_service:tag
    ports:

    - 8080:80 # bind container port 80 to 8080 on the host machine
    - 6379 # bind container port 6379 to a random available port on the host machine
    volumes:

    - /src/dir:/dst/dir # mount /src/dir on the host into /dst/dir in the container

```

## Repository resource

Let the system know about the repository if:

 -  If your pipeline has templates in another repository.
 -  If you want to use multi-repo checkout with a repository that requires a service connection.

The repository keyword lets you specify an external repository.

```YAML
resources:
  repositories:

  - repository: common
    type: github
    name: Contoso/CommonTools
    endpoint: MyContosoServiceConnection

```
