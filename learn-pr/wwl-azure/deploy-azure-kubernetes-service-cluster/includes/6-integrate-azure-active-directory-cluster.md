Securing access to and from the cluster is critical. Think from the cluster's perspective when you're making security choices:

 -  **Inside-out access**. AKS access to Azure components such as networking infrastructure, Azure Container Registry, and Azure Key Vault. Authorize only those resources that the cluster is allowed access.
 -  **Outside-in access**. Providing identities access to the Kubernetes cluster. Authorize only those external entities that are allowed access to the Kubernetes API server and Azure Resource Manager.

### AKS access to Azure

There are two ways to manage AKS to Azure access through Azure Active Directory (Azure AD): *service principals* or *managed identities for Azure resources*.

Of the two ways, managed identities are recommended. With service principals, responsibility for managing and rotating secrets, either manually or programmatically. With managed identities, Azure AD manages and performs the authentication and timely rotation of secrets for you.

It's recommended that managed identities are enabled so that the cluster can interact with external Azure resources through Azure AD. You can enable this setting only during cluster creation. Even if Azure AD isn't used immediately, you can incorporate it later.

By default, there are two primary identities used by the cluster, the *cluster identity* and the *kubelet identity*. The *cluster identity* is used by the AKS control plane components to manage cluster resources including ingress load balancers, AKS managed public IPs, etc. The *kubelet identity* is used to authenticate with Azure Container Registry (ACR). Some add-ons also support authentication using a managed identity.

As an example for the inside-out case, let's study the use of managed identities when the cluster needs to pull images from a container registry. This action requires the cluster to get the credentials of the registry. One way is storing information in Kubernetes Secrets objects and using `imagePullSecrets` to retrieve the secret. That approach isn't recommended because of security complexities. Not only do you need prior knowledge of the secret but also disclosure of that secret through the DevOps pipeline. Another reason is the operational overhead of managing the rotation of the secret. Instead, grant acrPull access to the kubelet managed identity of the cluster to your registry. This approach addresses those concerns.

In this architecture, the cluster accesses Azure resources are secured using Azure AD and perform operations that support managed identities. Assign Azure role-based access control (Azure RBAC) and permissions to the cluster's managed identities, depending on the operations that the cluster intends to do. The cluster authenticates itself to Azure AD and then it's allowed or denied access based on the roles it has been assigned. Here are some examples from this reference implementation where Azure built-in roles have been assigned to the cluster:

 -  [Network Contributor](/azure/role-based-access-control/built-in-roles#network-contributor). The cluster's ability to control the spoke virtual network. This role assignment allows AKS cluster system assigned identity to work with the dedicated subnet for the Internal Ingress Controller services.
 -  [Monitoring Metrics Publisher](/azure/role-based-access-control/built-in-roles#monitoring-metrics-publisher). The cluster's ability to send metrics to Azure Monitor.
 -  [AcrPull](/azure/role-based-access-control/built-in-roles#acrpull). The cluster's ability to pull images from the specified Azure Container Registries.

### Cluster access

Azure AD integration also simplifies security for outside-in access. Suppose a user wants to use kubectl. As an initial step, they run the az aks get-credentials command to get the credentials of the cluster. Azure AD authenticates the user's identity against the Azure roles that are allowed to get cluster credentials.

AKS allows for Kubernetes access using Azure Active Directory in two ways. The first is using Azure Active Directory as an identity provider integrated with the native Kubernetes RBAC system. The other is using native Azure RBAC to control cluster access.
