
In most infrastructure as a service (IaaS) scenarios, Azure virtual
machines (VMs) are the main workload for organizations that use cloud
computing. This fact is evident in hybrid scenarios where organizations
want to slowly migrate workloads to the cloud. In such scenarios, follow
the general security considerations for IaaS, and apply security best
practices to all your VMs.

The first step in protecting your VMs is to ensure that only authorized
users can set up new VMs and access VMs. To improve the security of
Linux VMs on Azure, you can integrate with Azure AD authentication. When
you use Azure AD authentication for Linux VMs, you centrally control and
enforce policies that allow or deny access to the VMs.

#### Security baseline for IaaS VMs

Security baselines for IaaS VMs are available for
[Windows](/azure/governance/policy/samples/guest-configuration-baseline-windows)
and
[Linux](/azure/governance/policy/samples/guest-configuration-baseline-linux).
While each operating system will have its own security settings, there
are some general guidelines that you can ensure are in place regardless
of the operating system, such as:

-   **Protect your virtual machines from viruses and malware:** if you
    are using Windows, you can use the Microsoft Antimalware for
    Azure, which is a single-agent solution for applications and tenant
    environments. It's designed to run in the background without human
    intervention. You can deploy protection based on the needs of your
    application workloads, with either basic secure-by-default or
    advanced custom configuration, including antimalware monitoring. For
    Linux you can use Microsoft Defender for Endpoint (MDE) for Linux.

-   **Encrypt your sensitive data:** you can use Azure Disk Encryption
    for encrypting your Windows and Linux virtual machine disks. Azure
    Disk Encryption uses the industry-standard BitLocker feature of
    Windows and the dm-crypt feature of Linux to provide volume
    encryption for the OS and the data disks. The solution is integrated
    with Azure Key Vault to help you control and manage the disk
    encryption keys and secrets in your key vault subscription. It
    ensures that all data in the virtual machine disks are encrypted at
    rest in Azure Storage.

-   **Secure network traffic:** use Azure virtual network to control
    traffic. An Azure virtual network is a logical construct built on
    top of the physical Azure network fabric. Each logical Azure virtual
    network is isolated from all other Azure virtual networks. This
    isolation helps ensure that network traffic in your deployments is
    not accessible to other Microsoft Azure customers.

-   **Identify and detect threats:** you can use Microsoft Defender for
    Servers threat detection which is available for Windows and Linux.
    This plan offers threat detection and it integrates with MDE (for
    Windows and Linux).

Security baselines for VMs are accessible via Defender for Cloud
recommendations. Each operating system has its own recommendation as
shown below:

:::image type="content" source="../media/remediate-security-configurations.png" alt-text="Screenshot showing remediating security configurations." lightbox="../media/remediate-security-configurations.png":::

As you open each recommendation, you'll see the security checks that
were performed, and when you select a security check, you'll see more
details about the impact, the vulnerability and remediation as shown
below:

:::image type="content" source="../media/vulnerability-remediation.png" alt-text="Screenshot showing using Microsoft Defender for Cloud recommendations to remediate vulnerabilities." lightbox="../media/vulnerability-remediation.png":::