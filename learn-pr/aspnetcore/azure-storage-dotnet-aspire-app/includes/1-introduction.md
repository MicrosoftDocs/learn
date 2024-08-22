Cloud-native applications consist of microservices, each of which implements a small part of the app's complete functionality and is independent of the others. Although each microservice is unique, it's common to need to store files or data. Additionally, to communicate robustly with other microservices, they often make use of message queues. Azure Storage includes services that can satisfy these requirements. It's easy to call those services by using out-of-the-box .NET Aspire components.

Imagine that you work for an outdoor equipment retailer. Your new public-facing eShop, which uses .NET Aspire, must store files, such as product images, and product metadata. You also want to queue messages for communications between microservices. You want to find out if Azure Storage is an efficient and scalable location for this information.

In this module, you'll see how to use built-in components to access an Azure Storage account and store and retrieve files, data rows, and messages.

## Learning objectives

At the end of this module, you'll be able to:

- Use the .NET Aspire Azure Blob Storage component to store files.
- Use the .NET Aspire Azure Storage Queues component to add messages to a queue.
- Use the .NET Aspire Azure Table Storage component to add rows to a table.