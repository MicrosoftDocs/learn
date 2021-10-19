Azure **Storage Service Encryption** (SSE) for data at rest protects your data by ensuring your organizational security and compliance commitments are met.

SSE automatically encrypts your data before persisting it to Azure-managed Disks, Azure Blob, Queue, Table storage, or Azure Files, and decrypts the data before retrieval.

SSE encryption, encryption at rest, decryption, and key management are transparent to users. All data written to the Azure storage platform is encrypted through 256-bit AES encryption, one of the strongest block ciphers available.

:::image type="content" source="../media/secure-encryption-e3b68445.png" alt-text="Screenshot of the Encryption page. Two radio buttons, Microsoft Managed Keys, and Customer Managed Keys are shown.":::


> [!NOTE]
> SSE is enabled for all new and existing storage accounts and cannot be disabled. Because your data is secured by default, you don't need to modify your code or applications.
