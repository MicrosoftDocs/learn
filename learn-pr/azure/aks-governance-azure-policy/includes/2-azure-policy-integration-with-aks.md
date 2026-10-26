Azure Policy is an Azure service that helps you manage your compliance state across different Azure services. Azure Policy for Kubernetes enables you to use the same Azure policies in your Kubernetes clusters, allowing you to manage the compliance state of Kubernetes resources like pods, deployments, and services as if they were an Azure resource.

Find the reference articles mentioned in this unit in the summary unit's **More info** section.

## Introducing Azure Policy

Azure Policy allows you to manage the compliance state of your Azure services. It works by comparing the state of your Azure resources to business rules you define. Common rules are the limitation of certain regions, the requirement for resource tags or limiting which Azure services can be used.

The way you define these business rules in Azure Policy is by using policy definitions. There are many built-in policies that cover a range of common scenarios. If one of the built-in policies doesn't meet your needs, you can also define a custom policy using a JSON-based language. You can also group multiple policy definitions together into an initiative.

In a policy definition, you define a resource compliance condition and the effect that should be taken if that condition is met. A condition compares a resource's properties to a required value. An example of a condition could be comparing the location of a resource versus a predefined list of allowed locations. The effect of a policy can be auditing the condition, denying the resource's creation, or modifying the created resource. In the example of the location of a resource, you could deny the creation of resources not in the list of allowed locations. For a more detailed explanation of policy definitions, refer to Azure Policy definition structure.

Azure Policy assigns a policy definition or initiative to a *scope*: a management group, subscription, resource group, or individual Azure resource. Assignments apply to applicable resources within that scope, subject to exclusions and exemptions. An assignment scoped to an AKS Azure resource is different from targeting individual Kubernetes objects; workload matching is controlled by the Kubernetes policy definition and its parameters.

Multiple policy definitions can apply to a certain scope. The net result of layering policy definitions is considered to be *cumulative most restrictive*: If multiple policies apply to a certain resource, that resource is only compliant if all policy definitions applying to it are compliant.

> [!NOTE]
> An exclusion removes the selected scope from evaluation and compliance counts. An exemption records an approved exception and can have an expiration. Choose the narrowest justified scope. Creating an exemption requires the documented exemption permissions on the resource and target assignment. See Understand scope in Azure Policy.

Policy assignments are evaluated during the creation or update of Azure resources. They're also evaluated if the definition or scope is changed, and periodically for continuous monitoring. Practically, the policy immediately takes effect when you create new resources. Any historical resources are also scanned, so you get a continuous view on the compliance of all your resources.

## Integration of Azure Policy with AKS

There are two ways in which Azure Policy integrates with Azure Kubernetes Service (AKS):

- Policies that enforce compliance on the Azure control plane for AKS.
- Policies that enforce compliance on the workload running in your cluster.

The first set of policies is focused more on the Azure resources that represent the cluster design, whereas the second set of policies is focused on workloads running within the cluster.

An example policy focused on the Azure control plane for AKS is the policy to enforce the use of private clusters. The policy evaluates whether an AKS cluster is using the private cluster functionality. This policy is a configuration on the Azure API that controls the design of the cluster itself.

An example of the set of policies focused on the workload running in your cluster is the policy to enforce the use of allowed images. The policy evaluates whether a pod definition in Kubernetes uses an image matching a certain regular expression. This policy is a configuration within the cluster itself, and doesn't interact with the Azure API.

The first set of policies works against the Azure API itself. The second set of policies interacts with the Kubernetes API. To apply and enforce these built-in security policies, you need to set up the Azure Policy add-on for AKS in your AKS cluster.

## Understanding how Azure Policy for AKS works under the covers

To enforce policies on top of the Kubernetes API, Azure Policy for Kubernetes makes use of many tools: namely admission webhooks, Open Policy Agent (OPA), Gatekeeper, and finally an Azure Policy pod.

Azure Policy uses admission webhooks in Kubernetes. Admission webhooks are a built-in functionality of the Kubernetes API. They allow the Kubernetes API to call an external webhook to validate if a request to create, delete, modify, or connect to a resource should be allowed or denied (`ValidatingAdmissionWebhook`); or if the request should be changed (`MutatingAdmissionWebhook`).

Open Policy Agent (OPA) is an open-source policy engine. Gatekeeper integrates policy evaluation with Kubernetes admission and audits existing Kubernetes objects.

A Kubernetes-mode Azure Policy definition identifies the Kubernetes resource types it evaluates and references or embeds a constraint template containing validation logic. The Azure Policy add-on retrieves the applicable assignments, installs the templates and parameterized constraints, and reports compliance to Azure Policy. For this module's allowed-images built-in, the referenced template uses Rego to compare Pod container image references with the configured regular expression.

This isn't automatic translation of arbitrary Azure resource-policy JSON into Rego. Current add-on versions also support Common Expression Language (CEL)-based validation for applicable policies; the template referenced by the chosen definition determines the implementation. For more information, see Azure Policy for Kubernetes.
