Contoso is deploying AI-powered document processing pipelines in Azure. AI agents running in Azure Functions upload, read, and process documents stored in Azure Blob Storage. During a security audit, the cloud security team discovered that storage account keys are stored in application configuration settings—a practice that creates significant security risk. Storage account keys provide unrestricted access to the entire storage account, and any compromise exposes all business data. The team is asked to eliminate shared key access and migrate to modern identity-based authentication.

Contoso's cloud security team takes on the challenge directly. They start by locking down foundational account settings—requiring encrypted connections, enforcing modern Transport Layer Security (TLS), and ensuring no data is accidentally exposed through anonymous access. From there, they work through the authorization problem: evaluating the three authorization models available in Azure Storage and understanding why managed identities are the right fit for AI agents running in Azure Functions. When external vendors need temporary access to specific documents, the team uses stored access policies to issue revocable SAS tokens—so they can cut access instantly without touching the storage account keys. The final step is eliminating those keys entirely, disabling Shared Key authorization, and enforcing that policy across every storage account through Azure Policy.

## Learning objectives

After completing this module, you'll be able to:

- Configure storage account security settings including secure transfer, minimum TLS, and anonymous access controls
- Select an appropriate authorization model for different access scenarios including managed identity for AI agent workloads
- Create and manage stored access policies to control SAS token lifecycle
- Disable Shared Key authorization and enforce compliance using Azure Policy 
