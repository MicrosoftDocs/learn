Blobs in Azure Storage have various properties that you can use to classify the blob data, and you can also add your own custom metadata.

As lead developer for Trey Research, you know there are several years of safety records in Azure blob storage. You now need to provide ways for your users to find all the records from the research department that are ready for external audit. You also want to set a flag on each document to indicate that it has been retrieved.

In this unit, you will compare the property types that you can retrieve from a blob. You'll also learn how to use your own custom metadata to help manage blob data.

## Overview

There are several types of Azure Blobs, and this module covers **Block** blobs.

Blobs have properties that contain information about each blob, and they can also have metadata that contains additional information. The names of properties are system-defined, whereas metadata consists of name-value pairs that are user-defined. Some properties are read-only, while others are read-write, and all metadata is user-defined.

Properties and metadata are stored with the blob or container. So, if your storage is replicated, this information is also copied.

## Properties

Blob properties have system-defined names, and the values of properties are often set by system processes.

- The values of some blob properties are read-only (*derived*), system-generated information about a blob. For example, the `LastModified` property of a blob is read-only.

- The values of other properties are read-write (*user-defined*). For example, you can specify the `ContentType` property, which is useful when you are classifying your blobs. For instance, if you are storing movie files, you can set the `ContentType` property to `video/mp4`.

The following list provides additional details about these types of properties:

**Read-only properties**

- **Default properties**: These properties include the date the object was created or modified (`LastModified`).

- **URI properties**: These properties are the locations of the primary and secondary storage for the container.

- Other read-only properties include: `BlobType`, `RemainingDaysBeforePermanentDelete`, `Length` and `SnapshotTime`.

**Read-write properties**

- These properties are used by clients when reading and writing blobs, and can be updated by applications.

- For example, you can specify the `StreamMinimumReadSizeInBytes` and `StreamWriteSizeInBytes` properties.

## Metadata

Blob metadata is user-defined information, consisting of name-value pairs, and only ASCII characters are allowed. Metadata can be returned in HTTP headers, so you must make sure that your metadata strings are acceptable in HTTP headers. You'll need to use URL encoding or Base64 encoding if any of your names or values are likely to contain non-ASCII characters. There is no limit on length of metadata strings, although your web server may have a limit for total HTTP header length.

For example, if you wanted to use metadata to classify your documents that are stored in blob storage, you might use this name-value scheme:

| Name | Value |
|---|---|
| **docType** | *safety-report* |
| **docType** | *test-report* |
| **docType** | *product-guide* |
| **docClass** | *public* |
| **docClass** | *confidential* |

If you add metadata as files are uploaded to blob storage, they can be automatically indexed by Azure Cognitive Search using the metadata to build the index. This can be useful for image files, where conventional content indexing can be difficult.
