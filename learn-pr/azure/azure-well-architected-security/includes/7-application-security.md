Hosting applications on a cloud platform provides a number of advantages when compared to traditional on-premises deployments. The cloud's shared-responsibility model moves security at the physical network, building, and host levels under the control of the cloud provider. An attacker trying to compromise the platform at this level would see diminishing returns versus the considerable investment and insight providers make in securing and monitoring their infrastructure.

It's therefore far more effective for attackers to pursue vulnerabilities introduced at the application level by cloud-platform customers. Furthermore, by adopting Platform as a Service (PaaS) to host their applications, customers are able to free resources from managing operating system security and deploy them to harden application code and monitor the identity perimeter around the application. In this unit we will discuss some of the ways application security can be improved through design.

## Scenario

Imagine you work for a healthcare organization whose customers require access to their personal medical records through an online web portal. Compliance with the Health Insurance Portability and Accountability Act (HIPAA) is mandatory and puts the company at significant risk of financial penalties if a breach of personal data occurs; therefore, securing the application and personal data it interacts with is paramount.

The primary areas that concern customer applications are:

- Secure application design
- Data security
- Identity and access management
- Endpoint security

## Security Development Lifecycle

Microsoft's [Security Development Lifecycle](https://www.microsoft.com/sdl) (SDL) process can be used during the application design stage to ensure security concerns are incorporated in the software development lifecycle. Security and compliance issues are far easier to address when designing an application and can mitigate many common errors that can lead to security flaws in the final product. Fixing issues early in the software development journey is also far less costly. The typical sequence of SDL steps a software project can use are as follows:

![An illustraton showing the Security development lifecycle](../media/sdl.png)

The SDL is as much a cultural aspect as it is a process or set of tools. Building a culture where security is a primary focus and requirement of any application development can make great strides in evolving an organization's capabilities around security.

## Operational security assessment

Once an application has been deployed, it's essential to continually evaluate its security posture, determine how to mitigate any issues that are discovered, and feed the knowledge back into the software development cycle. The depth to which this is performed is a factor of the maturity level of the software development and operational teams as well as the data privacy requirements.

Security vulnerability scanning software services are available to help automate this process and assess security concerns on a regular cadence, without burdening teams with costly manual processes, such as penetration testing.

Azure Security Center is a free service, now enabled by default for all Azure subscriptions, that is tightly integrated with other Azure application level services, such as Azure Application Gateway and Azure Web Application Firewall. By analyzing logs from these services, Security Center can report on known vulnerabilities in real time, recommend responses to mitigate them, and even be configured to automatically execute playbooks in response to attacks.

## Identity as the perimeter

Identity validation is becoming the first line in defense for applications. Restricting access to a web application by authenticating and authorizing sessions can drastically reduce the attack surface area. Azure AD and Azure AD B2C offer an effective way to offload the responsibility of identity and access to a fully managed service. Azure AD conditional access policies, privileged identity management, and Identity Protection controls further enhance a customer's ability to prevent unauthorized access and audit changes.

## Data protection

Customer data is the target for most, if not all attacks against web applications. The secure storage and transport of data between an application and its data storage layer is paramount.

Your organization stores and accesses particularly sensitive patient medical record data. HIPAA, enacted by the United States Congress in 1996, among other controls, defines the national standards for electronic healthcare transactions by healthcare providers and employers. They must ensure patients and authorized parties, such as their physicians, have secure access to medical data.

To comply with these requirements, your organization has modified their applications to encrypt all patient data at rest and in transit. For example, Transport Layer Security (TLS) is used to encrypt data exchanged between the web application and back-end SQL databases. Data is also encrypted at rest in SQL Server using Transparent Data Encryption (TDE), ensuring that even if the environment is compromised, data is effectively useless to anyone without the correct decryption keys.

To encrypt data stored in blob storage, client-side encryption can be used to encrypt the data in memory before it's written to the storage service. Libraries supporting this encryption are available for .NET, Java, and Python, and enable the integration of data encryption directly into applications to enhance data integrity.

### Secure key and secret storage

Separating application secrets (connection strings, passwords, etc.) and encryption keys from the application used to access data is vital. Encryption keys and application secrets should never be stored in the application code or configuration files. Instead, a secure store such as Azure Key Vault should be used. Access to this sensitive data can then be limited to application identities through Managed Service Identities, and keys can be rotated on a regular basis to limit exposure in the case of encryption key leakage. Customers can also choose to use their own encryption keys generated by on-premises Hardware Security Modules (HSM) and even mandate that Azure Key Vault instances are implemented in single-tenant, discrete HSMs.
