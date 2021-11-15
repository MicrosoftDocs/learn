Given the highly sensitive nature of its financial operations, Contoso business leaders want to ensure that their data running on Azure Stack HCI is protected from cyber threats. The case remains the same even if there's a successful exploit of the operating system running on the cluster nodes. To address these demands, you want to use the trusted enterprise virtualization capabilities built into the Azure Stack HCI hardware and hypervisor.

## What are the benefits of trusted enterprise virtualization in Azure Stack HCI scenarios?

Azure Stack HCI provides trusted enterprise virtualization through its built-in support for virtualization-based security (VBS). VBS relies on Hyper-V to implement the mechanism referred to as virtual secure mode, which allows for creating isolated memory regions within individual VMs. These regions are protected from the operating system running within the guest VM and the Hyper-V host, including their kernel-level code.

By using programming techniques, software developers can implement applications that perform designated, security-sensitive operations in these isolated memory regions without exposing them to other software running on the same hardware. This minimizes vulnerability in a wide range of exploits, including exploits that manage to compromise the operating system kernel of the Hyper-V host.

VBS allows you to implement Hypervisor-Enforced Code Integrity (HVCI) and Credential Guard, which help protect Azure Stack HCI-based workloads. HVCI code-integrity policy enforcement enhances code integrity, which identifies and remediates any unauthorized changes to device drivers and operating system files. HVCI runs the code-integrity service inside virtual secure mode, protecting it from operating system-based malware. Credential Guard protects cached sign-in credentials by storing them in the virtual secure mode. Both of these features use the Trusted Platform Module (TPM) included in the Azure Stack HCI hardware.

## Implement trusted enterprise virtualization for Azure Stack HCI workloads

To address the demands from Contoso business leads for protection of their workloads running on VDI on Azure Stack HCI from cyber threats, you decide to use trusted enterprise virtualization. At a high level, your plan involves the following steps:

1. Identify and purchase Azure Stack HCI hardware optimized for trusted enterprise virtualization. Azure Stack HCI Catalog includes **Trusted enterprise virtualization** as one of the search filtering criteria for integrated systems and validated nodes.

    :::image type="content" source="../media/azs-hci-catalog-tev.png" alt-text="A screenshot of the Azure Stack HCI Catalog with **Trusted enterprise virtualization** selected as one of the search filtering criteria for integrated systems and validated nodes." border="false":::

1. Enable HVCI. Although HVCI is available on Azure Stack HCI certified hardware, it's not automatically enabled. To enable it, use Group Policy or direct registry changes.
1. Optionally, integrate Azure Stack HCI with Microsoft Defender for Cloud, which provides cloud-based advanced security management and threat detection benefits for on-premises workloads, including workloads running on Azure Stack HCI VMs.
