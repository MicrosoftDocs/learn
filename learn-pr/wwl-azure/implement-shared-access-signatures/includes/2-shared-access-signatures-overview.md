
A shared access signature (SAS) is a signed URI that points to one or more storage resources and includes a token that contains a special set of query parameters. The token indicates how the resources may be accessed by the client. One of the query parameters, the signature, is constructed from the SAS parameters and signed with the key that was used to create the SAS. This signature is used by Azure Storage to authorize access to the storage resource.

## Types of shared access signatures

Azure Storage supports three types of shared access signatures:

* **User delegation SAS**: A user delegation SAS is secured with Azure Active Directory credentials and also by the permissions specified for the SAS. A user delegation SAS applies to Blob storage only.

* **Service SAS**: A service SAS is secured with the storage account key. A service SAS delegates access to a resource in the following Azure Storage services: Blob storage, Queue storage, Table storage, or Azure Files.

* **Account SAS**: An account SAS is secured with the storage account key. An account SAS delegates access to resources in one or more of the storage services. All of the operations available via a service or user delegation SAS are also available via an account SAS.

> [!NOTE]
> Microsoft recommends that you use Azure Active Directory credentials when possible as a security best practice, rather than using the account key, which can be more easily compromised. When your application design requires shared access signatures for access to Blob storage, use Azure Active Directory credentials to create a user delegation SAS when possible for superior security

## How shared access signatures work

When you use a SAS to access data stored in Azure Storage, you need two components. The first is a URI to the resource you want to access. The second part is a SAS token that you've created to authorize access to that resource.

In a single URI, such as `https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D`, you can separate the URI from the SAS token as follows:

* **URI:** `https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?` 
* **SAS token:** `sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D`

The SAS token itself is made up of several components.

| Component | Description |
|--|--|
| `sp=r` | Controls the access rights. The values can be `a` for add, `c` for create, `d` for delete, `l` for list, `r` for read, or `w` for write. This example is read only. The example `sp=acdlrw` grants all the available rights. |
| `st=2020-01-20T11:42:32Z` | The date and time when access starts. |
| `se=2020-01-20T19:42:32Z` | The date and time when access ends. This example grants eight hours of access. |
| `sv=2019-02-02` | The version of the storage API to use. |
| `sr=b` | The kind of storage being accessed. In this example, b is for blob. |
| `sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D` | The cryptographic signature. |

## Best practices

To reduce the potential risks of using a SAS, Microsoft provides some guidance:

* To securely distribute a SAS and prevent man-in-the-middle attacks, always use HTTPS.
* The most secure SAS is a user delegation SAS. Use it wherever possible because it removes the need to store your storage account key in code. You must use Azure Active Directory to manage credentials. This option might not be possible for your solution.
* Try to set your expiration time to the smallest useful value. If a SAS key becomes compromised, it can be exploited for only a short time.
* Apply the rule of minimum-required privileges. Only grant the access that's required. For example, in your app, read-only access is sufficient.
* There are some situations where a SAS isn't the correct solution. When there's an unacceptable risk of using a SAS, create a middle-tier service to manage users and their access to storage.

