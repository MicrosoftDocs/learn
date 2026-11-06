You now have a deployment and operations model for AKS on Azure Local in Contoso's hyperconverged environment. You distinguish the local infrastructure, the Azure management surface, and the Kubernetes resources that run applications, and you plan how to maintain and recover those workloads.

## Key takeaways

Keep the following deployment and operations principles in mind:

- Arc resource bridge, the AKS extension, a custom location, and a logical network provide the infrastructure foundation for cluster provisioning.
- Use a management workstation with supported tools and delegated access. Check network capacity, version availability, and OS-image readiness before provisioning.
- Azure CLI cluster creation automatically enables Azure Arc. Keep a Linux node pool available for the Arc agents and verify their health.
- Azure management permissions, Microsoft Entra authentication, and Kubernetes authorization are separate considerations. Choose creation-time identity capabilities before provisioning and check applicable preview limitations.
- Configure taints through node-pool management. OS selectors constrain pod placement, while tolerations permit scheduling onto matching tainted nodes without selecting those nodes by themselves.
- Verify that the persistent volume claim is `Bound` and the consuming pod is ready, then test a known file across pod replacement. Inspect the bound volume's reclaim policy before optional cleanup.
- A persistence check isn't a backup test. Plan application-consistent protection, restore into isolated test resources, verify the restored application data, and measure recovery time.
- Windows workloads require compatible images, ready node pools, appropriate licensing, and a verified identity design. Test an application response as well as pod readiness, and check the documented gMSA restrictions for the target release.
- Before updating Azure Local, establish a supported, sequential Kubernetes upgrade path for every workload cluster. Infrastructure updates don't upgrade workload-cluster Kubernetes versions.
- If the Arc proxy fails, distinguish Azure's reported connection status from live cluster health. IP-based log collection requires current node addresses, the correct SSH key, and permitted direct node connectivity.
- For optional monitoring, verify both collection health and fresh data at the destination, then test the alert notification. Automatic Arc connection alone doesn't configure the monitoring solution.

Before you expand Contoso's deployment, test representative applications in a nonproduction environment. Verify access, scheduling, storage persistence, application authentication, maintenance behavior, and recovery. Remove sample resources only after confirming that no required workloads or data depend on them.

## More info

These references support the procedures, support requirements, and limitations discussed throughout this module.

### Architecture, deployment, and servicing

Use these references to review the platform, deployment prerequisites, and supported maintenance procedures:

- [AKS on Azure Local architecture](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture)
- [Azure CLI aksarc reference](/cli/azure/aksarc)
- [Create Kubernetes clusters using Azure CLI](/azure/aks-hybrid-edge/local/aks-create-clusters-cli)
- [Azure portal deployment prerequisites](/azure/aks-hybrid-edge/local/aks-create-clusters-portal)
- [Create logical networks](/azure/aks-hybrid-edge/local/hyperconverged/aks-networks)
- [Network requirements](/azure/aks-hybrid-edge/local/hyperconverged/network-system-requirements)
- [IP address planning](/azure/aks-hybrid-edge/local/hyperconverged/aks-hci-ip-address-planning)
- [Kubernetes version readiness guidance](/azure/aks-hybrid-edge/local/hyperconverged/cluster-k8s-version)
- [Supported Kubernetes versions](/azure/aks-hybrid-edge/supported-kubernetes-versions)
- [AKS on Azure Local support policy](/azure/aks-hybrid-edge/local/hyperconverged/aks-on-azure-local-support-policy)
- [Upgrade an AKS cluster](/azure/aks-hybrid-edge/local/hyperconverged/cluster-upgrade)
- [Kubernetes version skew policy](https://kubernetes.io/releases/version-skew-policy/#kubectl)
- [Plan application disruption with PodDisruptionBudgets](https://kubernetes.io/docs/tasks/run-application/configure-pdb/)

### Identity, Azure Arc, and diagnostics

Use these references to configure authorization, verify Arc connectivity, and collect diagnostic evidence:

- [Azure Arc-enabled Kubernetes overview](/azure/azure-arc/kubernetes/overview)
- [Control access using Microsoft Entra ID and Kubernetes RBAC](/azure/aks-hybrid-edge/local/hyperconverged/kubernetes-rbac-local)
- [Use Azure RBAC for Kubernetes authorization](/azure/aks-hybrid-edge/local/hyperconverged/azure-rbac-local)
- [Workload identity preview terms](/azure/aks-hybrid-edge/local/hyperconverged/workload-identity)
- [Azure Arc-enabled Kubernetes Cluster User role](/azure/role-based-access-control/built-in-roles/containers#azure-arc-enabled-kubernetes-cluster-user-role)
- [Arc connectivity statuses](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#connectivity-status)
- [Diagnose a failed Arc proxy](/training/modules/manage-azure-kubernetes-service-azure-stack-hci/10-troubleshoot#diagnose-a-failed-arc-proxy)
- [Node-IP log collection procedure](/training/modules/manage-azure-kubernetes-service-azure-stack-hci/10-troubleshoot#preserve-keys-and-collect-support-logs)
- [Get on-demand logs](/azure/aks-hybrid-edge/local/hyperconverged/get-on-demand-logs)
- [Connect to Windows or Linux worker nodes with SSH](/azure/aks-hybrid-edge/local/hyperconverged/ssh-connect-to-windows-and-linux-worker-nodes)

### Scheduling, storage, and recovery

Use these references to plan workload placement, persistent storage, and application recovery:

- [Kubernetes namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
- [AKS on Azure Local node-pool taints](/azure/aks-hybrid-edge/local/hyperconverged/aks-arc-use-node-taints)
- [Kubernetes taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
- [Storage options for applications](/azure/aks-hybrid-edge/local/hyperconverged/concepts-storage)
- [Disk CSI configuration and Linux filesystem guidance](/azure/aks-hybrid-edge/local/hyperconverged/container-storage-interface-disks)
- [SMB or NFS CSI drivers](/azure/aks-hybrid-edge/local/hyperconverged/container-storage-interface-files)
- [Azure Local recovery options](/azure/azure-local/manage/disaster-recovery-vm-resiliency#backup-tools)

### Windows workloads

Use these references to prepare, validate, and maintain supported Windows workloads:

- [Mixed-OS deployments](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture#mixed-os-deployments)
- [Enable Windows node pools](/azure/aks-hybrid-edge/local/hyperconverged/howto-enable-windows-node-pools)
- [Create a Windows node pool](/azure/aks-hybrid-edge/local/hyperconverged/howto-create-windows-node-pools)
- [Windows container compatibility matrix](/virtualization/windowscontainers/deploy-containers/version-compatibility)
- [Windows Server activation and eligibility requirements](/azure/azure-local/manage/vm-activate)
- [Windows node-pool OS transition](/azure/aks-hybrid-edge/local/hyperconverged/howto-upgrade-windows-os)
- [gMSA on AKS in Azure](/azure/aks/use-group-managed-service-accounts)
- [Handling multiple Windows versions in the same cluster](https://kubernetes.io/docs/concepts/windows/user-guide/#handling-multiple-windows-versions-in-the-same-cluster)

### Monitoring and alerts

Use these references to configure optional monitoring and verify data collection and alert delivery:

- [Monitoring options for AKS on Azure Local](/azure/aks-hybrid-edge/local/hyperconverged/aks-monitor-logging)
- [Control plane metrics](/azure/aks-hybrid-edge/local/hyperconverged/control-plane-metrics)
- [Prometheus rule groups](/azure/azure-monitor/metrics/prometheus-rule-groups)
- [Prometheus alerts](/azure/azure-monitor/alerts/prometheus-alerts)
