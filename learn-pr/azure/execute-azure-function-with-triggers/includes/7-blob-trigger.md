Imagine you're a photographer and you have a website where you display your pictures of the day. Because you're busy, you don't have a consistent upload schedule, but you want to notify your fans when you upload a picture. You decide to create an Azure function to automatically send a tweet whenever you upload an image to your Azure Storage blob container.

Here, you learn how to create a blob trigger and instruct it to monitor a specific location in your Azure Storage blob container.

## What is Azure Storage?

Azure Storage is Microsoft's cloud storage solution that supports all types of data, including: blobs, queues, and NoSQL. The goal of Azure Storage is to provide data storage that's:

- Highly available
- Secure
- Scalable
- Managed

We're not going to focus on Azure Storage too much. Instead, we use it to create blobs that will trigger our function to run.

## What is Azure Blob storage?

Azure Blob storage is an object storage solution that's designed to store large amounts of unstructured data. 

For example, Azure Blob storage is great at doing things like:

- Storing files
- Serving files
- Streaming video and audio
- Logging data

There are three types of blobs: **block blobs**, **append blobs**, and **page blobs**. Block blobs are the most common type. They allow you to store text or binary data efficiently. Append blobs are like block blobs, but they're designed more for append operations like creating a log file that's being constantly updated. Finally, page blobs are made up of pages and are designed for frequent random read and write operations.

## What is a blob trigger?

A blob trigger is a trigger that executes a function when a file is uploaded or updated in Azure Blob storage. To create a blob trigger, you create an Azure Storage account and provide a location that the trigger monitors.

## How to create a blob trigger

Just like the other triggers we've seen so far, we create a blob trigger in the Azure portal. Inside your Azure function, select **Blob trigger** from the list of predefined trigger types. Then, enter the logic to execute when a blob is created or updated.

One setting that you'll want to look at is the **Path**. The **Path** tells the blob trigger where to monitor to see if a blob is uploaded or updated. By default, the **Path** value is: 

```
samples-workitems/{name}
```

Let's break down this concept into two pieces: *samples-workitems* and *{name}*. The first part, *samples-workitems*, represents the blob container that the trigger monitors. The second part, *{name}* means that every type of file will cause the trigger to invoke the function. The function is invoked because there's no filter. For example, we could make the trigger invoke the function only when a PNG file is added by using syntax like:

```
samples-workitems/{name}.png
```

The last significant piece of information with this concept is the text *name*. The *name* represents a parameter in your Azure function that receives the name of the added file. For example, if we upload a file named *resume.txt*, my Azure function receives that value as a string through a parameter called *name*.

A blob trigger invokes an Azure function when it sees activity at a specific location in your Azure Storage blob account. You set the location to monitor by modifying the **Path** value in the Azure portal.
