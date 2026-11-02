Azure confidential computing is a Microsoft solution for securing sensitive data-in-use by applying Trusted Execution Environments (TEEs). By processing data in hardware-based and attested TEEs, Azure allows businesses to run sensitive workloads without the risk of exposure to unauthorized users, including cloud administrators. Microsoft for Sovereignty customers can use the [Sovereign Landing Zone](/industry/sovereignty/slz-overview) to streamline the adoption of Microsoft confidential computing features in a compliant and sovereign environment.

### Data security and privacy

Azure relies on hardware-based technologies, such as secure enclaves and confidential virtual machines (confidential VMs), which guarantee that the data and code being processed remain confidential and more protected from external threats, including malware, insider threats, or even administrators of the cloud infrastructure. Azure also integrates these hardware-based technologies into its infrastructure as a service (IaaS) and platform as a service (PaaS) offerings, simplifying the adoption of Azure confidential computing for organizations.

### Scalability

Azure confidential computing is designed to support workloads at any scale by using the vast global network of Azure data centers, which helps ensure scalability. This capability allows organizations to more securely process large amounts of sensitive data, while ensuring that performance remains consistent and reliable across a wide array of use cases.

### Compatibility

Azure confidential computing service is built to be compatible with open standards. This capability makes it easier for businesses to integrate this technology into their existing environments, regardless of the tools and platforms they're already using. The platform also offers support for multiple programming languages and frameworks, which allows developers to build more secure applications without having to change the underlying architecture.

### Flexible deployment models

Azure confidential computing supports multiple deployment models to cater to different security requirements. The infrastructure as a service (IaaS) model allows for the use of confidential VMs or application enclaves, making it suitable for organizations that need full control over their computing environment and security boundaries. The platform as a service (PaaS) model, which uses Microsoft Azure Kubernetes Service (AKS) for confidential containers, offers a more flexible, modern approach to building and deploying more secure applications in the cloud.

For more information on Azure offerings, see [Confidential Computing on Azure](/azure/confidential-computing/overview-azure-products), [Confidential Computing Solutions](/azure/confidential-computing/confidential-computing-solutions), and [deployment models](/azure/confidential-computing/confidential-computing-deployment-models).

### More secure migration of legacy applications

For users who want to lift and shift existing applications into the cloud without modifying source code, Azure provides confidential VMs based on technologies like [AMD SEV-SNP](https://www.amd.com/en/developer/sev.html) or [Intel TDX](https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/overview.html). These VMs provide isolation for entire virtualized environments, ensuring that data and code that run inside them are more protected from unauthorized access by the host or other privileged entities. This capability is beneficial for legacy applications that need to be more securely migrated to the cloud without reengineering.

### Secure application enclaves

For workloads that require higher security, particularly those involving proprietary code or sensitive business logic, Azure offers secure application enclaves by using Intel Software Guard Extensions (SGX). Intel SGX provides hardware-based memory encryption, allowing portions of a virtual machine’s memory to be isolated in secure enclaves. This technology ensures that hypervisors, operating systems, or high-privileged administrators can't access the data and code inside the enclave, which helps provide a higher level of protection for mission-critical applications.

However, this approach is only suitable for applications that you're developing specifically for Azure confidential computing because they need to be coded to take advantage of Intel SGX technology. A lift-and-shift approach isn't supported in this case.

If you're seeking a more flexible and easier-to-adopt solution, container-based approaches might be more appropriate.

### App-enclave aware containers

For modern, cloud-native applications, Azure supports [App-enclave aware containers](/azure/confidential-computing/enclave-aware-containers) on Azure Kubernetes Service (AKS). Containers provide agility and portability for cloud-native applications, but they can introduce challenges in ensuring data confidentiality. With Azure confidential containers, workloads that run in these containers benefit from the same hardware-encrypted isolation that protects VMs, ensuring that data-in-use is kept more secure. This capability is ideal for businesses that want to build scalable and multicloud solutions with robust security for sensitive data.

### Support for emerging technologies

New technologies, such as GPU designs with TEE support ([NVIDIA offering currently in preview](https://azure.microsoft.com/blog/azure-confidential-computing-with-nvidia-gpus-for-trustworthy-ai/)), are expanding the potential of CPU TEE by allowing secure collaboration to [deliver trustworthy AI](https://azure.microsoft.com/blog/azure-confidential-computing-with-nvidia-gpus-for-trustworthy-ai/) by using Azure.

### Sovereignty and data protection

Azure confidential computing enhances sovereignty by providing confidentiality of the entire root of trust, from hardware to application. Azure confidential virtual machines (confidential VMs), such as the [Azure DCasv5 and DCadsv5-series](/azure/virtual-machines/dcasv5-dcadsv5-series), provide hardware isolation to help protect data in memory from other virtual machines, hypervisors, and host management code. Even with administrative access, Azure engineers can't access customer data in the VM. This isolation ensures that sensitive workloads are more securely processed, with pre-encrypted OS disks and key management solutions further enhancing security before the VM is provisioned.

By supporting security and sovereignty in Azure confidential computing, with flexible deployment options, strong encryption, and hardware-based isolation, Azure provides the security, scalability, and compliance that's required for even the most sensitive applications and data.

For more information, see [Sovereignty and Confidential Computing](/industry/sovereignty/azure-confidential-computing).
