`New-Volume` creates the virtual disk, partition, file system, and Cluster Shared Volume in one operation. Prefer it over separate low-level commands.

## Create a mirror volume

Use three-way mirror for latency-sensitive virtual machines in the four-node primary scenario:

```powershell
New-Volume -StoragePoolFriendlyName 'S2D on S2D-CL01' `
    -FriendlyName 'VirtualMachines01' `
    -FileSystem CSVFS_ReFS `
    -ResiliencySettingName Mirror `
    -Size 2TB
```

Confirm the result:

```powershell
Get-VirtualDisk |
    Format-Table FriendlyName, ResiliencySettingName,
        ProvisioningType, HealthStatus, Size, FootprintOnPool

Get-ClusterSharedVolume
Get-Volume
```

Verify the actual copy count and footprint. Don't infer resiliency from the word `Mirror` alone.

## Create a parity volume

Use parity for suitable capacity-oriented workloads:

```powershell
New-Volume -StoragePoolFriendlyName 'S2D on S2D-CL01' `
    -FriendlyName 'Archive01' `
    -FileSystem CSVFS_ReFS `
    -ResiliencySettingName Parity `
    -Size 4TB
```

Test the workload. Small random writes can expose parity CPU and latency costs.

## Create mirror-accelerated parity

Before creating the volume, inspect the available tier templates and their media and resiliency settings:

```powershell
Get-StorageTier |
    Format-Table FriendlyName, MediaType, ResiliencySettingName,
        PhysicalDiskRedundancy
```

For the four-node Windows Server 2025 hybrid scenario with HDD capacity drives, the expected default templates are `MirrorOnHDD` and `ParityOnHDD`. Verify that the selected mirror tier uses `Mirror` resiliency with `PhysicalDiskRedundancy` set to `2`, and that the selected parity tier uses `Parity` resiliency with `PhysicalDiskRedundancy` set to `2`. If your tier names differ, substitute the names returned by `Get-StorageTier` only after verifying those settings and the media type. Don't assume that legacy or custom names identify the required resiliency.

The following example creates a volume with a 200-GB mirror tier and an 800-GB parity tier, so 20 percent of its logical capacity uses mirroring:

```powershell
New-Volume -StoragePoolFriendlyName 'S2D on S2D-CL01' `
    -FriendlyName 'MixedData01' `
    -FileSystem CSVFS_ReFS `
    -StorageTierFriendlyNames 'MirrorOnHDD', 'ParityOnHDD' `
    -StorageTierSizes 200GB, 800GB
```

Size the mirror tier from measured write activity. A small mirror tier can force active writes into parity.

## Create a thin volume

Windows Server 2025 supports thin-provisioned Storage Spaces Direct volumes. A thin-provisioned Storage Spaces Direct volume presents its full configured capacity to workloads but consumes physical storage from the pool only as data is written, improving utilization and returning unused capacity for other volumes. Pool capacity must be monitored to prevent overcommitment from exhausting physical storage.

You can create a thin-provisioned S2D volume using a command similar to the following:

```powershell
New-Volume -StoragePoolFriendlyName 'S2D on S2D-CL01' `
    -FriendlyName 'ThinData01' `
    -FileSystem CSVFS_ReFS `
    -ResiliencySettingName Mirror `
    -ProvisioningType Thin `
    -Size 10TB
```

With thin-provisioned volumes, logical size can exceed current physical allocation. Ensure that you monitor both values:

```powershell
Get-VirtualDisk |
    Format-Table FriendlyName, ProvisioningType, Size,
        FootprintOnPool, HealthStatus

Get-StoragePool -IsPrimordial $false |
    Format-Table FriendlyName, Size, AllocatedSize
```

Thin provisioning doesn't create capacity. Define warning, stop-growth, and emergency expansion thresholds.

## Create a nested-resiliency volume

To create a nested-resiliency volume in a 2 node cluster:

```powershell
New-Volume -StoragePoolFriendlyName 'S2D*' `
    -FriendlyName 'NestedData01' `
    -StorageTierFriendlyNames 'NestedMirrorOnHDD',
        'NestedParityOnHDD' `
    -StorageTierSizes 100GB, 400GB
```

Confirm template names in the target cluster. Media-specific names vary.

## Size volume count

More volumes can improve:

- Parallel ownership.
- Failure isolation.
- Backup scheduling.
- Operational boundaries.

Too many volumes increase:

- Monitoring objects.
- Capacity fragmentation.
- Placement complexity.
- Administrative load.

Create volumes around workload and recovery boundaries, not arbitrary equal slices.

## Distinguish caches

The following table compares the Storage Bus Layer cache with the optional CSV memory cache:

| Cache | Location | Purpose | Main cost |
| --- | --- | --- | --- |
| Storage Bus Layer cache | Fast physical devices | Accelerate capacity devices | Device capacity and endurance |
| CSV memory cache | Node RAM | Cache unbuffered reads | Memory unavailable to workloads |

Use the following commands to configure and verify a 2-GB CSV memory cache:

```powershell
(Get-Cluster -Name 'S2D-CL01').BlockCacheSize = 2048
(Get-Cluster -Name 'S2D-CL01').BlockCacheSize
```

Measure before enabling it. On hyperconverged nodes, allocated cache memory can't host virtual machines.

## Preserve reserve

Don't fill volumes merely because allocation succeeds. Capacity policy must include:

- Repair after the largest planned fault.
- Expected thin-volume growth.
- ReFS metadata.
- Backup or checkpoint bursts.
- Expansion lead time.
