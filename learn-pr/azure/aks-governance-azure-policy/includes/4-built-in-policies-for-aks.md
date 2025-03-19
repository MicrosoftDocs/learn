Now that you created an Azure Kubernetes Service (AKS) cluster with the policy add-on enabled, you need to find the policy definitions that you want to assign to your environment. In this section, you learn how to discover policies and in the next section you walk through an example of how to assign those policies.

## Types of Azure Policies for AKS

There are two types of Azure Policies that can be applied to AKS: cluster policies or workload policies.

Cluster policies cover the cluster itself, not the workload running on the cluster. You would configure these policies to enforce cluster configuration. Examples of these policies include [Authorized IP ranges should be defined on Kubernetes Services](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0e246bcf-5f6f-4f87-bc6f-775d4712c7ea) and [Role-Based Access Control (RBAC) should be used on Kubernetes Services](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fac4a19c2-fa67-49b4-8ae5-0b2e78c49457).

Workload policies cover the applications running in your cluster. Workload policies are used to enforce configuration inside the Kubernetes cluster. These policies rely on the Azure policy for Kubernetes add-on to function correctly. Examples of these policies include [Kubernetes cluster containers should only use allowed images](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Ffebd0533-8e55-448f-b837-bd0e06f16469) and [Kubernetes cluster pods should only use allowed volume types](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F16697877-1118-4fb1-9b65-9898ec2509ec). 

It's useful to think about the Azure policies for Kubernetes this way: They allow you to distinguish between policies impacting the cluster versus the application running on the cluster. It's worth noting that these different policy types aren't distinguished during the policy discovery.

## Discovering built-in Azure policies for Kubernetes

There are two ways to discover built-in Azure policies for Kubernetes:

- Use the [Azure documentation](/azure/governance/policy/samples/built-in-policies), which details the built-in policies.
- Use the [Azure policy blade in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Definitions), go to **definitions**, and filter on the category *Kubernetes*.

You can assign one or multiple of these policy definitions to your management groups, subscriptions, or resource groups. In the next unit, you follow an exercise that will walk you through how to do that.

## Policy initiative: Kubernetes cluster pod security baseline standards for Linux-based workloads

Azure Policy for Kubernetes also has multiple policy initiatives. A policy initiative is a collection of policy definitions. Two of the initiatives for Kubernetes are:

- Kubernetes cluster pod security baseline standards for Linux-based workloads
- Kubernetes cluster pod security restricted standards for Linux-based workloads

The baseline version includes five policy definitions focused on providing a security baseline for your Kubernetes workloads. The restricted version includes a total of eight policy definitions for more security restricted environments.

You can assign these initiatives to your Azure Management groups, Subscriptions, or Resource Groups with an AKS cluster to enforce a consistent security baseline.
