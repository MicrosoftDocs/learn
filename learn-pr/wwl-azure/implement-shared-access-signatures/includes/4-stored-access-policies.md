
A stored access policy provides an additional level of control over service-level shared access signatures (SAS) on the server side. Establishing a stored access policy groups shared access signatures and provides additional restrictions for signatures that are bound by the policy. You can use a stored access policy to change the start time, expiry time, or permissions for a signature, or to revoke it after it has been issued.

The following storage resources support stored access policies:

* Blob containers
* File shares
* Queues
* Tables

## Creating a stored access policy

The access policy for a SAS consists of the start time, expiry time, and permissions for the signature. You can specify all of these parameters on the signature URI and none within the stored access policy; all on the stored access policy and none on the URI; or some combination of the two. However, you cannot specify a given parameter on both the SAS token and the stored access policy.

To create or modify a stored access policy, call the `Set ACL` operation for the resource (see [Set Container ACL](/rest/api/storageservices/set-container-acl), [Set Queue ACL](/rest/api/storageservices/set-queue-acl), [Set Table ACL](/rest/api/storageservices/set-table-acl), or [Set Share ACL](/rest/api/storageservices/set-share-acl)) with a request body that specifies the terms of the access policy. The body of the request includes a unique signed identifier of your choosing, up to 64 characters in length, and the optional parameters of the access policy, as follows:

> [!NOTE]
> When you establish a stored access policy on a container, table, queue, or share, it may take up to 30 seconds to take effect. During this time requests against a SAS associated with the stored access policy may fail with status code 403 (Forbidden), until the access policy becomes active. Table entity range restrictions (`startpk`, `startrk`, `endpk`, and `endrk`) cannot be specified in a stored access policy.

Below are examples of creating a stored access policy by using C# .NET and the Azure CLI.

```csharp
BlobSignedIdentifier identifier = new BlobSignedIdentifier
{
    Id = "stored access policy identifier",
    AccessPolicy = new BlobAccessPolicy
    {
        ExpiresOn = DateTimeOffset.UtcNow.AddHours(1),
        Permissions = "rw"
    }
};

blobContainer.SetAccessPolicy(permissions: new BlobSignedIdentifier[] { identifier });
```

```azurecli
az storage container policy create \
    --name <stored access policy identifier> \
    --container-name <container name> \
    --start <start time UTC datetime> \
    --expiry <expiry time UTC datetime> \
    --permissions <(a)dd, (c)reate, (d)elete, (l)ist, (r)ead, or (w)rite> \
    --account-key <storage account key> \
    --account-name <storage account name> \
```

## Modifying or revoking a stored access policy

To modify the parameters of the stored access policy you can call the access control list operation for the resource type to replace the existing policy. For example, if your existing policy grants read and write permissions to a resource, you can modify it to grant only read permissions for all future requests. 

To revoke a stored access policy you can delete it, rename it by changing the signed identifier, or change the expiry time to a value in the past. Changing the signed identifier breaks the associations between any existing signatures and the stored access policy. Changing the expiry time to a value in the past causes any associated signatures to expire. Deleting or modifying the stored access policy immediately affects all of the SAS associated with it.

To remove a single access policy, call the resource's `Set ACL` operation, passing in the set of signed identifiers that you wish to maintain on the container. To remove all access policies from the resource, call the `Set ACL` operation with an empty request body.
