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

- A basic understanding of Azure Kubernetes Service concepts such as Kubernetes API, cluster, and pod
- Deployed a fully running instance of an AKS cluster

## Summary
In this module, you learned to:

- Understand how Azure Policy integrates with Azure Kubernetes Service
- Deploy the Azure policy and Azure Monitor add-on for Azure Kubernetes Service
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

    Your team has been working on deploying a new application on top of the Azure Kubernetes Service. You just came out of a review with the security and compliance teams. They expressed concerns about the compliance status of your cluster. For example, they only want you to deploy images from trusted registries. They need you to be able to block new deployments from untrusted registries, and present a report of the status of your cluster against that policy. It's up to you to find out how you can meet this requirement and present a solution to the security and compliance teams. 

    *Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)*

1. **Azure Policy and how it integrates with the Azure Kubernetes Service**

    - What is Azure policy
        - Azure Policy
        - effects
        - continued monitoring
        - Policy scopes
        - links for more info
    - How does Azure policy integrate with AKS
        - explain Azure control plane vs kubernetes control plane
        - examples of policies
    - Under the cover
        - admission webhooks in kubernetes
        - OPA / Gatekeeper
        - Gatekeeper / Policy


    **Knowledge check**
    
    - A question about Azure policy itself
    - A scenario-based question about Azure policy for AKS (you want to achieve this, how...)
    - An implementation-based question about Azure policy for AKS (you have this configure, how will...)

3. **Exercise - enabling Azure Policy for Azure Kubernetes Service**
   1. Create a new AKS cluster with policy and monitor add-on enabled. If learner has an existing cluster, show how to enable the add-on on existing cluster.
   2. Enabling Azure Policy for AKS for a specific resource group
   3. How to automatically enable Azure Policy for AKS
   4. How to monitor which clusters have the add-on installed

4. **Built-in policies for Azure Kubernetes Service**

- How to find built-in policies for AKS, and provide links to documentation
    - Explain cluster policy, like authorized ip ranges for example.
    - Explain workload policy, like only allow trusted registry
- Explain the two secure baseline initiatives

5. **Exercise - assigning a policy to an AKS cluster**
   1. Ensure the learner has an AKS cluster with policy enabled
   2. (using kubectl) Deploy a non-compliant pod before the policy is applied
   3. (using Azure portal) Apply the "only trusted registry policy". Use dockerhub vs mcr.microsoft.com
   4. (using Azure portal) Apply the "[Kubernetes cluster pod security restricted standards for Linux-based workloads](https://docs.microsoft.com/en-us/azure/aks/policy-reference#initiatives) initiative". 
   5. (using kubectl) Deploy a non-compliant pod and see effect
   6. (using kubectl) Deploy a compliant pod and see effect
   7. (using kubectl) Deploy a non-compliant deployment and see effect (the deployment and replicaset will be created, but pods will fail. Show troubleshooting steps to do kubectl describe replicaset, which shows why pods aren't getting created)

6. **Checking compliance status using Azure portal**

- How to use Azure monitor to see runtime operation of policy
    - Explain how Azure monitor can be used to run queries and see runtime operation of policy in AKS clusters
- How to use Azure portal to see compliance status of cluster 
    - Explain how to use Azure policy in Azure portal to check compliance status and see non-compliant pods highlighted
    - Explain how it can take over 30 minutes for these non-compliant pods to show up

7. **Knowledge check**

- A question about what happens to the non-compliant pods after the policy is activated
- A question about what happens when you have two contradicting workload policies at different scopes
- A question about how to make exceptions to policies

8. **Summary**
   In this module, you learned to:
   * Understand how Azure Policy integrates with Azure Kubernetes Service
   * Deploy the Azure policy add-on for Azure Kubernetes Service
   * Configure policies to manage and report on the compliance state of an Azure Kubernetes Service cluster
   * Monitor cluster compliance status using Azure portal

 Learn more
 - [AKS Secure baseline](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
 - [Enterprise Scale for AKS](https://docs.microsoft.com/azure/cloud-adoption-framework/scenarios/aks/enterprise-scale-landing-zone)

## Notes