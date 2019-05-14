As a best practice, you shouldn't share storage account keys with external third-party applications. If these apps need access to your data, you'll need to secure their connections without using storage account keys.

For untrusted clients, use a *shared access signature* (SAS). A shared access signature is a string that contains a security token that can be attached to a URI. Use a shared access signature to delegate access to storage objects and specify constraints, such as the permissions and the time range of access.

You can give a customer a shared access signature token, for example, so they can upload pictures to a file system in Blob storage. Separately, you can give a web application permission to read those pictures. In both cases, you allow only the access that the application needs to do the task. 

## Types of shared access signatures

You can use a *service-level* shared access signature to allow access to specific resources in a storage account. You'd use this type of shared access signature, for example, to allow an app to retrieve a list of files in a file system or to download a file.

Use an *account-level* shared access signature to allow access to anything that a service-level shared access signature can allow, plus additional resources and abilities. For example, you can use an account-level shared access signature to allow the ability to create file systems.

You'd typically use a shared access signature for a service where users read and write their data to your storage account. Accounts that store user data have two typical designs:

* Clients upload and download data through a front-end proxy service, which performs authentication. This front-end proxy service has the advantage of allowing validation of business rules. But if the service must handle large amounts of data or high-volume transactions, you might find it complicated or expensive to scale this service to match demand.

    ![A client-side diagram](../media/4-client-flowchart.png)

* A lightweight service authenticates the client as needed. Then it generates a shared access signature. After receiving the shared access signature, the client can access storage account resources directly. The shared access signature defines the client's permissions and access interval. The shared access signature reduces the need to route all data through the front-end proxy service.

    ![A server-side diagram](../media/4-server-flowchart.png)