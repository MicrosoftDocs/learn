As you manage clusters in Azure Kubernetes Service (AKS), you often need to isolate teams and workloads. AKS allows flexibility in how you run multitenant clusters and isolate resources. To maximize your investment in Kubernetes, it's important you understand AKS multi-tenancy and isolation features.

## Design clusters for multi-tenancy

Kubernetes lets you logically isolate teams and workloads in the same cluster. The goal is to provide the least number of privileges scoped to the resources each team needs. A Kubernetes Namespace creates a logical isolation boundary. Other Kubernetes features and considerations for isolation and multi-tenancy include the following areas:

 -  Best practices for cluster isolation in Azure Kubernetes Service (AKS)<br>
     -  Design clusters for multi-tenancy
         -  Scheduling
         -  Networking
         -  Authentication and authorization
         -  Containers
 -  Logically isolated clusters
 -  Physically isolated clusters

## Scheduling

*Scheduling* uses basic features like resource quotas and pod disruption budgets.

More advanced scheduler features include:<br>

 -  Taints and tolerations.<br>
 -  Node selectors.
 -  Node and pod affinity or anti-affinity.

## Networking

*Networking* uses network policies to control the flow of traffic in and out of pods.

## Authentication and authorization

*Authentication and authorization uses:*

 -  Role-based access control (RBAC).<br>
 -  Microsoft Entra integration.
 -  Pod identities.
 -  Secrets in Azure Key Vault.

## Containers

*Containers* include:

 -  The Azure Policy add-on for AKS to enforce pod security.<br>
 -  Pod security admission.
 -  Scanning images and runtime for vulnerabilities.
 -  Using App Armor or Seccomp (Secure Computing) to restrict container access to the underlying node.

## Logically isolated clusters

**Best practice guidance**: Separate teams and projects using logical isolation. Minimize the number of physical AKS clusters you deploy to isolate teams or applications.

With logical isolation, you can use a single AKS cluster for multiple workloads, teams, or environments. Kubernetes Namespaces form the logical isolation boundary for workloads and resources.

:::image type="content" source="../media/logical-isolation-7e3f58e3.png" alt-text="Diagram showing an example of logically isolated clusters.":::


Logical separation of clusters usually provides a higher pod density than physically isolated clusters, with less excess compute capacity sitting idle in the cluster. When combined with the Kubernetes cluster autoscaler, you can scale the number of nodes up or down to meet demands. This best practice approach minimizes costs by running only the required number of nodes.<br>

Kubernetes environments aren't entirely safe for hostile multitenant usage. In a multitenant environment, multiple tenants work on a shared infrastructure. If all tenants can't be trusted, you need extra planning to prevent tenants from impacting the security and service of others.<br>

Other security features, like Kubernetes RBAC for nodes, efficiently block exploits. For true security when running hostile multitenant workloads, you should only trust a hypervisor. The security domain for Kubernetes becomes the entire cluster and not an individual node.<br>

For these types of hostile multitenant workloads, you should use physically isolated clusters.<br>

## Physically isolated clusters

**Best practice guidance**: Minimize the use of physical isolation for each separate team or application deployment and use logical isolation instead.

Physically separating AKS clusters is a common approach to cluster isolation. In this isolation model, teams or workloads are assigned their own AKS cluster. While physical isolation might look like the easiest way to isolate workloads or teams, it adds management and financial overhead. With physically isolated clusters, you must maintain multiple clusters and individually provide access and assign permissions. You're also billed for each individual node.

:::image type="content" source="../media/physical-isolation-24ce5695.png" alt-text="Diagram showing an example of physically isolated clusters.":::


Physically isolated clusters usually have a low pod density. Since each team or workload has their own AKS cluster, the cluster is often over-provisioned with compute resources. Often, a few pods are scheduled on those nodes. Unclaimed node capacity can't be used for applications or services in development by other teams. These excess resources contribute to the extra costs in physically isolated clusters.<br>
