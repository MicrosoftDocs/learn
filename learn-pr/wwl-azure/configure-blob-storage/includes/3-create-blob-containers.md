A container provides a grouping of a set of blobs. All blobs must be in a container. An account can contain an unlimited number of containers. A container can store an unlimited number of blobs. You can create the container in the Azure portal.

:::image type="content" source="../media/blob-containers-a243a2b9.png" alt-text="Screenshot showing the container creation page and the public access level choices.":::


**Name**: The name may only contain lowercase letters, numbers, and hyphens, and must begin with a letter or a number. The name must also be between 3 and 63 characters long.

**Public access level**: Specifies whether data in the container may be accessed publicly. By default, container data is private to the account owner.

 -  Use **Private** to ensure there is no anonymous access to the container and blobs.
 -  Use **Blob** to allow anonymous public read access for blobs only.
 -  Use **Container** to allow anonymous public read and list access to the entire container, including the blobs.

> [!NOTE]
> You can also create the Blob container with PowerShell using the **New-AzStorageContainer** command. How will you organize your Blob containers?
