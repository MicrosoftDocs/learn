The ease with which Azure Kubernetes Service (AKS) allows you to orchestrate your cloud-native applications has allowed more development teams in your company to embrace AKS as a development platform. You realize that you need to enforce business rules to manage how the teams use AKS to ensure a cost-effective approach to creating workloads.

Companies implement business rules to define how employees may use company software, hardware, and other resources in the organization. These business rules are often described using policies that are put in place, enforced, and reviewed as per defined within that policy. A policy allows an organization to meet governance, legal requirements, implement best practices, and organizational conventions.

You can apply this same idea to how your Azure cloud resources are used by using Azure Policy. Azure Policy helps you to enforce standards and assess compliance at-scale for your Azure cloud environment.

To understand how to use Azure Policy for Kubernetes, we need to cover a few additional concepts that enable this feature from within Kubernetes.

## What is a Kubernetes admission controller?

An admission controller is a Kubernetes plug-in that intercepts authenticated and authorized requests to the Kubernetes API before the requested object's persistence. You can think of an admission controller as software that governs and enforce how the cluster is used and designed to limit requests to create, delete, and modify Kubernetes objects.

## What is an admission controller webhook?

An admission controller webhook is an HTTP callback that receives admission requests and then acts on these requests. Admission controllers exist either as a compiled-in admission plug-in or as a deployed extension that runs as a webhook that you configure at runtime.

Admission webhooks are available in two kinds of webhooks. An admission webhook is either a validating or a mutating webhook. A mutating webhook is invoked first and can change and apply defaults on the objects sent to the API server. A validation webhook validates object values and can reject requests.

## What is the Open Policy Agent (OPA)?

The Open Policy Agent (OPA) is an open-source, general-purpose policy engine that gives you a high-level declarative language to author policies. These policies allow you to define rules that oversee how your system should behave.

## What is the Open Policy Agent (OPA) Gatekeeper?

The OPA Gatekeeper is an open-source validating Kubernetes admission controller webhook that enforces Custom Resource Definition (CRD) based policies using the Open Policy Agent.

The goal of the OPA Gatekeeper is to allow you to customize admission policies using configuration instead of hardcoded policy rules for services. It will also give you a full view of your cluster to identify policy-violating resources.

OPA aksGatekeeper allows you to define organization-wide policies.  For example, you can require that:

- the maximum resource limits like CPU and memory limits for all configured pods 

- the deployment of images is allowed only from approved repositories

- labels for all namespaces in a cluster list a point-of-contact for each namespace

- cluster services have globally unique selectors

The current version of the OPA Gatekeeper is version 3 and supported by Azure Kubernetes Service.

## Azure Policy for Azure Kubernetes Service (AKS)

Azure Policy extends OPA Gatekeeper v3 and integrates with AKS through built-in policies to apply at scale enforcements and safeguards on your cluster in a centralized and consistent manner.

Your company's development teams want to optimize development and introduce development tools such as DevSpaces to simplify their Kubernetes development workflow. You want to make sure that the team members adhere to specific resource limits for their projects. You decide to put a policy in place that defines the allowed compute resources, storage resources, and object count permitted in the development namespaces.

To set up resource limits, you can apply resource quotas at the namespace level and monitor resource usage to adjust policy quotas. This strategy will allow you to reserve and limit resources across the development team.

## How to enable the Azure Policy Add-on for AKS 

There are a few steps to registering the *Azure Policy Add-on for AKS* feature.

>[!CAUTION]
>
>Like spot nodes, the *Azure Policy Add-ons for AKS* is a preview feature. Once you enable some preview features in Azure, defaults may be used for all AKS clusters created in the subscription. Test preview features in non-production subscriptions to avoid unforeseen side effects in production deployments.


1. You register two resource providers using the `az provider register` command.

    - **Microsoft.ContainerService**. This provider is the same resource provider you used to register the *spotpoolpreview* feature with earlier.
    
    - **Microsoft.PolicyInsights**. This resource provider allows actions such as querying information about policy events as well as the ability to query, create or update, and delete policy remediation.

    Here is an example of the two registration commands.
    
    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    az provider register --namespace Microsoft.PolicyInsights
    ```

1. With these two resource providers registered, you now register the `AKS-AzurePolicyAutoApprove` feature with the **Microsoft Container Service** resource provider. Here is an example of the command.
    
    ```azurecli
    az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
    ```

1. Once you confirm the successful registration of the feature, you'll run the `az provider register` command with the `--namespace` parameter to propagate the new feature registration. Here is an example of the command.

    ```azurecli
    az provider register -n Microsoft.ContainerService
    ```

1. The final steps to install the Azure CLI preview extension and enabling the Azure Policy addon. Use the `az extensions add` command and enable the `azure-policy` addon using the `az aks enable-addons` command.

    Here is an example of the two commands.

    ```azurecli
    az extension add --name aks-preview

    az aks enable-addons \
        --addons azure-policy \
        --name myAKSLCuster \
        --resource-group myResourceGroup
    ```

    Activating the addon will schedule workloads in two namespaces on your cluster.

    The first namespace is **`kube-system`**. Here you'll find:

    - `azure-policy`, and
    - `azure-policy-webhook`

    The second namespace is **`gatekeeper-system`**. Here you'll find:

    - `gatekeeper-controller-manager`

    These workloads are responsible for evaluating requests submitted to the AKS control plane. Based on your configured policies, the policy webhook will allow or deny requests.

## Assign a built-in policy definition

You manage your Azure environment's policies using the Azure policy compliance dashboard. The dashboard allows you to drill down to a per-resource, per-policy granularity. It helps you bring your resources to compliance through bulk remediation for existing resources and automatic remediation for new resources.

For each policy, an overview of the following information is listed:

| Item  | Description | 
| --- | --- |
| **Name** | The name of the policy. For example, *[Preview]: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster*.
| **Scope** | The subscription resource group to which this policy applies. For example, *Visual Studio Enterprise/akscostsavinggrp*.
| **Compliance state** | The compliance state indicates the status of assigned policies. The value may be *Complaint*, *Conflicted*, *Not started*, or *Not Registered*. |
| **Resource compliance** | The percentage of resource that complies with the policy. This calculation takes into account compliant, non-compliant, and conflicting resources. |
| **Non-complaint resources** | The number of unique resources that violates one or more policy rules. |
| **Non-complaint policies** | The number of non-compliant policies.

From here, you drill down into the per-resource, per-policy detail as well as events triggered. For example, a workload deployment that is denied.

### Assigning policies

Azure Policies are assigned. To assign a policy, you select the **Assignments** option under the **Authoring section** in the Azure Policy navigation panel.

You assign Azure policies in two ways. Either as a group of policies, called an initiative, or as a single policy.

### Initiative assignment

An initiative assignment is a collection of Azure policy definitions grouped together to satisfy a specific goal or purpose in mind. For example, to apply the Payment Card Industry Data Security Standard across your resources.

### Policy assignment

A policy assignment allows you to assign a single policy. For example, do not enable privileged containers in the Kubernetes cluster.

## How to assign a policy

Each policy is defined using a series of configuration steps. The amount of information you capture depends on the type of policy you'll select.  

For example, to limit resource deployment by developers in the company's, you want to assign one of the built-in Azure policies for Azure Kubernetes Service. The name of the policy is *Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster*.

The policy requires you to set the limit on the allowed resources requested by deployment requests.

Let's look at the options you configure to assign a policy.

### Basic policy information

The first step requires you to select and enter basic information defining the new policy. For example, the policy and the resource scope that the policy covers. Here is a table that shows each item you'll configure.

| Item | Description |
| --- | --- |
| **Scope** | The scope determines what resources or group of resource the policy assignment gets enforced on. This value is based on a subscription or a management group. You can exclude resources from your selection at one level lower than the scope level.|
| **Policy Definition** | Here you select the policy you want to apply. You can choose from several built-in policy options. |
| **Assignment name** | The name by which to identify the assigned policy. |
| **Description** | A free text description that describes the policy. |
| **Policy enforcement** | This option switches between Enabled and Disabled. If disabled, the policy isn't applied, and requests are not denied with non-compliance. |
| **Assigned by** | This value is a free text value that defaults to the registered user and can be changed. |

### Policy parameters

Policies require you to configure the business rules that apply to each specific policy. Not all policies have the same business rules, and that's why each policy has different parameters that may apply.

For example, the *Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster* policy, requires you to set three parameters.

- The maximum CPU units allowed for a container.
- The maximum memory bytes allowed for a container.
- A list of Kubernetes namespaces to exclude from the policy.

If you compare the above policy with the *Web Application should only be accessible over HTTPS*, the policy has no custom parameters to configure.

All policies have an **Effect** setting. This setting enables or disables the execution of the policy. Like before, policies may have different effect options.

For example, for the resource management policy, you can select **audit**, **deny**, or **disable** as the value. For the web application policy, you can only select **audit** or **disable**.

The following table lists all the effects currently supported in policy definitions.

| Effect | Description |
| --- | --- |
| **Append** | Used to add additional fields to the requested resource. |
| **Audit** | Used to create a warning event in the activity log. |
| **AuditIfNotExists** |  Enables auditing of resources related to the resource that matches the condition. |
| **Deny** | Used to prevent a resource request that doesn't match defined standards through a policy definition and fails the request. |
| **DeployIfNotExists** | Executes a template deployment when the condition is met. |
| **Disabled** | useful for testing situations or for when the policy definition has parameterized the effect, and you want to disable a single assignment. |
| **Modify** | Used to add, update, or remove tags on a resource during creation or update. |

### Policy Remediation

The final step is to consider policy remediation. When assigning policies, there's the possibility that resources already exist and is impacted by the new policy. By default, only newly created resources are affected by the new policy. You can update existing resources using a remediation task following the assignment of the policy. Remediation tasks will differ between the types of policies applied.

Let's assign the *Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster* policy in the following exercise.
