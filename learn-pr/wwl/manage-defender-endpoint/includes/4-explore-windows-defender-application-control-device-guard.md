
With thousands of new malicious files created every day, using traditional methods like antivirus solutions—signature-based detection to fight against malware—provides an inadequate defense against new attacks. Application Control and Device Guard provide an extra layer of protection against unknown threats.

### Windows Defender Application Control

Normally, when a user runs a process, that process has the same level of access to data that the user has. As a result, sensitive information could easily be deleted or transmitted out of the organization if a user knowingly or unknowingly runs malicious software. Application control moves away from the traditional application trust model where all applications are assumed trustworthy by default to one where applications must earn trust in order to run.

All executables on the system must be vetted in order to run. This is done by using code signatures from software publishers, but not all Windows executables are properly signed. For code that isn't signed, an administrator can create a manifest of all files on the system. This manifest in turn is signed by the organization and deployed to Windows Enterprise PCs. Executables that aren't described in this policy file won't run once WDAC is enabled. WDAC policies also block unsigned scripts and MSIs, and Windows PowerShell.

Application Control is likely to be ideally suited to Point of Service (PoS) devices, such as sales terminals, ATMs, and similar devices, as well as server-based desktops (virtual desktop infrastructure) or other devices where the OS is relatively consistent across devices and updated relatively infrequently. However, Microsoft has stated that since code available from Windows Update is signed, Windows installs should continue to securely run, even as the OS and Microsoft applications are updated with new fixes and features. Organizations will need to consider how best to include third-party applications that update with regularity but aren't signed.

> [!NOTE]
> WDAC was formally known as the configurable code integrity policies in Windows Defender Device Guard.

### Windows Defender Device Guard

Device Guard combines the features of Application Control with the ability to use the Windows Hyper-V hypervisor to protect Windows kernel-mode processes against the injection and execution of malicious or unverified code. While WDAC doesn't require specific hardware or software, enabling Hypervisor protected code integrity (HVCI) requires compatible hardware and drivers.
