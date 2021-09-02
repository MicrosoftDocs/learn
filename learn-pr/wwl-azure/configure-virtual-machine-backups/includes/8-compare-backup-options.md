This table summarizes the Azure Backup (MARS) agent and the Azure Backup Server usage cases.

:::row:::
  :::column:::
    **Component**
  :::column-end:::
  :::column:::
    **Benefits**
  :::column-end:::
  :::column:::
    **Limits**
  :::column-end:::
  :::column:::
    **What is protected?**
  :::column-end:::
  :::column:::
    **Where are backups stored?**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Backup (MARS) agent
  :::column-end:::
  :::column:::
    Backup files and folders on physical or virtual Windows OS; no separate backup server required
  :::column-end:::
  :::column:::
    Backup 3x per day; not application aware; file, folder, and volume-level restore only; no support for Linux
  :::column-end:::
  :::column:::
    Files and folders
  :::column-end:::
  :::column:::
    Recovery services vault
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Backup Server (MABS)
  :::column-end:::
  :::column:::
    App aware snapshots; full flex for when to backups; recovery granularity; linux support on Hyper-V and VMware VMs; backup and restore VMware VMs, doesn't require a System Center license
  :::column-end:::
  :::column:::
    Cannot backup Oracle workloads; always requires live Azure subscription; no support for tape backup
  :::column-end:::
  :::column:::
    Files, folders, volumes, VMs, applications, and workloads
  :::column-end:::
  :::column:::
    Recovery services vault, locally attached disk
  :::column-end:::
:::row-end:::
