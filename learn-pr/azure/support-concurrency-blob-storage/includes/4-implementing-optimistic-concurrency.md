In optimistic concurrency, the application checks whether a blob has changed since the last time it was read. Azure Blob storage generates an identifier for every object when it changes state. Optimistic concurrency makes use of this identifier to determine if another user has changed the content since it was last read. If the object has been changed since it was last read, the commit will not complete.

![Workflow of optimistic strategy](../media/optimistic.png)

To implement an optimistic approach to accessing storage, the environment, or service, needs to give a value for the current state of a file. One example could be to use the last modified date, or you could use a combination of file name, size, and modified date. You need to have confidence that there's no changes to the file since you last accessed it.

In the example, both reporters were trying to write to the same storage, but neither checked if the file had changed before they tried to update it. If the app had checked, it would have detected that the file had been changed by something else. Reporter A's app won't allow the changes to be saved to the blob storage, as it would overwrite Reporter B's work.

### Azure Blob Storage

Azure provides a unique identifier that is updated anytime a change occurs on a blob. This identifier known as an entity tag (ETag), and its value can be read at any time and stored. An app can store the ETag, complete the processing it needs to, and try saving the changes. The stored value it has for the ETag is passed at the point of saving.

Azure blob storage service can now do an atomic action of checking its current value of the ETag against the stored version sent by the app. If they match, it can perform the update. If they don't match, the update fails and the app who made the request is notified using the HTTP protocol. The failed update is returned as a 412 error (precondition has failed). The precondition being the ETags must match before an update will be processed.

All the methods that can update storage in block blob storage support this approach. The first step is to get the current value for the ETag:

```csharp
string current-ETag-value = file-to-change.Properties.ETag;
```

The app needs to store the value `current-ETag-value` in a variable so it can send it with the `UploadText` call.

```csharp
await file-to-change.UploadTextAsync(text-to-upload, null, accessCondition: AccessCondition.GenerateIfMatchCondition(current-ETag-value), null, null);
```

For the simple example app, the null parameters are features of the `UploadTextAsync` that aren't required.

Now the processing is complete the app can try to save those changes with the above code. Reading from left to right, upload some text (`text-to-upload`) to a file (`file-to-change`), and when accessing the current file on the server does it have the same ETag that I've sent you (`current-ETag-value`).

An app can always check before updating storage that no other process, or app, has changed it on the meantime.

## Advantages and disadvantages

Optimistic concurrency is a good choice in environments when there's a low contention for data. Optimistic concurrency works well because data isn't locked. This approach doesn't block connections from trying to update data at the same time. The process starts with an attempt to write data. It's called optimistic because you hope that no one else has changed the file since you read it.

Optimistic concurrency doesn't put a lock on data, but instead it checks to see if data has changed at the point of trying to update it. Also, optimistic concurrency assumes there won't be any interference between multiple users. Because of this, optimistic concurrency is more appropriate in environments where there's low contention.

A disadvantage is that every app must implement the optimistic checks on the ETag. Apps that don't would be free to make updates and data can still be lost. Optimistic concurrency isn't enforced, it requires all apps that use the storage to adopt it.
