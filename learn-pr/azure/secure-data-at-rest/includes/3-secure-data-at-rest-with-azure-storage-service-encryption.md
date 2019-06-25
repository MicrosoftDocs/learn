<!--Introductory paragraph topic sentence

Summary: A sentence that helps the learner prepare for the upcoming content. This makes sure to set the learner's expectations about what they're going to accomplish.

Scenario sub-task

Summary: A couple of sentences that specifies which section of the overall module scenario will be covered in this unit.

Task the learner will learn to accomplish

Summary: A sentence that describes the content the learner will know by the end of the unit.
 
Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Explanatory paragraph-->

<!--Explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

<!-- Optional knowledge check -->

## Notes from design doc
**Secure data at rest with Azure Storage Service Encryption**

You have an environment which is classified as confidential. It is your company's policy to encrypt data at rest be it in the cloud or on-premises or personal device. By the end of this unit, you will be able to:

*   Understand what is Encryption at rest.
*   Why you would use Encryption at rest.
*   What is SSE
*   What is ADE
*   Understand how you would use Azure Storage Service Encryption.

Cover the following topics

*   Data at rest is inactive data that is stored physically in a digital form (e.g IaaS operating systems, databases, files)
*   Encryption at Rest is the encoding (encryption) of data when it is persisted.
*   Microsoft offers Azure Storage Service Encryption for data at rest for its storage accounts
*   Whilst it is unlikely a physical hard disk in an Azure datacenter would be stolen (compared to losing a laptop), it is important to put in place safeguards in place to meet your organization's obligations and strategy for classified data.
*   Azure Storage Service Encryption (SSE) for data at rest helps you protect your data to meet your organizational security and compliance commitments.
*   SSE supports the following storage types:

    *   Azure Blob
    *   Azure Table Storage
    *   Azure Files
    *   Azure Queue Storage
    *   Azure Managed Disks
*   SSE key features:

    *   SSE is encrypted through 256-bit AES encryption - one of the strongest block ciphers
    *   SSE is enabled for all new and existing storage accounts and cannot be disabled
    *   Data is secured by default,  in all storage tiers - both standard and premium.
    *   A storage account can be configured to use a Customer-managed Key (BYOK) for Azure Storage at Rest or a Microsoft managed Key.
    *   Microsoft managed keys are as secure as Customer-managed keys and live in an Azure Key Vault.
*   For IaaS VMs, Microsoft have Azure Disk Encryption (ADE) for Windows and Linux platforms

    *   This provides an additional layer of security defense and is NOT enabled as default.
    *   ADE leverages BitLocker for Windows and DM-Crypt for Linux
    *   ADE integrates with Azure Key Vault to manage the disk-encryption keys.
*   Azure client-side encryption for storage

    *   What is client-side encryption for storage?
    *   Why would you use client-side encryption for storage?
    *   How would you configure client-side encryption for storage in Azure?

**Knowledge check**

*   PaaS: For Azure storage managed accounts is encryption enabled as default?
*   IaaS: Is Azure Disk Encryption a replacement or additional layer of security?
*   IaaS: Is Azure Disk Encryption enabled as default?
