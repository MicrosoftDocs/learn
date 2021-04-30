You run a photo sharing application and due to scalability requirements, you migrated your storage to the cloud. You need to allow your users to upload images directly from their browsers. This poses a security challenge. How to grant your users access to your storage backend without compromising the security of your data. You would like to find a way to allow your users to upload images while keeping your storage account safe.

Using Shared Access Signatures, you could grant access to your storage account, but since every new user session will require a new Shared Access Signature, you need a way to generate them on demand.

By using an Azure Function, you can generate Shared Access Signatures on demand, and deliver them to your users’ browsers via an API.

## In this module you will

- Evaluate when to use Shared Access Signatures (SAS) to grant access to Azure Blob Storage.
- Generate SAS tokens on demand to authenticate image uploads request.
- Use the SAS token to upload an image to Azure Blob Storage.
- Implement file uploads in a Static Web App by following Security Best Practices.
