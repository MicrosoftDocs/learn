# Introduction

You run a photo sharing application and due to scalability requirements, you just moved your storage needs to the cloud. You need to allow your users to upload images directly from their browsers. This poses the challenge on how to grant them access to your storage account without compromising the security of your data. You would like to find a way to allow your users to upload images while keeping your storage account secure.

Using Shared Access Signatures, you could grant access to your storage account, but since every new user session will require a new Shared Access Signature, you need a way to generate them on demand.

By using an Azure Function, you can generate Shared Access Signatures on demand, and deliver them to your users’ browsers via an API.

## In this module you will

- Evaluate when to use Shared Access Signatures (SAS) to grant access to Azure Blob Storage.
- Generate SAS tokens on demand to authenticate image uploads request.
- Use the SAS token to upload an image to Azure Blob Storage.
- Implement file uploads in a Static Web App by following Security Best Practices.
