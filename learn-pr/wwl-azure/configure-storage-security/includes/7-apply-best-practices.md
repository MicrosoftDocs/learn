We reviewed how to create and work with a shared access signature (SAS) and the benefits it can provide to your storage security solution.

It's important to understand that when you use a SAS in your application, there can be potential risks.

- If a SAS is compromised, it can be used by anyone who obtains it, including a malicious user.

- If a SAS provided to a client application expires and the application is unable to retrieve a new SAS from your service, the application functionality might be hindered.

Watch this video for more ideas on how to secure your storage. This video is based on [Azure Tips and Tricks #272 Azure Security Best Practices](https://microsoft.github.io/AzureTipsAndTricks/blog/blog/tip272.html).


> [!VIDEO https://www.youtube.com/embed/mntOLLNejUo?list=PLLasX02E8BPCNCK8Thcxu-Y-XcBUbhFWC]


### Recommendations for managing risks

Let's look at some recommendations that can help mitigate risks when working with a SAS.

| Recommendation | Description |
| --- | --- |
| **Always use HTTPS for creation and distribution** | If a SAS is passed over HTTP and intercepted, an attacker can intercept and use the SAS. These _man-in-the-middle_ attacks can compromise sensitive data or allow for data corruption by the malicious user. |
| **Reference stored access policies where possible** | Stored access policies give you the option to revoke permissions without having to regenerate the Azure storage account keys. Set the storage account key expiration date far in the future. |
| **Set near-term expiry times for an unplanned SAS** | If a SAS is compromised, you can mitigate attacks by limiting the SAS validity to a short time. This practice is important if you can't reference a stored access policy. Near-term expiration times also limit the amount of data that can be written to a blob by limiting the time available to upload to it. |
| **Require clients automatically renew the SAS** | Require your clients to renew the SAS well before the expiration date. By renewing early, you allow time for retries if the service providing the SAS is unavailable. |
| **Plan carefully for the SAS start time** | If you set the start time for a SAS to now, then due to clock skew (differences in current time according to different machines), failures might be observed intermittently for the first few minutes. In general, set the start time to at least 15 minutes in the past. Or, don't set a specific start time, which causes the SAS to be valid immediately in all cases. The same conditions generally apply to the expiry time. You might observe up to 15 minutes of clock skew in either direction on any request. For clients that use a REST API version earlier than 2012-02-12, the maximum duration for a SAS that doesn't reference a stored access policy is 1 hour. Any policies that specify a longer term will fail. |
| **Define minimum access permissions for resources** | A security best practice is to provide a user with the minimum required privileges. If a user only needs read access to a single entity, then grant them read access to that single entity, and not read/write/delete access to all entities. This practice also helps lessen the damage if a SAS is compromised because the SAS has less power in the hands of an attacker. |
| **Understand account billing for usage, including a SAS** | If you provide write access to a blob, a user might choose to upload a 200-GB blob. If you've given them read access as well, they might choose to download the blob 10 times, which incurs 2 TB in egress costs for you. Again, provide limited permissions to help mitigate the potential actions of malicious users. Use a short-lived SAS to reduce this threat, but be mindful of clock skew on the end time. |
| **Validate data written by using a SAS** | When a client application writes data to your Azure storage account, keep in mind there can be problems with the data. If your application requires validated or authorized data, validate the data after it's written, but before it's used. This practice also protects against corrupt or malicious data being written to your account, either by a user who properly acquired the SAS, or by a user exploiting a leaked SAS. |
| **Don't assume a SAS is always the correct choice** | In some scenarios, the risks associated with a particular operation against your Azure storage account outweigh the benefits of using a SAS. For such operations, create a middle-tier service that writes to your storage account after performing business rule validation, authentication, and auditing. Also, sometimes it's easier to manage access in other ways. If you want to make all blobs in a container publicly readable, you can make the container Public, rather than providing a SAS to every client for access. |
| **Monitor your applications with Azure Storage Analytics** | You can use logging and metrics to observe any spike in authentication failures. You might see spikes from an outage in your SAS provider service or to the inadvertent removal of a stored access policy. |