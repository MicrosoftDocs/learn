## Plan node pools and VM sizes

In Azure Kubernetes Service (AKS), each node pool maps to an Azure Virtual Machine Scale Set or to the Virtual Machines node pool type. Use separate system and user node pools so cluster services and workloads can scale and upgrade independently.

### System node pool

System node pools host critical AKS components such as CoreDNS. They must use Linux nodes, either Ubuntu or Azure Linux. The [Use system node pools in AKS](/azure/aks/use-system-pools) guidance lists system-pool requirements, including a Linux `osType` and a VM SKU with at least 4 vCPUs and 4 GB of memory. The AKS-wide [VM size restrictions](/azure/aks/quotas-skus-regions) page also lists a lower restricted-size floor — VM sizes with fewer than 2 vCPUs and 4 GB of RAM might not be used — but size system pools according to the stricter system-pools requirement. B-series VMs aren't supported for system node pools, and Av1-series VMs aren't recommended.

For dev and lab clusters, use a current-generation D-series SKU such as `Standard_D4ds_v5`. For production, choose a larger current-generation D-series SKU based on enabled system add-ons, CoreDNS replica count, and your zone strategy. Confirm the SKU is AKS-supported in the region and that quota is available.

Dedicate the system pool to critical system pods with the taint `CriticalAddonsOnly=true:NoSchedule`. The `kubernetes.azure.com/mode: system` label only prefers system pods on system pools; it doesn't isolate application workloads.

### User node pools

User node pools run application workloads. Choose current-generation v5 or later VM families that match CPU, memory, storage, and GPU requirements. Also consider regional quota and AKS-supported SKUs. If you leave the VM SKU parameter blank, AKS dynamically selects an appropriate SKU based on available regional capacity and subscription quota. This capability, called Smart VM Defaults, became generally available in May 2025; before that, the default SKU was Standard_DS2_v2. For general-purpose workloads, start with current-generation D-series sizes and use specialized families only when required. Deploy at least two nodes for high availability and use autoscaling for demand changes.

## Choose the OS disk type

AKS prefers Ephemeral OS disks when the selected VM SKU supports them and the configured OS disk size fits within supported local storage, such as NVMe, temporary/resource disk, or cache, depending on the VM SKU. When `--node-osdisk-type` isn't specified and the requested or default OS disk size doesn't fit within supported local storage for that SKU, AKS uses a managed OS disk instead. If you explicitly request `--node-osdisk-type Ephemeral` and the disk doesn't fit, node-pool creation fails validation; lower `--node-osdisk-size` or pick a SKU with enough supported local storage. For more information, see [Ephemeral OS disks for AKS nodes](/azure/aks/concepts-storage#ephemeral-os-disk). With an ephemeral OS disk, the OS disk lives on the VM cache or temporary storage, has no extra managed disk IOPS cost, and can make node creation, reimage, and upgrade operations faster. Use `--node-osdisk-type Ephemeral` in Azure CLI, or accept the portal default when it selects an ephemeral OS disk.

Since March 2025, when `--node-osdisk-size` isn't specified, AKS sizes the ephemeral OS disk to the VM's full supported local storage by default — provided that local storage is at least 128 GiB. VMs with less supported local storage fall back to a managed OS disk. For example, `Standard_D8ds_v5` (300 GiB temp storage) gets a 300 GiB ephemeral OS disk by default. Set `--node-osdisk-size` at node-pool creation if you want to leave local storage available for workloads.

When ephemeral OS disks aren't supported for the selected VM size, AKS uses a managed OS disk. The default managed OS disk size is tiered by host vCPU count: 128 GB (P10) for 1-7 vCPUs, 256 GB (P15) for 8-15 vCPUs, 512 GB (P20) for 16-63 vCPUs, and 1024 GB (P30) for 64+ vCPUs.

## Plan node capacity

### AKS reservations and allocatable resources

Don't use a fixed workload-to-platform percentage for capacity planning. AKS reserves CPU and memory on each node for system pods, the kubelet, and node reliability. CPU reservation varies by host vCPU count. On AKS 1.29 and later, memory reservation uses a formula based on the node's `maxPods` value and total memory, plus a 100 Mi eviction threshold. Windows nodes also reserve an extra 2 GB of memory outside the calculated memory reservation. AKS versions earlier than 1.29 use a regressive percentage-based memory reservation formula with a 750 Mi eviction threshold and don't include `maxPods` as an input. For details, see [Resource reservations in AKS](/azure/aks/node-resource-reservations).

Use the allocatable CPU and memory shown by `kubectl describe node` as the capacity available to pods. Set workload resource requests and limits from allocatable capacity, and leave headroom for daemon sets, monitoring, logging, and workload bursts.

### Maximum pods per node

Set `maxPods` based on network model, node size, IP address plan, and workload density. Current defaults vary by network model:

| Network model | Default max-pods | Maximum |
|---|---:|---:|
| Azure CNI Overlay | 250 | 250 |
| Azure CNI Pod Subnet (Dynamic IP Allocation) | 250 | 250 |
| Azure CNI Pod Subnet (Static Block Allocation) | Set explicitly; ideal values follow `(16 × N) − 1` | 250 |
| Azure CNI Node Subnet (legacy) | 30 | 250 |
| Kubenet (legacy, retires on March 31, 2028) | 110 (CLI) / 30 (portal) | 250 |

> [!NOTE]
> Defaults vary by tool and network model (for example, Kubenet defaults to 110 in the Azure CLI but 30 in the Azure portal). Always set `--max-pods` explicitly at cluster or node-pool creation to avoid surprises, and verify with `az aks show --query agentPoolProfiles[].maxPods`.

Set `maxPods` at cluster or node-pool creation. To change it later, create a new node pool with the desired value and migrate workloads.

## Use Availability Zones for production

For production node pools, use Availability Zones in supported regions. Choose the zone strategy when you create the node pool because zone selection is immutable after node-pool creation.

Use `--zones 1 2 3` to create a zone-spanning node pool. Alternatively, create one node pool per zone for a zone-aligned strategy. If you use the cluster autoscaler with zone-aligned pools, enable the `balance-similar-node-groups` cluster autoscaler profile setting (`--cluster-autoscaler-profile balance-similar-node-groups=true`) so similar pools scale evenly across zones.

## Choose the node OS

System pools must use Linux nodes: Ubuntu or Azure Linux. User pools can use Ubuntu, Azure Linux, or Windows. Keep node images current by applying AKS node image upgrades as part of normal patching.
