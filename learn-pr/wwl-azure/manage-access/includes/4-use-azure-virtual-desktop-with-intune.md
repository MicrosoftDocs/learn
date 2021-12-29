With Microsoft Intune, you can secure and manage your Azure Virtual Desktop virtual machines (VMs) with policy and apps at scale, after they're enrolled.

Intune supports Azure Virtual Desktop virtual machines (VM)s that are:

 -  Running Windows 10 Enterprise, version 1809 or later.
 -  Hybrid Azure AD-joined
 -  Set up as personal remote desktops in Azure.
 -  Enrolled in Intune in one of the following methods:
    
     -  Configure Active Directory group policy to automatically enroll devices that are hybrid Azure AD joined.
     -  Configuration Manager co-management.
     -  User self-enrollment via Azure AD Join.

Intune treats Azure Virtual Desktop personal VMs the same as Windows 10 Enterprise physical desktops.

Intune allows you use some of your existing configurations and secure the VMs with compliance policy and conditional access. Intune management doesn't depend on or interfere with Azure Virtual Desktop management of the same virtual machine.

## Limitations

There are some limitations to keep in mind when managing Windows 10 Enterprise remote desktops:

### Configuration

All VM limitations listed in [Using Windows 10 virtual machines](/mem/intune/fundamentals/windows-10-virtual-machines) also apply to Azure Virtual Desktop VMs.

Also, the following profiles aren't currently supported:

 -  Domain Join
 -  Wi-Fi

### Remote actions

The following Windows 10 desktop device remote actions aren't supported/recommended for Azure Virtual Desktop VMs:

 -  Autopilot reset
 -  BitLocker key rotation
 -  Fresh Start
 -  Remote lock
 -  Reset password
 -  Wipe

### Retirement

Deleting VMs from Azure leaves orphaned device records in Intune. They'll be automatically cleaned up according to the cleanup rules configured for the tenant.

### Windows 10 Enterprise multi-session

Intune doesn't currently support management of Windows 10 Enterprise multi-session.
