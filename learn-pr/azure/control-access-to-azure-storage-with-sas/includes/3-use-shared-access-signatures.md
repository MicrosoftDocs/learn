Shared access signatures let you delegate access to your resources. Clients don't have direct access to your storage account credentials and you control at a granular level what they can access.

After investigating all the authorization options, you've chosen to look in more detail at SAS. You know you'll want to create and use SAS in a C# .NET web app. You'd also like to follow Microsoft's best practices on when and how to use SAS.

In this unit, you'll review how SAS works at a technical level and what C# code you write to use them.

## How shared access signatures work

When you use a SAS to access data stored in Azure Storage, you need two components. The first is a URI to the resource you want to access. The second part is a SAS token that you've created to authorize access to that resource.

| URI  | SAS token  |
|------|------------|
| https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?    | sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D |

The SAS token itself is made up of several components.

| Component | Description  |
|-----------|--------------|
| sp=r      | This controls the access rights, the values can be (a)dd, (c)reate, (d)elete, (l)ist, (r)ead, or (w)rite. This is an example of read only, sp=acdlrw grants all the available rights.        |
| st=2020-01-20T11:42:32Z | The date time access starts from |
| se=2020-01-20T19:42:32Z | The date time access ends, this would grant 8 hours access |
| sv=2019-02-02 | The version of the storage API to use |
| sr=b | The kind of storage being accessed, b=blob |
| sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D | The cryptographic signature |

The signature is signed with your storage account key if you're creating a service or account SAS. If you can use an Azure AD security principal with access to the storage, you can create a user delegation SAS. The principal also needs to be granted the **Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey** action.

### Create a SAS in .NET

For your company, you won't be able to use Active Directory to create service principals for each third-party requiring access to medical images. Your app will use a storage account key to create a service SAS for each individual file. You'll need to take these steps in code.

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

#### Create a **BlobSasBuilder** object for your blob that you'll use to generate the SAS token

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
> All of the above code is using the new Azure Storage API version 12. All the examples on [docs.microsoft.com](https://docs.microsoft.com/en-us/azure/storage/common/storage-samples-dotnet?toc=%2fazure%2fstorage%2fblobs%2ftoc.json) use the legacy version of the the API. If you'd like to see more code samples for version 12 see the GitHub repository [Azure.Storage.Blobs Samples](https://github.com/Azure/azure-sdk-for-net/tree/7b41d66f3c611eb2113e2ec11cb56e7edf542628/sdk/storage/Azure.Storage.Blobs/samples)

### Best practices

To reduce the potential risks of using SAS Microsoft provides some best practice guidance. 

1. To securely distribute a SAS and prevent man-in-the-middle attacks always use HTTPS.
1. The most secure SAS is a user delegation SAS. Use them wherever possible as it removes the need to store your storage account key in code. However, it does require using Azure Active Directory to manage credentials. This may not be possible for your solution.
1. Try to set your expiration time to the smallest useful value. So if a SAS key becomes compromised it can only be exploited for a short time.
1. Apply the rule of minimum required privileges. Only grant the access that is required, for example in your app read-only access is sufficient.
1. Some situations SAS isn't the correct solution. You'll need to create a middle-tier service to manage users and their access to storage, when the risks of using SAS aren't acceptable.

When using service or account SAS, the most flexible and secure way is to associate the SAS tokens with a stored access policy. You'll explore these benefits and how to do this in a later unit.