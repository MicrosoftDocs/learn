Confidential analytics services in Azure help organizations perform advanced data processing and analytics while ensuring that sensitive data remains private and more secure throughout the entire process. With the increasing need for organizations to gain insights from data while adhering to strict privacy and security regulations, confidential computing plays a pivotal role in providing more secure, scalable, and compliant analytics workloads. Microsoft for Sovereignty helps customers use services that the following sections describe.

### Query encrypted data with secure enclaves in Azure SQL

Always Encrypted with secure enclaves in Azure SQL enhances data confidentiality by allowing computations on sensitive data directly in a secure enclave on the server. This feature overcomes limitations of the traditional Always Encrypted service, which restricted operations on encrypted data to client-side processing.

With secure enclaves, organizations have access to richer queries (such as pattern matching) and in-place encryption tasks (such as key rotation) in the database while they're maintaining robust data protection. The secure enclave ensures that sensitive data remains confidential, shielding it from malware and unauthorized access.

For more information see [Always Encrypted with secure enclaves](/sql/relational-databases/security/encryption/always-encrypted-enclaves?view=sql-server-ver16&preserve-view=true).

### Azure Databricks with confidential computing VMs

Azure Databricks with Confidential computing VMs allows organizations to run analytics, machine learning, and other workloads in a more secure and privacy-preserving manner by using Azure confidential computing technology. This feature underscores Azure's dedication to enhancing cloud security by allowing customers to process sensitive data without compromising its confidentiality.

The supported VMs, such as DC and EC series VMs, feature AMD EPYC™ processors, which offer memory encryption to protect data during computation. While Azure Databricks with Confidential computing VMs provide a strong base, other products from Azure Databricks, such as [Unity Catalog](https://www.databricks.com/product/unity-catalog), [Delta Sharing](https://www.databricks.com/product/delta-sharing), and [Enhanced Security and Compliance Add-On in Security & Trust Center](https://www.databricks.com/trust/protect-your-data-with-enhanced-security-and-compliance), can provide enhanced security, compliance, and privacy.

For more information, see [Azure Databricks with Confidential computing VMs](https://techcommunity.microsoft.com/t5/azure-confidential-computing/confidential-vm-option-for-azure-databricks-preview/ba-p/3827982).

### Azure Virtual Desktop

Microsoft Azure Virtual Desktop ensures that a user’s virtual desktop is encrypted in memory, more protected in use, and backed by hardware root of trust.

### Confidential IoT Edge

The rapid growth of IoT introduces new security challenges because Microsoft Azure IoT Edge devices are often deployed outside the customer’s control, which makes them vulnerable to tampering and compromise. 

Confidential IoT Edge addresses these risks by allowing more secure workloads on IoT Edge devices by using Trusted Execution Environments (TEEs), which help protect data and applications in use. It extends Azure confidential computing to edge devices, allowing for more secure implementation of sensitive workloads in environments with increased physical exposure, therefore bridging cloud-level security with edge-level operations.

Azure IoT Edge supports confidential applications that run within TEEs, ensuring that they're encrypted in transit and at rest and that they're only decrypted in the secure enclave at runtime. Developers package these applications as IoT Edge modules, which keeps them encrypted until they're deployed on the device.

IoT Edge security manager further enhances security by using hardware security modules to protect device identity and processes.

For more information, see [Confidential IoT Edge](/azure/iot-edge/deploy-confidential-applications?view=iotedge-1.4&preserve-view=true).

### Microsoft Azure confidential ledger

Microsoft Azure confidential ledger is a service that helps organizations securely manage sensitive data records with unparalleled integrity and protection.

Azure confidential ledger uses the [Azure confidential computing platform](/azure/confidential-computing) and the [Confidential Consortium Framework](https://www.microsoft.com/research/project/confidential-consortium-framework) to offer a high-integrity, tamper-evident solution. Confidential Consortium Framework (CCF) is an open-source framework for building highly available stateful services that apply centralized computation for ease of use and performance while providing decentralized trust.

Operating exclusively on hardware-backed secure enclaves, Azure confidential ledger provides a monitored and isolated runtime environment that safeguards against tampering and unauthorized access, ensuring that data records remain immutable.

A ledger in Azure confidential ledger is a tamper-proof, cryptographically verifiable record storage that's designed for more secure and immutable data storage. Each ledger spans multiple identical instances that run in fully attested enclaves with data integrity enforced through a [consensus-based blockchain](/azure/architecture/guide/blockchain/multiparty-compute#azure-confidential-ledger).

The ledger supports append-only operations, which makes it ideal for storing unalterable records, such as business transactions, updates to trusted assets, access permissions, and operational IT/security events. Integration is seamless through REST APIs, which offer administrative controls for ledger management and functional APIs for direct data interactions.

Azure confidential ledger architecture ensures that no one, not even Microsoft, can modify the ledger. As a result, it's ideal for use cases that require robust compliance and archival protection. By providing immutability, tamper-proofing, and more secure data storage, Microsoft Azure confidential ledger empowers businesses to confidently manage critical metadata and comply with stringent regulatory requirements.

For more information, see [Microsoft Azure confidential ledger](/azure/confidential-ledger/overview).
