Learn how to perform offline migration of your MongoDB database to vCore-based Azure Cosmos DB for MongoDB using native MongoDB tools. This migration path is great for situations where migration time can be flexible, ensuring a smooth transfer of your database to Azure's environment.

## Prerequisites

 Before diving into the migration, confirm you have:

- A valid Azure subscription.
- A vCore-based Azure Cosmos DB for MongoDB account.
- MongoDB native tools installed on your local system.

## Get ready for the migration

Review your source MongoDB setup to ensure the compatibility with vCore-based Azure Cosmos DB for MongoDB. Check if your MongoDB native tools match your MongoDB version. If there's a mismatch, update these tools to match both your source and the vCore-based Azure Cosmos DB for MongoDB. Also, ensure you have a user set up in MongoDB with **readWrite** permissions.

Gather your Azure Cosmos DB credentials and adjust your firewall settings to allow access to your vCore-based Azure Cosmos DB for MongoDB cluster. These settings, ensure a secure connection between your MongoDB instance and the vCore-based Azure Cosmos DB for MongoDB cluster.

> [!TIP]
> Keeping the migration tools and MongoDB instance on the same network can smooth out potential firewall issues.

## Choose your MongoDB native tool

Selecting between ***mongoexport***/***mongoimport*** and ***mongodump***/***mongorestore*** boils down to your data's size and how quickly you need to move. It's about picking the right tool for the job.

### Using mongoexport/mongoimport

Think of **mongoexport** as packing your data into boxes (JSON files) and **mongoimport** as moving these boxes into your new vCore-based Azure Cosmos DB for MongoDB home. Remember, security is key, so use the **--ssl** flag and ensure you're sending your data to the correct place with your vCore-based Azure Cosmos DB for MongoDB connection string. **mongoexport**/**mongoimport** is more suited for smaller datasets or when you need to selectively export and import data. It's straightforward but might take longer for larger databases.

Keep an eye on the terminal during the import to get updates, much like tracking a delivery to its destination.

### Using mongodump/mongorestore

This method is like bulk-packing your MongoDB data (using **mongodump**) and then carefully placing it in its new spot in vCore-based Azure Cosmos DB for MongoDB with **mongorestore**. **mongodump**/**mongorestore** is the preferred method for larger datasets. It efficiently handles bulk data operations, making it ideal for comprehensive migrations.

Again, watching the terminal output during restoration gives you live feedback, ensuring each data piece lands right where it should.

This approach transitions your MongoDB database to a scalable, Azure-based environment efficiently, ensuring your data is set for future growth. To learn more about the MongoDB native tools, visit the [MongoDB native tools documentation](https://docs.mongodb.com/database-tools/).
