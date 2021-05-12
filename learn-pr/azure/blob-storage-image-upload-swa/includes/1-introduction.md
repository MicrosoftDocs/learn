You run a photo sharing application and due to scalability requirements, you had moved your storage needs to the cloud. At the same time your frontend got re-implemented as a lightweight static web application, so the only legacy part of your project is the middleware image upload handler.

The middleware is an old ASP.NET app that while it has performed its job well, it still requires a lot of maintenance on your side, including monitoring and having your developers on call to be sure the middleware stays up. Porting this piece of software into serverless will free your team from this work, while letting Azure handle the complexity of keeping your backend up and running.

A solution would be to leverage Azure Blog Storage directly by allowing your users to upload images right from their browsers to your storage containers. This poses a challenge though, how to grant your users access to your storage account without compromising the security of your data? You would like to find a way to allow your users to upload images while keeping your storage account secure.

Using Shared Access Signatures, you could grant access to your storage account in a fine grained way. Since every new user session will require a new Shared Access Signature, you need a way to generate them on demand.

By using an Azure Function, you can generate Shared Access Signatures on demand, and deliver them to your users’ browsers via an API. In this way you modernize your infrastructure, make your developers life easier, and your users remain happy using your website.

## In this module you will

- Evaluate when to use Shared Access Signatures (SAS) to grant access to Azure Blob Storage.
- Generate SAS tokens on demand to authenticate image upload requests.
- Use the SAS token to upload an image to Azure Blob Storage.
- Implement file uploads in a Static Web App by following security best practices.
