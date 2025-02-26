As in many organizations, Contoso's executive team prioritizes data and application privacy. Contoso systems handle significant amounts of sensitive data, intellectual property, and government solutions around the world. For that reason, you want to understand how CPU-enabled, secure computing in Azure can help your organization protect data and applications.

You're also working on machine-learning models that use sensitive data that Contoso considers intellectual property. What if Contoso could set up a secure environment in Azure and run machine-learning workloads to speed analysis by using preferred machine-learning frameworks? To make a business case for this workload, you want to be able to communicate how Microsoft addresses data privacy and security in its cloud operations. You also want to be able to describe new developments that can help secure data and the execution of applications.

## Data privacy and security

As you learn, Microsoft takes data privacy and security seriously. All data is encrypted at rest and in transit to help ensure privacy and security. Data is encrypted and triple-replicated in a datacenter for secure availability of 11 nines. For even higher availability, this encrypted data can be replicated across availability zones and even across geographies with the same level of security.

Microsoft even implements immutable data concepts in both blob storage and SQL Server in Azure to ensure that data is never changed. You begin to understand that you can help Contoso enable secure, highly available, and immutable data. You also have interest in Microsoft's award-winning blockchain technology, which Contoso might include in its global purchasing environment.

Microsoft doesn't inspect, approve, or monitor applications that customers deploy to Azure. Moreover, Microsoft doesn't know what kind of data customers choose to store in Azure. Microsoft doesn't claim ownership of any of the data or information that customers enter into Azure.

By default, Microsoft operations and support can't access customer data. When customers grant access to data related to a support case, access is granted with a just-in-time model that uses policies that are audited and vetted against Microsoft compliance and privacy policies. The following Azure security policies establish access-control requirements:

- No access to customer data, by default.

- No user or administrator accounts on customer VMs.

- Grant the least privilege required to complete the task, and audit and log access requests.

Your CIO (Chief information officer) wants to understand how Microsoft addresses a few other concerns, which include:

**Data destruction**: When customers delete data or leave Azure, Microsoft follows strict policies for deleting data. Microsoft also systematically destroys decommissioned hardware.

**Records management**: Microsoft establishes internal records-retention requirements for back-end data. Contoso is responsible for identifying its own record retention requirements, like extracting data and retaining content outside of Azure for the retention period. Microsoft allows customers to export data and audit reports from Azure and save them locally.

**Cloud security investments**: Microsoft invests over $1 billion annually in security. It has 3,500 security experts and tracks over 6.5 trillion security-related signals every day. Microsoft also runs the Microsoft Security Response Center to protect customers and Microsoft from current and emerging threats related to security and privacy.

Compared to what it's able to do on-premises Contoso can strengthen its security and privacy posture for global operations by using the Microsoft Cloud.

## Confidential computing

To replace its secure datacenters, you know that Contoso requires high security and confidentiality, which is why Microsoft's Confidential Computing initiatives are so vital to your research.

*Confidential computing* is an industry term defined by the [Confidential Computing Consortium](https://confidentialcomputing.io/) (CCC) - a foundation dedicated to defining and accelerating the adoption of confidential computing. The CCC defines confidential computing as "the protection of data in use by performing computations in a hardware-based trusted execution environment (TEE)."

A TEE is an environment that enforces execution of only authorized code. Any code outside that environment can't read or tamper with any data in the TEE. This capability enhances the security of the application while it's being executed in the CPU.

The confidential computing threat model minimizes the ability of a cloud provider and other actors in the tenant's domain to access code and data as it's being executed.

![Graphic illustration showing three states of data protection, with confidential computing's data in use highlighted.](../media/data-protection-states.png)

When used with data encryption at rest and in transit, confidential computing protects sensitive or highly regulated datasets and application workloads in a secure public cloud platform. Confidential computing extends beyond generic data protection. Trusted execution environments are also being used to protect proprietary business logic, analytics functions, machine-learning algorithms, and entire applications.

## Reducing the attack surface

The trusted computing base (TCB) refers to all of the system's hardware, firmware, and software components that provide a secure environment. All the components inside the TCB are considered to be critical. If one component inside the TCB is compromised, the security of the entire system can be jeopardized.

Azure confidential computing makes it easier to trust the cloud provider by reducing the need for trust across the compute cloud infrastructure - the host operating system kernel, the hypervisor, the virtual machine (VM) admin, and the host admin.

Azure confidential computing enables these key security capabilities:

- **Prevent unauthorized access**: Run sensitive data in the cloud. Trust that Azure provides the best data protection possible, with little to no change from what gets done today.

- **Meet regulatory compliance**: Migrate to the cloud, keep full control of data to satisfy government regulations for protecting personal information, and secure organizational IP.

- **Ensure secure and untrusted collaboration**: Comb data across organizations (even competitors), to unlock broad data analytics and deeper insights that you can use to tackle industry-wide work-scale problems.

- **Isolate processing**: Offer a new wave of products that remove liability on private data by using blind processing. Even the service provider can't retrieve user data.

Bringing confidential computing to life in Azure are technologies like [Intel Software Guard Extensions (SGX)](https://www.intel.com.au/content/www/au/en/architecture-and-technology/software-guard-extensions-enhanced-data-protection.html) and [AMD Secure Encrypted Virtualization](https://www.amd.com/en/developer/sev.html) (SEV-SNP). These CPU technologies are delivered as virtualization extensions. They provide feature sets for building the confidential computing threat model that includes memory encryption and integrity, CPU-state confidentiality and integrity, and attestation.

Remember that secure environment you were thinking Contoso could build in Azure to run machine-learning workloads? Confidential computing appears to be key. Azure confidential computing powered by NVIDIA GPU VMs is a capability that's available in public preview. It brings together trusted-VM security with secure boot and vTPM coupled with up to four NVIDIA A100 Tensor Core GPUs. You get an added layer of confidence knowing that the GPU-enabled VM boots and runs within a trusted environment. Contoso could take advantage of GPU performance for its workloads while the confidentiality of Contoso data remains intact.

Making sure these security options are supported in your Azure region is important when you need to place applications and databases in the cloud that require confidential computing or extra privacy.
