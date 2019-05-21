During the early stages of the migration project the IT Director requested that the current SQL cluster which hosts several line of business application databases be included. The required due dilligence has been completed and the finer details that make up the SQL cluster have been noted, the migration can now take place.

In this unit you will discover the **Azure Database Migration Service** which has been designed to offer a single tool that provides an end to end solution to move on-premises SQL server databases to the Azure cloud.

 ## Azure Database Migration Service

The migration service is similar to Azure Migrate as it offers a guided solution with recommendations to migrate your on-premise SQL environment to the Azure cloud. It uses the technology behind the Data Migration Assistant to assess and guide through the initial planning steps for the migration and ultimately carries out the migration when required.

## Offline vs Online migration

The migration service provides two different ways to migrate SQL, an Offline migration or an Online migration. An Offline migration requires that the server being migrated be shutdown at the start of the migration which means downtime for the service starts at that point. An Online migration performs a continuous sync operation which allows cut over to the Azure replica database when required, thus minimizing downtime.

## Prerequisites

Either of the above methods results in the same prerequisite tasks needing to be performed, they are:

- **Download the Data Migration Assistant** - Obtained from Microsoft's download site and installed locally on your desired server
- **Create an Azure VNET** - Created for the Azure Database Migration Service using the Azure Resource Manager deployment model, it provides connectivity to the on-premises environment via either Express route, or VPN solution chosen to connect to Azure.
- **Configure the NSG (Network Security Group)** - The NSG associated with the new VNET  should allow inbound connectivity to the service via ports 443, 53, 9354, 445, and 12000.
- **Configure the Windows Firewall**- If Windows Firewall is used it must be configured to allow the Database Migration Service to connect over port 1433. 1434 can also be opened up if multiple named instances on dynamic ports exist on the same server
- **Configure credentials**- The credentials used to connect to the source SQL server instance should have **Control Server** permissions and the credentials used to connect to the target Azure SQL database should have the **Control Database** permission on the target Azure SQL database
- **Provision your target database in Azure**- Create the database to be used as the target for the migration, it should be sized appropriately for the workload that will be migrated to it

## Assessing the on-premises databases

Before the migration tasks take place it is important to ensure all communication ports are open and to perform a connectivity check to ensure that the source and destination servers can communicate. This Data Migration Assistant is used for this, once installed you need to create the Project type of **Assessment** , give the project a name and select the source and target servers. Connection details of the source server should be provided including credentials with permission to access it, on the database selection screen choose the database to migrate.

On completion the assessment will generate a report with a set of recommendations and alternative approaches that could be taken for the migration. You will also be able to see any compatibility issues between the source and destination databases that could cause the migration to fail. The report should be viewed and acted upon, it can be run as many times as required to ensure any issues have been fixed.

A sample report produced can be referred to below

<-- Insert picture similar to this, Azure Migrate Architecture -->

![Sample DMA Report](../media/2dma-assessment.png)

## Migrating the Schema

Each database has a schema which is the skeletal structure that represents the logical view of the entire database. It defines the rules on how the data contained within it is organized and how any relations are associated to it. Before migrating the database contents the schema must be migrated, this sets out the framework on the new database in Azure to match that of the source database located on-premises. It also serves as a test as to whether all connectivity is working before actually performing the migration of the data.

The schema migration is performed using the Data Migration Assistant which was also used for the initial assessment of the environment. A new project type of **Migration** should be created, specifying the project name, the source server which is your on-premise SQL server and then a target server type which is your Azure SQL database. The scope of the migration should be set to **Schema Only**, the connection details being specified when requested. When connected to the source database the schema objects can be selected that will deploy to the new Azure SQL database. A script is generated that executes the action, select **Deploy Schema**, once complete check the target server to ensure it has been configured as expected.

## Preparing your Azure environment

Before starting the database data migration Azure must be prepared in readiness. The **Microsoft.DataMigration** resource provider must be installed, an instance of the Azure Database Migration Service must be created and the migration project must be configured.

- **Register the Microsoft.DataMigration resource provider** - In the Azure portal the Microsoft.DataMigration resource provider should be searched for and registered for use
- **Create an instance of the Azure Database Migration Service** - In the Azure portal search for the Azure Database Migration Service and create it on the selection screen, specifying a name, subscription, resource group, location, VNET, and pricing tier for the service.
- **Create a migration project** - In the Azure Database Migration Service a new migration project should be created, specifying a project name, source SQL server type, target SQL server type and the type of migration you wish to perform whether that be Offline or Online
- **Specify source and target server details**- Once the migration project has been created, the source and target server details should be entered, that being, server name, authentication type and a username and password
- **Identify the databases**- Once the credentials are entered correctly the list of available databases on the source server appear, they should now be mapped to their relevant target database on the target server
- **Run and monitor the migration**- Once the databases have been selected, you can select the **Run migration** button to start the migration. The migration activity screen will appear where progress can be tracked until the process shows as 'completed'.
- **Check the migrated databases** - Once all the required databases have been migrated they should be checked to ensure they are working as expected.

## Knowledge Check

quiz:
  title: Check your knowledge
  questions:
  - content: Which of the following ports are need to be open on your Azure VNET NSG to allow the Database Migration Service to communicate inbound from an On-Premise environment ?
    choices:
    - content: 443, 53, 9354
      isCorrect: True
      explanation: These are all valid ports which need to be opened up for inbound 	communications to your Azure environment
    - content: 80, 54, 9354
      isCorrect: Fals
      explanation: 80 is unencrypted HTTP traffic, and 54 is a Xerox network service
    - content: 443, 54, 9534
      isCorrect: False
      explanation: 443 is correct, however 54 is a Xerox network service and 9534 is from a 	range of unassigned ports
  - content: Name the two permissions that are required to be added to the credentials used to connect to your source SQL instance during a planned migration
    choices:
    - content: Control Services, Control Database
      isCorrect: false
      explanation: Control Services is not a valid permission
    - content: Control Server, Control Database
      isCorrect: True
      explanation: These are both valid permissions that need to be added to the account used 	to connect to the source SQL instance during a planned migration
     - content: Control Services, Control Data Type 
      isCorrect: False
      explanation: Neither Control Services or Control Data Type are supported permissions