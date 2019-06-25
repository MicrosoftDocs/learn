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
**Keep your keys and secrets safe using Azure Key Vault**

Your company's Intellectual Property is it's application source code. As such, it is classified as confidential and you need to ensure no credentials or certificates are hard coded or shared into source code management products. By the end of this unit you will be able to:

*   Understand what is Azure Key Vault.
*   Understand why you would use Azure Key Vault.
*   Understand how you would use Azure Key Vault.
*   Understand the use case for consuming Azure Key Vault with managed identities

Discuss the following topics:

*   When securing code there is sensitive information you want to protect, for example:

    *   Connection strings, such as a Database connection string
    *   Encryption keys used in your application to encrypt your data
    *   Certificates. E.G. x509 certificates used in HTTPS/SSL communications which consist of a private and a public key, both of which should be stored securely.
    *   For the storing of these, we can use Azure Key Vault
*   Azure Key Vault:

    *   Centralized, secure key management
    *   Azure Key Vault provides a way to securely store credentials, secrets, and other keys
    *   Have the ability to Grant/Revoke access to people and applications using either the portal or the CLI
    *   Provides auditing and logging abilities
    *   Key rotation and versioning to ensure they are not compromised.
    *   Versioning is important if you use Azure key vault to encrypt your Data at rest and rotate that key - your data will no longer accessible. With versioning,  you keep all versions of the key - which will allow you to decrypt your disk.
    *   By separating credentials from code, and keeping them in Azure Key Vault you reduce the possibility of your credentials being pushed to a source code management tool such as GitHub and being compromised externally.
    *   Hardware Security Module (HSM).  Azure Key Vault gives you the option to backend to HSM. This takes your key and keeps a copy in a secure device for added security ensuring tamper resistance
    *   Natively supported by other Microsoft Azure services (e.g Database, Storage, App Services), and also accessible via API/PowerShell and CLI

**Knowledge Check**

*   Should credentials for a confidential environment be stored in plain text or a centralized, auditable tool?
*   What is Managed identities used for?
*   For a system-assigned managed identity, would credential be automatically deleted if the instance was deleted?
