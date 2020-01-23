Your company needed to control the access to images that are highly sensitive. Your application needed enhancements to enable it to integrate with other providers, and provide them with controlled authorization to the images.

You made use of the security features of Azure Storage, to generate unique SAS tokens for images stored in containers. You then enhanced the flexibility and control of the SAS tokens by associating them with a stored access policy.

Without SAS and access policies your company would have likely had to develop a custom middle tier. The costs of this development, and then maintaining the middle tier being far greater than the elegant solution you used in these exercises.

## Additional resources

- [Grant limited access to Azure Storage resources using shared access signatures (SAS)](https://docs.microsoft.com/azure/storage/common/storage-sas-overview)
- [Quickstart: Azure Blob storage client library v12 for .NET](https://docs.microsoft.com/azure/storage/blobs/storage-quickstart-blobs-dotnet)