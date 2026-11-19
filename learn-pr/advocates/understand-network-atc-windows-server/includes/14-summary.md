Network ATC manages host-networking intent and reconciles supported configuration. Its value is consistent policy across hosts, not the elimination of network design or workload testing.

You connected the declaration to the generated resources, distinguished local and cluster ownership, and used Hyper-V and SMB to evaluate the resulting data paths. You also separated typed exceptions from drift and intent removal from actual recovery.

Apply the following operational rules.

- Choose convergence from isolation, capacity, and failure requirements.
- Prepare symmetric hosts and the physical fabric before submitting an intent.
- Keep management, guest, storage, and endpoint addressing ownership explicit.
- Change ATC-owned settings through supported intent operations.
- Require every expected node and the actual workload path to pass acceptance.
- Preserve evidence and dependencies before adoption, servicing, or retirement.
- Treat missing status, failed queries, and retained resources according to their meaning rather than hiding them.

A production handoff should make the accepted state and recovery route explicit.

| Handoff item | Required result |
|---|---|
| Desired configuration | Approved roles, adapters, VLANs, addressing, and exceptions |
| Effective state | Consistent host resources and required status across every expected node |
| Workload evidence | Verified management, guest, SMB/RDMA, and migration behavior |
| Monitoring | Visible sustained failures, missing nodes, and significant changes |
| Recovery | Protected evidence, known-good reconstruction steps, and independent access |

## More info

Use the following Microsoft references for Windows Server 2025 command syntax, supported behavior, and related networking details.

- [Deploy host networking with Network ATC](/windows-server/networking/network-atc/network-atc)
- [Manage Network ATC](/windows-server/networking/network-atc/manage-network-atc)
- [NetworkATC PowerShell reference](/powershell/module/networkatc/?view=windowsserver2025-ps&preserve-view=true)
- [Add-NetIntent](/powershell/module/networkatc/add-netintent?view=windowsserver2025-ps&preserve-view=true)
- [Set-NetIntent](/powershell/module/networkatc/set-netintent?view=windowsserver2025-ps&preserve-view=true)
- [Remove-NetIntent](/powershell/module/networkatc/remove-netintent?view=windowsserver2025-ps&preserve-view=true)
- [Global cluster overrides](/powershell/module/networkatc/new-netintentglobalclusteroverrides?view=windowsserver2025-ps&preserve-view=true)
- [Update-NetIntentAdapter](/powershell/module/networkatc/update-netintentadapter?view=windowsserver2025-ps&preserve-view=true)
- [Update-NetIntentType](/powershell/module/networkatc/update-netintenttype?view=windowsserver2025-ps&preserve-view=true)
- [Update-NetworkATC](/powershell/module/networkatc/update-networkatc?view=windowsserver2025-ps&preserve-view=true)
- [SMB Direct](/windows-server/storage/file-server/smb-direct)
- [Hyper-V PowerShell reference](/powershell/module/hyper-v/?view=windowsserver2025-ps&preserve-view=true)
- [Set-VMHost](/powershell/module/hyper-v/set-vmhost?view=windowsserver2025-ps&preserve-view=true)
- [FailoverClusters PowerShell reference](/powershell/module/failoverclusters/?view=windowsserver2025-ps&preserve-view=true)
- [Add-ClusterNode](/powershell/module/failoverclusters/add-clusternode?view=windowsserver2025-ps&preserve-view=true)
- [Get-Cluster](/powershell/module/failoverclusters/get-cluster?view=windowsserver2025-ps&preserve-view=true)
- [Get-ClusterLog](/powershell/module/failoverclusters/get-clusterlog?view=windowsserver2025-ps&preserve-view=true)
- [Move-ClusterVirtualMachineRole](/powershell/module/failoverclusters/move-clustervirtualmachinerole?view=windowsserver2025-ps&preserve-view=true)
- [VM load balancing for Windows Server clusters](/azure/azure-local/manage/vm-load-balancing?view=azloc-2610&preserve-view=true)
- [NetTCPIP PowerShell reference](/powershell/module/nettcpip/?view=windowsserver2025-ps&preserve-view=true)
- [DnsClient PowerShell reference](/powershell/module/dnsclient/?view=windowsserver2025-ps&preserve-view=true)
- [Live migration without failover clustering](/windows-server/virtualization/hyper-v/deploy/set-up-hosts-for-live-migration-without-failover-clustering)
- [Credential Guard overview](/windows/security/identity-protection/credential-guard/)
- [Credential Guard considerations and known issues](/windows/security/identity-protection/credential-guard/considerations-known-issues)
- [Network Direct driver requirements](/windows-hardware/drivers/network/inf-requirements-for-ndkpi)
- [Configure IPv6 in Windows](/troubleshoot/windows-server/networking/configure-ipv6-in-windows)
- [Microsoft architecture icon guidance](/azure/architecture/icons/)

The host-network reference also covers Azure Local. Use its RDMA/DCB traffic discussion alongside the Windows Server Network ATC guidance, without treating Azure Local-specific deployment requirements as Windows Server requirements. The cluster-network reference supports the live-migration selection check, not replacement of ATC-managed networking with its manual configuration examples.

- [Host RDMA and DCB traffic considerations](/azure/azure-local/concepts/host-network-requirements?view=azloc-2610&preserve-view=true#rdma-traffic-considerations)
- [Get-NetAdapterQos](/powershell/module/netadapter/get-netadapterqos?view=windowsserver2025-ps&preserve-view=true)
- [DCBx willingness behavior](/powershell/module/dcbqos/set-netqosdcbxsetting?view=windowsserver2025-ps&preserve-view=true)
- [Clustered live-migration network selection](/windows-server/virtualization/hyper-v/failover-cluster-network-recommendations#isolate-traffic-on-the-live-migration-network)
- [Get-ClusterResourceType](/powershell/module/failoverclusters/get-clusterresourcetype?view=windowsserver2025-ps&preserve-view=true)
- [Get-ClusterParameter](/powershell/module/failoverclusters/get-clusterparameter?view=windowsserver2025-ps&preserve-view=true)
