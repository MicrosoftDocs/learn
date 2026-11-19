After completing this unit, you should be able to use Slurm on Azure CycleCloud.

This unit uses standalone CycleCloud with the Slurm project 4.x integration. The field descriptions and template example target [project 4.0.11](https://github.com/Azure/cyclecloud-slurm/tree/4.0.11). Record your CycleCloud application version, Slurm project/template release, Slurm scheduler version, and node images separately. Use a compatible combination from the [project release notes](https://github.com/Azure/cyclecloud-slurm/releases); upgrading the CycleCloud application doesn't upgrade an existing cluster's template or node software.

## Prepare for deployment

Before creating an exercise-owned cluster, confirm the following prerequisites:

- You have a functioning CycleCloud server, an authorized application account, configured Azure subscription credentials, and a usable [storage locker](/azure/cyclecloud/how-to/storage-blobs?view=cyclecloud-8&preserve-view=true). The deployment identity needs the necessary Azure permissions; use a [managed identity](/azure/cyclecloud/how-to/managed-identities?view=cyclecloud-8&preserve-view=true) where appropriate.
- With built-in user management, select **Enable node access for this user**, grant cluster node-access authorization through ownership, sharing, or an applicable role, and upload the user's SSH public key. Confirm an approved network path to the scheduler or login node. Application login, Azure resource permissions, and [node-login authorization](/azure/cyclecloud/how-to/user-access?view=cyclecloud-8&preserve-view=true) are separate; enabling the user setting alone doesn't grant access.
- Choose supported images and VM sizes for the project, region, and workload. Check both regional and VM-family [vCPU quotas](/azure/virtual-machines/quotas), including scheduler and other infrastructure nodes. Spot has separate quota requirements.
- Confirm subnet capacity, name resolution, and required CycleCloud, Slurm, storage, and package-download traffic against the [network requirements](/azure/cyclecloud/how-to/network-security?view=cyclecloud-8&preserve-view=true). Don't expose cluster services publicly just to complete the exercise.
- Start with a small limit, such as one HTC compute node for the hostname test. Quotas and configured limits don't reserve Azure capacity. Your account and quality of service (QOS) permissions must also allow the test job.

## Enable Slurm on CycleCloud

Use the [cluster creation workflow](/azure/cyclecloud/how-to/create-cluster?view=cyclecloud-8&preserve-view=true) with the matching Slurm template:

1. Connect to the deployed Azure CycleCloud web application and sign in.
1. If clusters are already listed, select **Add**. On the **Create a New Cluster** page, select **Slurm** in the **Schedulers** section.

   :::image type="content" border="false" source="../media/4-new-cluster.png" alt-text="Screenshot of the Create a New Cluster page with the Slurm scheduler option." lightbox="../media/4-new-cluster.png":::

1. On the **About** tab, enter a unique name in **Cluster Name**.
1. On **Required Settings**, enter the following settings in their corresponding fields. These descriptions match the [project 4.0.11 template](https://github.com/Azure/cyclecloud-slurm/blob/4.0.11/templates/slurm.txt).

   | Field | Purpose |
   | --- | --- |
   | **Region** | Azure region that hosts the cluster nodes. |
   | **Scheduler VM Type** | VM size for the Slurm scheduler. |
   | **HPC VM Type** | VM size for the HPC node array, suitable for its intended tightly coupled workloads. |
   | **HTC VM Type** | VM size for the HTC node array used by this exercise. |
   | **Autoscale** | Enable automatic compute-node provisioning and idle-node suspension for this exercise. |
   | **Max HPC Nodes**, **Max HTC Nodes**, **Max GPU Nodes** | Maximum VM counts for these arrays. Set **Max HTC Nodes** to `1` for the test; keep unused arrays disabled or capped at zero where supported. |
   | **Max Dyn Cores** | Core-based limit for the optional dynamic array; this isn't a node count. |
   | **Max VMs per VMSS** | Maximum VMs in each applicable virtual machine scale set, not the overall cluster cap. |
   | **HTC Spot** | Whether HTC uses interruptible Spot capacity. Leave it disabled for the initial test; Spot eviction can interrupt work. |
   | **Subnet ID** | Subnet in which the cluster node VMs are deployed. |

   In these stock HPC, HTC, and GPU arrays, `MaxCount` limits nodes. `MaxCoreCount` still limits cores in other arrays or custom templates. Azure compute quotas are expressed in vCPUs, so don't interpret a node limit as a vCPU limit.

1. On **Network Attached Storage**, configure the `/sched` and `/shared` mounts. For a simple, non-HA cluster, **Use Builtin NFS** uses the scheduler as an NFS server. For an external export, clear that option and select **External NFS** as the **FS Type**. Supply a reachable NFS server address, export path, and suitable mount options, such as those for an Azure NetApp Files NFS volume or an appropriately configured NFS server VM. A non-NFS filesystem requires its own compatible mount configuration, not an entry in an External NFS field. See [Mount an existing file server](/azure/cyclecloud/how-to/mount-fileserver?view=cyclecloud-8&preserve-view=true).

   A locker distributes initialization projects; it isn't automatically shared storage for application inputs and outputs. Make application files available at consistent paths on the nodes that run the jobs.

   > [!IMPORTANT]
   > Don't keep the only copy of application data or results on disposable compute-local storage. Confirm which paths are shared and durable, who owns them, and what's retained when the exercise cluster is terminated.

1. On **Advanced Settings**, review these settings for the selected project release:

   | Setting | Purpose |
   | --- | --- |
   | **Slurm Version** | Use the scheduler package version specified by the selected project's release and template, rather than a version from another release. |
   | **Job Accounting** | Enable only when the database prerequisites described below are ready. Leave disabled for the minimal hostname exercise otherwise. |
   | **Credentials** | Select the configured Azure subscription credentials authorized to deploy the cluster. |
   | **Scheduler OS** | Supported Linux image for the scheduler. |
   | **HPC OS** | Supported Linux image for compute nodes in the HPC node array, not the scheduler. |
   | **HTC OS**, **GPU OS**, **Login Node OS**, **Dynamic OS** | Supported images for the corresponding node roles you enable. |
   | **Scheduler Cluster-Init**, **HTC Cluster-Init**, and other role-specific cluster-init fields | Additional initialization projects for the named node role. Preserve the matching project's initialization requirements. |
   | **Return Proxy**, **Public Head Node**, **Public Execute** | Use only the approved network design. Return Proxy relays node communication with CycleCloud through the head node; public node access isn't a prerequisite for this exercise. |

   Use the [supported operating-system guidance](/azure/cyclecloud/slurm-4-operations?view=cyclecloud-8&preserve-view=true#supported-versions-and-operating-systems) together with the selected release and VM requirements. For example, the project 4.0.11 template defaults to Ubuntu 24.04 images. Verify image architecture and required interconnect or GPU drivers for the VM sizes you select; a supported scheduler image isn't automatically appropriate for every compute workload.

   For [job accounting](/azure/cyclecloud/slurm-4-operations?view=cyclecloud-8&preserve-view=true#configure-slurm-job-accounting), supply a reachable MySQL database's hostname, database name, user credentials, and any required TLS certificate configuration. Verify database network access from the scheduler. Selecting **Job Accounting** doesn't provision every database prerequisite, and installed accounting commands alone don't guarantee historical records. Deleting the cluster doesn't delete its accounting database; plan its retention separately.

1. Review any site-required **Security** and **Cloud-init** settings. Cloud-init supplies node initialization configuration; no custom cloud-init is needed for the hostname test.
1. Select **Save** to create the cluster definition.
1. Select **Start** and confirm. Wait for the scheduler and any configured infrastructure nodes to finish initialization. Inspect the cluster event log and **Issues** if configuration fails; an Azure VM being running isn't proof that Slurm is ready.
1. Select the scheduler, or a configured login node, and select **Connect** to obtain the [SSH connection command](/azure/cyclecloud/how-to/connect-to-node?view=cyclecloud-8&preserve-view=true). Run it from your approved client using the authorized account and key over the approved network path. Keep your private key on your client.
1. In that Linux scheduler or login-node session, as a normal cluster user, inspect the HTC partition and run a small compute-node command:

   ```bash
   sinfo -p htc
   srun --partition=htc --nodes=1 --ntasks=1 --time=00:10:00 hostname
   ```

1. Confirm that `srun` returns a compute-node hostname. If it remains pending or fails, inspect the scheduling reason and follow the troubleshooting unit rather than assuming deployment succeeded.

The test requires an enabled HTC array with room for at least one node, adequate quota and capacity, and permission to submit to the partition. Supply your site's account or QOS options to `srun` if required. Cold node provisioning takes time. A powered-down elastic node, commonly shown as `idle~` in [`sinfo`](https://slurm.schedmd.com/sinfo.html), isn't automatically a failure.

## Memory settings

CycleCloud Slurm reserves memory for operating-system and VM overhead before advertising memory to the scheduler. In project 4.0.11, the default reservation is 5% or 1 GiB, whichever is larger. An explicit percentage still observes the 1-GiB minimum.

To request a 20% reservation, add this setting to the existing node array's `[[[configuration]]]` section in a copy of the matching cluster template:

```ini
slurm.dampen_memory = 20
```

A 4-GiB node still reserves 1 GiB in this example. Follow the same-project template workflow below and [apply the configuration on the scheduler](#apply-changes-to-an-existing-slurm-cluster). Then run `scontrol show nodes` from the scheduler or login node to inspect the resulting resources. Size jobs using Slurm's configured memory, not just the Azure VM's advertised memory. See [Adjust reported memory](/azure/cyclecloud/slurm-4-operations?view=cyclecloud-8&preserve-view=true#adjust-reported-memory).

## Configure an additional Slurm partition

The stock project 4.0.11 template defines `hpc`, `htc`, `gpu`, and `dynamic` partitions; their configured limits and settings determine which resources can be used. The existing GPU partition is sufficient for ordinary GPU workloads. The following optional example illustrates adding a separate partition, not a requirement for the hostname exercise.

In a copy of the template from the **same installed project version**, preserve site customizations and insert this section inside the cluster definition, before the parameter sections:

```ini
[[nodearray specialgpu]]
    Extends = gpu
    MaxCount = 1

    [[[configuration]]]
    slurm.partition = specialgpu
    slurm.default_partition = false
```

This inherits the existing GPU VM/image settings and execute-node initialization. The explicit `slurm.partition` override prevents both arrays from mapping to the inherited `gpu` partition. The default-partition override avoids inheriting that choice too. Check inherited GPU settings, supported image/SKU, regional availability, and quota before submitting GPU work.

Use an initialized CycleCloud CLI on your Linux management host for an intentional **same-project-version** configuration change. Plan an administrative maintenance window. Save your edited template as `modified-slurm.txt` and retain the original template and parameters. Record and verify site-specific **Security** and **Cloud-init** settings separately; these standard form sections aren't exported as template parameters. Work in an access-restricted directory: exported parameters can contain credentials. Don't commit them to source control or share them publicly. Replace `CLUSTER_NAME` with the actual exercise cluster name and confirm the target before using `--force`.

> [!WARNING]
> Don't overwrite an older cluster with a newer project/template release using this workflow. For upgrades, validate a replacement cluster using the [migration procedure](/azure/cyclecloud/how-to/migrate-slurm-cluster?view=cyclecloud-8&preserve-view=true) before moving workloads.

The `-c Slurm` option identifies the exact cluster-definition name in the stock template. These commands export the parameters, reimport the modified definition, and start the cluster:

```bash
umask 077
cyclecloud export_parameters CLUSTER_NAME -o cluster-parameters.json
cyclecloud import_cluster CLUSTER_NAME -c Slurm -f modified-slurm.txt -p cluster-parameters.json --force
cyclecloud start_cluster CLUSTER_NAME
```

This example adds a partition; it doesn't change live nodes' VM types/images or remove active nodes. Apply the resulting configuration on the scheduler as described next. Afterward, from the scheduler or login node, run `sinfo -p specialgpu` to verify that the new partition is present.

## Apply changes to an existing Slurm cluster

After saving supported changes to a running project-4.x cluster's CycleCloud definition, connect to the **scheduler** as an authorized administrator and run:

```bash
sudo -i
azslurm scale
exit
```

`azslurm scale` rebuilds `azure.conf`, updates partition/node and GRES configuration, and restarts `slurmctld`. Follow the matching template workflow for topology changes such as an additional partition, and schedule the controller restart appropriately. This isn't a per-job command, a blanket replacement for Slurm's own reconfiguration operations, or a software/template upgrade command. See [Make cluster changes](/azure/cyclecloud/slurm-4?view=cyclecloud-8&preserve-view=true#make-cluster-changes).

## Keep nodes or partitions running

> [!WARNING]
> Preventing automatic suspension can keep VMs running and accruing charges after jobs finish. These settings don't prevent every explicit termination operation and aren't a complete manual-scaling configuration.

Use an authorized administrator's session on the **scheduler** for the commands in this section. Before making changes, record the existing persistent and runtime exclusions so that you can preserve settings that predate the exercise:

```bash
scontrol show config | grep -E 'SuspendExcNodes|SuspendExcParts|ReconfigFlags'
```

For an individual running node on project 4.0.5 or later, use CycleCloud [KeepAlive](/azure/cyclecloud/how-to/keep-alive?view=cyclecloud-8&preserve-view=true). Verify that `KeepPowerSaveSettings` is included in `ReconfigFlags`. Select a real running node with KeepAlive disabled and no existing `SuspendExcNodes` exclusion. In the CycleCloud node's **Edit** interface, enable **KeepAlive**, then inspect the runtime configuration to confirm that the node is excluded from automatic suspension. When finished, disable only the KeepAlive setting introduced by this exercise and verify the resulting exclusions.

In [project 4.0.11](https://github.com/Azure/cyclecloud-slurm/blob/4.0.11/azure-slurm/slurmcc/allocation.py#L238-L270), once `azslurmd` observes KeepAlive enabled, disabling it removes that node's runtime exclusion even if the exclusion existed before the exercise. Don't toggle KeepAlive on a manually excluded node.

For an entire partition, an authorized administrator can keep `hpc` out of automatic suspension. If `hpc` is already excluded, leave that setting in place and don't remove it during cleanup. Otherwise, follow these steps:

1. On the scheduler, merge `hpc` into the existing `SuspendExcParts` setting in `/etc/slurm/site_specific.conf`, preserving other entries. If there are no existing exclusions, the setting is:

   ```ini
   SuspendExcParts=hpc
   ```

1. Apply the corresponding runtime change without replacing other exclusions, and inspect it:

   ```bash
   sudo scontrol update SuspendExcParts+=hpc
   scontrol show config | grep -E 'SuspendExcParts|ReconfigFlags'
   ```

1. When finished, remove only the `hpc` exclusion introduced for this exercise from the persistent setting, preserving all other entries. Remove the setting if it was created by this exercise and no entries remain. Remove the exercise's runtime exclusion and verify the result:

   ```bash
   sudo scontrol update SuspendExcParts-=hpc
   scontrol show config | grep -E 'SuspendExcParts|ReconfigFlags'
   ```

With `KeepPowerSaveSettings`, Slurm preserves runtime power-save settings during reconfiguration. Editing the file and running only `scontrol reconfigure` can therefore leave the previous runtime exclusion in place. Maintain both the intended persistent setting and effective runtime value; don't remove exclusions that predated the exercise. For a different operating model, follow the separate [manual-scaling procedure](/azure/cyclecloud/slurm-4?view=cyclecloud-8&preserve-view=true#scale-manually).

## Preserve results and clean up

After the exercise, use the [cluster termination guidance](/azure/cyclecloud/how-to/terminate-cluster?view=cyclecloud-8&preserve-view=true) to clean up only resources you own:

1. Let your exercise jobs finish, or cancel only your own jobs if appropriate. Copy valuable output to the intended durable destination before removing nodes or storage.
1. Remove only KeepAlive settings and suspension exclusions added for this exercise, using the procedures above.
1. For an exercise-owned cluster, select **Terminate** in CycleCloud and verify that termination completes. Inspect the event log and **Issues** if it fails. Don't terminate a shared or production cluster.
1. Review retained persistent disks, external storage, accounting databases, and the CycleCloud application server separately. Terminating compute nodes doesn't necessarily remove these resources or their charges.
1. Delete only explicitly exercise-owned resources whose data is no longer needed. Don't delete a shared resource group as a shortcut.
