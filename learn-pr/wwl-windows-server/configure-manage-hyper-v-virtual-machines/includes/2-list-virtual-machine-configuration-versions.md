As Contoso migrates its workloads, you need to determine what Windows or Windows Server versions or semi-annual channel releases are running on your Hyper-V hosts and what VM configuration versions exist. You must ensure that you can easily move and start VMs between Hyper-V hosts. It's important that you can utilize any new functionality and features available in Hyper-V.

Because of this, you should understand and identify the existing VM configurations and future required functionality, so that you can determine the appropriate requirements.

## VM configuration versions

The VM configuration version is determined by the version of Hyper-V installed on the host machine at the time of the VM creation. Certain features and functionality in Hyper-V are only available with specific VM configuration versions. The configuration version identifies the compatibility of certain components in a VM with features available on the host, such as:

- Configuration. The VM configuration information such as processor, memory, and attached storage.
- Checkpoint. Files representing configuration files and runtime state files used when checkpoints are created.

From the Hyper-V Manager console, you can display the configuration version of a specific VM by referring to the **Configuration Version** entry displayed on the **Summary** tab.

You can also use the following Windows PowerShell cmdlet to get the versions of the VMs stored on the host machine:

```powershell
Get-VM * | Format-Table Name, Version
```

To identify the VM configuration versions your Hyper-V host supports, run the following Windows PowerShell cmdlet:

```powershell
Get-VMHostSupportedVersion
```

When you create a new VM on a Hyper-V host, a default configuration version is used. To determine the default version for your Hyper-V host, run the following Windows PowerShell cmdlet:

```powershell
Get-VMHostSupportedVersion -Default
```

### Supported VM configuration versions

If you have VMs created with an earlier version of Hyper-V, some features that are introduced and available on a newer Hyper-V host operating system (OS) might not work with those VMs. it's important to understand which OS versions support which VM configuration versions.

The following table displays the VM configuration versions that are supported on hosts running various versions of the Windows OS.  

|Hyper-V host Windows version|Configuration versions|
|---------|---------|
|Windows 10 20H2|9.2, 9.1, 9.0, 8.3, 8.2, 8.1, 8.0, 7.1, 7.0, 6.2, 5.0
|Windows Server 2019|9.0, 8.3, 8.2, 8.1, 8.0, 7.1, 7.0, 6.2, 5.0|
|Windows 10 Enterprise 2019 LTSC|9.0, 8.3, 8.2, 8.1, 8.0, 7.1, 7.0, 6.2, 5.0|
|Windows Server 2016|8.0, 7.1, 7.0, 6.2, 5.0|
|Windows 10 Enterprise 2016 LTSC|8.0, 7.1, 7.0, 6.2, 5.0|
|Windows Server 2012 R2|5.0|

> [!NOTE]
> Hosts that run semi-annual channel versions of Windows, such as Windows Server 1903 and Windows 10 1903 or later, contain and support Hyper-V configuration version 9.0, 9.1, or 9.2, depending on the version you are using.

### Version requirements for Hyper-V features

|Feature|Minimum configuration version|
|---------|---------|
|Hot Add/Remove Memory|6.2|
|Production Checkpoints|6.2|
|PowerShell Direct|6.2|
|Virtual Machine Grouping|6.2|
|Secure Boot for Linux VMs|6.2|
|Virtual Trusted Platform Module (vTPM)|7.0|
|Virtual machine multi queues (VMMQ)|7.1|
|XSAVE support|8.0|
|Key storage drive|8.0|
|Guest virtualization-based security support (VBS)|8.0|
|Nested virtualization|8.0|
|Virtual processor count|8.0|
|Large memory VMs|8.0|
|Increase the default maximum virtual devices to 64 per device|8.3|
|Allow additional processor features for Perfmon|9.0|
|Automatically enable simultaneous multi-threading (SMT) configuration, and enhance security for Hyper-V hosts using the Core Scheduler|9.0|
|Hibernation support|9.0|

> [!NOTE]
> SMT is enabled for the Hyper-V host automatically, however it still must be manually enabled for guest virtual machines. This can be done using the Windows PowerShell cmdlet `Set-VMProcessor`.

## Update the VM configuration version

As you move or import a VM between Hyper-V hosts, it's important that the host supports the configuration version of the VM. If you move the VM to a newer version of Windows or Windows Server, the VM configuration version won't update automatically. This means that if you need to, you can move the VM back to the original host and it'll continue to run successfully. However, the VM won't benefit from the features or functionality of the newer version of Windows or Windows Server until you manually update the VM configuration version to a newer version.

To update the VM configuration version, from the Hyper-V host machine, run the following Windows PowerShell cmdlet:

```powershell
Update-VMVersion \<vmname\>
```

> [!TIP]
> The VM must be turned off to be able to update the configuration version.

When you update the configuration version of a VM, it's updated to the highest configuration level supported by the Hyper-V host on which it's running. For example, if you update the configuration version of a VM on a Hyper-V host running Windows Server 2019, the configuration version is updated to version 9.0.

> [!IMPORTANT]
> You can't downgrade a VM configuration version after it has been upgraded; the VM configuration version can only be upgraded, not downgraded.

Once the VM configuration version is updated, you can import the VM. However, the VM can't start on hosts that don't support the updated configuration version. In other words, newer Hyper-V hosts can run older VM configuration versions, but older Hyper-V hosts can't run newer VM configuration versions.

> [!NOTE]
> You won't be able to start from standard checkpoints that were created while VM was running prior to configuration version update. You'll need to discard saved memory state.

> [!TIP]
> As a general guideline, Microsoft recommends updating the VM configuration version after successfully upgrading the virtualization hosts to a newer version of Windows, and when you feel confident that you won't need to roll back.
