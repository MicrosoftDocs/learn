Cloud-based storage gives organizations the flexibility to work on files globally. Using economies of scale, large amounts of storage is available at a fraction of the cost of traditional storage. Companies have to handle files being accessed concurrently when writing applications that use it.

Your company's authoring app stores data in Blob Storage. The app was originally written when each story had only one editor assigned to it. The assigned editor gathered all contributions, and made sure the content was accurate and up to date before publishing. Over time, the organization has grown in size and now each story has multiple editors, reporters, and analysts around the world who are making contributions throughout the day. Recently, there have been issues with submissions being overwritten and lost.

Here, you learn about the issues you can face with concurrency when using Blob storage.

## Last writer wins

![text.](../media/last-writer-wins.png)

The last writer wins approach is the name given when no consideration has been given to concurrency. As the name implies, whoever makes the most recent change overwrites previous changes. The results of operations are unpredictable and can lead to data loss. When the last writer wins, there's no control over who reads or writes data. The last person to save their changes to a file has them reflected in that data. Anything that has happened to the blob before is overwritten. For example, a user may start editing a document. While that user is editing, a second user edits the same document and commits their changes. When the first user saves their changes, the second user's edits are overwritten and lost, because the first user was starting from a copy of the document without the second user's changes.

Even though there can be data lost, last writer wins can be a valid strategy in situations where having the latest data is most important. Previous versions of the data have little to no value. A stock market ticker is a good example, as the ticker app just needs to show the most recent values for a stock.

## Blob storage concurrency

Multiple users accessing data at the same time can cause concurrency issues when using Azure Blob storage. To solve these problems, Blob storage supports two different approaches to resolving concurrency. An app can choose to resolve concurrency *optimistically*, or *pessimistically*. We explain these terms later in the module.
