PowerShell offers more than 200 cmdlets for managing Hyper-V Virtual machines (VMs), virtual hard disks, and other components of a Hyper-V environment. Hyper-V cmdlets are available in the **Hyper-V** module for PowerShell.

The Hyper-V cmdlets are available when you install the **Hyper-V Management tools** feature on a Windows client operating system, or the **Hyper-V Module for Windows PowerShell** feature on Windows Server.

Hyper-V cmdlets use one of three prefixes:

- **VM** for virtual machine cmdlets
- **VHD** for virtual hard disk cmdlets
- **VFD** for virtual floppy disk cmdlets

The following table lists common cmdlets for managing Hyper-V VMs.

*Table 1: Cmdlets for managing Hyper-V VMs*

| **Cmdlet**        | **Description**              |
| ----------------- | ---------------------------- |
| **Get-VM**        | Gets properties of a VM      |
| **Set-VM**        | Sets properties of a VM      |
| **New-VM**        | Creates a new VM             |
| **Start-VM**      | Starts a VM                  |
| **Stop-VM**       | Stops a VM                   |
| **Restart-VM**    | Restarts a VM                |
| **Suspend-VM**    | Pauses a VM                  |
| **Resume-VM**     | Resumes a paused VM          |
| **Import-VM**     | Imports a VM from a file     |
| **Export-VM**     | Exports a VM to a file       |
| **Checkpoint-VM** | Creates a checkpoint of a VM |
