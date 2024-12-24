With thousands of new malicious files created every day, using traditional methods like antivirus solutions—signature-based detection to fight against malware—provides an inadequate defense against new attacks. Application Control and Device Guard provide an extra layer of protection against unknown threats.

### Windows Defender Application Control

Typically, a user-initiated process has the same level of data access as the user, putting sensitive information at risk of being deleted or leaked if the user intentionally or inadvertently runs malicious software. Application control moves away from the traditional trust model, where all applications are assumed trustworthy by default, to one where applications must establish their trustworthiness to operate.

For a system to function correctly, its executables must be checked and verified using code signatures from software publishers. However, some Windows executables may need proper signatures. To address this, an administrator can create a list of all unsigned code files on the system and have the organization sign it. This list is then deployed to Windows Enterprise PCs. Once the Windows Defender Application Control (WDAC) is enabled, any executable not listed in this policy file will be blocked from running. Furthermore, WDAC policies also prevent the execution of unsigned scripts, MSIs, and Windows PowerShell.

Application Control is well suited for Point of Service (PoS) devices, such as sales terminals, ATMs, similar devices, server-based desktops (virtual desktop infrastructure), or other devices where the OS is relatively consistent and updated infrequently. Since code from Windows Update is signed, Windows installations should continue to run securely, even as the OS and Microsoft applications receive updates with new fixes and features. Organizations must carefully consider how to include third-party applications that update frequently but lack signatures.

> [!NOTE]
> WDAC was formally known as the configurable code integrity policies in Windows Defender Device Guard.

### Windows Defender Device Guard

Device Guard combines the features of Application Control with the ability to use the Windows Hyper-V hypervisor to protect Windows kernel-mode processes against the injection and execution of malicious or unverified code. While WDAC doesn't require specific hardware or software, enabling Hypervisor protected code integrity (HVCI) requires compatible hardware and drivers.
