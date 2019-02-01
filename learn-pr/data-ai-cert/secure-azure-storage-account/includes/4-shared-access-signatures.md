As the best practice is to not share storage account keys to external third-party applications, another approach must be used.

For untrusted clients, you can use a **Shared Access Signature** (SAS) if you require these applications to have access to your data. A Shared Access Signature is a string containing a security token that can be attached to a URI that allows you to delegate access to storage objects and specify constraints such as the permissions and the date/time range of access.

As an example, you could give one customer a SAS token they can use to upload pictures to a filesystem in Blob Storage and provide a web application permission to read those pictures. In both cases, there is a separation of duty concerns – each application can be granted just the access that they require to perform their task. This is possible using Shared Access Signatures.

## Types of Shared Access Signatures

- A service-level SAS can be used to access specific resources in a storage account. Some examples of this are retrieving a list of files in a filesystem or downloading a file.
- An account-level SAS can be used to access anything that a service-level SAS can be used for. Additionally, it can give options to resources that are not permitted with a service-level SAS, such as the ability to create filesystems.

A typical scenario where a SAS is useful is a service where users read and write their data to your storage account. In a scenario where a storage account stores user data, there are two typical design patterns:

1. Clients upload and download data via a front-end proxy service, which performs authentication. This front-end proxy service has the advantage of allowing validation of business rules, but for large amounts of data or high-volume transactions, creating a service that can scale to match demand may be expensive or complicated.

    ![Screenshot of Client-side Flowchart](../media/4-client-flowchart.png)

2. A lightweight service authenticates the client as needed and then generates a SAS. Once the client receives the SAS, they can access storage account resources directly with the permissions defined by the SAS and for the interval allowed by the SAS. The SAS mitigates the need for routing all data through the front-end proxy service.

    ![Screenshot of Server-side Flowchart](../media/4-server-flowchart.png)