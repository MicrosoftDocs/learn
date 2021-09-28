Now that you created an Azure Kubernetes Service (AKS) cluster with the policy add-on enabled, you'll need to find the policies definitions that you want to assign to your environment. In this section you'll learn how to discover policies and the next section will walk you through an example on how to assign those policies.

## Types of Azure Policies for AKS

There are two types of Azure Policies that can be applied to AKS:

1. Cluster policies eg Authorized IP ranges
2. Workload policies eg Allow only trusted registries

## Discovering built-in Azure policies for Kubernetes

There are two way to discover built-in Azure policies for Kubernetes:

1. [By using the Azure documentation](/azure/governance/policy/samples/built-in-policies), which details the built-in policies.
2. By using the [Azure policy blade in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Definitions), going to definitions and filtering on category Kubernetes.

You can assign one or multiple of these policy definitions to your management groups, subscriptions or resource groups. In the next unit, you will follow an exercise that will walk you through how to do that.

## Policy initiative Kubernetes cluster pod security baseline standards for Linux-based workloads

Azure Policy for Kubernetes also has multiple policy initiatives. A policy initiative is a collection of policy definitions. Two fo the initiatives for Kubernetes are:

- Kubernetes cluster pod security baseline standards for Linux-based workloads
- Kubernetes cluster pod security restricted standards for Linux-based workloads

The [baseline version](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Kubernetes/Kubernetes_PSPBaselineStandard.json) includes 5 policy definitions focused on providing a security baseline for your Kubernetes workloads. The [restricted version](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Kubernetes/Kubernetes_PSPRestrictedStandard.json) includes a total of 8 policy definitions for more security restricted environments. 

You can assign these initiatives to your Azure Management groups, Subscriptions or Resource groups with an AKS cluster to enforce a consistent security baseline.