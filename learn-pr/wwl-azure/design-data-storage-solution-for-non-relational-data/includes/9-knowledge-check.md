Tailwind Traders wants to reduce storage costs by reducing duplicate content and, whenever applicable, migrating it to the cloud. The company would like a solution that centralizes maintenance while still providing nation-wide access for customers. Customers should be able to browse and purchase items online even in a case of a failure affecting an entire Azure region. Here are some specific requirements.

- **Warranty document retention.** The company’s risk and legal teams requires warranty documents be kept for three years. 

- **New photos and videos.** The company would like each product to have a photo or video to demonstrate the product features.

- **External vendor development.** A vendor will create and develop some of the online ecommerce features. The developer will need access to the HTML files, but only during the development phase.

- **Product catalog updates.** The product catalog is updated every few months. Older versions of the catalog aren’t viewed frequently but must be available immediately if accessed.

What is the best way for Tailwind Traders to protect their warranty information?
( ) Legal hold policy {{That’s incorrect. Legal hold allows objects to be created or read, but not modified or deleted. It doesn’t provide a time frame and can be removed at any time.}}
(x) Time-based retention policy {{That’s correct. With a time-based retention policy, users can set policies to store data for a specified interval. When a time-based retention policy is in place, objects can be created and read, but not modified or deleted.}}
( ) Private endpoint for storage account {{That’s incorrect. A private endpoint is a special network interface for storage access from the virtual network.}}

 
## Multiple Choice 
What type of storage should Tailwind Traders use for their photos and videos?
(x) Blob storage {{That’s correct. Blob storage is best for their photos.}}
( ) File storage {{That’s incorrect. Photos could be uploaded to file storage, but blob storage would be more appropriate.}}
( ) Disk storage {{That’s incorrect. Disk storage is more appropriate for virtual machine storage.}}

 
## Multiple Choice 
What is the best way to provide the developer access to the ecommerce HTML files?
( ) Enable secure transfer {{That’s incorrect. Enable secure transfer accepts requests only from secure connections.}}
( ) Enable firewall policies and rules {{That’s incorrect. Firewall policies and rules are for network access.}}
(x) Shared access signatures {{That’s correct. Shared access signatures provide secure delegated access. This functionality can be used to define permissions and how long access is allowed.}}

 
## Multiple Choice 
Which access tier should be used for the older versions of the product catalog? 
( ) Hot access tier {{That’s incorrect. The hot tier is optimized for frequent reads and writes of objects in the storage account.}}
(x) Cool access tier {{That’s correct. The cool access tier is for content that wouldn’t be viewed frequently but must be available immediately if accessed.}}
( ) Archive access tier. {{That’s incorrect. The older catalogs are accessed although infrequently. There’s an early deletion charge if data is accessed sooner than 180 days.}}