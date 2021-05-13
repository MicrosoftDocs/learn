As the Contoso Windows Server administrator. you will assess the attestation options. One of those is TPM-trusted attestation, which you could consider implementing in the Contoso guarded fabric because it offers the strongest assurances.

## Overview of TPM-trusted attestation

With TPM-trusted attestation, when a user starts a VM, the Hyper-V host sends the following three types of information to the HGS:

- TPM-identity. This is the host's unique TPM 2.0 endorsement key. The HGS uses this information to check whether the host belongs to the list of HGS authorized hosts.
- Measured Boot sequence. The host sends the HGS its Trusted Computing Group (TCG) log. The TCG log contains details about processes that were started during the most recent boot sequence. The HGS compares the host's TCG log to a known, good reference (TPM baseline) for the host's hardware configuration. This comparison allows the HGS to check the health of the host's hardware when the VM starts up.

- Code integrity policy. The host provides the HGS with information about the Code Integrity (CI) policy that was applied on the host. The CI policy defines the binaries or executables (software) the host is permitted to run. Malware and other executables outside the trusted executables are prevented from running. In other words, the CI policy enables the HGS to check the integrity of the host's software when the VM starts up.

Attestation happens when the host starts and then every 8 hours thereafter. If a host doesn't have an attestation certificate when a VM tries to start, attestation is triggered again.

Although TPM-trusted attestation offers the strongest assurances, it also requires that your Hyper-V hosts' hardware supports TPM 2.0, and you must configure the hardware. Host hardware and firmware must include TPM 2.0 and use UEFI 2.3.1 with Secure Boot enabled.

## Configure TPM-trusted attestation

The HGS attests the health and authority of a guarded host based on its TPM identity, Measured Boot sequence (TPM baseline), and CI policies. To configure the Contoso HGS to use TPM-trusted attestation you must:

- Authorize the host's TPM identity.
- Apply a CI policy to the host.
- Set the host's TPM baseline.

The following provides a summary of the steps required to configure your guarded hosts for TPM-trusted attestation.

### Task 1: Authorize the host's TPM identity

To specify which hosts are permitted to run shielded VMs in the Contoso fabric, you need to obtain the unique endorsement key from each host. Then, you add the endorsement key from each host to the list of HGS authorized hosts.

1. In the fabric domain, initialize TPM and set TPM ownership for each host in the TPM Management Console or by run the `Initialize-Tpm` cmdlet in an elevated Windows PowerShell session.
1. To obtain host's endorsement key, on each guarded host run the Windows PowerShell cmdlet `Get-PlatformIdentifier`. The cmdlet generates an XML file with the host's endorsement key.
1. In an elevated Windows PowerShell session on the HGS server, use the XML files to register each host to the HGS list of authorized hosts with the cmdlet `Add-HgsAttestationTpmHost`.

### Task 2: Apply a CI policy to the host

To run shielded VMs in TPM mode, a guarded host must have a CI policy applied. You can capture CI policies from a *reference host* that has all the required software and features installed, and then add the policies to the HGS as trusted CI policies.

> [!NOTE]
> Capture a CI policy for each set of Hyper-V hosts in your fabric that share the same software configuration. You can create each CI policy once, and then apply the same CI policy to groups of Hyper-V hosts that have the same software configuration.

1. On the reference host, in an elevated Windows PowerShell session, generate a new CI policy by using the `New-CIPolicy` cmdlet. The cmdlet creates an XML file for your CI policy.
1. Apply the policy to your reference host for testing. If there are any CI integrity violations, update your CI policy as necessary.

1. Convert your finalized CI policy to an **enforced mode** CI policy by running the cmdlet `ConvertFrom-CIPolicy` against the CI policy XML file. The cmdlet `ConvertFrom-CIPolicy` uses the XML file to generate a binary file for your CI policy (enforced mode).

1. Use the binary file to apply the CI policy to all your hosts that have the same hardware and software configuration as your reference host.

1. In the HGS domain, copy the CI policy to the HGS server, and then register the policy to the HGS by running the `Add-HgsAttestationCIPolicy` cmdlet.

> [!TIP]
> You can apply the CI policy to the reference host by using the Windows PowerShell cmdlet `Invoke-CimMethod`, via Group Policy or by using the Windows PowerShell cmdlets from the `ConfigCI` module. You can get a list of `ConfigCI` Windows PowerShell cmdlets by running the Windows PowerShell command `Get-Command -Module ConfigCI`.

### Task 3: Set the host's TPM baseline

Just as with CI policies, you can capture a TPM baseline from a *reference host* for each unique Hyper-V hardware configuration in your fabric. To run shielded VMs, you must set the TPM baseline that applies to each guarded host, and then add the TPM baseline to the HGS.

> [!TIP]
> Capture a TPM baseline for each set of Hyper-V hosts in your fabric that share the same hardware configuration. Create each TPM baseline once, and then apply that TPM baseline to groups of Hyper-V hosts that have the same hardware configuration.

1. On the reference host, make sure that the **Hyper-V** role and the **Host Guardian Hyper-V Support** feature are installed.

    You can install the Hyper-V role and the **Host Guardian Hyper-V Support** feature by running the following cmdlet in an elevated Windows PowerShell session on the reference host:

    ```powershell
    Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart
    ```

1. To capture the TPM baseline, run the cmdlet `Get-HgsAttestationBaselinePolicy` in an elevated Windows PowerShell session on the reference host. The cmdlet creates a TCG log file for the TPM baseline.

1. In the HGS domain, copy the TCG log file to the HGS server, and then run the cmdlet `Add-HgsAttestationTpmPolicy` to add the TPM baseline to the HGS.

    > [!IMPORTANT]
    > The HGS administrator should retain copies of the endorsement key, CI policy, and TPM baseline files in a secure storage location.
