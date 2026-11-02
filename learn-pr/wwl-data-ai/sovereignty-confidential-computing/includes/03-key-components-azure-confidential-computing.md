Azure confidential computing represents a groundbreaking approach to securing sensitive workloads in the cloud. By using advanced hardware-based technologies, Azure ensures that data remains more protected even when in use. This section provides an overview of the key components that make Azure confidential computing a robust and reliable solution for businesses with stringent security and data sovereignty requirements.

### Microsoft Azure Attestation

A key component of Azure confidential computing that supports data sovereignty is [Microsoft Azure Attestation](/azure/attestation/overview). This remote attestation service verifies the trustworthiness of the platform that's running the workload, ensuring that the binaries inside Trusted Execution Environments (TEEs), such as Intel SGX, VBS enclaves, TPMs, and confidential virtual machines (confidential VMs), are more secure and untampered with. By validating the fundamental root of trust, attestation ensures that only verified and trusted software is implemented, guaranteeing data sovereignty throughout the entire process.

Benefits of using Microsoft Azure Attestation are that it's available for free, provides source code for government customers, protects data-in-use, attests multiple TEEs in one single solution, and offers strong service-level agreements (SLAs).

Alternatively, by building their own attestation, organizations have full control to meet regulatory needs and customization of integrations with other computing technologies.

Customers can choose among using Microsoft Azure Attestation, partner solutions like [**Intel Trust Authority**](https://azuremarketplace.microsoft.com/marketplace/apps/intel_corporation.intel-trust-authority), or building their own solution, which provides flexibility in securing and verifying their infrastructure.

### Trusted launch

Azure also provides [Trusted launch](/azure/virtual-machines/trusted-launch), a technology that enhances the security of Generation 2 virtual machines (VMs). Trusted launch offers multiple layers of protection, including secure boot, virtual Trusted Platform Modules (TPMs), and boot integrity monitoring to defend against advanced attack techniques, such as boot kits and rootkits. This capability ensures that the entire boot process, from the bootloader to the OS kernel, is more secure and verifiable.

Trusted launch also provides an extra layer of protection for sensitive workloads, ensuring that the entire boot process is more secure and compliant; therefore, data is more protected throughout its life cycle to ensure compliance with various data sovereignty standards.

### Trusted Hardware Identity Management

[Trusted Hardware Identity Management](/azure/security/fundamentals/trusted-hardware-identity-management) is a key feature that supports data sovereignty and confidentiality in Azure. It manages and validates the integrity of Trusted Execution Environments (TEEs) by handling certificate cache management and providing Trusted Compute Base (TCB) information to enforce a security baseline. By interacting with Microsoft Azure Attestation and Azure confidential computing nodes, this feature ensures that TEEs are validated against trusted certificates, maintaining a trusted state for confidential computing nodes. This integration safeguards data sovereignty by ensuring that only verified platforms process sensitive data.

### Azure Kubernetes Service

To help meet sovereignty, confidentiality, and security requirements, customers can use [Azure App-enclave aware containers](/azure/confidential-computing/enclave-aware-containers) that run on Azure Kubernetes Service (AKS), which use Intel SGX to create isolated environments for each container application. Additionally, Azure is previewing [Confidential VM node pool support on AKS with AMD SEV-SNP VM components](https://techcommunity.microsoft.com/t5/azure-confidential-computing/confidential-vm-node-pool-with-amd-sev-snp-protection-available/ba-p/3586136), allowing Kubernetes clusters to run confidential workloads with enhanced security. This service includes the ability to run [confidential VM with AMD SEV-SNP node pools in Kubernetes](https://techcommunity.microsoft.com/t5/azure-confidential-computing/amd-sev-snp-confidential-vm-nodes-are-now-generally-available-in/ba-p/3649065), which adds further layers of defense to Azure’s security profile.

As part of its confidential computing offerings, Azure integrates confidential computing into its containerized environments through Azure Kubernetes Service (AKS). AKS with confidential computing ensures that containerized applications that run on the Azure platform adhere to regional security requirements.

In particular, AKS allows businesses to deploy containers in more secure enclaves, ensuring that the data that's processed inside these containers is never exposed to external threats. Moreover, with AKS, organizations can specify the region in which their confidential containers are deployed, ensuring that their data stays in the geographical boundaries that are set by data sovereignty laws. This capability is a significant advantage for businesses that want to scale their containerized applications while adhering to strict compliance requirements.

For more information, see [AKS Confidential Containers](/azure/aks/confidential-containers-overview).
