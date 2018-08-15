When designing an app that needs to store data, it's important to think about how it's going to organize and store data across storage accounts, containers and blobs.

## Storage accounts

**TODO get feedback and consider shrinking this; it's basically a knowledge prereq and should be included in a storage account/Azure Storage module**

Storage accounts should always be considered a primary unit of billing and management as well as a major security boundary. A single storage account is flexible enough to organize your blobs however you like, but you should use additional storage accounts as necessary to logically separate out costs and control access to data where needed.

> [!TIP]
> An application that authenticates to a storage account using a key has full permissions to all the data in that account. When you design your storage infrastructure, think about which applications conceptually "own" the data in an account. Applications that don't own the data in an account should not have its key, and should request data through an application that does.
>
> Shared Access Signatures (SAS) is a feature of Azure Storage that your apps can use to grant limited access to other apps and users. See the Additional Resources section at the end of this module for more information.

As with other Azure resources, the best practice for managing multiple environments is to duplicate the set of storage accounts your app uses for each environment to fully segregate each environment's data. During development, developers will commonly configure their local instances of the application to use individually-controlled accounts or the local storage emulator to better isolate problems during debugging.

## Containers and blobs

The nature of your application and the data that it stores should drive your strategy for naming and organizing containers and blobs.

Apps using blobs as part of a storage scheme that includes a database often don't need to rely heavily on organization, naming or metadata to indicate anything about their data. Such apps commonly use identifiers like GUIDs as blob names and reference these identifiers in database records. The app will use the database to understand where blobs are stored and what kind of data they contain.

Other apps may use Blob storage more like a personal filesystem, where container and blob names are used to indicate meaning and structure. Blob names in these kinds of apps will often look like traditional filenames and include filename extensions like `.jpg` to indicate what kind of data they contain. They'll use virtual directories (see below) to organize blobs and will frequently use metadata tags to store information about blobs and containers.

There are a few key aspects and features of Blob storage to consider when thinking about how your app will organize and store data blobs and containers.

### Naming limitations

Container and blob names must conform to a set of rules, including length limitations and character restrictions. See the Additional Resources section at the end of this module for more specific information about naming rules.

### Public access and containers as security boundaries

By default, all blobs require authentication to access. However, individual containers can be configured to allow public downloading of their blobs without authentication. This feature supports many use cases, such as hosting static website assets and sharing files, because downloading blob contents works the same as reading any other kind of data over the web: you just point a browser or anything that can make a GET request at the blob URL.

**TODO public container image, showing direct access URL**

Enabling public access is important for scalability because data downloaded directly from Blob storage doesn't generate any traffic in your server-side app. Even if you don't immediately take advantage of public access or you plan use a database to control data access via your application, plan on using separate containers for data you want to be publicly available.

> [!CAUTION]
> Blobs in a container configured for public access can be downloaded without any kind of authentication or auditing by anyone who knows their storage URLs. Never put blob data in a public container that you don't intend to share publicly!

In addition to public access, the Shared Access Signatures feature of Azure Storage mentioned above can enable fine-grained permissions control on containers. Precision access control enables scenarios that further improve scalability, so thinking about containers as security boundaries in general is a helpful guideline.

### Blob name prefixes (virtual directories)

Technically, containers are "flat" and do not support any kind of nesting or hierarchy. But if you give your blobs hierarchical names that look like file paths (such as `finance/budgets/2017/q1.xls`), the API's listing operation can filter results to specific "folders", allowing your app to navigate the list as if it was a hierarchical system of files and folders.

This feature is often called *virtual directories* because some tools and client libraries use this it to visualize and navigate Blob storage as if it was a filesystem. Each folder navigation triggers a separate call to list the blobs in that folder.

**TODO image of storage explorer and/or portal w/folders**

We'll discuss details of virtual directories in unit 5 **TODO maybe not**. For now, it's enough to know that using filename-like names for blobs is a good way to organize and navigate blob data.

### Blob types

We've only talked about blobs generally, but there are three different kinds of blobs you can store data in:

* **Block blobs** are composed of blocks of different sizes that can be uploaded and downloaded independently and in parallel. Writing to a block blob involves uploading data to blocks and committing them to the blob &mdash; client libraries will handle this for you.
* **Append blobs** are specialized block blobs that only support appending new data (not updating or deleting existing data), but are very efficient at it. Append blobs are great for scenarios like storing logs or streaming data.
* **Page blobs** are designed for scenarios that involve lots of random-access reads and writes. Page blobs are most commonly used to store virtual hard disk files (VHDs) used by Azure Virtual Machines, but they're great for any scenario that involves random access.

Block blobs are the general-purpose workhorse of Blob storage and are the best choice for most scenarios that don't specifically call for append or page blobs. The exercise in this module uses block blobs to store uploaded files.