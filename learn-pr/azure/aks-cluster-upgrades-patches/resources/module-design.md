# Apply cluster upgrades and security patches with Azure Kubernetes Service

## Role(s)

- devops-engineer
- solution-architect

## Level

- beginner

## Product(s)

- Azure Kubernetes Service 

## Prerequisites

- A basic understanding of containerization (https://docs.microsoft.com/en-us/learn/modules/intro-to-docker-containers/). 
 
- A basic understanding of Azure Kubernetes Service (https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-kubernetes-service/).

## Summary

In this module, you learned to:
- Identify when you need to upgrade your Azure Kubernetes cluster components to the latest version that is supported by Kubernetes 
- Understand which Kubernetes versions Azure Kubernetes Services (AKS) supports and where to find them
- Upgrade your Azure Kubernetes Service clusters to ensure your cluster components have the latest version updates 
- Ensure your Azure Kubernetes Services clusters do not go out of support

## Learning objectives

Upon completing this module, you should be able to: 
 - Understand what Kubernetes versions are supported by Azure Kubernetes Services (AKS) [https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions]
 - Upgrade your existing Azure Kubernetes Services (AKS) clusters components to the latest supported Kubernetes version
 - Understand how to adopt a Blue/Green deployment  to upgrade your Azure Kubernetes Services clusters in a production environment

## Chunk your content into subtasks

Identify the subtasks of **Understand, upgrade and stay up to date with the latest Kubernetes versions for your Azure Kubernetes Service clusters.**

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand why it is necessary to upgrade your Azure Kubernetes Service clusters  | Email notification | Knowledge Check | 1 | Yes |
| Upgrade your Azure Kubernetes Service cluster components to the latest supported stable Kubernetes version | Upgrade cluster | Exercise | 2 | Yes |
| Test and deploy the upgraded Azure Kubernetes Service clusters  | Upgrade cluster  | Knowledge Check | 3 | Yes |

## Outline the units

1. **Introduction**

    Uh oh, you have received an email in your inbox from Microsoft Azure (azure-noreply@microsoft.com) notifying you that the current Kubernetes version you are running in your Azure Kubernetes Service clusters will go out of support soon. You must upgrade your clusters immediately to the latest stable Kubernetes version. You want to understand why this has happened and what your next steps should be. 

1. **What are Kubernetes versions?**

    Help learners understand why Kubernetes goes through versions: 

    - What is versioning? 
        - In software, versioning is ...
            - Why is versioning important?
        - What is semantic versioning? 
            - [major].[minor].[patch] 
        - Why do Kubernetes release new versions? [https://kubernetes.io/docs/setup/release/version-skew-policy/#kubectl]
            - Talk about the core Kubernetes components that are patched or updated here. 

    **Knowledge check**

    A question about versions

    - Some bugs have been identified by the Kubernetes community that needs to be fixed. When the bug fixes have been made, what should Kubernetes do? 
        1. Deprecate Kubernetes 1.0.0 and release Kubernetes 2.0.0
        1. Make a patch release (correct answer)
        1. Make a feature release 
    
    A question about semantic versioning

    - Kubernetes has just announced they have released a new version, v1.20.0. The last known version of Kubernetes was v1.19.10. Using your knowledge of semantic versioning, what type of changes does v1.20.0 indicate? 
        1. Major updates
        1. Minor updates (correct answer)
        1. Patch updates
    
    A question about what Kubernetes versions are
 
    - When Kubernetes releases a new version, what is updated? 
        1. The OS image for the control plane  
        1. Security patches for the OS of the nodes 
        1. The core components (correct answer)

1. **What are Azure Kubernetes Service (AKS) versions?**

    Help learners understand which Kubernetes versions Azure Kubernetes Service (AKS) supports: 

    - What is the "N-2" rule? [https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions#kubernetes-version-support-policy]
    - What is the release and deprecation process? [https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions#release-and-deprecation-process]
    - What are the updates and changes made to the latest version? [https://github.com/Azure/AKS/releases]
    - How to test AKS version upgrades in production?
        - Blue/Green Deployment with Azure Front Door [https://techcommunity.microsoft.com/t5/azure-architecture-blog/blue-green-deployment-with-azure-front-door/ba-p/1609178#:~:text=%20Blue%2FGreen%20Deployment%20with%20Azure%20Front%20Door%20, relatively%20unimportant.%20What%20you%20select%20here...%20More%20]

1. **Exercise - Create your Azure Kubernetes Service cluster**
    
    1. First check for any existing resource group, e.g.,  az group list -o table 
        1. If resource group exists, create a variable to store the resource group name for example, rg={resource-group-name} and set a location variable to "westus"
        1. If no resource group exists, create one for example, az group create -n aks-rg -l $location (*which is set to "westus")
    1. Next, check for aks versions that are currently supported, e.g.,  az aks get-versions -l $location -o table
    1. Create an AKS cluster using the oldest version available e.g. az aks create -n myakscluster -g $rg --kubernetes-version $kv --generate-ssh-keys (*remember to set a variable, kv to the oldest kubernetes version)
        1. Requirements: 
            1. User must have at least "Azure Kubernetes Service Contributor Role" (https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#azure-kubernetes-service-contributor-role)
            1. Subscription must be registered to use "Microsoft.ContainerService" for example. 
                1. az provider register --namespace Microsoft.ContainerService (but need rights on the subscription)

    **Knowledge check**

    A question about N-2
    - Kubernetes has released a new minor version 1.20.0. Which of the following Kubernetes versions will go out of support according to the N-2 rule?
        1. 1.19.8
        1. 1.18.0
        1.  1.17.0 (correct answer)
        
    A question about a new minor version release
    - How many patch versions of a minor version does Azure Kubernetes Services support?
        1. 1
        1. 2 (correct answer)
        1. 3
    
    A question about a version deprecation 
    - How many days do you have to upgrade an AKS cluster version that becomes deprecated?
        1. 30 days (correct answer)
        1. 60 days
        1. 90 days 
    
    A question about testing and deployment with Blue/Green deployment

    - Your organization has decided to use Blue/Green deployment to test and deploy the newly upgraded AKS clusters. Which of the following most accurately describes this test and deployment strategy?
        1. Run two identical AKS clusters, upgrade one cluster then switch the router to the upgrade cluster (correct answer)
        1. Run two AKS clusters, label one as 'staging' and the other as 'production', first upgrade the staging cluster then upgrade the production cluster 
        1. Make a copy of your existing AKS cluster, upgrade the copy then shut down the original cluster


1. **Exercise - Upgrade your Azure Kubernetes Service clusters (manual upgrade)**

    List the steps which apply the learning content from previous unit:

    1. First check: Do I need to upgrade my AKS cluster? for example 
        1. az aks get-upgrades -n myakscluster -g $rg 
            1. This command needs permission at the "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.ContainerService/managedClusters/myakscluster/upgradeProfiles/default" scope to perform the action "Microsoft.ContainerService/managedClusters/upgradeProfiles/read" (we need to assign the Contributor role of the user to the resource group. Also for some bizarre reason, it sometimes malfunctions.)
        1. Check the available versions again for example. 
            1. az aks get-versions -l $location
            1. You might need to get the subscription ID, e.g.,  az account list -o table 
        1. Alternatively, we can check the current AKS cluster version by executing: 
            1. az aks show -g $rg -n myakscluster -o table 
    1. Upgrade an AKS cluster 
        1. Let's try to upgrade to the latest version straight away, e.g.,  az aks upgrade -n myakscluster -g $rg -k {latest-version}
            1. This should fail (lesson here is you cannot skip minor version upgrades)
        1. Next, try, and upgrade to the next patch version for example. 
            1. az aks upgrade -n myakscluster -g $rg -k {next-patch-version} --no-wait
        1. Next, try, and upgrade to the next minor version for example. 
            1. az aks upgrade -n myakscluster -g $rg -k {next-minor-version} --no-wait 
        1. Finally, upgrade to the latest AKS supported version for example. 
            1. az aks upgrade -n myakscluster -g $rg -k {latest-version} --no-wait 
        1. Do a check after each upgrade to check out the cluster for example. 
            1. az aks show -n myakscluster -g $rg -o table (and make sure the provisioning state is Succeeded before moving on)
            1. You can either remove the --no-wait flag or use:
                1. az aks wait -g $rg -n myakscluster --updated 
                to check 
    1. Delete your cluster and remove your resources
        1. az aks delete -n myakscluster -g $rg --no-wait 

1. **Summary**

**You have now successfully resolved that concerning email about your Azure Kubernetes Service clusters going out of support by upgrading your Kubernetes components in your Azure Kubernetes Service clusters to the latest supported Kubernetes versions.**

Azure Kubernetes Services depends on Kubernetes. This means when Kubernetes releases a new version, Azure Kubernetes Service will also follow suit. These new releases can range from bug fixes  are to ensure your Kubernetes cluster have the latest security patches and updates for your core Kubernetes components such as kubectl, kube-apiserver, kubelet, kube-scheduler, kube-proxy and so on. 

To make sure your cluster components are up to date with the latest version releases, you have the option to manually upgrade your Azure Kubernetes Service clusters which we practiced doing during the exercise There is also the option to configure auto-upgrade for your Azure Kubernetes Services cluster upgrades. To find out more about auto-upgrade, check out the Microsoft Docs on 'Set auto-upgrade channel [https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#set-auto-upgrade-channel].

Finally, setting up a Blue/Green deployment for your Azure Kubernetes Service clusters ensures a smooth transition from your previous clusters to your upgraded clusters and allows for you to easily roll back should you encounter any issues during or after the rollout of the upgraded clusters. 


## Notes

- Reference links to: 
    - auto-upgrade
    - blue/green deployment
    - Azure front door 
    - how to test 


## Question

- If I want to use images/screenshot for example, for the email notification part, for the exercise labs - can I source it from anywhere or is there an image repository I have to source it from? What are the design guidelines around this as well? 