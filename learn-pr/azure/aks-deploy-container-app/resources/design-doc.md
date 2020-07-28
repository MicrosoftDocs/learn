# Title

<!-- *Add the working title [(Title guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-title)* -->
Deploy a containerized app to Azure Kubernetes Services

## Role(s)

<!-- - *Add the role(s)* [Role guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#role) -->
- DevOps Engineer

## Level

<!-- - *Add the level*  [Level guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#level) -->
- Beginner

## Product(s)

<!-- - *Add the product(s)* -->
- Azure Kubernetes Services (AKS)

## Prerequisites

<!-- - *List the prerequisites [(Prerequisite guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-prerequisites)* -->
- An Azure Subscription
- Ability to use the Azure CLI
- Ability to create a Docker container
- Ability to navigate the Azure portal
- Basic knowledge of Kubernetes and its concepts

## Summary

<!-- *Add the summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductory-summaries)* -->
Rapidly deploy a containerized application hosted on Azure Container Services or any other registrar to the Azure Kubernetes Services.

## Learning objectives

<!-- 1. *Add numbered Learning Objectives [(Learning objective guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-learning-objectives)* -->
Upon the completion of this module, the learner will be able to:

1. Create and set up an Azure Kubernetes Cluster
2. Create Kubernetes deployment and service YAML files
3. Deploy and expose Kubernetes workloads using public images

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask Number | Subtask Title | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1 | Create an AKS Cluster | Through the steps of creating an AKS cluster using CLI and portal | Exercise | 1 | Yes |
| 2 | Install Kubectl via Azure CLI | Understanding kubectl is needed to deploy the application | Knowledge Check | 1 | No, together with 1 |
| 3 | Create AKS context into Kubectl | Setting up local development is needed to deploy the app | Knowledge Check | 1 | No, joined with 1 |
| 4 | Deploy an application using imperative paradigm | Learning context to tasks 5 and 6 | None just as a context | 2 | No, joined with 5 |
| 5 | Write Kubernetes YAML files | Pros of using a declarative structure, YAML files are needed to deploy the application | Knowledge Check | 2 | Yes |
| 6 | Deploy an application using YAML files | Deploy the written files to the cluster | Exercise | 2, 3 | No, joined with 5 |
| 7 | Expose the application to the Web | The application must be exposed for other users to use | Exercise | 3 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Let's suppose you work for a growing company that, because of the increased demand, needed to scale the product so it can provide a better experience to all customers. For that they asked you, the DevOps Engineer, to assess which tool would be the best for the job.

    After experimenting with Kubernetes you got to Azure Kubernetes Service, which fits all the prerequisites to be the perfect tool for the company's increased growth. So, after clearance from the leadership, you have to create the future structure that will support the company in the future!

    <!-- *Add your scenario [(Scenario guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-scenarios)* -->

2. **Create an AKS Cluster**

    - Access the Azure portal and create a cluster using the GUI and also show the learner how to create a cluster from the CLI
    - Use the AZ CLI command to install `kubectl` (if the user already has it installed, no need to go through this step)
    - Use the AZ CLI command to create a `kubectl` context
    - Test the commands

    **Knowledge check**

    - What is the command used to create a context in `kubectl`?
    - Why do we need to create a context in `kubectl`?

3. **Exercise - Create an AKS Cluster**

    1. Ask the learner to create an AKS cluster using one of the provided methods in the task
    2. If not installed, execute command `az aks install-cli` to install `kubectl`
    3. Ask the learner to run `az aks get-credentials` to setup the local environment
    4. Run `kubectl get all --all-namespaces` to test the completion

    > The commands will not be displayed to the user, this is just something so we do not forget the answers

4. **Deploy an application**

    - Brief contextualization with `kubectl create` as imperative example
    - Introduce YAML files as workload descriptors
      - Pros of a declarative paradigm
    - Create YAML files for all workloads needed
      - Deployment YAML
      - Service YAML

    **Knowledge check**

    - What are the benefits of having a declarative paradigm?
    - What is the purpose of the YAML files for Kubernetes?
    - Which of the options correctly describes a deployment YAML?
        - Present the user with three different YAML descriptions

5. **Exercise - Deploy an application**

    1. Ask the learner to write a YAML file for the deployment
    2. Ask the learner to run `kubectl create -f <files>` to deploy the files
    3. Test it with `kubectl get deployment <name>`

    > The commands will not be displayed to the user, this is just something so we do not forget the answers

6. **Expose an application**

    - Briefly describe service types to contextualize
    - Create YAML files for the service as LoadBalancer type
    - Show the load balancer created in Azure portal
    - Test connection

    **Knowledge check**

    - Why are we using LoadBalancer service type?
    - Which of the options correctly describes a service YAML?
      - Present the user with three different YAML descriptions

7. **Exercise - Expose an application**

    1. Ask the learner to write a YAML file for the service choosing the right service type
    2. Ask the learner to run `kubectl create -f <files>` to deploy the files
    3. Test it with `kubectl get svc <name>`
    4. access the application online

    > The commands will not be displayed to the user, this is just something so we do not forget the answers

8. **Summary**

    The company needed to deploy its infrastructure from the ground up. So we created an AKS cluster and deployed a ping application to check it's working properly.

    We used Kubernetes' declarative paradigm to help us describe what we wanted to create, this way we can keep a version history and make it easily reproducible. AZ CLI allowed us to connect to our managed Kubernetes service with AKS without having to worry about infrastructure and to get up and running fast.

    Imagine how would it be to deploy this application on a VM or another environment without Kubernetes. Having AKS to manage the heavy lifting for us, it made possible not only to save much time but to make our deployment much simpler.

    <!-- *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)* -->

## Notes
