By using a shared access signature (SAS), you can delegate access to your resources. Clients don't have direct access to your storage account credentials and, at a granular level, you control what they access.

After you investigate all the authorization options, you decide to look at a SAS in more detail. You know you'll want to create and use a SAS in a C# .NET web app. You also want to follow Microsoft's best practices on when and how to use a SAS.

In this unit, you'll review how a SAS works at a technical level and what C# code you write to use it.

## How shared access signatures work

When you use a SAS to access data stored in Azure Storage, you need two components. The first is a URI to the resource you want to access. The second part is a SAS token that you've created to authorize access to that resource.

In a single URI, such as `https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D`, you can separate the URI from the SAS token as follows:

| URI  | SAS token  |
|------|------------|
| `https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?`    | `sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D` |

The SAS token itself is made up of several components.

| Component | Description  |
|-----------|--------------|
| sp=r      | Controls the access rights. The values can be a for add, c for create, d for delete, l for list, r for read, or w for write. This example is read only. The example sp=acdlrw grants all the available rights.        |
| st=2020-01-20T11:42:32Z | The date and time when access starts. |
| se=2020-01-20T19:42:32Z | The date and time when access ends. This example grants eight hours of access. |
| sv=2019-02-02 | The version of the storage API to use. |
| sr=b | The kind of storage being accessed. In this example, b is for blob. |
| sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D | The cryptographic signature. |

The signature is signed with your storage account key if you create a service or account SAS. If you use an Azure Active Directory (Azure AD) security principal with access to the storage, you create a user delegation SAS. You also grant the **Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey** action to the principal.

### Create a SAS in .NET

For your company, you can't use Azure AD to create service principals for each third party that requires access to medical images. Your app uses a storage account key to create a service SAS for each individual file. You need to take these steps in code.

#### Create a blob container to connect to the storage account on Azure

```csharp
BlobContainerClient container = new BlobContainerClient( "ConnectionString", "Container" );
```

#### Retrieve the blob you want to create a SAS token for and create a BlobClient

```csharp
foreach (BlobItem blobItem in container.GetBlobs())
{
    BlobClient blob = container.GetBlobClient(blobItem.Name);
}
```

#### Create a BlobSasBuilder object for the blob you use to generate the SAS token

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

#### Authenticate a call to the ToSasQueryParameters method of the BlobSasBuilder object

```csharp
StorageSharedKeyCredential storageSharedKeyCredential = new StorageSharedKeyCredential( "AccountName", "AccountKey");

sasToken = sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
```

> [!NOTE]
> All of the previous code uses the new Azure Storage API version 12. All the examples on [docs.microsoft.com](https://docs.microsoft.com/azure/storage/common/storage-samples-dotnet?toc=%2fazure%2fstorage%2fblobs%2ftoc.json) use the legacy version of the API. To see more code samples for version 12, go to the GitHub repository [Azure.Storage.Blobs Samples](https://github.com/Azure/azure-sdk-for-net/tree/7b41d66f3c611eb2113e2ec11cb56e7edf542628/sdk/storage/Azure.Storage.Blobs/samples).

### Best practices

To reduce the potential risks of using a SAS, Microsoft provides some guidance:

- To securely distribute a SAS and prevent man-in-the-middle attacks, always use HTTPS.
- The most secure SAS is a user delegation SAS. Use it wherever possible because it removes the need to store your storage account key in code. You must use Azure AD to manage credentials. This option might not be possible for your solution.
- Try to set your expiration time to the smallest useful value. If a SAS key becomes compromised, it can be exploited for only a short time.
- Apply the rule of minimum-required privileges. Only grant the access that's required. For example, in your app, read-only access is sufficient.
- There are some situations where a SAS isn't the correct solution. When there's an unacceptable risk of using a SAS, create a middle-tier service to manage users and their access to storage.

The most flexible and secure way to use a service or account SAS is to associate the SAS tokens with a stored access policy. You'll explore these benefits and how they work in a later unit.