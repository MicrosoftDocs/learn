As you deploy and maintain clusters in Azure Kubernetes Service (AKS), you implement ways to manage access to resources and services. Without these controls:

 -  Accounts could have access to unnecessary resources and services.<br>
 -  Tracking credentials used to make changes can be difficult.

## Use Microsoft Entra ID

**Best practice guidance**: Deploy AKS clusters with Microsoft Entra integration. Using Microsoft Entra ID centralizes the identity management layer. Any change in user account or group status is automatically updated in access to the AKS cluster. Scope users or groups to the minimum permissions amount using Roles, ClusterRoles, or Bindings.

Your Kubernetes cluster developers and application owners need access to different resources. Kubernetes lacks an identity management solution for you to control the resources with which users can interact. Instead, you can integrate your cluster with an existing identity solution like Microsoft Entra ID, an enterprise-ready identity management solution.<br>

With Microsoft Entra integrated clusters in AKS, you create Roles or ClusterRoles defining access permissions to resources. You then bind the roles to users or groups from Microsoft Entra ID.

1. Developer authenticates with Microsoft Entra ID.<br>

2. The Microsoft Entra token issuance endpoint issues the access token.

3. The developer performs an action using the Microsoft Entra token, such as kubectl create pod.

4. Kubernetes validates the token with Microsoft Entra ID and fetches the developer's group memberships.

5. Kubernetes RBAC and cluster policies are applied.

6. The developer's request is successfully based on previous validation of Microsoft Entra group membership and Kubernetes RBAC and policies.

## Use Kubernetes role-based access control (Kubernetes RBAC)

**Best practice guidance**: Define user or group permissions to cluster resources with Kubernetes RBAC. Create roles and bindings that assign the least amount of permissions required. Integrate with Microsoft Entra ID to automatically update any user status or group membership change and keep access to cluster resources current.

In Kubernetes, you provide granular access control to cluster resources. You define permissions at the cluster level, or to specific namespaces. You determine what resources can be managed and with what permissions. You then apply these roles to users or groups with a binding. For more information about Roles, ClusterRoles, and Bindings, see Access and identity options for Azure Kubernetes Service (AKS).<br>

When `developer1@contoso.com` is authenticated against the AKS cluster, they have full permissions to resources in the finance-app namespace. In this way, you logically separate and control access to resources. Use Kubernetes RBAC with Microsoft Entra ID-integration.

## Use Azure RBAC

**Best practice guidance**: Use Azure RBAC to define the minimum required user and group permissions to AKS resources in one or more subscriptions.

There are two levels of access needed to fully operate an AKS cluster:<br>

1.  This access level allows you to:
     -  Control scaling or upgrading your cluster using the AKS APIs.
     -  Pull your kubeconfig.
     -  Access the AKS resource on your Azure subscription.
2.  This access level is controlled either by:
     -  Kubernetes RBAC (traditionally) or
     -  By integrating Azure RBAC with AKS for kubernetes authorization.
     -  Access to the Kubernetes API.
