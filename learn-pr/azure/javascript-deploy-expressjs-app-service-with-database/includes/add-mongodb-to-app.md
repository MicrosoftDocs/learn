Adding MongoDB to an Express.js app includes several steps. In this module, many of the steps are done for you as part of the sample application.




## Azure Connection string requirements

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