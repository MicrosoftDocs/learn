Organizations that want to use Microsoft for Sovereignty often have strict rules about where and how their data is stored. To meet these requirements, it's crucial to set up a good key management strategy in the cloud.

Planning for encryption at the platform level usually involves identifying key management requirements, making technology choices, and selecting designs and configuration choices for the Azure services to be used.

This process involves making technical decisions across the following three areas:

- Define key management requirements.

- Select data encryption features.

- Choose key management solutions.

## Define key management requirements

Assessing what your organization needs to do to safeguard your sensitive data and cryptographic material is a key strategy in developing a plan for implementing platform-level encryption in Azure.

When it comes to key management, you need to think about technical and operational requirements for your organization. Technical requirements involve the selected cryptographic services, while operational requirements focus on certain aspects, such as performance, security, and data sovereignty.

A great starting point for deciding how to encrypt data in Azure is an organization's data classification system. You can link encryption needs to these classifications, which offers flexibility during workload migration. This tiered strategy of applying various levels of encryption solutions based on the sensitivity and importance of the data being handled allows for simpler solutions for less critical workloads. For example, you can use Microsoft-managed keys for development storage and then use more complex setups, such as customer-managed keys, for production accounts.

After encryption needs are clear, you can select the Azure features. Because some features differ from on-premises systems, it's vital to understand Azure's encryption processes and best practices.

## Select data encryption features

Determining how, where, and when to encrypt your data in Azure is an important key management strategy. Many Azure services offer encryption by using platform-managed keys, which Azure generates, stores, and manages without your involvement. This step simplifies your organization's encryption needs. However, if your organization has strict data sovereignty needs, selecting specific platform encryption features in each Azure service is crucial in helping protect sensitive data at rest.

For highly sensitive information, several Azure services allow implementation of double encryption by using customer-managed keys. While using customer-managed keys enhances protection, it can also increase costs and complexity. You should assess the need for customer-managed keys for your organization based on workload and data classification, limiting its use to the most sensitive cases to reduce operational overhead.

If a customer-managed key is required, it must be configured for each Azure service. You should establish consistent standards and repeatable design patterns to streamline deployment or migration.

## Choose key management solutions

Another main key management strategy is to decide on the appropriate key store to protect the data encryption keys that are used to encrypt your data in Azure.

While features like double encryption with customer-managed keys enhance the protection of data that's stored in Azure services, cloud-based key management solutions are essential for safeguarding the encryption keys and cryptographic materials that are used for encrypting sensitive data. If your organization has strict data sovereignty requirements, you should choose a key management solution that aligns with your assurance needs and the risk level of your workloads.

To effectively manage your keys, it's crucial for you to [choose your key management solution](/azure/security/fundamentals/key-management-choose) as part of your solution architecture.
