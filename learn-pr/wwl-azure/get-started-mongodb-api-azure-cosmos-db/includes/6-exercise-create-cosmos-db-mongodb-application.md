
It's time to programmatically check out how to create our Azure Cosmos DB for MongoDB databases, collections, and add some data.

This exercise can be completed using a Microsoft Learn *sandbox*, which provides a temporary Azure subscription. To activate the sandbox subscription, you must sign in using a Microsoft account. The sandbox subscription is automatically deleted when you complete this module. After the sandbox is activated, [sign into the Azure portal using the credentials for your sandbox subscription](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Ensure you're working in the **Microsoft Learn Sandbox** directory - indicated at the top right of the portal under your user ID. If not, select the user icon and switch directory.

> [!TIP]
> If you prefer, you can use your own Azure subscription. To do so, [sign into the Azure portal using credentials for your subscription](https://portal.azure.com?azure-portal=true). Ensure you are working in the directory containing your subscription - indicated at the top right under your user ID. If not, select the user icon and switch directory.

::: zone pivot="node"

## Create MongoDB app using ***Node.js*** Azure Cosmos DB for MongoDB

::: zone-end

::: zone pivot="java"

## Create MongoDB app using ***Java*** Azure Cosmos DB for MongoDB

::: zone-end

::: zone pivot="python"

## Create MongoDB app using ***Python*** Azure Cosmos DB for MongoDB

::: zone-end

::: zone pivot="csharp"

## Create MongoDB app using ***C#*** Azure Cosmos DB for MongoDB

::: zone-end

In this exercise, you create an Azure Cosmos DB for MongoDB account, a database, a collection and add a couple of documents to the collection. You notice that this code is identical to how you would connect to any MongoDB database. You then create a collection using extension commands that allow you to define the throughput in Request Units/sec (RUs) for the collection.

### Prepare your development environment

::: zone pivot="node"

If you don't have the Azure Cosmos DB account and environment where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the App.js file** section.

::: zone-end

::: zone pivot="java"

If you don't the environment and the Azure Cosmos DB account where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the App.java file** section.

::: zone-end

::: zone pivot="python"

If you don't the Azure Cosmos DB account and environment where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the App.py file** section.

::: zone-end

::: zone pivot="csharp"

If you don't have the environment and the Azure Cosmos DB account where you're working on this lab, follow these steps to do so. Otherwise, go to the **Add the code to create the databases, collection and document to the app.cs file** section.

::: zone-end

1. In Azure Cloud Shell, copy and paste the following commands.

    ::: zone pivot="node"

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

    ::: zone-end

    ::: zone pivot="java"

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

    ::: zone-end

    ::: zone pivot="python"

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/python
    # Install the MongoDB Python drivers
    python -m pip install pymongo
    # Create an Azure Cosmos DB for MongoDB account
    bash ../init.sh
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/csharp
    
    # Add MongoDB driver to DotNet
    dotnet add package MongoDB.Driver --version 2.16.0
    
    # Create an Azure Cosmos DB for MongoDB account
    bash ../init.sh
    ```

    ::: zone-end

    > [!Tip]
    > If you are not using the sandbox for the lab, and you want to specify the location where you would like to create your database and storage objects, add a ***-l LOCATIONNAME*** parameter to the *init.sh* call. Additionally, if you would like to specify a resource group, add a ***-r YOURRRESOURCEGROUPNAMEHERE*** parameter to the *init.sh* call.

    > [!NOTE]
    > This bash script will create the Azure Cosmos DB for MongoDB account. *It can take 5-10 minutes to create this account* so it might be a good time to get a cup of coffee or tea.

    ::: zone pivot="node"

    > [!TIP]
    > If you come back and your cloud shell has reset, run the following commands in the cloud shell to use Node version 14, otherwise the code in the next section will fail.

    > 1. source ~/.nvm/nvm.sh
    > 1. nvm install 14.0.0
    > 1. npm link mongodb

    ::: zone-end

1. When the bash *init.sh* file completes running, copy somewhere the **Connection String**, ***Cosmos DB Account name***, and ***Resource Group name*** returned, we'll need them in the next section. You can also review the JSON  returned by the account creation script that is located before the connection string. If you look somewhere in the middle of the JSON, you should see the property **"kind": "MongoDB"**.

    > [!NOTE]
    > Note that the **Connection String**, ***Cosmos DB Account name*** and ***Resource Group name*** can also be found using the Azure portal.

::: zone pivot="node"

### Add the code to create the databases, collection, and document to the App.js file

It's now time to add our JavaScript code to create a Database, a Collection and add a document to the collection.

::: zone-end

::: zone pivot="java"

### Add the code to create the databases, collection, and document to the App.java file

It's now time to add our Java code to create a Database, a Collection and add a document to the collection.

::: zone-end

::: zone pivot="python"

### Add the code to create the databases, collection, and document to the App.py file

It's now time to add our Python code to create a Database, a Collection and add a document to the collection.

::: zone-end

::: zone pivot="csharp"

### Add the code to create the databases, collection, and document to the app.cs file

It's now time to add our C# code to create a Database, a Collection and add a document to the collection.

::: zone-end

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ::: zone pivot="node"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/node/
    code App.js
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/java/AzureApp
    code ./src/main/java/com/fabrikam/App.java
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/python
    code App.py
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/csharp
    code app.cs
    ```

    ::: zone-end

1. Copy the following code to the App file. *Don't forget that you need to replace the uri value for the connection string copied in the previous section*.

    This part of the code uses the MongoDB drivers and uses the connection string to Azure Cosmos DB like you would normally use a connection string to any MongoDB server. The code then defines and opens the connection to the Azure Cosmos DB account.

    ::: zone pivot="node"

    ```javascript
    // Uses the MongoDB driver
    const {MongoClient} = require("mongodb");
        
    async function main() {
        
        // One of the values you copied earlier was the connection string, replace it in the following line 
        var url = "TheConnectionStringYouCopiedEarlier";
        
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

    ::: zone-end

    ::: zone pivot="java"

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
    
            // One of the values you copied earlier was the connection string, replace it in the following line 
            MongoClientURI uri = new MongoClientURI("TheConnectionStringYouCopiedEarlier");
        
            MongoClient mongoClient = null;
            try {
                // define the connection using the MongoClient method ane the url above and open the connection 
                mongoClient = new MongoClient(uri);
        
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```python
    # Use the MongoDB drivers
    import pymongo
        
        
    def main():
        # One of the values you copied earlier was the connection string, replace it in the following line 
        uri = "TheConnectionStringYouCopiedEarlier"
            
        # We use the "MongoClient" method and the "uri" value to connect to the account 
        client = pymongo.MongoClient(uri)
            
        ```

    ::: zone-end

    ::: zone pivot="csharp"

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
          
        // One of the values you copied earlier was the connection string, replace it in the following line 
        string connectionString = 
            @"TheConnectionStringYouCopiedEarlier";
        
        MongoClientSettings settings = MongoClientSettings.FromUrl(new MongoUrl(connectionString));
        
        // define the connection using the MongoClient method ane the connectionString above and open the connection 
        var mongoClient = new MongoClient(settings);
        
    ```

    ::: zone-end

1. The next step connects to the **products** database. If this database doesn't exist, it creates it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ::: zone pivot="node"

    ```javascript
    // connect to the database "products"
    var ProductDatabase = mongoClient.db("products");
    ```
    ::: zone-end

    ::: zone pivot="java"

    ```java
        // connect to the database "products"
        MongoDatabase ProductDatabase = mongoClient.getDatabase("products");
        
    ::: zone-end

    ::: zone pivot="python"

    ```python
        # connect to the database "products"
        ProductDatabase = client["products"]
            
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
        // connect to the database "products"
        var ProductDatabase = mongoClient.GetDatabase("products");
        
    ```

    ::: zone-end

1. Next, we connect to the **documents** collection if it already exists, and then adds one document to the collection. If the collection doesn't exist this code creates the collection if it also performs an operation on that collection in the same connection (for example, like add a document to the collection) or by using extension commands. Add the following to the script in the editor.

    ::: zone pivot="node"

    ```javascript

      // create a collection "documents" and add one document for "bread"
      var collection = ProductDatabase.collection('documents');
      var insertResult = await collection.insertOne({ ProductId: 1, name: "bread" });
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```java
                // create a collection "documents" and add one document for "bread" 
                MongoCollection collection = ProductDatabase.getCollection("products");
    
                collection.insertOne(new Document()
                            .append("ProductId", 1)
                            .append("name", "bread"));
    
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```python
        # create a collection "products" and add one document for "bread"
        collection = ProductDatabase["products"]
        collection.insert_one({ "ProductId": 1, "name": "bread" })
        
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
        // create a collection "products" and add one document for "bread" 
        var mongoCollection = ProductDatabase.GetCollection<Products>("products");

        Products Product = new Products {ProductId=1,name="bread"};
        mongoCollection.InsertOne (Product);

    ```

    ::: zone-end

1. Lets now search for the inserted document and display it to the shell. Add the following to the script in the editor.

    ::: zone pivot="node"

    ```javascript
      // return data where ProductId = 1
      const findProduct = await collection.find({ProductId: 1});
      await findProduct.forEach(console.log);
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```java
                // return data where ProductId = 1
                Document findProduct = (Document) collection.find(eq("ProductId", 1)).first();
                System.out.println(findProduct.toJson());
            }
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```python
        # return data where ProductId = 1
        Product_1 = collection.find_one({"ProductId": 1})
    
        print(Product_1)
    
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
        // return data where ProductId = 1
        Products ProductFound =  mongoCollection.Find(_ => _.ProductId == 1).FirstOrDefault();
        Console.WriteLine ("Id: {0}, ProductId: {1}, name: \'{2}\'", ProductFound.Id, ProductFound.ProductId, ProductFound.name);
      }
    }
    ```

    ::: zone-end

1. Finally let's close the connection. Add the following to the script in the editor.

    ::: zone pivot="node"

    ```javascript
      // close the connection
      mongoClient.close();
    }

    main();
    ```
    ::: zone-end

    ::: zone pivot="java"

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

    ::: zone-end

    ::: zone pivot="python"

    ```python
        # close the connection
        client.close()

    if __name__ == '__main__':
        main()
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
    // Note C# doesn't need to close the connection, it disposes of the connection when the program ends.
    ```

    ::: zone-end

1. The script should look like this:

    ::: zone pivot="node"

    ```JavaScript
    // Uses the MongoDB driver
    const {MongoClient} = require("mongodb");
    
    async function main() {
    
      // One of the values you copied earlier was the connection string, replace it in the following line
      var url = "TheConnectionStringYouCopiedEarlier";
    
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

    ::: zone-end

    ::: zone pivot="java"

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

            // One of the values you copied earlier was the connection string, replace it in the following line
            MongoClientURI uri = new MongoClientURI("TheConnectionStringYouCopiedEarlier");
    
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

    ::: zone-end

    ::: zone pivot="python"

    ```python
    # Use the MongoDB drivers
    import pymongo
    
    def main():
        # One of the values you copied earlier was the connection string, replace it in the following line
        uri = "TheConnectionStringYouCopiedEarlier"
        
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

    ::: zone-end

    ::: zone pivot="csharp"

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
      
        // One of the values you copied earlier was the connection string, replace it in the following line
        string connectionString = 
          @"TheConnectionStringYouCopiedEarlier";
    
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

    ::: zone-end

1. Let's go ahead and save the program. Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the App with the following command.

    ::: zone pivot="node"

    ```bash
    node App.js
    ```  

    ::: zone-end

    ::: zone pivot="java"

    ```bash
    mvn clean compile exec:java
    ```  

    ::: zone-end

    ::: zone pivot="python"

    ```bash
    python App.py
    ```  

    ::: zone-end

    ::: zone pivot="csharp"

    ```bash
    dotnet run
    ```  

    ::: zone-end

1. This script should return a similar result to the following one. This means that we created the database, collection, and added a document to it.

    ::: zone pivot="node"

    ```json
    {
      _id: new ObjectId("62aed08663c0fd62d30240db"),
      ProductId: 1,
      name: 'bread'
    }
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```json
    INFO: Opened connection [connectionId{localValue:3, serverValue:74678510}] to learn-account-cosmos-665601-westus.mongo.cosmos.azure.com:10255
    { "_id" : { "$oid" : "62afa8c3dff473012e7b7910" }, "ProductId" : 1, "name" : "bread" }
    Jun 19, 2022 10:52:59 PM com.mongodb.diagnostics.logging.JULLogger log
    INFO: Closed connection [connectionId{localValue:3, serverValue:74678510}] to learn-account-cosmos-665601-westus.mongo.cosmos.azure.com:10255 because the pool has been closed.
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```json
    {'_id': ObjectId('62afecc3a04e32b92451ac5d'), 'ProductId': 1, 'name': 'bread'}
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```json
    Id: 62affed8147b5206db146298, ProductId: 1, name: 'bread'
    ```

    ::: zone-end

As you can notice, this code is the same code you would run to create a database, collection, and document on a MongoDB database. So programming for Azure Cosmos DB for MongoDB should be transparent to you if you're already familiar with creating apps that connect to MongoDB.

### Managed identities

For production workloads, we recommend using managed identities to authenticate to Azure Cosmos DB. This way, you don't have to store the connection string in your code. For this next section, we'll use managed identities to authenticate to Azure Cosmos DB.

On a production environment, you should use a managed identity with the least privilege necessary. You might create one or more user-assigned managed identities and assign them to the Azure Cosmos DB account. For this lab, let's create a system-assigned managed identity for the Azure Cosmos DB account. 

1. In the Azure portal, navigate to the Azure Cosmos DB account you created earlier.
1. In the left-hand menu, under **Settings**, select **Identity**.
1. In the **Identity** pane, select **System assigned**.
1. Select **On** for the **Status**.
1. Select **Save**.
1. It takes a minute or two for the managed identity to be created.

Once the managed identity is created, we need to assign the managed identity the necessary permissions to the Azure Cosmos DB account. Time to use RBAC (Role-Based Access Control) to assign the managed identity the necessary permissions. For this lab, we assign the **Contributor** role to the managed identity to allow it to read and write data to the Azure Cosmos DB account. In a production environment, you should assign the least privilege role necessary.

1. In the Azure portal, navigate to the Azure Cosmos DB account you created earlier.
1. In the left-hand menu, under **Settings**, select **Access control (IAM)**.
1. Select **+ Add** and then **Add role assignment**.
1. Under the **Privileged administrator role**, select **Contributor**, select **Next**.
1. Under **Members** select **Managed Identity**, and then **+ Select members**.
1. In the **Select managed identities** pane, search for the managed identity you created earlier, select it, and then select **Review + assign**.

You now have a managed identity assigned to the Azure Cosmos DB account with the necessary permissions. Let's now use the managed identity to authenticate to the Azure Cosmos DB account.

### Using extension commands to manage data stored in Azure Cosmos DB’s API for MongoDB

While the previous code, would be identical between connecting to a MongoDB Server then connection to our Azure Cosmos DB for MongoDB account, the connection might not take advantage of Azure Cosmos DB features. What this means is using the default driver methods to create our collections, also uses the default Azure Cosmos DB Account parameters  to create those collections. So we aren't able to define creation parameters like our throughput, sharding key, or autoscaling settings using those methods.

By using the Azure Cosmos DB’s API for MongoDB, you can enjoy the benefits of Cosmos DB. These benefits include global distribution, automatic sharding, high availability, latency guarantees, automatic, encryption at rest, backups, and many more. Plus the added benefit of preserving your investments in your MongoDB app. You can communicate with the Azure Cosmos DB’s API for MongoDB by using any of the open-source MongoDB client drivers. The Azure Cosmos DB’s API for MongoDB enables the use of existing client drivers by adhering to the MongoDB wire protocol.

Let's create some code that allows us to create a collection and define its sharding key and throughput.

1. In not already opened, open the Azure Cloud Shell.

1. Run the following command to open the code editor.

    ::: zone pivot="node"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/node
    code App.js
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/java/AzureApp
    code ./src/main/java/com/fabrikam/App.java
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/python
    code App.py
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```bash
    cd ~/mslearn-cosmosdb/api-for-mongodb/01-create-mongodb-objects/csharp
    code app.cs
    ```

    ::: zone-end

1. Copy the following code to the file.

    ::: zone pivot="node"

    ```javascript
    import { DefaultAzureCredential, ClientSecretCredential } from "@azure/identity";
    const { MongoClient, ObjectId } = require('mongodb');
    import axios from "axios";
    
    async function main() {
        // Environment variables
        const endpoint = process.env.AZURE_COSMOS_RESOURCEENDPOINT;
        const listConnectionStringUrl = process.env.AZURE_COSMOS_LISTCONNECTIONSTRINGURL;
        const scope = process.env.AZURE_COSMOS_SCOPE;
    
        // For system-assigned managed identity.
        const credential = new DefaultAzureCredential();
    
        // Acquire the access token
        const accessToken = await credential.getToken(scope);
    
        // Get the connection string
        const config = {
            method: 'post',
            url: listConnectionStringUrl,
            headers: {
                'Authorization': 'Bearer ${accessToken.token}'
            }
        };
        const response = await axios(config);
        const keysDict = response.data;
        const connectionString = keysDict['connectionStrings'][0]['connectionString'];
    
        // Connect to Azure Cosmos DB for MongoDB
        const mongoClient = new MongoClient(connectionString);
    
        // open the connection
        await mongoClient.connect();
        
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```java
    package com.fabrikam;
    
    import com.mongodb.MongoClient;
    import com.mongodb.MongoClientURI;
    import com.mongodb.client.MongoCollection;
    import com.mongodb.client.MongoDatabase;
    import com.mongodb.client.model.Filters;
    import javax.net.ssl.*;
    import java.net.InetSocketAddress;
    import com.azure.identity.*;
    import com.azure.core.credential.*;
    import java.net.http.*;
    import java.net.URI;
    
    public class App {
        public static void main(String[] args) {
            // Environment variables
            String endpoint = System.getenv("AZURE_COSMOS_RESOURCEENDPOINT");
            String listConnectionStringUrl = System.getenv("AZURE_COSMOS_LISTCONNECTIONSTRINGURL");
            String scope = System.getenv("AZURE_COSMOS_SCOPE");
    
            // For system-assigned managed identity.
            DefaultAzureCredential defaultCredential = new DefaultAzureCredentialBuilder().build();
    
    
        MongoClient mongoClient = null;

        try {
            // Acquire the access token
            AccessToken accessToken = defaultCredential
                .getToken(new TokenRequestContext().addScopes(scope))
                .block();
            String token = accessToken.getToken();

            // Retrieve the connection string
            HttpClient client = HttpClient.newBuilder().build();
            HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI(listConnectionStringUrl))
                .header("Authorization", "Bearer " + token)
                .POST(HttpRequest.BodyPublishers.noBody())
                .build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            JSONParser parser = new JSONParser();
            JSONObject responseBody = parser.parse(response.body());
            List<Map<String, String>> connectionStrings = responseBody.get("connectionStrings");
            String connectionString = connectionStrings.get(0).get("connectionString");

            // Connect to Azure Cosmos DB for MongoDB
            MongoClientURI uri = new MongoClientURI(connectionString);
            mongoClient = new MongoClient(uri);
    
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```python
    import os
    import pymongo
    import requests
    from azure.identity import ManagedIdentityCredential, ClientSecretCredential
    
    def main():
        # Environment variables
        endpoint = os.getenv('AZURE_COSMOS_RESOURCEENDPOINT')
        listConnectionStringUrl = os.getenv('AZURE_COSMOS_LISTCONNECTIONSTRINGURL')
        scope = os.getenv('AZURE_COSMOS_SCOPE')
        
        # For system-assigned managed identity
        cred = ManagedIdentityCredential()
        
        # Get the connection string
        session = requests.Session()
        token = cred.get_token(scope)
        response = session.post(listConnectionStringUrl, headers={"Authorization": "Bearer {}".format(token.token)})
        keys_dict = response.json()
        conn_str = keys_dict["connectionStrings"][0]["connectionString"]
    
        # Connect to Azure Cosmos DB for MongoDB
        client = pymongo.MongoClient(conn_str)
        
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
    using MongoDB.Driver;
    using Azure.Identity;
    using Azure.Core;
    using System;
    using System.Net.Http;
    using System.Text.Json;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    
    public class Products
    {
        public int ProductId { get; set; }
        public string name { get; set; }
    }
    
    class App
    {
        public static async Task Main(string[] args)
        {
            // Environment variables
            var endpoint = Environment.GetEnvironmentVariable("AZURE_COSMOS_RESOURCEENDPOINT");
            var listConnectionStringUrl = Environment.GetEnvironmentVariable("AZURE_COSMOS_LISTCONNECTIONSTRINGURL");
            var scope = Environment.GetEnvironmentVariable("AZURE_COSMOS_SCOPE");
    
            // For system-assigned identity.
            var tokenProvider = new DefaultAzureCredential();
    
            // Acquire the access token.
            AccessToken accessToken = await tokenProvider.GetTokenAsync(
                new TokenRequestContext(scopes: new[] { scope }));
    
            // Get the connection string.
            using var httpClient = new HttpClient();
            httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {accessToken.Token}");
            var response = await httpClient.PostAsync(listConnectionStringUrl, null);
            response.EnsureSuccessStatusCode();
            var responseBody = await response.Content.ReadAsStringAsync();
    
            // Parse the connection string.
            var connectionStrings = JsonSerializer.Deserialize<Dictionary<string, List<Dictionary<string, string>>>>(responseBody);
            string connectionString = connectionStrings["connectionStrings"][0]["connectionString"];
    
            // Initialize the MongoClient with the connection string.
            var mongoClient = new MongoClient(connectionString);
    
    ```

    ::: zone-end

1. The next step connects to the **employees** database. If this database doesn't exist, it creates it only if also creates a collection in the same connection or by using extension commands. Add the following to the script in the editor.

    ::: zone pivot="node"

    ```javascript
      // connect to the database "HumanResources"
      var EmployeeDatabase = mongoClient.db("HumanResources");
    
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```java
                // connect to the database "HumanResources"
                MongoDatabase EmployeeDatabase = mongoClient.getDatabase("HumanResources");
    
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```python
        # connect to the database "HumanResources"
        EmployeeDatabase = client["HumanResources"]
        
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
         // connect to the database "HumanResources"
        var EmployeeDatabase = mongoClient.GetDatabase("HumanResources");
    
    ```

    ::: zone-end

1. So far it looks much like the code in the previous section. In this step, we take advantage of the extension commands and create a custom action. This action allows us to define the throughput and the sharding key of the collection. In turn the step gives Azure Cosmos DB the parameters to use when creating the collection. Add the following to the script in the editor.

    ::: zone pivot="node"

    ```javascript
      // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
      var result = EmployeeDatabase.command({customAction: "CreateCollection", collection: "Employee", offerThroughput: 1000, shardKey: "EmployeeId"});
    
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```java
                // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
                Document employeeCollectionDef = new Document();
                employeeCollectionDef.append("customAction", "CreateCollection");
                employeeCollectionDef.append("collection", "Employee");
                employeeCollectionDef.append("offerThroughput", 1000);
                employeeCollectionDef.append("shardKey", "EmployeeId");

                Document result = EmployeeDatabase.runCommand(employeeCollectionDef);
        
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```python
        # create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
        EmployeeDatabase.command({'customAction': "CreateCollection", 'collection': "Employee", 'offerThroughput': 1000, 'shardKey': "EmployeeId"})
    
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
        // create the Employee collection with a throughput of 1000 RUs and with EmployeeId as the sharding key
        var result = EmployeeDatabase.RunCommand<BsonDocument>(@"{customAction: ""CreateCollection"", collection: ""Employee"", offerThroughput: 1000, shardKey: ""EmployeeId""}");
    
    ```

    ::: zone-end

1. The rest is identical to the previous example. We connect to the collection, insert some rows,  finally query and output a row back. Add the following to the script in the editor.

    ::: zone pivot="node"

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

    ::: zone-end

    ::: zone pivot="java"

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

    ::: zone-end

    ::: zone pivot="python"

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

    ::: zone-end

    ::: zone pivot="csharp"

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

    ::: zone-end

1. The script should look like this:

    ::: zone pivot="node"

    ```javascript
    import { DefaultAzureCredential, ClientSecretCredential } from "@azure/identity";
    const { MongoClient, ObjectId } = require('mongodb');
    import axios from "axios";
    
    async function main() {
        // Environment variables
        const endpoint = process.env.AZURE_COSMOS_RESOURCEENDPOINT;
        const listConnectionStringUrl = process.env.AZURE_COSMOS_LISTCONNECTIONSTRINGURL;
        const scope = process.env.AZURE_COSMOS_SCOPE;
    
        // For system-assigned managed identity.
        const credential = new DefaultAzureCredential();
    
        // Acquire the access token
        const accessToken = await credential.getToken(scope);
    
        // Get the connection string
        const config = {
            method: 'post',
            url: listConnectionStringUrl,
            headers: {
                'Authorization': 'Bearer ${accessToken.token}'
            }
        };
        const response = await axios(config);
        const keysDict = response.data;
        const connectionString = keysDict['connectionStrings'][0]['connectionString'];
    
        // Connect to Azure Cosmos DB for MongoDB
        const mongoClient = new MongoClient(connectionString);
    
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

    ::: zone-end

    ::: zone pivot="java"

    ```java
    package com.fabrikam;
    
    import com.mongodb.MongoClient;
    import com.mongodb.MongoClientURI;
    import com.mongodb.client.MongoCollection;
    import com.mongodb.client.MongoDatabase;
    import com.mongodb.client.model.Filters;
    import javax.net.ssl.*;
    import java.net.InetSocketAddress;
    import com.azure.identity.*;
    import com.azure.core.credential.*;
    import java.net.http.*;
    import java.net.URI;
    
    public class App {
        public static void main(String[] args) {
            // Environment variables
            String endpoint = System.getenv("AZURE_COSMOS_RESOURCEENDPOINT");
            String listConnectionStringUrl = System.getenv("AZURE_COSMOS_LISTCONNECTIONSTRINGURL");
            String scope = System.getenv("AZURE_COSMOS_SCOPE");
    
            // For system-assigned managed identity.
            DefaultAzureCredential defaultCredential = new DefaultAzureCredentialBuilder().build();
    
    
            MongoClient mongoClient = null;
    
            try {
                // Acquire the access token
                AccessToken accessToken = defaultCredential
                    .getToken(new TokenRequestContext().addScopes(scope))
                    .block();
                String token = accessToken.getToken();
    
                // Retrieve the connection string
                HttpClient client = HttpClient.newBuilder().build();
                HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(listConnectionStringUrl))
                    .header("Authorization", "Bearer " + token)
                    .POST(HttpRequest.BodyPublishers.noBody())
                    .build();
                HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
    
                JSONParser parser = new JSONParser();
                JSONObject responseBody = parser.parse(response.body());
                List<Map<String, String>> connectionStrings = responseBody.get("connectionStrings");
                String connectionString = connectionStrings.get(0).get("connectionString");
    
                // Connect to Azure Cosmos DB for MongoDB
                MongoClientURI uri = new MongoClientURI(connectionString);
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

    ::: zone-end

    ::: zone pivot="python"

    ```python
    import os
    import pymongo
    import requests
    from azure.identity import ManagedIdentityCredential, ClientSecretCredential
    
    def main():
        # Environment variables
        endpoint = os.getenv('AZURE_COSMOS_RESOURCEENDPOINT')
        listConnectionStringUrl = os.getenv('AZURE_COSMOS_LISTCONNECTIONSTRINGURL')
        scope = os.getenv('AZURE_COSMOS_SCOPE')
        
        # For system-assigned managed identity
        cred = ManagedIdentityCredential()
        
        # Get the connection string
        session = requests.Session()
        token = cred.get_token(scope)
        response = session.post(listConnectionStringUrl, headers={"Authorization": "Bearer {}".format(token.token)})
        keys_dict = response.json()
        conn_str = keys_dict["connectionStrings"][0]["connectionString"]
    
        # Connect to Azure Cosmos DB for MongoDB
        client = pymongo.MongoClient(conn_str)
        
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

    ::: zone-end

    ::: zone pivot="csharp"

    ```csharp
    using MongoDB.Driver;
    using Azure.Identity;
    using Azure.Core;
    using System;
    using System.Net.Http;
    using System.Text.Json;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    
    public class Products
    {
        public int ProductId { get; set; }
        public string name { get; set; }
    }
    
    class App
    {
        public static async Task Main(string[] args)
        {
            // Environment variables
            var endpoint = Environment.GetEnvironmentVariable("AZURE_COSMOS_RESOURCEENDPOINT");
            var listConnectionStringUrl = Environment.GetEnvironmentVariable("AZURE_COSMOS_LISTCONNECTIONSTRINGURL");
            var scope = Environment.GetEnvironmentVariable("AZURE_COSMOS_SCOPE");
    
            // For system-assigned identity.
            var tokenProvider = new DefaultAzureCredential();
    
            // Acquire the access token.
            AccessToken accessToken = await tokenProvider.GetTokenAsync(
                new TokenRequestContext(scopes: new[] { scope }));
    
            // Get the connection string.
            using var httpClient = new HttpClient();
            httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {accessToken.Token}");
            var response = await httpClient.PostAsync(listConnectionStringUrl, null);
            response.EnsureSuccessStatusCode();
            var responseBody = await response.Content.ReadAsStringAsync();
    
            // Parse the connection string.
            var connectionStrings = JsonSerializer.Deserialize<Dictionary<string, List<Dictionary<string, string>>>>(responseBody);
            string connectionString = connectionStrings["connectionStrings"][0]["connectionString"];
    
            // Initialize the MongoClient with the connection string.
            var mongoClient = new MongoClient(connectionString);
    
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

    ::: zone-end

1. Let's go ahead and save the program. Select on the Upper right hand corner of the code editor and select **Save** (or Ctrl+S). Now select **Close Editor** (or Ctrl+Q) to go back to the Shell.

1. Let's now run the App with the following command.

    ::: zone pivot="node"

    ```bash
    node App.js
    ```  

    ::: zone-end

    ::: zone pivot="java"

    ```bash
    mvn clean compile exec:java
    ```  

    ::: zone-end

    ::: zone pivot="python"

    ```bash
    python App.py
    ```  

    ::: zone-end

    ::: zone pivot="csharp"

    ```bash
    dotnet run
    ```  

    ::: zone-end

1. This should return a similar result to the one below. This means that we created the database, collection and added a document to it.

    ::: zone pivot="node"

    ```json
    {
      _id: new ObjectId("62aed08663c0fd62d30240db"),
      EmployeeId: 1,
      email: 'Marcos@fabrikam.com'
      name: 'Marcos'
    }
    ```

    ::: zone-end

    ::: zone pivot="java"

    ```json
    INFO: Opened connection [connectionId{localValue:3, serverValue:2080122971}] to learn-account-cosmos-845083734-westus.mongo.cosmos.azure.com:10255
    { "_id" : { "$oid" : "62afd8e2c471f3011bd415fe" }, "EmployeeId" : 1, "email" : "Marcos@fabrikam.com", "name" : "Marcos" }
    Jun 20, 2022 2:18:11 AM com.mongodb.diagnostics.logging.JULLogger log
    INFO: Closed connection [connectionId{localValue:3, serverValue:2080122971}] to learn-account-cosmos-845083734-westus.mongo.cosmos.azure.com:10255 because the pool has been closed.
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```json
    {'_id': ObjectId('62afecc3a04e32b92451ac5d'), 'EmployeeId': 1, 'email': 'Marcos@fabrikan.com', 'name': 'Marcos'}
    ```

    ::: zone-end

    ::: zone pivot="csharp"

    ```json
    Id: 62affed8147b5206db146298, EmployeeId: 1, email: 'Marcos@fabrikam.com', name: 'Marcos'
    ```

    ::: zone-end

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

Once you've completed this exercise, continue to the knowledge check questions for this module.
