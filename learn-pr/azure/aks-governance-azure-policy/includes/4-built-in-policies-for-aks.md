Now that you created an Azure Kubernetes Service (AKS) cluster with the policy add-on enabled, you need to find the policy definitions that you want to assign to your environment. In this section, you learn how to discover policies and in the next section you walk through an example of how to assign those policies.

Find links to the policy definitions and documentation mentioned in this unit in the summary unit's **More info** section.

## Types of Azure policies for AKS

There are two types of Azure policies that can be applied to AKS: cluster policies or workload policies.

Cluster policies cover the cluster itself, not the workload running on the cluster. You'd configure these policies to enforce cluster configuration. Examples of these policies include **Authorized IP ranges should be defined on Kubernetes Services** and **Role-Based Access Control (RBAC) should be used on Kubernetes Services**.

Workload policies cover the applications running in your cluster. Workload policies are used to enforce configuration inside the Kubernetes cluster. These policies rely on the Azure Policy for Kubernetes add-on to function correctly. Examples of these policies include **Kubernetes cluster containers should only use allowed images** and **Kubernetes cluster pods should only use allowed volume types**.

It's useful to think about the Azure policies for Kubernetes this way: They allow you to distinguish between policies impacting the cluster versus the application running on the cluster. It's worth noting that these different policy types aren't distinguished during the policy discovery.

## Discovering built-in Azure policies for Kubernetes

There are two ways to discover built-in Azure policies for Kubernetes:

- Use the Built-in Azure Policy definitions documentation, which details the built-in policies.
- In the Azure portal, open **Policy**, select **Definitions**, and filter on the **Kubernetes** category.

You can assign one or multiple of these policy definitions to your management groups, subscriptions, or resource groups. In the next unit, you'll walk through an exercise to do that.

## Policy initiative: Kubernetes cluster pod security baseline standards for Linux-based workloads

Azure Policy for Kubernetes also has multiple policy initiatives. A policy initiative is a collection of policy definitions. Two of the initiatives for Kubernetes are:

- Kubernetes cluster pod security baseline standards for Linux-based workloads
- Kubernetes cluster pod security restricted standards for Linux-based workloads

The baseline version includes five policy definitions focused on providing a security baseline for your Kubernetes workloads. The restricted version includes a total of eight policy definitions for environments with stricter security requirements.

You can assign these initiatives to your Azure management groups, subscriptions, or resource groups with an AKS cluster to enforce a consistent security baseline.
