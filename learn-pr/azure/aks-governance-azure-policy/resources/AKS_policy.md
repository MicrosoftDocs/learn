# Cluster governance using Azure Policy 

## Role(s)
- administrator
- auditor
- devops-engineer	
- solution-architect	
## Level

- intermediate	  

## Product(s)

- Azure Kubernetes Service
- Azure Policy

## Prerequisites

- A basic understanding of Azure Kubernetes Service concepts such as Kubernetes API, cluster and pod
- Deployed a fully running instance of an AKS cluster

## Summary
In this module, you learned to:

- Understand how Azure Policy integrates with Azure Kubernetes Service
- Deploy the Azure policy add-on for Azure Kubernetes Service
- Configure policies to manage compliance state of an Azure Kubernetes Service cluster
- Monitor cluster compliance status using Azure policy



## Learning objectives
Upon completing this module, you should be able to: 
 - Understand how Azure Policy integrates with Azure Kubernetes Service
 - Configure policies to manage and report on the compliance state of an Azure Kubernetes Service cluster

## Chunk your content into subtasks

Identify the subtasks of **Cluster governance using Azure Policy**

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand how the Azure Policy integration with Azure Kubernetes Service helps maintain compliance | Need for a solution | Knowledge check | 1 | Yes |
| Enable the Azure Policy add-on for Azure Kubernetes Service | Setup | Exercise | 2 | Yes |
| Configure policies on an Azure Kubernetes Service cluster | Setup | Exercise | 2 | Yes |
| Monitor the compliance status of an Azure Kubernetes Service cluster | Compliance monitoring | Exercise | 2 | Yes |


## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice:

    Your team has been working on deploying a new application on top of the Azure Kubernetes Service. You just came out of a review with the security and compliance teams. They expressed concerns about the compliance status of your cluster. For example, they only want you to deploy images from trusted registries. They need you to be able to block new deployments from untrusted registries, and they need to you to be able to present a report of the status of your cluster against that policy. It's now up to you to find out how you can meet this requirement and present a solution to the security and compliance teams. 

    *Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)*

1. **Azure Policy and how it integrates with the Azure Kubernetes Servcie**

    - What is Azure policy
        - Azure Policy
        - effects
        - continued monitoring
        - links for more info
    - How does Azure policy integrate with AKS
        - explain azure control plane vs kubernetes control plane
        - examples of policies
    - Under the cover
        - admission webhooks in kubernetes
        - OPA / Gatekeeper
        - Gatekeeper / Policy


    **Knowledge check**

    - A question about Azure policy itself
    - A scenario-based question about Azure policy for AKS (you want to achieve this, how...)
    - A implementation-based question about Azure policy for AKS (you have this configures, how will...)

1. **Exercise - enabling Azure Policy for Azure Kubernetes Service**

    1. Ensure the learner has a AKS cluster, and if not refer to docs on how to create one (FYI, I don't think we can use the sandbox. enabling policy takes up to 30 minutes, which does not play well with the maximum 60 minutes sandbox)
    1. Enabling Azure Policy for AKS for a specific resource group
    1. How to automatically enable Azure Policy for AKS
    1. How to monitor which clusters have the add-on installed

1. **Built-in policies for Azure Kubernetes Servcice**

    - How to find built-in policies for AKS, and provide links to documentation
    - Explain the two secure baseline initiatives
    
1. **Exercise - assigning a policy to an AKS cluster**
    
    1. Ensure the learner has an AKS cluster with policy enabled
    1. (using kubectl) Deploy a non-compliant pod before the policy is applied
    1. (using Azure portal) Apply the "only trusted registry policy". Use dockerhub vs mcr.microsoft.com
    1. (using kubectl) Deploy a non-compliant pod and see effect
    1. (using kubectl) Deploy a compliant pod and see effect
    1. (using kubectl) Deploy a non-compliant deployment and see effect (the deployment and replicaset will be created, but pods will fail. Show troubleshooting steps to do kubectl describe replicaset which shows why pods are not getting created)
    1. (using Azure portal) See compliance status of cluster and see non-compliant pod highlighted

1. **Summary**
In this module, you learned to:

- Understand how Azure Policy integrates with Azure Kubernetes Service
- Deploy the Azure policy add-on for Azure Kubernetes Service
- Configure policies to manage and report on the compliance state of an Azure Kubernetes Service cluster
- Monitor cluster compliance status using Azure policy

## Notes


### Questions:
The focus of the excersize will be the example outlined in the scenario, meaning non-compliant registries. I was thinking of using mcr.microsoft.com vs dockerhub as the example, since this does not require a learner to deploy an Azure container registry. Is that OK or do we want to add the complexity of an ACR?