A shared access signature (SAS) is a URI that grants restricted access rights to Azure Storage resources. You can provide a SAS to clients who shouldn't have access to your storage account key. By distributing a SAS URI to these clients, you grant them access to a resource for a specified period of time. SAS is a secure way to share your storage resources without compromising your account keys.

:::image type="content" source="../media/configure-secure-signatures-be02fa89.png" alt-text="Screenshot of the Create a SAS key page.":::


A SAS gives you granular control over the type of access you grant to clients who have the SAS, including:

 -  An account-level SAS can delegate access to multiple storage services. For example, blob, file, queue, and table.
 -  An interval over which the SAS is valid, including the start time and the expiry time.
 -  The permissions granted by the SAS. For example, a SAS for a blob might grant read and write permissions to that blob, but not delete permissions.

> [!NOTE]
> SAS both provides both **account-level** and **service-level** control. The account-level SAS delegates access to resources in one or more of the storage services. The service-level SAS delegates access to a resource in just one of the storage services.

Optionally, you can also:

 -  Specify an IP address or range of IP addresses from which Azure Storage will accept the SAS. For example, you might specify a range of IP addresses belonging to your organization.
 -  The protocol over which Azure Storage will accept the SAS. You can use this optional parameter to restrict access to clients using HTTPS.

> [!NOTE]
> A stored access policy can provide another level of control over service-level SAS on the server side. You can group shared access signatures and provide other restrictions by using policy.
