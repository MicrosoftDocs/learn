
It's time to programmatically check-out how to create our Azure Cosmos DB for MongoDB databases, collections and add some data.

This exercise can be completed using a Microsoft Learn *sandbox*, which provides a temporary Azure subscription. To activate the sandbox subscription, you must sign in using a Microsoft account. The sandbox subscription will be automatically deleted when you complete this module. After the sandbox has been activated, [sign into the Azure portal using the credentials for your sandbox subscription](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Ensure you're working in the **Microsoft Learn Sandbox** directory - indicated at the top right of the portal under your user ID. If not, select the user icon and switch directory.

> [!TIP]
> If you prefer, you can use your own Azure subscription. To do so, [sign into the Azure portal using credentials for your subscription](https://portal.azure.com?azure-portal=true). Ensure you are working in the directory containing your subscription - indicated at the top right under your user ID. If not, select the user icon and switch directory.

::: zone pivot="node"

## Create MongoDB app using ***Node.js*** Azure Cosmos DB for MongoDB

In this exercise, you'll create an Azure Cosmos DB for MongoDB account, a database, a collection and add a couple of documents to the collection. You'll notice that this code will be identical to how you would connect to any MongoDB database.  You'll then create a collection using extension commands that allow you to define the throughput in Request Units/sec (RUs) for the collection.

### Prepare your development environment

If you haven't already prepared the Azure Cosmos DB account and environment where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the App.js file** section.

1. In Azure Cloud Shell, copy and paste the following commands.

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/node/

    # Update Azure Cloud Shell node to Version 14.0.0, since the MongoDB driver requires ver 10+
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install 14.0.0
    npm install -g mongodb
    npm link mongodb
    # Check if the node version is now v14.0.0
    node --version
    
    # Create an Azure Cosmos DB for MongoDB account
    bash ../init.sh
    ```

    > [!Tip]
    > If you are not using the sandbox for the lab, and you want to specify the location where you would like to create your database and storage objects, add a ***-l LOCATIONNAME*** parameter to the *init.sh* call. Additionally, if you would like to specify a resource group, add a ***-r YOURRRESOURCEGROUPNAMEHERE*** parameter to the *init.sh* call.

    > [!NOTE]
    > This bash script will create the Azure Cosmos DB for MongoDB account. *It can take 5-10 minutes to create this account* so it might be a good time to get a cup of coffee or tea.

    > [!TIP]
    > If you come back and your cloud shell has reset, run the following commands in the cloud shell to use Node version 14, otherwise the code in the next section will fail.

    >1. source ~/.nvm/nvm.sh
    >1. nvm install 14.0.0
    >1. npm link mongodb

1. When the bash *init.sh* file completes running, copy somewhere the ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** returned, we'll need them in the next section. You can also review the JSON  returned by the account creation script that is located before the connection string.  If you look somewhere in the middle of the JSON, you should see the property **"kind": "MongoDB"**.

    > [!NOTE] 
    > The ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** can also be found using the Azure portal.

### Add the code to create the databases, collection and document to the App.js file

It's now time to add our JavaScript code to create a Database, a Collection and add a document to the collection.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/node/
    code App.js
    ```

1. Copy the following code to the App.js file. *Don't forget that you'll need to replace the url value for the connection string copied in step 2 of the previous section*. This connection string should look like

    mongodb://learn-account-cosmos-92903170:XvrarRd8LnqWNZiq3ahHXngbZoVRxVO192WahrcdsmHVivBGbRqnHx2cq0oMGnc0DUPAWpyGu7kt7APVH4nqXg==@learn-account-cosmos-92903170.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@learn-account-cosmos-92903170@.  

    This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```JavaScript
    // Uses the MongoDB driver
    const {MongoClient} = require("mongodb");
    
    async function main() {
    
      // Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
      // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
      // Or replace it with the connection string if you have it.
      var url = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@";
    
      // define the connection using the MongoClient method ane the url above
      var mongoClient = new MongoClient(url, function(err,client)
        {
          if (err)
          {
            console.log("error connecting")
          }
        }
      );
    
      // open the connection
      await mongoClient.connect();
        
    ```

1. The next step connects to the **products** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```javascript
      // connect to the database "products"
      var ProductDatabase = mongoClient.db("products");
    
    ```

1. Next, we'll connect to the **documents** collection if it already exists, and then adds one document to the collection. Note that if the collection doesn't exist this code will only create the collection if it also performs an operation on that collection in the same connection (for example, like add a document to the collection) or by using extension commands. Add the following to the script in the editor.

    ```javascript
      // create a collection "documents" and add one document for "bread"
      var collection = ProductDatabase.collection('documents');
      var insertResult = await collection.insertOne({ ProductId: 1, name: "bread" });
    
    ```

1. Lets now search for the document we just inserted and display it to the shell. Add the following to the script in the editor.

    ```javascript
      // return data where ProductId = 1
      const findProduct = await collection.find({ProductId: 1});
      await findProduct.forEach(console.log);
    
    ```

1. Finally let's close the connection and call the *main* function to run it. Add the following to the script in the editor.

    ```javascript
      // close the connection
      mongoClient.close();
    }
    
    main();
    ```

1. The script should look like this:

    ```JavaScript
    // Uses the MongoDB driver
    const {MongoClient} = require("mongodb");
    
    async function main() {
    
      // Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
      // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
      // Or replace it with the connection string if you have it.
      var url = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@";
    
      // define the connection using the MongoClient method ane the url above
      var mongoClient = new MongoClient(url, function(err,client)
        {
          if (err)
          {
            console.log("error connecting")
          }
        }
      );
    
      // open the connection
      await mongoClient.connect();
        
      // connect to the database "products"
      var ProductDatabase = mongoClient.db("products");
    
      // create a collection "documents" and add one document for "bread"
      var collection = ProductDatabase.collection('documents');
      var insertResult = await collection.insertOne({ ProductId: 1, name: "bread" });
    
      // return data where ProductId = 1
      const findProduct = await collection.find({ProductId: 1});
      await findProduct.forEach(console.log);
    
      // close the connection
      mongoClient.close();
    }
    
    main();
    ```

1. Let's go ahead and save the JavaScript program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the JavaScript App with the following command.

    ```bash
    node App.js
    ```  

1. This should return a similar result to the one below.  This means that we created the database, collection and added a document to it.

    ```json
    {
      _id: new ObjectId("62aed08663c0fd62d30240db"),
      ProductId: 1,
      name: 'bread'
    }
    ```

As you should have noticed, this code is the same code you would run to create a database, collection and document on a MongoDB database. So programming for Azure Cosmos DB for MongoDB should be transparent to you if you're already familiar with creating apps that connect to MongoDB.

### Using extension commands to manage data stored in Azure Cosmos DB’s API for MongoDB

While the code above, except for the connection string, would be identical between connecting to a MongoDB Server then connection to our Azure Cosmos DB for MongoDB account, this might not take advantage of Azure Cosmos DB features. What this means is using the default driver methods to create our collections, will also use the default Azure Cosmos DB Account parameters  to create those collections. So we won't be able to define creation parameters like our throughput, sharding key or autoscaling settings using those methods.

By using the Azure Cosmos DB’s API for MongoDB, you can enjoy the benefits of Cosmos DB such as global distribution, automatic sharding, high availability, latency guarantees, automatic, encryption at rest, backups, and many more, while preserving your investments in your MongoDB app. You can communicate with the Azure Cosmos DB’s API for MongoDB by using any of the open-source MongoDB client drivers. The Azure Cosmos DB’s API for MongoDB enables the use of existing client drivers by adhering to the MongoDB wire protocol.

Let's create some code that will allow us to create a collection and define its sharding key and throughput.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/node
    code App.js
    ```

1. Copy the following code and *replace the existing content* from the app.cs file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```javascript
    // Uses the MongoDB driver
    const {MongoClient} = require("mongodb");
    
    async function main() {
    
      // Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
      // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
      // Or replace it with the connection string if you have it.
      var url = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@";
    
      // define the connection using the MongoClient method ane the url above
      var mongoClient = new MongoClient(url, function(err,client)
        {
          if (err)
          {
            console.log("error connecting")
          }
        }
      );
    
      // open the connection
      await mongoClient.connect();
        
    ```

1. The next step connects to the **employees** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```javascript
      // connect to the database "HumanResources"
      var EmployeeDatabase = mongoClient.db("HumanResources");
    
    ```

1. So far it looks pretty much like the code in the previous section. In this step, we'll now take advantage of the extension commands and create a custom action.  This action will allow us to define the throughput and the sharding key of the collection, which will in turn give Azure Cosmos DB the parameters to use when creating the collection. Add the following to the script in the editor.

    ```javascript
      // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
      var result = EmployeeDatabase.command({customAction: "CreateCollection", collection: "Employee", offerThroughput: 1000, shardKey: "EmployeeId"});
    
    ```

1. The rest will be pretty identical to the previous example, we will connect to the collection, insert some rows,  finally query and output a row back. Add the following to the script in the editor.

    ```javascript
      // Connect to the collection "Employee" and add two documents for "Marcos" and "Tam" 
      var collection = EmployeeDatabase.collection('Employee');

      var insertResult = await collection.insertOne({EmployeeId: 1, email: "Marcos@fabrikam.com", name: "Marcos"});
      insertResult = await collection.insertOne({EmployeeId: 2, email: "Tam@fabrikam.com", name: "Tam"});
    
      // return data where ProductId = 1
      const findProduct = await collection.find({EmployeeId: 1});
      await findProduct.forEach(console.log);
    
      // close the connection
      mongoClient.close();
    }
    
    main();
    ```

1. The script should look like this:

    ```javascript
    // Uses the MongoDB driver
    const {MongoClient} = require("mongodb");
    
    async function main() {
    
      // Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
      // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
      // Or replace it with the connection string if you have it.
      var url = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@";
    
      // define the connection using the MongoClient method ane the url above
      var mongoClient = new MongoClient(url, function(err,client)
        {
          if (err)
          {
            console.log("error connecting")
          }
        }
      );
    
      // open the connection
      await mongoClient.connect();
        
      // connect to the database "HumanResources"
      var EmployeeDatabase = mongoClient.db("HumanResources");
    
      // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
      var result = EmployeeDatabase.command({customAction: "CreateCollection", collection: "Employee", offerThroughput: 1000, shardKey: "EmployeeId"});
    
      // Connect to the collection "Employee" and add two documents for "Marcos" and "Tam" 
      var collection = EmployeeDatabase.collection('Employee');

      var insertResult = await collection.insertOne({EmployeeId: 1, email: "Marcos@fabrikam.com", name: "Marcos"});
      insertResult = await collection.insertOne({EmployeeId: 2, email: "Tam@fabrikam.com", name: "Tam"});
    
      // return data where ProductId = 1
      const findProduct = await collection.find({EmployeeId: 1});
      await findProduct.forEach(console.log);
    
      // close the connection
      mongoClient.close();
    }
    
    main();
    ```

1. Let's go ahead and save the Node.js program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the Node.js App with the following command.

    ```bash
    node App.js
    ```  

1. This should return a similar result to the one below. This means that we created the database, collection and added a document to it.

    ```json
    {
      _id: new ObjectId("62aed08663c0fd62d30240db"),
      EmployeeId: 1,
      email: 'Marcos@fabrikam.com'
      name: 'Marcos'
    }
    ```

1. However this last result set only confirmed that we indeed created a database, collection and documents, but what about our shard key and throughput, did they really change? On the Cloud Shell let's run the following commands to verify our changes took effect.

    1. Let's verify that our Shard key changed to ***EmployeeId*** (the default is *id*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"shardKey": {"EmployeeId": "Hash"}**.

    1. Let's verify that our Throughput changed to ***1000*** (the default is *400*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection throughput show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"throughput": 1000**.

This code illustrated the power of using extended commands in our code, which allows us to define the Azure Cosmos DB creation parameters.  This allows us to take advantage of controlling how our collections will be created and processed by Azure Cosmos DB.

::: zone-end

::: zone pivot="java"

## Create MongoDB app using ***Java*** Azure Cosmos DB for MongoDB

In this exercise, you'll create an Azure Cosmos DB for MongoDB account, a database, a collection and add a couple of documents to the collection. You'll notice that this code will be identical to how you would connect to any MongoDB database. To use the Java engine, we'll create and compile an App running *Maven*. You'll then create a collection using extension commands that allow you to define the throughput in Request Units (RUs) for the collection.

### Prepare your development environment

If you haven't already prepared the environment and the Azure Cosmos DB account where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the App.java file** section.

1. In Azure Cloud Shell, copy and paste the following commands.

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/java
    # Download and install the Maven project, this will take a minute or two
    mvn archetype:generate -DgroupId=com.fabrikam -DartifactId=AzureApp -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
    # Replace the projects pom.xml file with the github one that has the MongoDB definition
    mv pom.xml1 ./AzureApp/pom.xml

    # Create an Azure Cosmos DB for MongoDB account
    bash ../init.sh
    ```

    > [!Tip]
    > If you are not using the sandbox for the lab, and you want to specify the location where you would like to create your database and storage objects, add a ***-l LOCATIONNAME*** parameter to the *init.sh* call. Additionally, if you would like to specify a resource group, add a ***-r YOURRRESOURCEGROUPNAMEHERE*** parameter to the *init.sh* call.

    > [!NOTE] 
    > This bash script will create the Azure Cosmos DB for MongoDB account. *It can take 5-10 minutes to create this account* so it might be a good time to get a cup of coffee or tea.

1. When the bash *init.sh* file completes running, copy somewhere the ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** returned, we'll need them in the next section. You can also review the JSON  returned by the account creation script that is located before the connection string.  If you look somewhere in the middle of the JSON, you should see the property **"kind": "MongoDB"**.

    > [!NOTE] 
    > Note that  the ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** can also be found using the Azure portal.

### Add the code to create the databases, collection and document to the App.java file

It's now time to add our Java code to create a Database, a Collection and add a document to the collection.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/java/AzureApp
    code ./src/main/java/com/fabrikam/App.java
    ```

1. Copy the following code and *replace the existing content* from the App.java file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This connection string should look like

    mongodb://learn-account-cosmos-92903170:XvrarRd8LnqWNZiq3ahHXngbZoVRxVO192WahrcdsmHVivBGbRqnHx2cq0oMGnc0DUPAWpyGu7kt7APVH4nqXg==@learn-account-cosmos-92903170.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@learn-account-cosmos-92903170@.  

    This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```Java
    package com.fabrikam;

    // Uses the MongoDB driver
    import com.mongodb.MongoClient;
    import com.mongodb.MongoClientURI;
    import com.mongodb.client.MongoDatabase;
    import com.mongodb.client.MongoCollection;
    import org.bson.Document;
    import static com.mongodb.client.model.Filters.eq;

    public class App {
        public static void main(String[] args) {

            // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
            // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
            // Or replace it with the connection string if you have it.
            MongoClientURI uri = new MongoClientURI("mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@");
    
            MongoClient mongoClient = null;
            try {
                // define the connection using the MongoClient method ane the url above and open the connection 
                mongoClient = new MongoClient(uri);
    
    ```

1. The next step connects to the **products** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```java
                // connect to the database "products"
                MongoDatabase ProductDatabase = mongoClient.getDatabase("products");
    
    ```

1. Next, we'll connect to the **documents** collection if it already exists, and then adds one document to the collection. Note that if the collection doesn't exist this code will only create the collection if it also performs an operation on that collection in the same connection (for example, like add a document to the collection) or by using extension commands. Add the following to the script in the editor.

    ```java
                // create a collection "documents" and add one document for "bread" 
                MongoCollection collection = ProductDatabase.getCollection("products");
    
                collection.insertOne(new Document()
                            .append("ProductId", 1)
                            .append("name", "bread"));
    
    ```

1. Lets now search for the document we just inserted and display it to the shell. Add the following to the script in the editor.

    ```java
                // return data where ProductId = 1
                Document findProduct = (Document) collection.find(eq("ProductId", 1)).first();
                System.out.println(findProduct.toJson());
            }
    ```

1. Finally let's close the connection. Add the following to the script in the editor.

    ```java
            // close the connection
            finally {
                if (mongoClient != null) {
                    mongoClient.close();
                }
            }
        }
    }
    ```

1. The script should look like this:

    ```java
    package com.fabrikam;

    // Uses the MongoDB driver
    import com.mongodb.MongoClient;
    import com.mongodb.MongoClientURI;
    import com.mongodb.client.MongoDatabase;
    import com.mongodb.client.MongoCollection;
    import org.bson.Document;
    import static com.mongodb.client.model.Filters.eq;

    public class App {
        public static void main(String[] args) {

            // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
            // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
            // Or replace it with the connection string if you have it.
            MongoClientURI uri = new MongoClientURI("mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@");
    
            MongoClient mongoClient = null;
            try {
                // define the connection using the MongoClient method ane the url above and open the connection 
                mongoClient = new MongoClient(uri);
    
                // connect to the database "products"
                MongoDatabase ProductDatabase = mongoClient.getDatabase("products");
    
                // create a collection "products" and add one document for "bread" 
                MongoCollection collection = ProductDatabase.getCollection("products");
    
                collection.insertOne(new Document()
                            .append("ProductId", 1)
                            .append("name", "bread"));
    
                // return data where ProductId = 1
                Document findProduct = (Document) collection.find(eq("ProductId", 1)).first();
                System.out.println(findProduct.toJson());
            }
            // close the connection
            finally {
                if (mongoClient != null) {
                    mongoClient.close();
                }
            }
        }
    }
    ```

1. Let's go ahead and save the Java program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the Java App with the following command.

    ```bash
    mvn clean compile exec:java
    ```  

1. This should return a similar result to the one below. As we mentioned at the beginning of this exercise, we're using *Maven* to build and compile this app.  You'll notice that this output is very chatty, this is normal since this output is usually piped to a log file. However towards the end, you should see this *INFO* message below with the JSON results of our **ProductId = 1** query in our code.  This means that we created the database, collection and added a document to it.

    ```json
    INFO: Opened connection [connectionId{localValue:3, serverValue:74678510}] to learn-account-cosmos-665601-westus.mongo.cosmos.azure.com:10255
    { "_id" : { "$oid" : "62afa8c3dff473012e7b7910" }, "ProductId" : 1, "name" : "bread" }
    Jun 19, 2022 10:52:59 PM com.mongodb.diagnostics.logging.JULLogger log
    INFO: Closed connection [connectionId{localValue:3, serverValue:74678510}] to learn-account-cosmos-665601-westus.mongo.cosmos.azure.com:10255 because the pool has been closed.
    ```

As you should have noticed, this code is the same code you would run to create a database, collection and document on a MongoDB database. So programming for Azure Cosmos DB for MongoDB should be transparent to you if you're already familiar with creating apps that connect to MongoDB.

### Using extension commands to manage data stored in Azure Cosmos DB’s API for MongoDB

While the code above, except for the connection string, would be identical between connecting to a MongoDB Server then connection to our Azure Cosmos DB for MongoDB account, this might not take advantage of Azure Cosmos DB features. What this means is using the default driver methods to create our collections, will also use the default Azure Cosmos DB Account parameters  to create those collections. So we won't be able to define creation parameters like our throughput, sharding key or autoscaling settings using those methods.

By using the Azure Cosmos DB’s API for MongoDB, you can enjoy the benefits of Cosmos DB such as global distribution, automatic sharding, high availability, latency guarantees, automatic, encryption at rest, backups, and many more, while preserving your investments in your MongoDB app. You can communicate with the Azure Cosmos DB’s API for MongoDB by using any of the open-source MongoDB client drivers. The Azure Cosmos DB’s API for MongoDB enables the use of existing client drivers by adhering to the MongoDB wire protocol.

Let's create some code that will allow us to create a collection and define its sharding key and throughput.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/java/AzureApp
    code ./src/main/java/com/fabrikam/App.java
    ```

1. Copy the following code and *replace the existing content* from the App.java file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```java
    package com.fabrikam;

    // Uses the MongoDB driver
    import com.mongodb.MongoClient;
    import com.mongodb.MongoClientURI;
    import com.mongodb.client.MongoDatabase;
    import com.mongodb.client.MongoCollection;
    import org.bson.Document;
    import static com.mongodb.client.model.Filters.eq;

    public class App {
        public static void main(String[] args) {

            // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
            // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
            // Or replace it with the connection string if you have it.
            MongoClientURI uri = new MongoClientURI("mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@");
    
            MongoClient mongoClient = null;
            try {
                // define the connection using the MongoClient method ane the url above and open the connection 
                mongoClient = new MongoClient(uri);
    
    ```

1. The next step connects to the **employees** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```java
                // connect to the database "HumanResources"
                MongoDatabase EmployeeDatabase = mongoClient.getDatabase("HumanResources");
    
    ```

1. So far it looks pretty much like the code in the previous section. In this step, we'll now take advantage of the extension commands and create a custom action.  This action will allow us to define the throughput and the sharding key of the collection, which will in turn give Azure Cosmos DB the parameters to use when creating the collection. Add the following to the script in the editor.

    ```java
                // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
                Document employeeCollectionDef = new Document();
                employeeCollectionDef.append("customAction", "CreateCollection");
                employeeCollectionDef.append("collection", "Employee");
                employeeCollectionDef.append("offerThroughput", 1000);
                employeeCollectionDef.append("shardKey", "EmployeeId");

                Document result = EmployeeDatabase.runCommand(employeeCollectionDef);
        
    ```

1. The rest will be pretty identical to the previous example, we will connect to the collection, insert some rows,  query and output a row back and finally close the collection. Add the following to the script in the editor.

    ```java
                // Connect to the collection "Employee" and add two documents for "Marcos" and "Tam" 
                MongoCollection collection = EmployeeDatabase.getCollection("Employee");
    
                collection.insertOne(new Document()
                            .append("EmployeeId", 1)
                            .append("email","Marcos@fabrikam.com")
                            .append("name", "Marcos"));
    
                collection.insertOne(new Document()
                            .append("EmployeeId", 2)
                            .append("email","Tam@fabrikam.com")
                            .append("name", "Tam"));
    
                // return data where EmployeeId = 1
                Document findEmployee = (Document) collection.find(eq("EmployeeId", 1)).first();
                System.out.println(findEmployee.toJson());
            }
            // close the connection
            finally {
                if (mongoClient != null) {
                    mongoClient.close();
                }
            }
        }
    }
    ```

1. The script should look like this:

    ```java
    package com.fabrikam;

    // Uses the MongoDB driver
    import com.mongodb.MongoClient;
    import com.mongodb.MongoClientURI;
    import com.mongodb.client.MongoDatabase;
    import com.mongodb.client.MongoCollection;
    import org.bson.Document;
    import static com.mongodb.client.model.Filters.eq;

    public class App {
        public static void main(String[] args) {

            // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
            // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
            // Or replace it with the connection string if you have it.
            MongoClientURI uri = new MongoClientURI("mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@");
    
            MongoClient mongoClient = null;
            try {
                // define the connection using the MongoClient method ane the url above and open the connection 
                mongoClient = new MongoClient(uri);
    
                // connect to the database "HumanResources"
                MongoDatabase EmployeeDatabase = mongoClient.getDatabase("HumanResources");
    
                // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
                Document employeeCollectionDef = new Document();
                employeeCollectionDef.append("customAction", "CreateCollection");
                employeeCollectionDef.append("collection", "Employee");
                employeeCollectionDef.append("offerThroughput", 1000);
                employeeCollectionDef.append("shardKey", "EmployeeId");

                Document result = EmployeeDatabase.runCommand(employeeCollectionDef);
        
                // Connect to the collection "Employee" and add two documents for "Marcos" and "Tam" 
                MongoCollection collection = EmployeeDatabase.getCollection("Employee");
    
                collection.insertOne(new Document()
                            .append("EmployeeId", 1)
                            .append("email","Marcos@fabrikam.com")
                            .append("name", "Marcos"));
    
                collection.insertOne(new Document()
                            .append("EmployeeId", 2)
                            .append("email","Tam@fabrikam.com")
                            .append("name", "Tam"));
    
                // return data where EmployeeId = 1
                Document findEmployee = (Document) collection.find(eq("EmployeeId", 1)).first();
                System.out.println(findEmployee.toJson());
            }
            // close the connection
            finally {
                if (mongoClient != null) {
                    mongoClient.close();
                }
            }
        }
    }
    ```

1. Let's go ahead and save the Java program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the Java App with the following command.

    ```bash
    mvn clean compile exec:java
    ```  

1. This should return a similar result to the one below. As we mentioned at the beginning of this exercise, we're using *Maven* to build and compile this app.  You'll notice that this output is very chatty, this is normal since this output is usually piped to a log file. However towards the end, you should see this *INFO* message below with the JSON results of our **EmployeeId = 1** query in our code.  This means that we created the database, collection and added a document to it.

    ```json
    INFO: Opened connection [connectionId{localValue:3, serverValue:2080122971}] to learn-account-cosmos-845083734-westus.mongo.cosmos.azure.com:10255
    { "_id" : { "$oid" : "62afd8e2c471f3011bd415fe" }, "EmployeeId" : 1, "email" : "Marcos@fabrikam.com", "name" : "Marcos" }
    Jun 20, 2022 2:18:11 AM com.mongodb.diagnostics.logging.JULLogger log
    INFO: Closed connection [connectionId{localValue:3, serverValue:2080122971}] to learn-account-cosmos-845083734-westus.mongo.cosmos.azure.com:10255 because the pool has been closed.
        ```

1. However this last result set only confirmed that we indeed created a database, collection and documents, but what about our shard key and throughput, did they really change? On the Cloud Shell let's run the following commands to verify our changes took effect.

    1. Let's verify that our Shard key changed to ***EmployeeId*** (the default is *id*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"shardKey": {"EmployeeId": "Hash"}**.

    1. Let's verify that our Throughput changed to ***1000*** (the default is *400*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection throughput show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"throughput": 1000**.

This code illustrated the power of using extended commands in our code, which allows us to define the Azure Cosmos DB creation parameters.  This allows us to take advantage of controlling how our collections will be created and processed by Azure Cosmos DB.
::: zone-end

::: zone pivot="python"

## Create MongoDB app using ***Python*** Azure Cosmos DB for MongoDB

In this exercise, you'll create an Azure Cosmos DB for MongoDB account, a database, a collection and add a couple of documents to the collection. You'll notice that this code will be identical to how you would connect to any MongoDB database.  You'll then create a collection using extension commands that allow you to define the throughput in Request Units/sec (RUs) for the collection.

### Prepare your development environment

If you haven't already prepared the Azure Cosmos DB account and environment where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the App.py file** section.

1. In Azure Cloud Shell, copy and paste the following commands.

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/python
    # Install the MongoDB Python drivers
    python -m pip install pymongo
    # Create an Azure Cosmos DB for MongoDB account
    bash ../init.sh
    ```

    > [!Tip]
    > If you are not using the sandbox for the lab, and you want to specify the location where you would like to create your database and storage objects, add a ***-l LOCATIONNAME*** parameter to the *init.sh* call. Additionally, if you would like to specify a resource group, add a ***-r YOURRRESOURCEGROUPNAMEHERE*** parameter to the *init.sh* call.

    > [!NOTE] 
    > This bash script will create the Azure Cosmos DB for MongoDB account. *It can take 5-10 minutes to create this account* so it might be a good time to get a cup of coffee or tea. 

1. When the bash *init.sh* file completes running, copy somewhere the ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** returned, we'll need them in the next section. You can also review the JSON  returned by the account creation script that is located before the connection string.  If you look somewhere in the middle of the JSON, you should see the property **"kind": "MongoDB"**.

    > [!NOTE] 
    > The ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** can also be found using the Azure portal.

### Add the code to create the databases, collection and document to the App.py file

It's now time to add our Python code to create a Database, a Collection and add a document to the collection.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/python
    code App.py
    ```

1. Copy the following code to the App.js file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This connection string should look like

    mongodb://learn-account-cosmos-92903170:XvrarRd8LnqWNZiq3ahHXngbZoVRxVO192WahrcdsmHVivBGbRqnHx2cq0oMGnc0DUPAWpyGu7kt7APVH4nqXg==@learn-account-cosmos-92903170.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@learn-account-cosmos-92903170@.  

    This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```python
    # Use the MongoDB drivers
    import pymongo
    
    
    def main():
        # Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB
        # account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        # Or replace it with the connection string if you have it.
        uri = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@"
        
        # We use the "MongoClient" method and the "uri" value to connect to the account 
        client = pymongo.MongoClient(uri)
        
        ```

1. The next step connects to the **products** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```python
        # connect to the database "products"
        ProductDatabase = client["products"]
        
    ```

1. Next, we'll connect to the **documents** collection if it already exists, and then adds one document to the collection. Note that if the collection doesn't exist this code will only create the collection if it also performs an operation on that collection in the same connection (for example, like add a document to the collection) or by using extension commands. Add the following to the script in the editor.

    ```python
        # create a collection "products" and add one document for "bread"
        collection = ProductDatabase["products"]
        collection.insert_one({ "ProductId": 1, "name": "bread" })
        
    ```

1. Lets now search for the document we just inserted and display it to the shell. Add the following to the script in the editor.

    ```python
        # return data where ProductId = 1
        Product_1 = collection.find_one({"ProductId": 1})
    
        print(Product_1)
    
    ```

1. Finally let's close the connection and call the *main* function to run it. Add the following to the script in the editor.

    ```python
        # close the connection
        client.close()

    if __name__ == '__main__':
        main()
    ```

1. The script should look like this:

    ```python
    # Use the MongoDB drivers
    import pymongo
    
    def main():
        # Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB
        # account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        # Or replace it with the connection string if you have it.
        uri = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@"
        
        # We use the "MongoClient" method and the "uri" value to connect to the account 
        client = pymongo.MongoClient(uri)
        
        # connect to the database "products"
        ProductDatabase = client["products"]
        
        # create a collection "products" and add one document for "bread"
        collection = ProductDatabase["products"]
        collection.insert_one({ "ProductId": 1, "name": "bread" })
        
        # return data where ProductId = 1
        Product_1 = collection.find_one({"ProductId": 1})
        
        print(Product_1)
    
        # close the connection
        client.close()

    if __name__ == '__main__':
        main()
    ```

1. Let's go ahead and save the Python program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the Python App with the following command.

    ```bash
    python App.py
    ```  

1. This should return a similar result to the one below.  This means that we created the database, collection and added a document to it.

    ```json
    {'_id': ObjectId('62afecc3a04e32b92451ac5d'), 'ProductId': 1, 'name': 'bread'}
    ```

As you should have noticed, this code is the same code you would run to create a database, collection and document on a MongoDB database. So programming for Azure Cosmos DB for MongoDB should be transparent to you if you're already familiar with creating apps that connect to MongoDB.

### Using extension commands to manage data stored in Azure Cosmos DB’s API for MongoDB

While the code above, except for the connection string, would be identical between connecting to a MongoDB Server then connection to our Azure Cosmos DB for MongoDB account, this might not take advantage of Azure Cosmos DB features. What this means is using the default driver methods to create our collections, will also use the default Azure Cosmos DB Account parameters  to create those collections. So we won't be able to define creation parameters like our throughput, sharding key or autoscaling settings using those methods.

By using the Azure Cosmos DB’s API for MongoDB, you can enjoy the benefits of Cosmos DB such as global distribution, automatic sharding, high availability, latency guarantees, automatic, encryption at rest, backups, and many more, while preserving your investments in your MongoDB app. You can communicate with the Azure Cosmos DB’s API for MongoDB by using any of the open-source MongoDB client drivers. The Azure Cosmos DB’s API for MongoDB enables the use of existing client drivers by adhering to the MongoDB wire protocol.

Let's create some code that will allow us to create a collection and define its sharding key and throughput.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/python
    code App.py
    ```

1. Copy the following code and *replace the existing content* from the app.cs file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```python
    # Use the MongoDB drivers
    import pymongo
    
    def main():
        # Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB
        # account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        # Or replace it with the connection string if you have it.
        uri = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@"
        
        # We use the "MongoClient" method and the "uri" value to connect to the account 
        client = pymongo.MongoClient(uri)
        
    ```

1. The next step connects to the **employees** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```python
        # connect to the database "HumanResources"
        EmployeeDatabase = client["HumanResources"]
        
    ```

1. So far it looks pretty much like the code in the previous section. In this step, we'll now take advantage of the extension commands and create a custom action.  This action will allow us to define the throughput and the sharding key of the collection, which will in turn give Azure Cosmos DB the parameters to use when creating the collection. Add the following to the script in the editor.

    ```python
        # create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
        EmployeeDatabase.command({'customAction': "CreateCollection", 'collection': "Employee", 'offerThroughput': 1000, 'shardKey': "EmployeeId"})
    
    ```

1. The rest will be pretty identical to the previous example, we will connect to the collection, insert some rows,  finally query and output a row back. Add the following to the script in the editor.

    ```python
        # Connect to the collection "Employee" and add two documents for "Marcos" and "Tam"
        collection = EmployeeDatabase["Employee"]
        collection.insert_one({ "EmployeeId": 1, "email": "Marcos@fabrikan.com", "name": "Marcos" })
        collection.insert_one({ "EmployeeId": 2, "email": "Tam@fabrikan.com", "name": "Tam" })
        
        # return data where ProductId = 1
        Product_1 = collection.find_one({"EmployeeId": 1})
        
        print(Product_1)
    
        # close the connection
        client.close()

    if __name__ == '__main__':
        main()
    ```

1. The script should look like this:

    ```python
    # Use the MongoDB drivers
    import pymongo
    
    def main():
        # Replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB
        # account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        # Or replace it with the connection string if you have it.
        uri = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@"
        
        # We use the "MongoClient" method and the "uri" value to connect to the account 
        client = pymongo.MongoClient(uri)
        
        # connect to the database "HumanResources"
        EmployeeDatabase = client["HumanResources"]
        
        # create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
        EmployeeDatabase.command({'customAction': "CreateCollection", 'collection': "Employee", 'offerThroughput': 1000, 'shardKey': "EmployeeId"})
    
        # Connect to the collection "Employee" and add two documents for "Marcos" and "Tam"
        collection = EmployeeDatabase["Employee"]
        collection.insert_one({ "EmployeeId": 1, "email": "Marcos@fabrikan.com", "name": "Marcos" })
        collection.insert_one({ "EmployeeId": 2, "email": "Tam@fabrikan.com", "name": "Tam" })
        
        # return data where ProductId = 1
        Product_1 = collection.find_one({"EmployeeId": 1})
        
        print(Product_1)
    
        # close the connection
        client.close()

    if __name__ == '__main__':
        main()
    ```

1. Let's go ahead and save the Python program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the Python App with the following command.

    ```bash
    python App.py
    ```  

1. This should return a similar result to the one below. This means that we created the database, collection and added a document to it.

    ```json
    {'_id': ObjectId('62afecc3a04e32b92451ac5d'), 'EmployeeId': 1, 'email': 'Marcos@fabrikan.com', 'name': 'Marcos'}
    ```

1. However this last result set only confirmed that we indeed created a database, collection and documents, but what about our shard key and throughput, did they really change? On the Cloud Shell let's run the following commands to verify our changes took effect.

    1. Let's verify that our Shard key changed to ***EmployeeId*** (the default is *id*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"shardKey": {"EmployeeId": "Hash"}**.

    1. Let's verify that our Throughput changed to ***1000*** (the default is *400*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection throughput show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"throughput": 1000**.

This code illustrated the power of using extended commands in our code, which allows us to define the Azure Cosmos DB creation parameters.  This allows us to take advantage of controlling how our collections will be created and processed by Azure Cosmos DB.

::: zone-end

::: zone pivot="csharp"

## Create MongoDB app using ***C#*** Azure Cosmos DB for MongoDB

In this exercise, you'll create an Azure Cosmos DB for MongoDB account, a database, a collection and add a couple of documents to the collection. You'll notice that this code will be identical to how you would connect to any MongoDB database. You'll then create a collection using extension commands that allow you to define the throughput in Request Units (RUs) for the collection.

### Prepare your development environment

If you haven't already prepared the environment and the Azure Cosmos DB account where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the app.cs file** section.

1. In Azure Cloud Shell, copy and paste the following commands.

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/csharp

    # Add MongoDB driver to DotNet
    dotnet add package MongoDB.Driver --version 2.16.0

    # Create an Azure Cosmos DB for MongoDB account
    bash ../init.sh
    ```

    > [!Tip]
    > If you are not using the sandbox for the lab, and you want to specify the location where you would like to create your database and storage objects, add a ***-l LOCATIONNAME*** parameter to the *init.sh* call. Additionally, if you would like to specify a resource group, add a ***-r YOURRRESOURCEGROUPNAMEHERE*** parameter to the *init.sh* call.

    > [!NOTE] 
    > This bash script will create the Azure Cosmos DB for MongoDB account. *It can take 5-10 minutes to create this account* so it might be a good time to get a cup of coffee or tea.

1. When the bash *init.sh* file completes running, copy somewhere the ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** returned, we'll need them in the next section. You can also review the JSON  returned by the account creation script that is located before the connection string.  If you look somewhere in the middle of the JSON, you should see the property **"kind": "MongoDB"**.

    > [!NOTE] 
    > Note that  the ***Connection String***, ***Cosmos DB Account name*** and ***Resource Group name*** can also be found using the Azure portal.

### Add the code to create the databases, collection and document to the app.cs file

It's now time to add our C# code to create a Database, a Collection and add a document to the collection.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/csharp
    code app.cs
    ```

1. Copy the following code and *replace the existing content* from the app.cs file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This connection string should look like

    mongodb://learn-account-cosmos-92903170:XvrarRd8LnqWNZiq3ahHXngbZoVRxVO192WahrcdsmHVivBGbRqnHx2cq0oMGnc0DUPAWpyGu7kt7APVH4nqXg==@learn-account-cosmos-92903170.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@learn-account-cosmos-92903170@.  

    This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```csharp
    // Uses the MongoDB driver
    using MongoDB.Driver;
    using MongoDB.Bson;
    using System;
    
      public class Products {
        public ObjectId Id { get; set; }  
        public int ProductId { get; set; }
        public string name { get; set; }
      }
    
    class App {
      public static void Main (string[] args) {
      
        // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
        // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        // Or replace it with the connection string if you have it.
        string connectionString = 
          @"mongodb://calopezdp420mongodb01:6CKYlfyagNSQ2ZmP8XEmc2Z6gozF6NkIJ6w1WoYFehZ8Z3842jEhz7xRBl7KeGX2QajQt54Y2g9bJ9MZXU8Z9Q==@calopezdp420mongodb01.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@calopezdp420mongodb01@";
    
        MongoClientSettings settings = MongoClientSettings.FromUrl(new MongoUrl(connectionString));
    
        // define the connection using the MongoClient method ane the connectionString above and open the connection 
        var mongoClient = new MongoClient(settings);
    
    ```

1. The next step connects to the **products** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```csharp
        // connect to the database "products"
        var ProductDatabase = mongoClient.GetDatabase("products");
    
    ```

1. Next, we'll connect to the **documents** collection if it already exists, and then adds one document to the collection. Note that if the collection doesn't exist this code will only create the collection if it also performs an operation on that collection in the same connection (for example, like add a document to the collection) or by using extension commands. Add the following to the script in the editor.

    ```csharp
        // create a collection "products" and add one document for "bread" 
        var mongoCollection = ProductDatabase.GetCollection<Products>("products");

        Products Product = new Products {ProductId=1,name="bread"};
        mongoCollection.InsertOne (Product);

    ```

1. Lets now search for the document we just inserted and display it to the shell. Add the following to the script in the editor.

    ```csharp
        // return data where ProductId = 1
        Products ProductFound =  mongoCollection.Find(_ => _.ProductId == 1).FirstOrDefault();
        Console.WriteLine ("Id: {0}, ProductId: {1}, name: \'{2}\'", ProductFound.Id, ProductFound.ProductId, ProductFound.name);
      }
    }
    ```

1. The script should look like this:

    ```csharp
    // Uses the MongoDB driver
    using MongoDB.Driver;
    using MongoDB.Bson;
    using System;
    
      public class Products {
        public ObjectId Id { get; set; }  
        public int ProductId { get; set; }
        public string name { get; set; }
      }
    
    class App {
      public static void Main (string[] args) {
      
        // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
        // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        // Or replace it with the connection string if you have it.
        string connectionString = 
          @"mongodb://calopezdp420mongodb01:6CKYlfyagNSQ2ZmP8XEmc2Z6gozF6NkIJ6w1WoYFehZ8Z3842jEhz7xRBl7KeGX2QajQt54Y2g9bJ9MZXU8Z9Q==@calopezdp420mongodb01.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@calopezdp420mongodb01@";
    
        MongoClientSettings settings = MongoClientSettings.FromUrl(new MongoUrl(connectionString));
    
        // define the connection using the MongoClient method ane the connectionString above and open the connection 
        var mongoClient = new MongoClient(settings);
    
        // connect to the database "products"
        var ProductDatabase = mongoClient.GetDatabase("products");
    
        // create a collection "products" and add one document for "bread" 
        var mongoCollection = ProductDatabase.GetCollection<Products>("products");

        Products Product = new Products {ProductId=1,name="bread"};
        mongoCollection.InsertOne (Product);

        // return data where ProductId = 1
        Products ProductFound =  mongoCollection.Find(_ => _.ProductId == 1).FirstOrDefault();
        Console.WriteLine ("Id: {0}, ProductId: {1}, name: \'{2}\'", ProductFound.Id, ProductFound.ProductId, ProductFound.name);
      }
    }
    ```

1. Let's go ahead and save the C# program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the C# App with the following command.

    ```bash
    dotnet run
    ```  

1. This should return a similar result to the one below. This means that we created the database, collection and added a document to it.

    ```json
    Id: 62affed8147b5206db146298, ProductId: 1, name: 'bread'
    ```

As you should have noticed, this code is the same code you would run to create a database, collection and document on a MongoDB database. So programming for Azure Cosmos DB for MongoDB should be transparent to you if you're already familiar with creating apps that connect to MongoDB.

### Using extension commands to manage data stored in Azure Cosmos DB’s API for MongoDB

While the code above, except for the connection string, would be identical between connecting to a MongoDB Server then connection to our Azure Cosmos DB for MongoDB account, this might not take advantage of Azure Cosmos DB features. What this means is using the default driver methods to create our collections, will also use the default Azure Cosmos DB Account parameters  to create those collections. So we won't be able to define creation parameters like our throughput, sharding key or autoscaling settings using those methods.

By using the Azure Cosmos DB’s API for MongoDB, you can enjoy the benefits of Cosmos DB such as global distribution, automatic sharding, high availability, latency guarantees, automatic, encryption at rest, backups, and many more, while preserving your investments in your MongoDB app. You can communicate with the Azure Cosmos DB’s API for MongoDB by using any of the open-source MongoDB client drivers. The Azure Cosmos DB’s API for MongoDB enables the use of existing client drivers by adhering to the MongoDB wire protocol.

Let's create some code that will allow us to create a collection and define its sharding key and throughput.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/csharp
    code app.cs
    ```

1. Copy the following code and *replace the existing content* from the app.cs file. *Don't forget that you'll need to replace the uri value for the connection string copied in step 2 of the previous section*. This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server.  The code then defines and opens the connection to the Azure Cosmos DB account.

    ```csharp
    // Uses the MongoDB driver
    using MongoDB.Driver;
    using MongoDB.Bson;
    using System;
    
      public class Employees {
        public ObjectId Id { get; set; }  
        public int EmployeeId { get; set; }
        public string email { get; set; }
        public string name { get; set; }
      }
    
    class App {
      public static void Main (string[] args) {
      
        // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
        // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        // Or replace it with the connection string if you have it.
        string connectionString = 
          @"mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@";
    
        MongoClientSettings settings = MongoClientSettings.FromUrl(new MongoUrl(connectionString));
    
        // We use the "MongoClient" method and the "settings" value to connect to the account 
        var mongoClient = new MongoClient(settings);
    
    ```

1. The next step connects to the **employees** database. Note that if this database doesn't exist it will create it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ```csharp
         // connect to the database "HumanResources"
        var EmployeeDatabase = mongoClient.GetDatabase("HumanResources");
    
    ```

1. So far it looks pretty much like the code in the previous section. In this step, we'll now take advantage of the extension commands and create a custom action.  This action will allow us to define the throughput and the sharding key of the collection, which will in turn give Azure Cosmos DB the parameters to use when creating the collection. Add the following to the script in the editor.

    ```csharp
        // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
        var result = EmployeeDatabase.RunCommand<BsonDocument>(@"{customAction: ""CreateCollection"", collection: ""Employee"", offerThroughput: 1000, shardKey: ""EmployeeId""}");
    
    ```

1. The rest will be pretty identical to the previous example, we will connect to the collection, insert some rows,  finally query and output a row back. Add the following to the script in the editor.

    ```csharp
        // Connect to the collection "Employee" and add two documents for "Marcos" and "Tam" 
        var mongoCollection = EmployeeDatabase.GetCollection<Employees>("Employee");
    
        Employees Employee = new Employees {EmployeeId=1,email="Marcos@fabrikam.com",name="Marcos"};
        mongoCollection.InsertOne (Employee);
    
        Employee = new Employees {EmployeeId=2,email="Tam@fabrikam.com",name="Tam"};
        mongoCollection.InsertOne (Employee);
    
        // return data where EmployeeId = 1
        Employees EmployeeFound =  mongoCollection.Find(_ => _.EmployeeId == 1).FirstOrDefault();
        Console.WriteLine ("Id: {0}, EmployeeId: {1}, email: \'{2}\', name: \'{3}\'", EmployeeFound.Id, EmployeeFound.EmployeeId, EmployeeFound.email, EmployeeFound.name);
      }
    }
    ```

1. The script should look like this:

    ```csharp
    // Uses the MongoDB driver
    using MongoDB.Driver;
    using MongoDB.Bson;
    using System;
    
      public class Employees {
        public ObjectId Id { get; set; }  
        public int EmployeeId { get; set; }
        public string email { get; set; }
        public string name { get; set; }
      }
    
    class App {
      public static void Main (string[] args) {
      
        // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
        // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
        // Or replace it with the connection string if you have it.
        string connectionString = 
          @"mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@";
    
        MongoClientSettings settings = MongoClientSettings.FromUrl(new MongoUrl(connectionString));
    
        // We use the "MongoClient" method and the "settings" value to connect to the account 
        var mongoClient = new MongoClient(settings);
    
        // connect to the database "HumanResources"
        var EmployeeDatabase = mongoClient.GetDatabase("HumanResources");
    
        // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
        var result = EmployeeDatabase.RunCommand<BsonDocument>(@"{customAction: ""CreateCollection"", collection: ""Employee"", offerThroughput: 1000, shardKey: ""EmployeeId""}");
    
        // Connect to the collection "Employee" and add two documents for "Marcos" and "Tam" 
        var mongoCollection = EmployeeDatabase.GetCollection<Employees>("Employee");
    
        Employees Employee = new Employees {EmployeeId=1,email="Marcos@fabrikam.com",name="Marcos"};
        mongoCollection.InsertOne (Employee);
    
        Employee = new Employees {EmployeeId=2,email="Tam@fabrikam.com",name="Tam"};
        mongoCollection.InsertOne (Employee);
    
        // return data where EmployeeId = 1
        Employees EmployeeFound =  mongoCollection.Find(_ => _.EmployeeId == 1).FirstOrDefault();
        Console.WriteLine ("Id: {0}, EmployeeId: {1}, email: \'{2}\', name: \'{3}\'", EmployeeFound.Id, EmployeeFound.EmployeeId, EmployeeFound.email, EmployeeFound.name);
      }
    }
    ```

1. Let's go ahead and save the C# program.  Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the C# App with the following command.

    ```bash
    dotnet run
    ```  

1. This should return a similar result to the one below. This means that we created the database, collection and added a document to it.

    ```json
    Id: 62affed8147b5206db146298, EmployeeId: 1, email: 'Marcos@fabrikam.com', name: 'Marcos'
    ```

1. However this last result set only confirmed that we indeed created a database, collection and documents, but what about our shard key and throughput, did they really change? On the Cloud Shell let's run the following commands to verify our changes took effect.

    1. Let's verify that our Shard key changed to ***EmployeeId*** (the default is *id*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"shardKey": {"EmployeeId": "Hash"}**.

    1. Let's verify that our Throughput changed to ***1000*** (the default is *400*).  *Don't forget to change the ***resource group name*** and ***account name*** for the names we saved at the beginning of this lab.*

        ```bash
        az cosmosdb mongodb collection throughput show --name Employee --database-name HumanResources --resource-group learn-20c8df29-1419-49f3-84bb-6613f052b5ae --account-name learn-account-cosmos-845083734
        ```

        The result should include the property **"throughput": 1000**.

This code illustrated the power of using extended commands in our code, which allows us to define the Azure Cosmos DB creation parameters.  This allows us to take advantage of controlling how our collections will be created and processed by Azure Cosmos DB.

::: zone-end

Once you've completed this exercise, continue to the knowledge check questions for this module.

