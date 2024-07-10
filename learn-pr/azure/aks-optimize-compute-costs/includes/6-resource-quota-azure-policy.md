Azure Policy helps you to enforce standards and assess compliance at scale for your cloud environment. It's good practice for companies to implement business rules to define how employees are allowed to use company software, hardware, and other resources in the organization. Therefore, businesses use policies to enforce, review, and define access. A policy helps an organization meet governance and legal requirements, implement best practices, and establish organizational conventions.

Azure Kubernetes Service (AKS) allows you to orchestrate your cloud-native applications efficiently with policies. You realize that you need to enforce business rules to manage how the teams use AKS to ensure a cost-effective approach. You decide to use Azure Policy to apply this idea on your Azure-based cloud resources.

Before discussing how to use Azure Policy for Kubernetes, you should understand a few more concepts that enable this feature from within Kubernetes.

## What is a Kubernetes admission controller?

An *admission controller* is a Kubernetes plug-in that intercepts authenticated and authorized requests to the Kubernetes API before the requested Kubernetes object's persistence. For example, suppose you deploy a new workload, and the deployment includes a pod request with specific memory requirements. The admission controller intercepts the deployment request and must authorize the deployment before it's persisted to the cluster.

You can think of an admission controller as software that governs and enforces how the cluster is used and designed. It limits requests to create, delete, and modify Kubernetes objects.

## What is an admission-controller webhook?

An *admission-controller webhook* is an HTTP callback function that receives admission requests and then acts on these requests. Admission controllers need to be configured at runtime. These controllers exist either for your compiled-in admission plug-in or a deployed extension that runs as a webhook.

Admission webhooks are available in two kinds: either a *validating webhook* or a *mutating webhook*. A mutating webhook is invoked first and can change and apply defaults on the objects sent to the API server. A validation webhook validates object values and can reject requests.

## What is the Open Policy Agent (OPA)?

The *Open Policy Agent (OPA)* is an open-source, general-purpose policy engine that gives you a high-level declarative language to author policies. These policies allow you to define rules that oversee how your system should behave.

## What is the OPA Gatekeeper?

The *OPA Gatekeeper* is an open-source, validating, Kubernetes admission-controller webhook that enforces Custom Resource Definition (CRD)-based policies that follow the OPA syntax.

The goal of the OPA Gatekeeper is to allow you to customize admission policies by using configuration instead of hard-coded policy rules for services. It also gives you a full view of your cluster to identify policy-violating resources.

Use the OPA Gatekeeper to define organization-wide policies with rules:

- The maximum resource limits, such as CPU and memory limits, are enforced for all configured pods.

- The deployment of images is allowed only from approved repositories.

- Naming convention for labels for all namespaces in a cluster must specify a point of contact for each namespace.

- Mandate that cluster services have globally unique selectors.

## Azure Policy for AKS

Azure Policy extends OPA Gatekeeper version 3 and integrates with AKS through built-in policies. These policies apply at-scale enforcements and safeguards on your cluster in a centralized and consistent manner.

Your company's development teams want to optimize development and introduce development tools such as DevSpaces to simplify their Kubernetes development workflow. You want to make sure that the team members adhere to specific resource limits for their projects. You decide to put a policy in place that defines the compute resources, storage resources, and object count permitted in the development namespaces.

To set up resource limits, you can apply resource quotas at the namespace level and monitor resource usage to adjust policy quotas. Use this strategy to reserve and limit resources across the development team.

## How to enable the Azure Policy Add-on for AKS

There are a few steps to registering the Azure Policy Add-on for AKS feature. We'll provide examples here, but you'll actually complete the steps in the next unit.

1. Register two resource providers by using the `az provider register` command:

    - **Microsoft.ContainerService** and **Microsoft.PolicyInsights**: These resource providers support actions such as querying information about policy events and managing containers. These are actions to query, create, update, or delete policy remediation.

    Here's an example of the two registration commands:

    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    az provider register --namespace Microsoft.PolicyInsights
    ```

1. Register the `AKS-AzurePolicyAutoApprove` feature with the `Microsoft. ContainerService` resource provider. Here's an example of the command:

    ```azurecli
    az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
    ```

1. After you confirm the successful feature registration, run the `az provider register` command with the `--namespace` parameter to propagate the new feature registration. Here's an example of the command:

    ```azurecli
    az provider register -n Microsoft.ContainerService
    ```

1. Enable the azure-policy add-on:

    ```azurecli
    az aks enable-addons \
        --addons azure-policy \
        --name myAKSCluster \
        --resource-group myResourceGroup
    ```

    Activating the addon schedules workloads in two namespaces on your cluster. The first namespace is **kube-system**, which contains the `azure-policy` and `azure-policy-webhook`. The second namespace is **gatekeeper-system**, which contains the `gatekeeper-controller-manager`. These workloads are responsible for evaluating requests submitted to the AKS control plane. Based on your configured policies, your policy webhook can allow or deny requests.

## Assign a built-in policy definition

You manage your Azure environment's policies by using the Azure policy compliance dashboard. The dashboard allows you to drill down to a per-resource, per-policy level of detail. It helps you bring your resources to compliance by using bulk remediation for existing resources and automatic remediation for new resources.

For each policy, the following overview information is listed:

| Item  | Description | Example
| --- | --- | --- |
| **Name** | The name of the policy. | **[Preview]: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster**.
| **Scope** | The subscription resource group to which this policy applies. | mySubscription/rg-akscostsaving.
| **Compliance state** | The status of assigned policies. | **Compliant**, **Conflicted**, **Not started**, or **Not Registered**. |
| **Resource compliance** | The percentage of resources that comply with the policy. This calculation takes into account compliant, non-compliant, and conflicting resources. | 100 |
| **Non-compliant resources** | The number of unique resources that violate one or more policy rules. | 3 |
| **Non-compliant policies** | The number of non-compliant policies. | 5 |

From here, you can drill down into the per-resource and per-policy details for the events triggered. For example, you can examine details of a denied workload deployment.

### Assigning policies

To assign a policy, select the **Assignments** option under the **Authoring section** in the Azure Policy navigation panel.

You assign Azure policies in one of two ways: as a group of policies called an *initiative*, or as a single policy.

### Initiative assignment

An initiative assignment is a collection of Azure policy definitions grouped together to satisfy a specific goal or purpose. For example, the goal might be to apply the Payment Card Industry Data Security Standard across your resources.

### Policy assignment

A policy assignment assigns a single policy, such as **Do not allow privileged containers in Kubernetes cluster**.

## How to assign a policy

Each policy is defined by using a series of configuration steps. The amount of information you capture depends on the type of policy you select.  

For example, to limit resource deployment by developers in the company's cloud environment, you can assign one of the built-in Azure policies for Azure Kubernetes Service. The name of the policy is **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster**.

The policy requires you to set the limit on the allowed resources requested by deployment requests.

Let's take a look at the configurable options when you assign a policy.

### Basic policy information

The first step requires you to select and enter basic information that defines the new policy. For example, this information can be the policy and the resource scope. This table shows each item you can configure:

| Item | Description |
| --- | --- |
| **Scope** | The scope determines on what resources or group of resources the policy assignment is enforced. This value is based on a subscription or a management group. You can exclude resources from your selection at one level lower than the scope level.|
| **Policy Definition** | The policy you want to apply. You can choose from several built-in policy options. |
| **Assignment name** | The name used to identify the assigned policy. |
| **Description** | A free-text description that describes the policy. |
| **Policy enforcement** | You can choose **Enabled** and **Disabled**. If the option is **Disabled**, the policy isn't applied and requests aren't denied with non-compliance. |
| **Assigned by** | A free-text value that defaults to the registered user. You can change this value. |

### Policy parameters

Policies require you to configure the business rules that apply to each specific policy. Not all policies have the same business rules, and that's why each policy has different parameters.

For example, the **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy requires you to set three parameters:

- The maximum CPU units allowed for a container
- The maximum memory bytes allowed for a container
- A list of Kubernetes namespaces to exclude from the policy

Compare that policy with the **Web Application should only be accessible over HTTPS** policy, which has no custom parameters to configure.

All policies have an **Effect** setting. This setting enables or disables the policy execution. As with parameters, policies can also have different **Effect** options.

For example, for the resource-management policy, you can select **audit**, **deny**, or **disable** as the **Effect** value. For the web-application policy, you can select only **audit** or **disable**.

This table lists all the effects currently supported in policy definitions:

| Effect | Description |
| --- | --- |
| **Append** | Adds more fields to the requested resource |
| **Audit** | Creates a warning event in the activity log |
| **AuditIfNotExists** |  Enables auditing of resources related to the resource that matches the condition |
| **Deny** | Prevents a resource request that doesn't match defined standards through a policy definition, and fails the request |
| **DeployIfNotExists** | Executes a template deployment when the condition is met |
| **Disabled** | Useful for testing situations or for when the policy definition has parameterized the effect, and you want to disable a single assignment |
| **Modify** | Adds, updates, or removes tags on a resource during creation or update |

### Policy remediation

The final step is to consider policy remediation. When you assign policies, it's possible that resources already exist and violate the new policy. By default, only newly created resources are applied to the new policy. Use remediation to check existing resources after you assign a new policy. Remediation tasks can differ depending on the types of policies applied.

In the next exercise, you use the **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy to lower costs further.
