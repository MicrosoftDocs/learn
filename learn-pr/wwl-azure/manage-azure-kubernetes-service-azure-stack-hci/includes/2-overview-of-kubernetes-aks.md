Contoso needs to manage a collection of containerized applications, not just start individual containers. Kubernetes provides a declarative model for describing applications and maintaining their desired state.

## Understand the Kubernetes resource model

A Kubernetes cluster consists of a **control plane** and **worker nodes**. The control plane exposes the Kubernetes API, records cluster state, and coordinates scheduling and reconciliation. Worker nodes run the containers that make up your applications. In AKS on Azure Local, control plane nodes run Linux; worker node pools can run Linux or supported Windows Server images.

A **pod** is the smallest deployable Kubernetes unit. It contains one or more related containers that share networking and can share storage. A pod isn't a virtual machine, and restarting a container or replacing a pod doesn't automatically preserve application data.

Use a **Deployment** to manage replicas of a stateless application. Its controllers create replacement pods when necessary and reconcile the number of replicas with the desired configuration. A rolling-update strategy controls how the Deployment replaces application instances. Availability still depends on replica counts, available capacity, application health, and the update settings you choose.

A **Service** provides a stable way to reach a set of pods, even when their individual addresses change. Its type determines how it exposes the application. Creating a Service doesn't by itself configure every external network or security dependency.

For stateful applications, evaluate persistent storage and workload controllers such as StatefulSets. Don't rely on a pod's writable container layer to preserve application data.

## Use declarative configuration and namespaces

Kubernetes manifests describe resources in YAML. For example, a Deployment specifies the container image, replica count, and pod configuration. You submit the manifest to the Kubernetes API, and controllers work to make the observed state match the desired state.

The `kubectl` command-line tool lets you submit manifests, inspect resources, read application logs, and investigate events. Helm packages Kubernetes manifests into charts for applications that need several related resources.

**Namespaces** organize namespaced resources within a cluster. Use separate namespaces for Contoso's development teams or environments. Namespace-scoped Kubernetes role-based access control (RBAC) limits which operations a user or service account can perform in those namespaces.

> [!IMPORTANT]
> A namespace alone isn't a complete security boundary. Configure RBAC and any required network policies, quotas, and other controls. Giving a user cluster-wide administrator permissions defeats namespace-scoped access restrictions.

For example, a development team might have permission to manage Deployments and Services in its own namespace without permission to modify another team's resources. This is different from creating another cluster, which also separates cluster-level resources and administration.

## Distinguish Kubernetes from AKS management

Kubernetes manages application resources after you establish a cluster and grant access to its API. AKS on Azure Local adds an Azure-integrated way to provision and manage Kubernetes clusters on your local infrastructure.

There are two related management surfaces:

- **Azure management:** Create or inspect the AKS resource, manage node pools, and configure Azure integrations using supported Azure tools.
- **Kubernetes management:** Deploy applications, configure Services and storage claims, and inspect pods using the Kubernetes API.

Permission on one surface doesn't automatically grant every permission on the other. An Azure user who can view a resource isn't necessarily authorized to create a Kubernetes Deployment.

Use this separation to assign infrastructure tasks to platform administrators and application tasks to development teams. It also helps you choose where to start troubleshooting: an Azure deployment error and a pod scheduling error belong to different layers.

See [AKS on Azure Local architecture](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture) and [Kubernetes namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) for more information.
