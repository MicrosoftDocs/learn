Microsoft for Sovereignty empowers governments and regulated industries to more securely configure and protect their data and resources, ensuring compliance with complex regulatory, security, and sovereignty requirements.

Confidential computing is an industry term from the [Confidential Computing Consortium (CCC)](https://confidentialcomputing.io/), a foundation dedicated to defining and accelerating the adoption of confidential computing.

Traditional security methods protected data at rest and in transit; however, they left data vulnerable during active use in RAM and during computation. Confidential computing represents a transformative approach to data security in the cloud with primary focus on safeguarding data-in-use.

Confidential computing allows for more secure processing of sensitive data, proprietary algorithms, and applications. Coupled with the scalability and compliance tools of Azure, it ensures robust protection across the entire data life cycle for sovereign cloud operations.

Typical use cases that require confidential computing include [Anti-money laundering](https://www.databricks.com/blog/2021/07/16/aml-solutions-at-scale-using-databricks-lakehouse-platform.html), [Fraud prevention](https://www.databricks.com/solutions/accelerators/fraud-detection), and [Adverse Drug Event Detection](https://www.databricks.com/solutions/accelerators/adverse-drug-event-detection).

By addressing data security during all stages of its life cycle, confidential computing strengthens data sovereignty by ensuring that sensitive data remains in the control of the rightful authorities, therefore minimizing risks that are associated with external threats.

### Trusted Execution Environment

Confidential computing protects data in use by using hardware-based Trusted Execution Environments (TEEs). A Trusted Execution Environment (TEE) is a secure area within a CPU and its memory that protects sensitive data and code from external interference. A TEE enforces implementation of only authorized code. Code that's outside of the TEE can't read or tamper with data in the TEE.

TEEs form the basis of the confidential computing threat model, which aims to remove or reduce the ability for a cloud provider operator and other actors in the tenant's domain to access code and data while they're being run. It provides a level of assurance of isolation, data confidentiality, and data and code integrity, adding layers of protection for sensitive workloads.

Key features of a TEE include: 

- **Isolation** - By using encryption, TEEs create an isolated environment where data and computations remain more secure against malicious software or unauthorized access. This ensures robust data security and integrity for sensitive workloads. TEEs isolate computations, ensuring that only authorized code can be run on the data, and it safeguards data from tampering or unauthorized access.

- **Confidentiality**- Confidentiality ensures that code and data are more protected from manipulation by the operating system or other applications. TEEs address key threats, minimizing trust in system processes, administrators, and operators. Unauthorized access to the data isn't allowed while the data is in use in the TEE.

- **Integrity** - Integrity of code and data prevents tampering, maintains trust in implementation, and ensures accuracy of results. Unauthorized alteration of data isn't allowed while the data is used in the TEE. Unauthorized code alteration isn't allowed in the TEE.

For more information, see [Trusted Execution Environment](/azure/confidential-computing/trusted-execution-environment).

### Hardware root of trust

Hardware root of trust is essential for ensuring the integrity and security of the Trusted Execution Environment (TEE).

TEE protection needs hardware support to prevent cloud operators from breaking isolation through software emulation. Each TEE-capable device should have a unique, cryptographically secured identity that's created with a hardware secret. You can record this secret in the device's fuse banks at the end of manufacturing, and then the manufacturer can use the public key to issue the platform certificate.

The hardware root of trust plays a key role in validating that the customer workload is securely running in a TEE by generating cryptographic proofs, ensuring the integrity of the Confidential Computing environment.

### Trusted Compute Base

The **Trusted Compute Base (TCB)** refers to all hardware, firmware, and software components that are critical in providing a secure environment. These components are essential for maintaining system security. Any compromises in the TCB can jeopardize the entire system. In a traditional computing environment, the assumption is that the entire layer from the host to the application is the *Trusted Computing Base (TCB)*. 

However, a Confidential Computing environment significantly reduces the potential attack surface by creating secure encrypted zones known as *enclaves*. An enclave is inaccessible to unauthorized entities. Data that needs to be processed is decrypted in the enclave, and only code with the proper authorization can access this data. Even the cloud platform provider can't access the enclave because they don't possess the access keys that are required for entry.

Other components that the cloud provider manages, such as the host OS, hypervisor, BIOS, and device drivers, have no visibility or access to the customer’s workload. These external elements reside outside the TCB.

TCB definition can be mapped to individual code functions or to the entire virtual machines inside the TEE to support lift-and-shift scenarios of existing workloads. This flexibility allows customers to choose the level of TCB granularity that best meets their needs, balancing confidentiality with ease of adoption.

For more information, see [Trusted Compute Base](/azure/confidential-computing/trusted-compute-base)

### Confidential computing framework

Confidential computing provides a robust framework for addressing modern security concerns, particularly in the following scenarios:

**Collaborative computing** - Organizations can more securely share and analyze sensitive datasets without exposing proprietary information.

**Cloud migration** - Businesses that are hesitant about moving to the cloud due to data privacy concerns can now apply the cloud without compromising security.

**Regulatory compliance** - Confidential computing simplifies compliance with stringent data privacy regulations by ensuring that data remains more protected during processing.

Confidential computing is a cornerstone in addressing modern security challenges, where sensitive data, such as personal records and trade secrets, require the highest levels of protection. By implementing confidential computing, enterprises can build customer trust, reduce risks of data breaches, mitigate insider threats, malware, and unauthorized data access, and innovate with sensitive workloads.

To learn more, see [Confidential Computing Overview](/azure/confidential-computing/overview)

### Attestation

The process of attestation verifies the authenticity and trustworthiness of the computing systems, including hardware and software components.

- **Trusted Execution Environment (TEE) or "Attester"** - Submits evidence to an attestation service.

- **Attestation service or "Verifier"** - Evaluates the trustworthiness of the system based on the evidence provided by the Attester against the appraisal policies that validate the authenticity by issuing an Attestation result.

- **Relying Party (such as a Secrets Manager)** - Receives the Attestation result, confirming system integrity before proceeding with secure operations.

The two primary models for attestation in cloud computing are the [Passport Model](/azure/confidential-computing/attestation-solutions#passport-model) and the [Background Check Model](/azure/confidential-computing/attestation-solutions#background-check-model). Attestation services can be used to two different ways: cloud provider-based services and custom-built solutions. Both ways have their own benefits.

For more information, see [Attestation](/azure/confidential-computing/attestation-solutions).
