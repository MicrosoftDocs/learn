Imagine you are a photographer and you have a website where you display your pictures of the day. Since you're busy, you don't have a consistent upload schedule, but you want your fans to be notified when you upload a picture. You decide to create an Azure Function to automatically send a tweet whenever you upload an image to your Azure Storage blob container.

Here, you will learn how to create a blob trigger and instruct it to monitor a specific location in your Azure Storage blob container.

## What is Azure Storage?

Azure Storage is Microsoft's cloud storage solution that supports all types of data including: blobs, queues, and NoSQL. The goal of Azure Storage is to provide data storage that is:

- Highly available.
- Secure.
- Scalable.
- Managed.

We're not going to focus on Azure Storage too much, instead we'll use it to create blobs, which will then trigger our function to run.

## What is Azure Blob storage?

Azure Blob storage is an object storage solution that is designed to store large amounts of unstructured data. 

For example, Azure Blob storage is great at doing things like:

- Storing files.
- Serving files.
- Steaming video and audio.
- Logging data.

There are three types of blobs: **block blobs**, **append blobs**, and **page blobs**. Block blobs are the most common type and they allow you to store text or binary data efficiently. Append blobs are like block blobs, however, they are designed more for append operations like creating a log file that is constantly being updated. Finally, page blobs are made up of pages and are designed for frequent random read and write operations.

## What is a blob trigger?

A blob trigger is a trigger that executes a function when a file is uploaded or updated in Azure Blob storage. To create a blob trigger, you'll need to create an Azure Storage account and provide a location that the trigger will monitor.

## How to create a blob trigger

Just like all the other triggers we've seen so far, we can create a blob trigger in the Azure portal. Inside your Azure Function, you'll select **Blob trigger** from the list of predefined trigger types. Then you'll enter your logic that will execute when a blob is created or updated.

One setting that you'll want to look at is the **Path**. The **Path** tells the blob trigger where it should be monitoring to see if a blob is uploaded or updated. By default, the **Path** value is: 

> samples-workitems/{name}

Let's break this down into two pieces, *samples-workitems* and *{name}*. The first part, *samples-workitems*, represents the blob container that the trigger is going to be monitoring. The second part, *{name}*, means that every type of file will cause the trigger to invoke the function. This is because there is no filter. For example, I could make the trigger only invoke the function when a PNG file is added by doing something like this:

> samples-workitems/{name}.png

The last significant piece of information with this is the text *name*. This represents a parameter in your Azure Function that will receive the name of the added file. For example, if I upload a file called *resume.txt*, my Azure Function will receive that as a string through a parameter called *name*.

## Summary

A blob trigger invokes an Azure Function when it sees activity at a specific location in your Azure Storage blob account. You set the location to be monitored by modifying the **Path** value in the Azure portal.


