Your company needed to control access to highly sensitive images. Your application needed enhancements to enable it to integrate with other providers, and provide them with controlled authorization to the images.

You used the security features of Azure Storage to generate unique SAS tokens for images stored in containers. You then enhanced the flexibility and control of the SAS tokens by associating them with a stored access policy.

Without SAS and access policies, your company would likely have had to develop a custom middle tier. The cost of this development, and maintaining the middle tier, would be far greater than the elegant solution you used in these exercises.

## Learn more

To learn more about using SAS to secure your data stored in Azure Storage, visit the following articles:

- [Grant limited access to Azure Storage resources using shared access signatures (SAS)](https://docs.microsoft.com/azure/storage/common/storage-sas-overview)
- [Quickstart: Azure Blob storage client library v12 for .NET](https://docs.microsoft.com/azure/storage/blobs/storage-quickstart-blobs-dotnet)