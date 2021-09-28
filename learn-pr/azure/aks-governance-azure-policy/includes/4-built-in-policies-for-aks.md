- How to find built-in policies for AKS, and provide links to documentation
    - Explain cluster policy, like authorized ip ranges for example.
    - Explain workload policy, like only allow trusted registry
- Explain the two secure baseline initiatives

Now that you created an Azure Kubernetes Service cluster with the policy add-on enabled, you'll need to find the policy definitions that you want to assign to your environment. In this section you'll learn how to discover policies and the next section will walk you through an example on how to assign those policies.

## Discovering built-in Azure policies for Kubernetes

There are two way to discover built-in Azure policies for Kubernetes:

1. [By using the Azure documentation](/azure/governance/policy/samples/built-in-policies), which details the built-in policies.
2. By using the [Azure policy blade in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Definitions), going to definitions and filtering on category Kubernetes.

You can assign one or multiple of these policy definitions to your management groups, subscriptions or resource groups. In the next unit, you will follow an exercise that will walk you through how to do that.

## Policy initiative: Kubernetes cluster pod security baseline standards for Linux-based workloads

Azure Policy for Kubernetes also has two policy initiatives. A policy initiative is a collection of policy definitions. The two initiatives for Kubernetes are:

- Kubernetes cluster pod security baseline standards for Linux-based workloads
- Kubernetes cluster pod security restricted standards for Linux-based workloads

The [baseline version](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Kubernetes/Kubernetes_PSPBaselineStandard.json) includes five policy definitions focused on providing a security baseline for your Kubernetes workloads. The [restricted version](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Kubernetes/Kubernetes_PSPRestrictedStandard.json) includes a total of eight policy definitions for more security restricted environments. 

You can assign these initiatives to your Azure Management groups, Subscriptions or Resource groups with an AKS cluster to enforce a consistent security baseline.