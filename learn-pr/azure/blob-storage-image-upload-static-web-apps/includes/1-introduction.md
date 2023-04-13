Azure Blob Storage lets you serve files to your users in a fast and reliable way, which can be a key resource to having a responsive website that your users love. You can use Blob Storage to cover your application's static file needs, whether that's uploading images or serving images to the user. While serving files is the easy part, uploading images requires you grant your users access to your Blob Storage account. Azure offers a safe and secure solution to do just that. In this module, we're going to explore image uploading in a secure way. 

Imagine the following scenario: You run a photo-sharing application, and because of scalability requirements, you moved your storage needs to the cloud. At the same time, your frontend got reimplemented as a lightweight static web application, so the only legacy part of your project is the middleware image-upload handler.

The middleware is an old ASP.NET app that, while it's done its job well, still requires heavy maintenance on your side, including monitoring and having your developers on call to be sure the middleware stays up. Porting this piece of software into serverless will free your team from this work. At the same time, this lets Azure handle the complexity of keeping your backend up and running.

A solution is to use Azure Blog Storage directly by allowing your users to upload images right from their browsers to your storage containers. This solution poses a challenge, though: how do you grant your users access to your storage account without compromising the security of your data? You'd like to find a way to allow your users to upload images while keeping your storage account secure.

Using shared access signatures, you could grant access to your storage account in a fine grained way. Because every new user session will require a new shared access signature, you need a way to generate signatures on demand.

By using an Azure Function, you can generate shared access signatures on demand and deliver them to your users’ browsers via a REST API. In this way, you modernize your infrastructure, make your developers' lives easier, and give your users an improved experience by getting their images from the optimized Azure Storage servers.

## In this module, you'll discover how to:

- Evaluate when to use shared access signatures (SAS) to grant access to Azure Blob Storage.
- Generate SAS tokens on demand to authenticate image upload requests.
- Use the SAS token to upload an image to Azure Blob Storage.
- Implement file uploads in a Static Web App by following security best practices.
