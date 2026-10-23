You now have a deployment and operations model for AKS on Azure Local in Contoso's hyperconverged environment. You distinguish the local infrastructure, the Azure management surface, and the Kubernetes resources that run applications.

## Key takeaways

- Arc resource bridge, the AKS extension, a custom location, and a logical network provide the infrastructure foundation for cluster provisioning.
- Use a management workstation with supported tools and delegated access.
- Azure CLI cluster creation automatically enables Azure Arc. Keep a Linux node pool available for the Arc agents and verify their health.
- Azure management permissions, Microsoft Entra authentication, and Kubernetes authorization are separate considerations.
- OS selectors constrain pod placement. Tolerations permit scheduling onto matching tainted nodes but don't select those nodes by themselves.
- Persistent volume claims request storage from a suitable class. Reclaim policies and backups determine how you protect the data throughout its lifecycle.
- Windows workloads require compatible images, prepared node pools, appropriate licensing, and a verified identity design. Check the documented gMSA restrictions for the target release before approving an AD DS-dependent workload.

Before you expand Contoso's deployment, test representative applications in a nonproduction environment. Verify access, scheduling, storage persistence, application authentication, and recovery behavior.

## Learn more

- [AKS on Azure Local architecture](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture)
- [Create Kubernetes clusters using Azure CLI](/azure/aks-hybrid-edge/local/aks-create-clusters-cli)
- [Create logical networks](/azure/aks-hybrid-edge/local/hyperconverged/aks-networks)
- [Storage options for applications](/azure/aks-hybrid-edge/local/hyperconverged/concepts-storage)
- [Create a Windows node pool](/azure/aks-hybrid-edge/local/hyperconverged/howto-create-windows-node-pools)
- [Get on-demand logs](/azure/aks-hybrid-edge/local/hyperconverged/get-on-demand-logs)
