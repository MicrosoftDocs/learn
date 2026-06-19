In this module, you learned how to build applications that connect to Azure DocumentDB using the official MongoDB drivers for Python, .NET, and JavaScript.

Your retail company's development teams can now integrate Azure DocumentDB into their application code regardless of their preferred programming language. You connected to your cluster using the standard MongoDB connection string with `SCRAM-SHA-256` authentication and `TLS` encryption. You performed `CRUD` operations programmatically, including inserting products with `insertOne` and `insertMany`, reading them with `findOne` and `find`, updating fields with `$set`, `$inc`, and `$addToSet`, and removing documents with `deleteOne` and `deleteMany`. You also learned how to manage connection lifecycles, handle common database errors, and secure connection strings using environment variables.

Because Azure DocumentDB is compatible with the MongoDB wire protocol, your existing MongoDB skills and code transfer directly. You can use the same drivers, the same query operators, and the same patterns you'd use with any MongoDB deployment.

## Learn more

- [Quickstart: Use Azure DocumentDB with MongoDB driver for Python](/azure/documentdb/quickstart-python)
- [Quickstart: Use Azure DocumentDB with MongoDB driver for C#](/azure/documentdb/quickstart-dotnet)
- [Quickstart: Use Azure DocumentDB with MongoDB driver for Node.js](/azure/documentdb/quickstart-nodejs)
