# Title

*Add the working title [(Title guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-title)*

## Role(s)

- *Add the role(s)* [Role guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#role)

## Level

- *Beginner*

## Product(s)

- *Azure Kubernetes Service*
- *Azure CosmosDB*

## Prerequisites

- Access to an Azure subscription
- Access to a GitHub account
- Basic knowledge of executing commands using Azure CLI
- Basic knowledge of Kubernetes and its concepts
- Basic knowledge of AKS and its concepts

## Summary

*Understand and apply the concepts behind stateful applications using Kubernetes and CosmosDB*

## Learning objectives

By the end of this module the learner will be able to:

1. Deploy a stateful cloud-native application to Azure Kubernetes service (AKS)
1. Create a CosmosDB database
1. Understand the concepts of database security using Kubernetes

## Chunk your content into subtasks

Identify the subtasks of *module title*

ID | Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1 | What is a stateful application? | Introductory concepts | Knowledge Check | 1 | yes |
| 2 | What is CosmosDB | Introductory concepts | Knowledge Check | 2 | yes |
| 3 | Exercise - Create a database using CosmosDB | Deploy the database | Exercise | 2 | yes |
| 4 | Deploy the backend application | Deploy the application | Exercise | 3 | no, 3 and 4 will be one exercise |
| 5 | Understand concepts of security using Kubernetes Secrets | Introductory Concepts | Knowledge Check | 3 | yes |
| 6 | Apply secrets to the backend application | Database Security | Exercise | 3 | yes |
| 7 | Deploy the frontend application | Database Security | Exercise | 3 | yes |

## Outline the units

1. **Introduction**

    *Imagine you work for a freight company that transports goods all over the world using ships. The operations department already uses a small system that tracks where all the company's are docket at, but, due to staff increasing, this system will need to be ported to Kubernetes.*

    *This application uses MongoDB as a database and it's already built using a separated backend, the problem you have to solve is how you can manage your database access in this distributed environment, and deploy a new database to support this critical application.*

1. **Understand state management in Kubernetes**

    Introductory concepts on stateful applications:

    - What is a state
    - What is a stateful application
    - How is state handled in Kubernetes
    - How should we handle state in Kubernetes

    **Knowledge check**

    - What is an application state?
    - How do kubernetes handle state in applications?
    - Why store the state externally

1. **Exercise - Host a new database using CosmosDB**

    List the steps which apply the learning content from previous unit:

    1. Log in to azure account
    1. Create a new Resource Group
    1. Deploy a CosmosDB instance to that new group
    1. Get the necessary connection strings
    1. Create a new AKS Cluster
        1. Important to describe that the Cosmos creation and AKS creation are two separate processes and one of them is completely non-related to the other.
    1. Deploy the backend application
    1. Include connection strings using raw text

1. **Understand Secrets best practices in Kubernetes**

    Introductory concepts on security using secrets and configmaps:

    - What is a secret
    - Why should we use secrets and not plain text
        - As @ckittel said, we should also explain there's another optimal idea by using pod identity with Azure Key Vault, but not direct the user out of the path, just let them know there's a better, but more complex, alternative and link it to the summary.
    - How secrets interact with kubernetes deployments
    - What's a configmap
    - How does a configmap work

    **Knowledge check**

    - What is a secret
    - What is the difference between a secret and a configmap
    - Why use secrets

1. **Exercise - Secure the application using secrets**

    List the steps which apply the learning content from previous unit:

    1. Create a new secret with the Cosmos connection string
    1. Edit the current application deployment to match the new secret
    1. Create a new configmap to deploy the frontend
    1. Deploy the frontend of the application using the provided values
    1. Test the application

1. **Summary**

    *You needed to support a whole operating platform by managing the application state while using Kubernetes on AKS. By creating a new instance of CosmosDB you managed to delegate the management of the database to Azure, this way you don't need to worry about availability since CosmosDB better supports multi-region and multi-master deployments and the application would be able to grow across many regions in the world without any added complexity.*

    *Along with that, you were able to understand and better secure the managed application state using secrets to keep the connection string safe and still be able to deploy your application without any problems. Now your cluster have a better handling of application states and is also scalable to the point where you can handle multiple users without needing to configure the database.*

## Notes

I'll use the application from my AKS bootcamp to deploy it:

- [Repository](https://github.com/Azure-Samples/aks-bootcamp-sample/tree/finished)
