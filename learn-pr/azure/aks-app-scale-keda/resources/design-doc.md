# Title

<!-- *Add the working title [(Title guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-title)* -->
Scale container applications in Azure Kubernetes Services (AKS) using Kubernetes Event-driven Autoscaling (KEDA)

## Role(s)

<!-- - *Add the role(s)* [Role guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#role) -->
- DevOps Engineer
- Developer

## Level

<!-- - *Add the level*  [Level guidance](https://review.docs.microsoft.com/en-us/new-hope/information-architecture/metadata/taxonomies?branch=master#level) -->
- Beginner

## Product(s)

<!-- - *Add the product(s)* -->
- Azure Kubernetes Services (AKS)
- Kubernetes Event-driven Autoscaling (KEDA)

## Prerequisites

<!-- - *List the prerequisites [(Prerequisite guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-prerequisites)* -->
- An Azure Subscription
- Ability to use the Azure CLI
- Ability to run and exec into a Docker container
- Ability to navigate the Azure portal
- Basic knowledge of Kubernetes and its concepts
- Basic knowledge of AKS and its concepts
- Basic knowledge of microservice concepts

## Summary

<!-- *Add the summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductory-summaries)* -->
Scale a containerized application hosted on AKS using event driven scaling using KEDA

## Learning objectives

<!-- 1. *Add numbered Learning Objectives [(Learning objective guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-learning-objectives)* -->
Upon the completion of this module, the learner will be able to:

1. Understand the concept of event driven auto scaling and how it applies to Kubernetes
2. Deploy KEDA within AKS
3. Deploy and configure a built-in KEDA scaler
4. Understand K8S scaling options including KEDA, Cluster Autoscaling (CA), and Horizontal Pod Autoscaling (HPA)

## Chunk your content into subtasks

Identify the subtasks of *Event Driven Autoscaling using KEDA*

| Subtask Number | Subtask Title | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1 | Create an AKS Cluster | Through the steps of creating an AKS cluster using CLI and portal | Exercise | 1 | Yes |
| 2 | Install Kubectl via Azure CLI | Understanding kubectl is needed to deploy the application | Knowledge Check | 1 | No, together with 1 |
| 3 | Create AKS context into Kubectl | Setting up local development is needed to deploy the app | Knowledge Check | 1 | No, together with 1 |
| 4 | Deploy KEDA into AKS | Deploy the lightweight KEDA component into AKS | Exercise | 2 | Yes |
| 5 | Deploy an application using YAML files | Deploy the written files to the cluster | Exercise | 2, 3 | No, joined with 5 |
| 6 | Configure a KEDA scaler object | Learning context to tasks 5 and 6 | Exercise | 3 | No, joined with 4 |
| 7 | Test the application and KEDA scaler | Validate that the sample application autoscales using the KEDA scaler | Exercise | 3 | No, together with 4, 5, and 6 |
| 8 | Review concepts and use cases of Cluster Autoscaler, KEDA, and HPA | Compare and contrast KEDA, CA, and HPA | Knowledge Check | 4 | Yes

## Outline the units

1. **Introduction**

    You work for a growing company.  Usage of its client application peaks at various times during a 24-hr period. Due to increasing and decreasing demand, the company needs to scale its application accordingly to provide a better experience to all customers. Since the application is event driven and receives a significant number of messages, CPU and Memory based metrics are not sufficient to scale properly. As the DevOps Engineer, you need to assess which tools will help achieve the company's scaling needs.  

    After experimenting with various options, you've determined that using Azure Kubernetes Services (AKS) and KEDA fulfills all the requirements to scale for peak and off-peak usage. With clearance from leadership, you begin the journey of an event driven application that supports the company now and in the future!

    <!-- *Add your scenario [(Scenario guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-scenarios)* -->

2. **Create an AKS Cluster**

    - Access the Azure portal and create a cluster using the GUI and also show the learner how to create a cluster from the CLI
    - Use the AZ CLI command to install `kubectl` (if the user already has it installed, no need to go through this step)
    - Use the AZ CLI command to create a `kubectl` context
    - Test the commands

   **Exercise - Create an AKS Cluster**

    1. Ask the learner to create an AKS cluster using one of the provided methods in the task
    2. If not installed, execute command `az aks install-cli` to install `kubectl`
    3. Ask the learner to run `az aks get-credentials` to set up the local environment
    4. Run `kubectl get all --all-namespaces` to test the completion

3. **Deploy KEDA into AKS**

    - Describe the concept of KEDA and how it differs from HPA
    - Describe the deployment process of KEDA for AKS and ask the learner to chose one of recommended options
    - Explain Custom Resource Definitions
   
    **Exercise - Deploy KEDA into AKS**

    1. Install KEDA
    2. Verify the installation

    **Knowledge Check**

    - What are the differences between KEDA and native Kubernetes HPA?
    - What is the primary purpose of using Scaled Jobs?
    - What authentication patterns are provided with KEDA?

4. **Deploy an application**

    - Brief contextualization with `kubectl create` as imperative example
    - Create YAML files for all workloads needed
      - Deployment YAML
      - Service YAML

    **Exercise - Deploy an application**

    1. Ask the learner to write a YAML file for the deployment
    2. Ask the learner to run `kubectl create -f <files>` to deploy the files
    3. Test it with `kubectl get deployment <name>`

5. **Configure a KEDA scaler object**

    - Briefly describe what scaler objects are and some of the common scalers
    - Describe KEDA is not limited to the available Scalers and can create **Custom** Scalers
    - Create and configure YAML files for a Redis List Scaler Object
    - Deploy scaler object using `kubectl apply -f`
    - Test the connection

    **Knowledge check**

    - What purpose do scaler objects perform?
    - What purpose do scaler jobs perform?
    - Are scalers limited to only Azure resources?

    **Exercise - Configure a KEDA scaler object**

    1. Configure a KEDA scaler object
    2. Deploy scaler object using `kubectl apply -f`
    3. Trigger the pod scaling by adding items to Redis List
    4. Verify that the pods scale up and scale down based on the number of messages in the Redis List

6. **Review K8S scaling options**

    - Describe Cluster Autoscaler and its role in scaling
    - Explain recommended practices of when to and when not to use KEDA/HPA

    **Knowledge check**

    - Describe a few scenarios and ask learner which scaling option is appropriate

7. **Summary**

    The company needed to develop a solution to handle application traffic at peak and off peak times.  The current application is already applying AKS as its orchestration platform, plus using Redis to facilitate messaging.

    After researching available options for autoscaling the application, the best solution was KEDA. The Dev Team created a Redis Scaler to increase the number of containers during peak times and to gracefully back off the number of containers as traffic returns to normal.

    Using the native HPA would not adequately scale during times of high traffic. In the case of our application, we need to scale based on the number of messages in a list. HPAs scale based on metrics like CPU utilization. CPU utilization does not accurately reflect the number of messages in a list waiting to be processed. For this reason, we use KEDA to use the number of messages in the Redis list to scale the containers processing the messages.

    <!-- *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)* -->

## Notes
