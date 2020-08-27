Azure Policy helps you to enforce standards and assess compliance at scale for your cloud environment. It's good practice for companies to implement business rules to define how employees are to use company software, hardware, and other resources in the organization. These business rules are often described by using policies that are put in place, enforced, and reviewed as defined within each policy. A policy helps an organization meet governance and legal requirements, implement best practices, and establish organizational conventions.

Azure Kubernetes Service (AKS) enables you to orchestrate your cloud-native applications efficiently. This ease has allowed more development teams in your company to embrace AKS as a development platform. You realize that you need to enforce business rules to manage how the teams use AKS to ensure a cost-effective approach to creating workloads. You can use Azure Policy to apply this same idea to how your Azure-based cloud resources are used.

Before discussing how to use Azure Policy for Kubernetes, we need to cover a few additional concepts that enable this feature from within Kubernetes.

## What is a Kubernetes admission controller?

An *admission* controller is a Kubernetes plug-in that intercepts authenticated and authorized requests to the Kubernetes API before the requested Kubernetes object's persistence. For example, suppose you deploy a new workload, and the deployment includes a pod request with specific memory requirements. The admission controller intercepts the deployment request and must authorize the deployment before it's persisted to the cluster.

You can think of an admission controller as software that governs and enforces how the cluster is used and designed. It limits requests to create, delete, and modify Kubernetes objects.

## What is an admission-controller webhook?

An *admission-controller webhook* is an HTTP callback function that receives admission requests and then acts on these requests. Admission controllers exist either as a compiled-in admission plug-in or as a deployed extension that runs as a webhook that you configure at runtime.

Admission webhooks are available in two kinds: either a *validating webhook* or a *mutating webhook*. A mutating webhook is invoked first and can change and apply defaults on the objects sent to the API server. A validation webhook validates object values and can reject requests.

## What is the Open Policy Agent (OPA)?

The *Open Policy Agent (OPA)* is an open-source, general-purpose policy engine that gives you a high-level declarative language to author policies. These policies enable you to define rules that oversee how your system should behave.

## What is the OPA Gatekeeper?

The *OPA Gatekeeper* is an open-source, validating, Kubernetes admission-controller webhook that enforces Custom Resource Definition (CRD)-based policies by using the Open Policy Agent.

The goal of the OPA Gatekeeper is to enable you to customize admission policies by using configuration instead of hard-coded policy rules for services. It also gives you a full view of your cluster to identify policy-violating resources.

You can use the OPA Gatekeeper to define organization-wide policies. For example, you can require that:

- The maximum resource limits, such as CPU and memory limits, are enforced for all configured pods.

- The deployment of images is allowed only from approved repositories.

- Labels for all namespaces in a cluster specify a point of contact for each namespace.

- Cluster services have globally unique selectors.

The current version of the OPA Gatekeeper (version 3) is supported by Azure Kubernetes Service.

## Azure Policy for AKS

Azure Policy extends OPA Gatekeeper version 3 and integrates with AKS through built-in policies. These policies apply at-scale enforcements and safeguards on your cluster in a centralized and consistent manner.

Your company's development teams want to optimize development and introduce development tools such as DevSpaces to simplify their Kubernetes development workflow. You want to make sure that the team members adhere to specific resource limits for their projects. You decide to put a policy in place that defines the compute resources, storage resources, and object count permitted in the development namespaces.

To set up resource limits, you can apply resource quotas at the namespace level and monitor resource usage to adjust policy quotas. Use this strategy to reserve and limit resources across the development team.

## How to enable the Azure Policy Add-on for AKS

There are a few steps to registering the Azure Policy Add-on for AKS feature.

>[!CAUTION]
>
>Like spot nodes, the Azure Policy Add-on for AKS is a preview feature. After you enable some preview features in Azure, defaults might be used for all AKS clusters created in the subscription. Test any preview features in non-production subscriptions to avoid unforeseen side effects in production deployments.

1. Register two resource providers by using the `az provider register` command:

    - **Microsoft.ContainerService**: This resource provider is the same one you used to register the **spotpoolpreview** feature with previously.

    - **Microsoft.PolicyInsights**: This resource provider supports actions such as querying information about policy events. It also provides the ability to query, create or update, and delete policy remediation.

    Here's an example of the two registration commands:

    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    az provider register --namespace Microsoft.PolicyInsights
    ```

1. Register the `AKS-AzurePolicyAutoApprove` feature with the `Microsoft. ContainerService` resource provider. Here's an example of the command:

    ```azurecli
    az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
    ```

1. After you confirm the successful registration of the feature, run the `az provider register` command with the `--namespace` parameter to propagate the new feature registration. Here's an example of the command:

    ```azurecli
    az provider register -n Microsoft.ContainerService
    ```

1. Install the Azure CLI preview extension and enable the Azure Policy Add-on. Use the `az extensions add` command, and then enable the `azure-policy` add-on by using the `az aks enable-addons` command.

    Here's an example of the two commands:

    ```azurecli
    az extension add --name aks-preview

    az aks enable-addons \
        --addons azure-policy \
        --name myAKSCluster \
        --resource-group myResourceGroup
    ```

    Activating the add-on will schedule workloads in two namespaces on your cluster. The first namespace is **kube-system**, where you'll find `azure-policy` and `azure-policy-webhook`. The second namespace is **gatekeeper-system**, where you'll find `gatekeeper-controller-manager`. These workloads are responsible for evaluating requests submitted to the AKS control plane. Based on your configured policies, the policy webhook will allow or deny requests.

## Assign a built-in policy definition

You manage your Azure environment's policies by using the Azure policy compliance dashboard. The dashboard enables you to drill down to a per-resource, per-policy level of detail. It helps you bring your resources to compliance by using bulk remediation for existing resources and automatic remediation for new resources.

For each policy, the following overview information is listed:

| Item  | Description |
| --- | --- |
| **Name** | The name of the policy. For example, **[Preview]: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster**.
| **Scope** | The subscription resource group to which this policy applies. For example, "Visual Studio Enterprise/rg-akscostsaving".
| **Compliance state** | The status of assigned policies. The value can be **Compliant**, **Conflicted**, **Not started**, or **Not Registered**. |
| **Resource compliance** | The percentage of resources that comply with the policy. This calculation takes into account compliant, non-compliant, and conflicting resources. |
| **Non-compliant resources** | The number of unique resources that violate one or more policy rules. |
| **Non-compliant policies** | The number of non-compliant policies. |

From here, you drill down into the per-resource and per-policy details and events triggered. For example, you can examine details of a workload deployment that is denied.

### Assigning policies

Azure Policies are assigned. To assign a policy, you select the **Assignments** option under the **Authoring section** in the Azure Policy navigation panel.

You assign Azure policies in one of two ways: as a group of policies, called an *initiative*, or as a single policy.

### Initiative assignment

An initiative assignment is a collection of Azure policy definitions grouped together to satisfy a specific goal or purpose. For example, the goal might be to apply the Payment Card Industry Data Security Standard across your resources.

### Policy assignment

A policy assignment assigns a single policy, such as **Do not allow privileged containers in Kubernetes cluster**.

## How to assign a policy

Each policy is defined by using a series of configuration steps. The amount of information you capture depends on the type of policy you select.  

For example, to limit resource deployment by developers in the company's cloud environment, you can assign one of the built-in Azure policies for Azure Kubernetes Service. The name of the policy is **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster**.

The policy requires you to set the limit on the allowed resources requested by deployment requests.

Let's look at the options you configure to assign a policy.

### Basic policy information

The first step requires you to select and enter basic information that defines the new policy. For example, this information might be the policy and the resource scope that the policy covers. This table shows each item you'll configure:

| Item | Description |
| --- | --- |
| **Scope** | The scope determines what resources, or group of resources, the policy assignment is to be enforced on. This value is based on a subscription or a management group. You can exclude resources from your selection at one level lower than the scope level.|
| **Policy Definition** | The policy you want to apply. You can choose from several built-in policy options. |
| **Assignment name** | The name by which to identify the assigned policy. |
| **Description** | A free-text description that describes the policy. |
| **Policy enforcement** | This option switches between **Enabled** and **Disabled**. If the option is **Disabled**, the policy isn't applied and requests aren't denied with non-compliance. |
| **Assigned by** | A free-text value that defaults to the registered user. This value can be changed. |

### Policy parameters

Policies require you to configure the business rules that apply to each specific policy. Not all policies have the same business rules, and that's why each policy has different parameters.

For example, the **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy requires you to set three parameters:

- The maximum CPU units allowed for a container.
- The maximum memory bytes allowed for a container.
- A list of Kubernetes namespaces to exclude from the policy.

Compare that policy with the **Web Application should only be accessible over HTTPS** policy, which has no custom parameters to configure.

All policies have an **Effect** setting. This setting enables or disables the execution of the policy. As with parameters, policies can also have different **Effect** options.

For example, for the resource-management policy, you can select **audit**, **deny**, or **disable** as the value for **Effect**. For the web-application policy, you can select only **audit** or **disable**.

This table lists all the effects currently supported in policy definitions:

| Effect | Description |
| --- | --- |
| **Append** | Adds more fields to the requested resource. |
| **Audit** | Creates a warning event in the activity log. |
| **AuditIfNotExists** |  Enables auditing of resources related to the resource that matches the condition. |
| **Deny** | Prevents a resource request that doesn't match defined standards through a policy definition, and fails the request. |
| **DeployIfNotExists** | Executes a template deployment when the condition is met. |
| **Disabled** | Useful for testing situations or for when the policy definition has parameterized the effect, and you want to disable a single assignment. |
| **Modify** | Adds, updates, or removes tags on a resource during creation or update. |

### Policy remediation

The final step is to consider policy remediation. When you assign policies, it's possible that resources already exist and are impacted by the new policy. By default, only newly created resources are affected by the new policy. You can update existing resources by using a remediation task after you assign the policy. Remediation tasks will differ depending on the types of policies applied.

In the next exercise, let's assign the **Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy.
