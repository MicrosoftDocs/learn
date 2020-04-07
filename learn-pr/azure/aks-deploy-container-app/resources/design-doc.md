---
no-loc: ["Kubernetes", "kubectl", "Docker", "cluster", "Azure Container Registry"]
---
# Title

<!-- *Add the working title [(Title guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-title)* -->
Deploy a containerized app to Azure Kubernetes Services

## Role(s)

<!-- - *Add the role(s)* [Role guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#role) -->
- devOps Engineer
- Developer

## Level

<!-- - *Add the level*  [Level guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#level) -->
- Beginner

## Product(s)

<!-- - *Add the product(s)* -->
- Azure Kubernetes Services (AKS)
- Azure Container Registry (ACR)

## Prerequisites

<!-- - *List the prerequisites [(Prerequisite guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-prerequisites)* -->
- An Azure Subscription
- An Azure Container Registry already created
- Ability to log in and interact with Azure via Azure CLI
- Ability to navigate the Azure portal
- Ability to interact with any Kubernetes cluster through `kubectl`
- Basic knowledge of Docker and its concepts
- Basic knowledge of containers and their concepts
- Basic knowledge of Kubernetes and its concepts

## Summary

<!-- *Add the summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductory-summaries)* -->
Rapidly deploy a containerized application hosted on Azure Container Services or any other registrar to the Azure Kubernetes Services.

## Learning objectives

<!-- 1. *Add numbered Learning Objectives [(Learning objective guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-learning-objectives)* -->
Upon the completion of this module, the learner will be able to:

1. Identify the steps required to deploy a containerized app to AKS
2. Identify the correct AZ CLI commands to setup AKS clusters in local `kubectl`
3. Identify the correct AZ CLI commands to attach ACR to AKS
4. Identify the correct workloads to be created to fully deploy an application
5. Explain why the said workloads are needed to make the application fully functional
6. Understand the correct representation/structure of Kubernetes' YAML files
7. Deploy Kubernetes workloads using images from DockerHub
8. Deploy Kubernetes workloads using images from ACR
9. Use `kubectl` to access AKS locally to fetch cluster information

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask Number | Subtask Title | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1 | Overview of the deployed app | Overview the app, introduce needed workloads | Knowledge Check | 1, 4, 5 | Yes |
| 2 | Creating YAML files for each workload | Creating the needed resources | Knowledge Check | 1, 4, 5, 6 | Yes |
| 3 | Deploying the application using a DockerHub image | Deploying and testing the app on DockerHub | Exercise | 1, 6, 7 | Yes |
| 4 | Setting up local environment | Setup local environment | Exercise | 1, 2, 9 | No, combined with subtask 3 |
| 5 | Deploying the application using an ACR image | Deploying and testing the app outside of DockerHub | Exercise | 1, 6, 8, 9 | Yes |
| 6 | Attaching ACR to AKS | Deploy from a private registry | Exercise | 1, 3, 8, 9 | No, combined with subtask 5 |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Imagine you work for a transport company that delivers goods around the world using cargo ships as a devOps Engineer. The company already adopted AKS as the chosen infrastructure solution. Now, the internal product team finished a long-waited internal management tool that needs to be deployed ASAP to track ship movement across the globe. The application has already been containerized and pushed to the company's private registry in the ACR. It just needs to be deployed to the existent cluster so employees can use it.

    <!-- *Add your scenario [(Scenario guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-scenarios)* -->

2. **Understanding what need to be done**

    - Pass through all the information needed to create the app:
      - App architecture overview
      - Deployments needed
      - Services needed
      - Ingresses needed

    **Knowledge check**

    - What is the purpose of the deployment in this architecture?
    - What is the purpose of both the ingress and the service in this architecture?

3. **Describing workloads**

    - Introduce YAML files as workload descriptors
      - Pros of a declarative paradigm
    - Create YAML files for all workloads needed
      - Deployment YAML
      - Service YAML
      - Ingress YAML
        - Explain annotation for `http-application-routing`

    **Knowledge check**

    - What are the benefits of having a declarative paradigm?
    - What is the purpose of the YAML files for Kubernetes?
    - Which of the options correctly describes a deployment YAML?
        - Present the user with three different YAML descriptions
    - Which of the options correctly describes a service YAML?
        - Present the user with three different YAML descriptions
    - Which of the options correctly describes an ingress YAML?
        - Present the user with three different YAML descriptions

4. **Deploying a public image**

    - Setup AZ CLI to access remote cluster on AKS
    - Creating the YAML (deployment and service) files for the database
    - Using `kubectl` to deploy the workload

    **Knowledge Check**

    - Why didn't we create an ingress for the database?
    - Select the correct command to deploy a given YAML file to the cluster

5. **Exercise - Deploying a public image**

    1. Ask the learner to run `az aks get-credentials` to setup the local environment
    2. Ask the learner to write a YAML file for the database deployment
    3. Ask the learner to write a YAML file for the database service
    4. Ask the learner to run `kubectl create -f <files>` to deploy the files
    5. Test it with `kubectl get deployment <name>` and `kubectl get svc <name>`

    > The commands will not be displayed to the user, this is just something so we do not forget the answers

6. **Deploying a private ACR image**

    - Writing the YAML (deployment, ingress and service) files for the application frontend
    - Writing the YAML (deployment, ingress and service) files for the application backend
    - Attach ACR with AKS
        - Explain how to use AZ CLI to create the attachment
        - Explain how it could be done without ACR attachment (secret creation)
    - Using `kubectl` to deploy the workload
    - Testing it online

    **Knowledge Check**

    - Why did we create an ingress for the applications?
    - Why did we attach our ACR to our AKS?

7. **Exercise - Deploying a private ACR image**

    1. Ask the learner to write a YAML file for the applications deployments
    2. Ask the learner to write a YAML file for the applications services
    3. Ask the learner to write a YAML file for the applications ingresses
    4. Ask the learner to attach ACR to the existing AKS cluster
    5. Run `kubectl create -f <files>` to deploy the files
    6. Test it with `kubectl get deployment <name>` and `kubectl get svc <name>` and `kubectl get ing <name>`
    7. Try to access the application using the DNS name

    > The commands will not be displayed to the user, this is just something so we do not forget the answers

8. **Summary**

    The company team needed to access the new tracking system ASAP so the ships would be tracked across deliveries. We needed something fast and easy to deploy our containerized application to the cloud and make it available to the internal team.

    We used Kubernetes' declarative paradigm to help us describe what we wanted to create, this way we can keep a version history and make it easily reproducible.

    AZ CLI allowed us to connect to our managed Kubernetes service with AKS without having to worry about infrastructure and the ACR integration with AKS allowed us to download private images much faster.

    Imagine how would it be to deploy this application on a VM or another environment without Kubernetes. Having AKS to manage the heavy lifting for us, and using the integration between Azure services, made possible not only to save much time but to make our deployment much simpler.

    Thanks to this agility, the company can now use the system to track deliveries around the world. Optimizing time between routes, which means less wasted fuel, better economy and cleaner operations!

    <!-- *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)* -->

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, etc.

- [Attaching ACR to AKS](https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration)
