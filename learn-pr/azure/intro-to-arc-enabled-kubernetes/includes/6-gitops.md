One of the primary benefits of Azure Arc is facilitating implemenation of DevOps principles that apply established development practices to operations. This results in improved agility, without jeopardizing the stability of IT environment. One way to promote DevOps principles is to implement GitOps, which streamline releases of new versions of applications by eliminating the manual effort involved in their deployment. Azure Arc enabled Kubernetes clusters offer support for GitOps. In this unit you'll learn what is GitOps and how to configure it. <!--Marcin: I added this sentence, ok?--> 

## What is GitOps?

GitOps is a DevOps practice that relies on a Git repository to store a code or configuration representing the current state of a resource external to the repository. An approved change to this repository leads automatically to an update of the corresponding resource.

In the context of Azure Arc enabled Kubernetes clusters, a Git repository hosts a configuration of a Kubernetes cluster, including its resources such as pods and deployments. A pod or a set of pods running on the cluster polls the status of the repository and, once it detects a change, it pulls and applies the new configuration to the cluster. 

Azure Arc enabled Kubernetes clusters rely on Flux, an open source GitOps deployment tool to implement the pods responsible for tracking changes to the Git repository you designate and applying them to the local cluster. In addition, the containerized Flux operator also periodically review the existing cluster configuration to ensure that it matches the one residing in the Git repository. In case of a configuration drift, the Flux agent remediates it by reapplying the desired configuration. 

GitOps simplifies standardizing Kubernetes configuration across your organization. You can define a baseline configuration that you want to apply to every cluster and its components, including, for example, the delegation model, monitoring and logging settings, as well as characteristics of cluster-wide services.

## How to configure GitOps?

GitOps associates your Kubernetes cluster with one or more Git repositories, where each of them can describe different aspects of cluster configuration. Each Git repository can contain configuration of any valid Kubernetes resources, such as namespaces or deployments in the form of manifest files. It is possible to use for this purpose Helm charts, which facilitates deployment of applications. 

> [!NOTE] 
> When using Helm charts, the Flux operator interacts with the containerized Helm operator to deploy packaged applications. 

> [!NOTE] 
> For examples of manifest files illustrating configuration of Azure Arc enabled Kubernetes clusters, refer to [the official, Microsoft-curated GitHub repository](https://github.com/Azure/arc-k8s-demo). <!--Marcin: is this an ancillary portal? If yes, please add '?azure-portal=true' at the end of the URL, please. If not, you would have to remove it from here, please.-->

:::image type="content" source="../media/arc_enabled_k8s_gitops.png" alt-text="A graphic depicts the process of applying GitOps-based configuration to multiple Azure Arc enabled clusters." border="false":::  <!--Marcin: please include the unit number in the title for your graphic. In which unit is the other graphic safed in the media folder?-->

Each association between an Azure Arc enabled Kubernetes cluster configuration and the corresponding GitOps repository resides in Azure, as part of the Azure Resource Manager resource representing the Azure Arc enabled Kubernetes clusters. You can configure that association via traditional Azure management interfaces, such as the Azure portal or Azure CLI. Alternatively, you can use for this purpose Azure Policy, which automates this process, allowing you to apply it consistently to all resources in entire subscription or indiviual resource groups you designate.

To create an Azure Policy assignment in the Azure portal, you would use the following sequence of high-level steps:

1. In the Azure portal, from the blade displaying Azure policy definitions, search for the **Deploy GitOps to Kubernetes cluster** built-in policy. To speed up the search by filtering the list of policy definitions based on the **Kubernetes** category.
1. Create a policy assignment by specifying the following settings:

- Set the scope to the management group, subscription, or resource group where the policy assignment will apply.
- Optionally, specify an exclusion to designate a sub-scope of resources where the policy should not apply.
- Enable policy enforcement.
- Set values of the **sourceControlConfiguration** parameter, representing the association between Git repositories and configuration of the corresponding components of the Azure Arc enabled Kubernetes cluster.
- Create a remediation task and enable the **Create a managed identity** option. Verify that the identity will have Contributor permissions. 

The policy definition automatically applies the GitOps-based configuration to each Azure Arc enabled Kubernetes cluster you create, as long as its Azure Resource Manager resoure is in the scope of the assignment. For existing clusters, you need to manually run the remediation task. The policy assignment typically takes effect within 20 minutes from the time you create it. 

Choose the best response for each of the following questions. Then select "Check your answers".
