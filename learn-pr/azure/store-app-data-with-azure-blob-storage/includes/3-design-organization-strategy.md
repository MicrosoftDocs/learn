When you design an app that needs to store data, it's important to think about how the app is going to organize data across storage accounts, containers, and blobs.

## Storage accounts

A single storage account is flexible enough to organize your blobs. However, you should use more storage accounts as necessary to logically separate costs and control access to data.

## Containers and blobs

The nature of your app and the data it stores should drive your strategy for naming and organizing containers and blobs.

Apps that use blobs as part of a storage scheme that includes a database often don't need to rely heavily on organization, naming, or metadata to indicate anything about their data. Such apps commonly use identifiers like GUIDs as blob names and reference these identifiers in database records. The app uses the database to determine where blobs are stored and the kind of data they contain.

Other apps use Azure Blob Storage more like a personal file system. Container and blob names indicate meaning and structure. Blob names in these kinds of apps often look like traditional file names. They can include file name extensions like *.jpg* to indicate what type of data they contain. Such apps use virtual directories to organize blobs. They frequently use metadata tags to store information about blobs and containers.

There are a few key things to consider when deciding how to organize and store blobs and containers.

### Naming limitations

Container and blob names must conform to a set of rules, including length limitations and character restrictions. For more specific information about naming rules, see the *Further Reading* section at the end of this module.

### Public access and containers as security boundaries

By default, all blobs require authentication to access. However, you can configure individual containers to allow public downloading of their blobs without authentication. Public downloading supports many use cases, such as hosting static website assets and sharing files. This approach works because downloading blob contents works the same way as reading any other data over the web. You just point a browser or anything that can make a GET request at the blob URL.

Enabling public access is important for scalability. Data downloaded directly from Blob Storage doesn't generate any traffic in your server-side app. Plan to use separate containers for data that you want to be publicly available, even if you don't immediately allow public access or use a database to control data access.

> [!CAUTION]
> Anyone who knows the storage URLs can download blobs in a container configured for public access without any kind of authentication or auditing. Never put blob data in a public container that you don't intend to share publicly.

In addition to public access, Azure has a shared access signature feature that allows fine-grained permissions control on containers. Precision access control enables scenarios that further improve scalability, so it's helpful to think about containers as security boundaries.

### Blob name prefixes (virtual directories)

Containers are *flat*. They don't support any kind of nesting or hierarchy. If you give your blobs hierarchical names that look like file paths, such as *finance/budgets/2017/q1.xls*, the API's listing operation can filter results to specific prefixes. This approach enables you to navigate the list as if it was a hierarchical system of files and folders.

Some tools and client libraries use this approach to visualize and navigate Blob Storage as if it was a file system. Each folder navigation triggers a separate call to list the blobs in that folder. This feature is often called *virtual directories*.

> [!NOTE]
> If you enable the hierarchial namespace feature of the account, directories are no longer virtual. Instead, they become concrete, independent objects that you can operate on directly. A directory can exist without containing any files. This module describes only accounts that **do not** have hierarchical namespace feature enabled.

## Blob types

There are three different kinds of blobs in which you can store data:

- **Block blobs** are composed of blocks of different sizes that can be uploaded independently and in parallel. Writing to a block blob involves uploading data to blocks and committing them to the blob.
- **Append blobs** are specialized block blobs that support only appending new data, not updating or deleting existing data. They're efficient for this purpose. Append blobs are great for scenarios like storing logs or writing streamed data.
- **Page blobs** support scenarios that involve random-access reads and writes. Page blobs are used to store the virtual hard disk (VHD) files used by Azure Virtual Machines. They're great for any scenario that involves random access.

Block blobs are the best choice for most scenarios that don't specifically call for append or page blobs. Their block-based structure supports fast uploads and downloads and efficient access to individual pieces of a blob. Most client libraries automatically manage and commit blocks. Some also handle parallel uploads and downloads to maximize performance.
