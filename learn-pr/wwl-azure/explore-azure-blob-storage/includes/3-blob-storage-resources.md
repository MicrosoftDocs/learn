Blob storage offers three types of resources:

* The **storage account**.
* A **container** in the storage account
* A **blob** in a container

## Storage accounts

A storage account provides a unique namespace in Azure for your data. Every object that you store in Azure Storage has an address that includes your unique account name. The combination of the account name and the Azure Storage blob endpoint forms the base address for the objects in your storage account.

For example, if your storage account is named *mystorageaccount*, then the default endpoint for Blob storage is:

```
http://mystorageaccount.blob.core.windows.net
```

## Containers

A container organizes a set of blobs, similar to a directory in a file system. A storage account can include an unlimited number of containers, and a container can store an unlimited number of blobs.

A container name must be a valid DNS name, as it forms part of the unique URI (Uniform resource identifier) used to address the container or its blobs. Follow these rules when naming a container:

* Container names can be between 3 and 63 characters long.
* Container names must start with a letter or number, and can contain only lowercase letters, numbers, and the dash (-) character.
* Two or more consecutive dash characters aren't permitted in container names.

The URI for a container is similar to:

```bash
https://myaccount.blob.core.windows.net/mycontainer
```

## Blobs

Azure Storage supports three types of blobs:

* **Block blobs** store text and binary data. Block blobs are made up of blocks of data that can be managed individually. Block blobs can store up to about 190.7 TiB.
* **Append blobs** are made up of blocks like block blobs, but are optimized for append operations. Append blobs are ideal for scenarios such as logging data from virtual machines.
* **Page blobs** store random access files up to 8 TB in size. Page blobs store virtual hard drive (VHD) files and serve as disks for Azure virtual machines. 

The URI for a blob is similar to:

```bash
https://myaccount.blob.core.windows.net/mycontainer/myblob
```

or

```bash
https://myaccount.blob.core.windows.net/mycontainer/myvirtualdirectory/myblob
```
