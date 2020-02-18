Shared access signatures let you delegate access to your resources. Clients don't have direct access to your storage account credentials and, at a granular level, you control what they access.

After investigating all the authorization options, you're going to look at SAS in more detail. You know you'll want to create and use SAS in a C# .NET web app. You'd also like to follow Microsoft's best practices on when and how to use SAS.

In this unit, you'll review how SAS works at a technical level and what C# code you write to use it.

## How shared access signatures work

When you use a SAS to access data stored in Azure Storage, you need two components. The first is a URI to the resource you want to access. The second part is an SAS token that you've created to authorize access to that resource.

| URI  | SAS token  |
|------|------------|
| https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?    | sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D |

The SAS token itself is made up of several components.

| Component | Description  |
|-----------|--------------|
| sp=r      | Controls the access rights; the values can be (a)dd, (c)reate, (d)elete, (l)ist, (r)ead, or (w)rite. An example of read only, where sp=acdlrw grants all the available rights.        |
| st=2020-01-20T11:42:32Z | The date time access starts from. |
| se=2020-01-20T19:42:32Z | The date time access ends; this example would grant eight hours of access. |
| sv=2019-02-02 | The version of the storage API to use. |
| sr=b | The kind of storage being accessed; b=blob. |
| sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D | The cryptographic signature. |

The signature is signed with your storage account key if you're creating a service or account SAS. If you use an Azure AD security principal with access to the storage, you create a user delegation SAS. You also grant the **Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey** action to the principal.

### Create a SAS in .NET

For your company, you can't use Active Directory to create service principals for each third party that requires access to medical images. Your app will use a storage account key to create a service SAS for each individual file. You'll need to take these steps in code.

#### Create a **blob container** to connect to the storage account on Azure

```csharp
BlobContainerClient container = new BlobContainerClient( "ConnectionString", "Container" );
```

#### Retrieve the **blob** you'd like to create a SAS token for and create a **BlobClient**

```csharp
foreach (BlobItem blobItem in container.GetBlobs())
{
    BlobClient blob = container.GetBlobClient(blobItem.Name);
}
```

#### Create a **BlobSasBuilder** object for the blob you'll use to generate the SAS token

```csharp
BlobSasBuilder sas = new BlobSasBuilder
{
    BlobContainerName = blob.BlobContainerName,
    BlobName = blob.Name,
    Resource = "b",
    ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(1)
};

// Allow read access
sas.SetPermissions(BlobSasPermissions.Read);
```

#### Authenticate a call to the **ToSasQueryParameters** method of the BlobSasBuilder object

```csharp
StorageSharedKeyCredential storageSharedKeyCredential = new StorageSharedKeyCredential( "AccountName", "AccountKey");

sasToken = sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
```

> [!NOTE]
> All of the above code uses the new Azure Storage API version 12. All the examples on [docs.microsoft.com](https://docs.microsoft.com/en-us/azure/storage/common/storage-samples-dotnet?toc=%2fazure%2fstorage%2fblobs%2ftoc.json) use the legacy version of the the API. To see more code samples for version 12, go to the GitHub repository [Azure.Storage.Blobs Samples](https://github.com/Azure/azure-sdk-for-net/tree/7b41d66f3c611eb2113e2ec11cb56e7edf542628/sdk/storage/Azure.Storage.Blobs/samples).

### Best practices

To reduce the potential risks of using SAS, Microsoft provides some best practice guidance: 

1. To securely distribute a SAS and prevent man-in-the-middle attacks, always use HTTPS.
1. The most secure SAS is a user delegation SAS. Use wherever possible as it removes the need to store your storage account key in code. However, you'll need to use Azure Active Directory to manage credentials. This option might not be possible for your solution.
1. Try to set your expiration time to the smallest useful value. If a SAS key then becomes compromised, it can only be exploited for a short time.
1. Apply the rule of minimum required privileges. Only grant the access that's required. For example, in your app, read-only access is sufficient.
1. There are some situations where SAS isn't the correct solution. When there's an unacceptable risk of using SAS, you'll need to create a middle-tier service to manage users and their access to storage.

The most flexible and secure way to use a service or account SAS is to associate the SAS tokens with a stored access policy. You'll explore these benefits and how they work in a later unit.