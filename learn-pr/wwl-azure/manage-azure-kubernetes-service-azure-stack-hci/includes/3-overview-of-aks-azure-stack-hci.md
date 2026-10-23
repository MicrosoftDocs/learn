Contoso needs to manage Kubernetes from Azure while its containerized workloads run in its datacenter. AKS on Azure Local uses Azure Arc and the local infrastructure to meet both requirements.

## Understand the infrastructure components

For hyperconverged deployments, AKS uses **Azure Arc resource bridge** as the orchestration interface between Azure and the local platform. The AKS cluster extension provides the on-premises functionality required to manage Kubernetes clusters from Azure.

A **custom location** identifies the local deployment target. It isn't an Azure region or a Kubernetes namespace, although Azure tools use it to target resources to your datacenter. An AKS logical network supplies the network configuration and address allocation for the cluster's underlying virtual machines.

Your infrastructure administrator prepares these components as part of the Azure Local environment.

| Component | Responsibility |
| --- | --- |
| Azure Local infrastructure | Provide the local compute, networking, storage, and virtualization platform. |
| Arc resource bridge and AKS extension | Coordinate Azure-based provisioning and management of local AKS resources. |
| Custom location | Identify the local target for deploying the AKS cluster. |
| AKS cluster control plane | Expose the Kubernetes API and coordinate the cluster's desired state. |
| Worker node pools | Run application pods on the appropriate operating system and VM configuration. |

## Understand cluster and node-pool responsibilities

An AKS cluster contains Linux control plane nodes and worker node pools. A node pool groups nodes with a common configuration. Linux pools run Linux containers, and optional Windows pools run compatible Windows containers.

Keep at least one Linux node pool available to host the Azure Arc agents and maintain connectivity with Azure. A Windows application doesn't remove this Linux infrastructure requirement.

AKS on Azure Local automatically enables Azure Arc on clusters created through its supported provisioning workflow. You use Azure tools to manage the cluster resource and Kubernetes tools to manage application resources.

Your organization remains responsible for capacity planning, local platform maintenance, application access, data protection, and workload availability.

## Plan lifecycle management

Azure Local solution updates include its AKS infrastructure components. Plan workload-cluster Kubernetes upgrades and node-pool changes separately, using the supported AKS management operations. An infrastructure update doesn't automatically upgrade every workload cluster to the latest Kubernetes release.

Before you make a change, check the supported release and version combinations, available capacity, application compatibility, and recovery requirements. Test applications during representative node maintenance and pod rescheduling.

Check each layer separately:

- Is the underlying Azure Local environment healthy and supported?
- Are the resource bridge, AKS extension, custom location, and logical network ready?
- Is the workload cluster on a supported Kubernetes version?
- Do the node images, storage configuration, and application dependencies support the intended workload?

See [AKS on Azure Local architecture](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture) for the current architecture and infrastructure lifecycle model.
