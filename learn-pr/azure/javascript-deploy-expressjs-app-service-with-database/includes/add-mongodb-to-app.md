Adding MongoDB to an Express.js app includes several steps. In this module, many of the steps are done for you as part of the sample application.

## Adding MongoDB to an Express.js app

In order to add MongoDB to a Node.js app, such as Express.js, the complete connection requires:

* Connection data: adding the MongoDB connection string, database name and collection name to the app. You'll complete this step next.
* NPM package: Adding an appropriate npm package to connect to your remote MongoDB database. This module uses the native MongoDB driver, specified in the package.json file. 
* JavaScript code: Adding MongoDB API code to your Express.js app. This code is already provided for you. 

## MongoDB connection data

Connection data for this sample app is contained in the `.env` file. In the next exercise, you'll find your Cosmos DB connection string, and add that to the `.env` file, along with the database and collection you entered in the last exercise.

## Connection string requirements

> [!Important]
> Azure Cosmos DB has strict security requirements and standards. Azure Cosmos DB accounts require authentication and secure communication via *TLS*.

Azure Cosmos DB supports the standard MongoDB connection string URI format, with a couple of specific requirements: Azure Cosmos DB accounts require authentication and secure communication via TLS. So, the connection string format is:

`mongodb://username:password@host:port/[database]?ssl=true`

The values of this string are available in the **Connection String** blade shown earlier:

* Username (required): Cosmos account name.
* Password (required): Cosmos account password.
* Host (required): FQDN of the Cosmos account.
* Port (required): 10255.
* Database (optional): The database that the connection uses. If no database is provided, the default database is "test."
* ssl=true (required)

For example, consider the account shown in the **Connection String** blade. A valid connection string is:

`mongodb://contoso123:0Fc3IolnL12312asdfawejunASDF@asdfYXX2t8a97kghVcUzcDv98hawelufhawefafnoQRGwNj2nMPL1Y9qsIr9Srdw==@contoso123.documents.azure.com:10255/mydatabase?ssl=true`

## Driver Requirements

All drivers that support wire protocol version 3.4 or greater will support Azure Cosmos DB API for MongoDB.

Specifically, client drivers must support the Service Name Identification (SNI) TLS extension and/or the appName connection string option. If the `appName` parameter is provided, it must be included as found in the connection string value in the Azure portal.