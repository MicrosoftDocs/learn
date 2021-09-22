Complete the following question to test your knowledge of the topics covered in this module.
### Review questions


## Multiple Choice 
You need to provide a contingent staff employee temporary read-only access to the contents of an Azure storage account container named “Media”. It is important that you grant access while adhering to the security principle of least-privilege. What should you do? Select one.  
() Set the public access level to container.{{You don't want to lower the security of you container storage by granting public access.}}
(x) Generate a shared access signature (SAS) token for the container.{{You should generate a SAS token for the container. The SAS can provide read-only access.}}
() Share the container entity tag (Etag) with the contingent staff member.{{An access token is required in the scenario, not an Etag.}}



## Multiple Choice
Your company has both a development and production environment.  The development environment needs time-limited access to storage. The production environment needs unrestricted access to storage resources. You need to configure storage access to meet the requirements. What should you do? Each answer presents part of the solution. Select two. 
(x) Use shared access signatures for the development apps. And use access keys for the production apps.{{Shared access signatures provide a way to provide more granular storage access than access keys. For example, you can limit access to “read only” and you can limit the services and types of resources. Shared access signatures can be configured for a specified amount of time, which meets the scenario’s requirements. Access keys provide unrestricted access to the storage resources, which is the requirement for production apps in this scenario.}}
() Use shared access signatures for the production apps. Then, use access keys for the development apps.{{This solution would not provide the time-limited access to your development apps.}}
() Use Stored Access Policies for the production apps. Also, use Cross Origin Resource Sharing for the development apps.{{Cross Origin Resource Sharing does not help with restricting the time limit of the development apps.}}



## Multiple Choice
Your company is being audited. It is not known how long the audit will take, but during that time files must not be changed or removed. It is okay to read or create new files. What should you do? 
() Add a time-based retention policy to the blob container. And create an tag to identify items being protected.{{Using a tag to identify items is a good idea, but a time-based retention policy does not work in this situation.}}
(x) Add legal hold retention policy to the blob container.  Also, identify a tag for the items that are being protected.{{Add legal hold retention policy to the blob container. Identify a tag for the items that are being protected. If the retention interval is not known, users can set legal holds to store immutable data until the legal hold is cleared. When a legal hold policy is set, blobs can be created and read, but not modified or deleted. Each legal hold is associated with a user-defined alphanumeric tag (such as a case ID, event name, etc.) that is used as an identifier string.}}
() Configure a retention time period of 2 weeks with an option to renew. Then, add a time-based retention policy to the blob container.{{A retention policy would only ensure files are not deleted, they could still be modified.}}




## Multiple Choice
You are configuring an Azure File share for the business group. Which of the following is not true? Select one?
() Azure Files can authenticate to Azure Active Directory Domain Services.{{Azure Files can authenticate with Azure AD.}}
() Azure Files can authenticate to on-premises Active Directory Domain Services.{{Azure Files can authenticate to an on-premises Azure AD Domain Service}}
(x) Azure Files can use RBAC for share-level or directory/file permissions.{{Azure Files cannot use RBAC for share-level or directory/file permissions. Only share-level permissions can use RBAC. Directory or file level permissions can use Windows DACLs, or not.}}



## Multiple Choice
You are configuring Secure transfer required. Your Compliance office wants to more about this feature. You provide all the following information, except? Select one.
(x) Requests to storage can be HTTPS or HTTP.{{Requests to storage can be HTTPS or HTTP. When Secure transfer required is enabled all requests must be HTTPS.}}
() Requests to storage must be SMB with encryption.{{It is required that your storage requests are encrypted.}}
() By default, new storage accounts have secure transfer required enabled.{{To help protect your data, secure transfer is enabled by default on new storage accounts.}}

