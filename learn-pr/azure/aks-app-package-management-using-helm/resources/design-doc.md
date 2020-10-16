# Design Document

## Title

Application and package management using Helm

## Role(s)

- developer
- administrator
- solution-architect
- student

## Level

- beginner

## Product(s)

- azure
- azure-kubernetes-service

## Prerequisites

- Access to an Azure subscription
- Basic knowledge of executing commands using Azure CLI
- Knowledge of Kubernetes and its concepts
- Basic knowledge of creating Kubernetes YAML manifest files
- Basic knowledge of executing commands using Kubectl

## Summary

DevOps teams use Helm, the Kubernetes package manager for Kubernetes, to standardize, simplify, and implement reusable deployment packages for all apps in the drone tracking solution. Here you'll see how to install third-party packages into your Azure Kubernetes (AKS) Cluster and how to create Helm charts for the applications your teams develop.

## Learning objectives

[//]:# (Complete the sentence. By the end of this module you will be able to...)
[//]:# (Try to keep it to three high-level skills the learner will achieve.)

- Describe the benefits of using HELM as a Kubernetes package manager
- Create a HELM chart for a cloud-native application
- Manage a cloud-native application release using Helm

## Chunk your content into subtasks

Identify the subtasks of *Application and package management using Helm*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Helm | Simplifying deployments | NA | Describe the use of Helm and Helm Charts | Yes |
| Install an application using a Helm Chart | Simplifying deployments | Exercise | Describe the use of Helm and Helm Charts | Yes |
| Create a Helm chart for an existing application | Simplifying deployments | Exercise | Create a Helm Chart for a Kubernetes application | Yes |
| Create an application release using Helm charts | Simplifying deployments | Exercise | Manage a Kubernetes application release by using Helm charts | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Kubernetes allows you to manage the deployment life cycle of cloud-native applications using Kubernetes package managers. A Kubernetes package manager allows you to standardize, simplify, and implement reusable deployment strategies for your applications.

    :::image type="content" source="../media/placeholder.svg" alt-text="A diagram that shows the life cycle of an app managed using a package manager. The image starts at packing the app, then deploying the app, and then updating the app iteratively.":::

    Suppose you work at a drone management company. Your company provides a drone tracking solution to customers worldwide. The solution is built and deployed as microservices and includes several major applications:

    :::image type="content" source="../media/placeholder.svg" alt-text="A diagram that shows all the applications that forms part of the drone tracking solution. A number of applications shown in the diagram that is deployed to an Azure Kubernetes Service cluster.":::

    You use an Azure Kubernetes Service (AKS) cluster to host the drone tracking solution. The DevOps team uses standard declarative YAML files to deploy various services in the solution. In the current deployment workflow, the development teams create the deployment files for each application. Next, the DevOps team updates the deployment files to reflect production configuration settings where required. The manual management of many YAML files is proving a risk to the teams when efficiently deploying, operating, and maintaining systems and procedures. The DevOps team wants to use a Kubernetes package manager to standardize, simplify, and implement reusable deployment packages for all apps in the drone tracking solution.

    By the end of this module, you'll be able to create and manage a Kubernetes releases using Helm as a Kubernetes package manager.

1. **What is Helm?**

    Description: This is the description of the unit.

    [//]:# (List the content that will enable the learner to *subtask*:)

    The deployment, versioning, and updating of any application usually requires planning and management to ensure the correct versions of software libraries and configuration settings are in place.

    :::image type="content" source="placeholder.svg" alt-text="A diagram that shows a container deployed to a Kubernetes node using a deployment, service, and ingress YAML files.":::

    Here you'll see how Helm can simply application deployment.

    - What is Helm?

        Helm is a package manager for Kubernetes that combines all your application's resources and deployment information into a single definition.

        :::image type="content" source="placeholder.svg" alt-text="A diagram that shows how an application is automatically transformed into a container and is deployed as a pod onto a node in a Kubernetes cluster by using a helm chart package.":::

    - Helm architecture

	    Helm uses a **client binary**, **charts**, **releases**, and **repositories** when managing application deployments.

        :::image type="content" source="placeholder.svg" alt-text="A diagram that shows the three Helm architectural concepts. A Helm chart, repository, and a release.":::

    - Helm versions

    	This module and other Learn modules always assume the use of Helm v3. In contrast to v3, which installs only a binary client, Helm v2 required you to install two components. The Helm client binary and a server binary called Tiller.

1. **Exercise - Set up the environment**

    In this exercise, you'll use a script to create and configure your Azure Kubernetes Service (AKS) cluster.

    - Launch Azure Cloud Shell

    - Clone the deployment script repository

    - Run the deployment script

1. **Create and install a Helm chart**

    Description: This is the description of the unit.

    [//]:# (List the content that will enable the learner to *subtask*:)

    Helm makes it simple to deploy applications to any Kubernetes clusters by using Helm charts. Assume your development team already deploys your company's drone tracking website to your Azure Kubernetes Service cluster. The team creates three files to deploy the website.

    - What is a Helm chart?

        A Helm chart is a collection of files that describe a related set of Kubernetes resources. These resources can be a single application or an application with several dependencies.

        :::image type="content" source="placeholder.svg" alt-text="A diagram that shows the folder tree of a Helm chart.":::

    - How to define a `Chart.yaml` file

        The `Chart.yaml` is one of the required files in a Helm chart definition. The file consists of three required fields and various optional fields that describe the chart.

    - What is a Helm chart template?

        A Helm Chart template is a file you use to model and build different deployment type manifest files to deploy apps to a Kubernetes cluster. Chart templates are written in the Go template language and provides additional template functions to automate deployments.

    - How to customize an existing chart

        You use chart values to customize the configuration of a Helm chart. Chart values can either be predefined or supplied by the user at the time of deploying the chart.

    - How to use functions and pipelines in a Helm template

        The Helm template language defines functions that you can use to transform values from the `values.yaml` file in a template. The syntax for a function follows the *{{ functionName arg1 arg2 ... }}* structure.

        **Conditional flow control in a Helm template**

        Conditional flow control allows you to make decisions about the structure of the generated manifest file when combining data from the `values.yaml` file and instructions from the template file. The `if / else` block is such a control flow structure.

        **How to iterate through a collection of values**

        YAML allows you to define collections of items and use as values in your templates. Accessing items in a collection is possible using an indexer. However, the Helm template language supports iteration though a collection of values by using the `range` operator.

        **How to control scope of available values**

        Recall, the `.` used in a Helm template references the current scope. For example, the `.Values` instructs the template engine to find the *Values* object in the current scope. When you have values defined several layers deep, your syntax may become verbose and cumbersome. The `with` action allows you to limit the scope of variables in a template.

    - How to use a Helm repository

        A Helm repository is a dedicated HTTP server that stores information on Helm charts

        You need to configure Helm repositories with the Helm client for it to install charts from the repository. You register a repository by using the `helm repo add` command. For example, to install the ASP.NET Core chart that is available from the Bitnami Helm repository, you can run the following command:

    - How to install a Helm chart

        Helm charts are deployed from either a Helm repository or a local folder on the client PC.

        :::image type="content" source="../media/placeholder.svg" alt-text="A placeholder image - Deploy a Helm chart using `helm install` command line.":::

        You use the `helm install` command to install a chart. However, the required parameters differ depending on the location of the chart. In both cases, the install command requires the name of the chart you want to install as well as a name for the release the installation will create.


1. **Exercise - Install a Helm chart**

    Description: This is the description of the unit.

    In this exercise, you'll add a Helm repository to your Helm installation and install an ASP.NET Core website to your Azure Kubernetes Service cluster.

    1. In the Azure Cloud Shell, add the Azure marketplace Helm repository to the Helm Cloud Shell configuration. This repository gives you access to a number pre-configured Helm charts available for installation.

    1. Run the `helm search repo` command to search for the `azure-marketplace/aspnet-core` chart.

    1. Deploy the ASP.NET Core Helm chart by using the `helm install` command.

    1. List all Helm deployments by using the `helm list` command

    1. Run `helm get manifest aspnet-webapp` to get the manifest files for the release.

    1. You can validate that the pod is running by running the `kubectl get pods` command.

1. **Manage a Helm release**

    Helm charts make it easy to install, upgrade, roll back, and delete an application on a Kubernetes cluster. Helm provides functionality to retrieve the status of a Helm release to track aspects such as last deployment time or listing the resources used in the release. This feature allows you to track changes to running releases and manage future deployments.

    Application code seldom remains static. Any changes made to code results in the redeployment of the application in order for users to make use of new features and potential bug fixes. New features added to applications often results in added dependencies for applications.

    Here, you'll learn how to add a chart's dependencies, upgrade a Helm release and rollback a Helm release.

    - How to define chart dependencies

      A chart allows for the declaration of dependencies to support the main application deployed using Helm.

      Assume the development team decides to add a database to the web application. The web app is now dependent on the database's availability on the cluster to function properly. Recall from earlier that the `/charts` folder may contain sub charts. These sub charts are deployed as part to the main chart's release and used to define dependencies for the main chart.

      :::image type="content" source="placeholder.svg" alt-text="A list of chart files showing the main Chart.yaml file and the location of chart dependencies.":::

    - How to upgrade a Helm release

      Helm allows upgrades to existing releases as a delta of all the changes that you apply to a chart and its dependencies.

      :::image type="content" source="placeholder.svg" alt-text="A diagram that shows how the helm upgrade command creates a delta of all changed items to upgrade only the changed items from the chart and then create a new release revision.":::

    - How to roll back a Helm release

      Helm allows the rollback of an existing Helm release to a previous installed release. Helm tracks release information of all releases done for a Helm chart.

      :::image type="content" source="placeholder.svg" alt-text="A diagram that shows how the helm rollback command can roll back to a previous revision number.":::

1. **Exercise - Manage a Helm release**

    Description: This is the description of the unit.

    [//]:# (List the steps which apply the learning content from the previous unit:)

    1. Create a Helm chart by using the `helm create drone-webapp` command.

    1. Update the `templates/service/yaml` file

    1. Deploy the drone-webapp Helm chart by using the `helm install` command.

    1. List all Helm deployments by using the `helm list` command.

    1. Inspect the `Chart.yaml` file by opening the integrated editor in Cloud Shell.

    1. Roll back the Helm release by using the `helm rollback` command.`

    1. View the web app Helm deployment history by using the `helm history` command.

1. **Summary**

    Description: This is the description of the unit.

    The manual management of many YAML files introduces unnecessary risk when teams want to target efficient deployment, operation, and maintenance of Kubernetes application releases.

    - Revert .NET Core SDK changes

    - Reset Azure Cloud Shell

        The scripts used in this module make temporary changes to your Cloud Shell preferences. You don't need to reset your configuration if the scripts ran as intended. If you want to reset your Cloud Shell to its default configuration, see the [documentation on deleting personal data](/azure/cloud-shell/troubleshooting#delete).

    - Learn More

        [Go template language](https://godoc.org/text/template)

        [Sprig template library](https://masterminds.github.io/sprig/)

    *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-module-summary-unit)*
