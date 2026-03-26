Now that you understand the different storage options within Azure, it's important to also understand how to get your data into Azure. Azure supports both real-time migration of infrastructure, applications, and data using Azure Migrate as well as asynchronous migration of data using Azure Data Box.

:::image type="content" source="../media/data-migration-options.png" alt-text="Diagram comparing two Azure data migration approaches: Azure Migrate for online real-time migration and Azure Data Box for physical offline bulk data transfer.":::

## Azure Migrate

Azure Migrate is a service that helps you migrate from an on-premises environment to the cloud. Azure Migrate functions as a hub to help you manage the assessment and migration of your on-premises datacenter to Azure. It provides the following:

 -  **Unified migration platform**: A single portal to start, run, and track your migration to Azure.
 -  **Range of tools**: A range of tools for assessment and migration. Azure Migrate tools include Azure Migrate: Discovery and assessment and Azure Migrate: Server Migration. Azure Migrate also integrates with other Azure services and tools, and with independent software vendor (ISV) offerings.
 -  **Assessment and migration**: In the Azure Migrate hub, you can assess and migrate your on-premises infrastructure to Azure.

### Integrated tools

In addition to working with tools from ISVs, the Azure Migrate hub includes integrated options for discovery and assessment, server migration, database migration, and web app migration.

## Azure Data Box

Azure Data Box is a physical migration service that helps transfer large amounts of data in a quick, inexpensive, and reliable way. The secure data transfer is accelerated by shipping you a proprietary Data Box storage device that has a maximum usable storage capacity of 80 terabytes. The Data Box is transported to and from your datacenter via a regional carrier. A rugged case protects and secures the Data Box from damage during transit.

You can order the Data Box device via the Azure portal to import or export data from Azure. Once the device is received, you can quickly set it up using the local web UI and connect it to your network. Once you’re finished transferring the data (either into or out of Azure), simply return the Data Box. If you’re transferring data into Azure, the data is automatically uploaded once Microsoft receives the Data Box back. The entire process is tracked end-to-end by the Data Box service in the Azure portal.

### Use cases

Data Box is ideally suited for moving very large data sets (often tens of terabytes or more) when network bandwidth is limited.

Common Data Box scenarios include:

 -  One-time bulk migration of on-premises data to Azure.
 -  Periodic large data uploads where online transfer is too slow.
 -  Exporting large data sets from Azure for recovery or regulatory needs.

Once the data from your import order is uploaded to Azure, the disks on the device are wiped clean in accordance with NIST 800-88r1 standards. For an export order, the disks are erased once the device reaches the Azure datacenter.

