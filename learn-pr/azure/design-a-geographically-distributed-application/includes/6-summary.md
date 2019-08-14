The shipping company needed to take their existing architectural practices and adapt them to the cloud environment. 

In this module, you've considered the differences between architecting for on-premises and the cloud. You've seen that failure is a more expected condition in the cloud, and considered how to architect primarily with this principle in mind. 

You've seen how to make the networking elements of the application highly available and multi-regional – with a combination of Azure DNS and the Azure Traffic Manager.

You can make the application architecture highly available and multi-regional by duplicating them across regions, organizing them using resource groups, and understanding the capabilities and limitations of Azure Storage in RA-GRS mode.

Finally, you saw how to make the data architecture highly available and multi-regional by assessing how much data loss can be tolerated if there's a disaster. You've also discovered the overall expected recovery time for fully restoring the application, and budgeting for the appropriate tiers of Azure SQL and Cosmos DB.

## Learn more

- [Improve scalability in an Azure web application](https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/scalable-web-app)
- [Run a web application in multiple Azure regions for high availability](https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/multi-region)
- [Business continuity and disaster recovery (BCDR): Azure Paired Regions](https://docs.microsoft.com/azure/best-practices-availability-paired-regions)