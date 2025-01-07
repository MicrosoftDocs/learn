Azure Policy is an Azure service that helps you manage your compliance state across different Azure services. Azure Policy for Kubernetes enables you to use the same Azure policies in your Kubernetes clusters, allowing you to manage the compliance state of Kubernetes resources like pods, deployments, and services as if they were an Azure resource.

## Introducing Azure Policy

Azure Policy allows you to manage the compliance state of your Azure services. It works by comparing the state of your Azure resources to business rules you define. Common rules are the limitation of certain regions, the requirement for resource tags or limiting which Azure services can be used.

The way you define these business rules in Azure policy is by using policy definitions. There are many built-in policies that cover a range of common scenarios. If one of the built-in policies doesn't meet your needs, you can also define a custom policy using a JSON-based language. You can also group multiple policy definitions together into an initiative.

In a policy definition, you define a resource compliance condition and the effect that should be taken if that condition is met. A condition compares a resource's properties to a required value. An example of a condition could be comparing the location of a resource versus a predefined list of allowed locations. The effect of a policy can be auditing the condition, denying the resource's creation, or modifying the created resource. In the example of the location of a resource, you could deny the creation of resources not in the list of allowed locations. For a more detailed explanation of policy definitions, refer to the [Azure Policy definition structure](/azure/governance/policy/concepts/definition-structure).

Azure Policy works by assigning a policy definition or an initiative to a specific *scope*. A scope can be either a management group, a subscription, or a resource group. Policy assignments are automatically inherited to all scopes underneath the assignment, unless you make an exclusion. Multiple policy definitions can apply to a certain scope. The net result of layering policy definitions is considered to be *cumulative most restrictive*: If multiple policies apply to a certain resource, that resource is only compliant if all policy definitions applying to it are compliant.

Policy assignments are evaluated during the creation or update of Azure resources. They're also evaluated if the definition or scope is changed, and periodically for continuous monitoring. Practically, the policy immediately takes effect when you create new resources. Any historical resources are also scanned, so you get a continuous view on the compliance of all your resources.

## Integration of Azure Policy with AKS

There are two ways in which Azure Policy integrates with Azure Kubernetes Service (AKS).

- Policies that enforce compliance on the Azure control plane for AKS.
- Policies that enforce compliance on the workload running in your cluster.

The first set of policies is focused more on the Azure resources that represent the cluster design, whereas the second set of policies is focused on workloads running within the cluster.

An example Policy focused on the Azure control plane for AKS is the policy to [enforce the use of private clusters](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/AKS_PrivateCluster_Deny.json). The policy evaluates whether or not an AKS cluster is using the private cluster functionality. This policy is a configuration on the Azure API that controls the design of the cluster itself.

An example of the set of policies focused on the workload running in your cluster is the policy to [enforce the use of allowed images](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerAllowedImages.json). The policy evaluates whether a pod definition in Kubernetes uses an image matching a certain regular expression. This policy is a configuration within the cluster itself, and doesn't interact with the Azure API.

The first set of policies works against the Azure API itself. The second set of policies interacts with the Kubernetes API. To apply and enforce these built-in security policies, you need to set up the [Azure Policy add-on for AKS](/azure/aks/use-azure-policy) in your AKS cluster.

## Understanding how Azure Policy for AKS works under the covers

To enforce policies on top of the Kubernetes API, Azure Policy for Kubernetes makes use of many tools: namely admission webhooks, Open Policy Agent (OPA), Gatekeeper, and finally an Azure Policy pod.

Azure Policy uses [admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) in Kubernetes. Admission webhooks are a built-in functionality of the Kubernetes API. They allow the Kubernetes API to call an external webhook to validate if a request to create, delete, modify, or connect to a resource should be allowed or denied (`ValidatingAdmissionWebhook`); or if the request should be changed (`MutatingAdmissionWebhook`).

[Open Policy Agent (OPA)](https://www.openpolicyagent.org/) is an open-source policy engine. OPA provides a high-level language to define policies in. You can use OPA to enforce policies in your own microservices, in CI/CD pipelines, and in Kubernetes. Azure policy for Kubernetes translates Azure policies into the OPA language to be deployed on your Kubernetes cluster.

[OPA Gatekeeper](https://www.openpolicyagent.org/docs/latest/kubernetes-introduction/) is a Kubernetes specific implementation of OPA that integrates with the Kubernetes API. It integrates with the admission webhooks introduced earlier. Rather than having to deploy your own webhook handlers, you can use OPA gatekeeper to service the admission webhook responses. Azure Policy for Kubernetes deploys OPA Gatekeeper on your Kubernetes cluster to achieve this functionality.

