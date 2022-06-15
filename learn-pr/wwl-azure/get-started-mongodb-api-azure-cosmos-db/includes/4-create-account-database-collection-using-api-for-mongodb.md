Azure Cosmos DB is a fully managed platform-as-a-service (PaaS). To use this service, we'll need to first create an Azure Cosmos DB account under our subscription. Once our account has been created, we can then add database, containers and items under it.  For Azure Cosmos DB API for MongoDB accounts, a container is realized as a Collection and an item is realized as a Document.

[![Diagram showing the Azure Cosmos DB Resource Model](../media/4-database-containers-items.png)](../media/4-database-containers-items.png#lightbox)

We'll take a look at a couple of ways to create the different Azure Cosmos DB API for MongoDB model elements.

## Create an account, database and container for the Azure Cosmos DB API for MongoDB using the Azure portal

One way of creating our Azure Cosmos DB account and its elements, is using the Azure portal.  In this example, we'll use the Azure portal to create a simple Azure Cosmos DB account using the Azure Cosmos DB API for MongoDB.  We'll then add a database and a container. For the moment, we won't worry about filling out more advanced settings that we'll cover in more detail in later modules. For this example, we'll just visit the Basics tab.  Let's create our account and its elements.

### Create an account for the Azure Cosmos DB API for MongoDB

1. In the Azure portal, Select **+ Create a Resource**, select **Azure Cosmos DB** and **Create**.

1. Select **Azure Cosmos DB API for MongoDB**.

1. Input the following parameters.

    - **Subscription** - Your current Azure subscription.
    - **Resource Group** - A new or existing Azure Resource Group to create the Azure Cosmos DB account on.
    - **Account Name** - A unique name for your Azure Cosmos DB account. This name must be unique across the Azure. Your account URI will be *mongo.cosmos.azure.com* appended to your account name.
    - **Location** - The geographical location that will host your Azure Cosmos DB account. You should typically select a location close to your users or applications.
    - **Capacity mode** - As we discussed in a previous unit, you can select for your account to use *Provisioned throughput* or *Serverless*. Select **Provisioned throughput** for this example.
    - **Apply Free Tier Discount** - Select *Don't Apply* for this example.
    - **Limit total account throughput** - Leave *unchecked* for this example.
    - **Version** - Select *4.0*.

        [!NOTE] To take better advantage of the supported features, we recommend that you use versions 3.6+ whenever possible.

1. Select **Review + Create**, and on a successful validation, select **Create**.

[!NOTE] It can take several minutes to create your Azure Cosmos DB account.

[![Diagram showing the Create Azure Cosmos DB Account - Azure Cosmos DB API for MongoDB creation page](../media/4-create-azure-cosmos-db-account-mongodb.png)](../media/4-create-azure-cosmos-db-account-mongodb.png#lightbox)

### Create a database and container for the Azure Cosmos DB API for MongoDB

Creating a database and container in the Azure portal is straight forward, let's first create a database.

1. On the *Azure Cosmos DB API for MongoDB account* left-hand menu, select **Data Explorer**.

1. Select the pulldown to the right of the *New Collection* icon and select **New Database**. 

[![Diagram showing the create an Azure Cosmos DB API for MongoDB database or collection](../media/4-create-azure-cosmos-db-database-or-collection-mongodb.png)](../media/4-create-azure-cosmos-db-database-or-collection-mongodb.png#lightbox)

1. Give your database a new name under the **Database id** textbox.

1. While we could define the **Provision throughput** in the *New Database* dialog, in most cases you would select your provisioned throughput at the container level.  Let's *uncheck* the *Provision throughput* checkbox and select **Ok** for this example.

[![Diagram showing the create an Azure Cosmos DB API for MongoDB database](../media/4-create-azure-cosmos-db-database-mongodb.png)](../media/4-create-azure-cosmos-db-database-mongodb.png#lightbox)

We should now notice our new database under the *MONGO API* section. It's time to create our new collection.

1. Select the **New Collection** icon. 

1. Input the following parameters under the *New Collection* dialog.

    - **Database name** - You'll notice that you have two options here, *Create new* or *Use existing*. This option allows you to create a new database at the time you're creating the new collection. Since we already created a new database in our previous steps, select *Use existing* and pick the database name from the pulldown options.
    - **Collection id** - This parameter will be the name you'll give your collection.
    - **Sharding** - We usually would want to select **Sharded**. This option allows Azure Cosmos DB to create containers that are sharded across multiple tenants based on the *Shard key*. With large containers, Azure Cosmos DB spreads your tenants across multiple physical nodes to achieve a high degree of scale. We'll discuss sharding in more detail under the *Design* module. Select ***Sharded***.
        - **Shard key** - Selecting *Sharded* will require you to add a *Shard key*. This is the partition key that defines your partitioning strategy, for example in and IOT collection it could be */deviceid* or maybe */region* depending on the partitioning strategy you choose. We'll discuss partitioning strategy in more detail under the *Design* module.
        - **Provision dedicated throughput for this collection** checkbox - Usually you'll want to provision the throughput of your collection either as *Autoscale* or *Manual*.  This setting allows you to have better control of the cost of your individual collection. We'll discuss throughput in more detail in the *Design* module. For now, check the checkbox and select **Autoscale**.
        - **Collection throughput** or **Collection Max RU/s** - Depending if you selected *Manual* or *Autoscale* you'll need to input the *Collection throughput* or *Collection Max RU/s* respectively, or in other words the throughput mode. The main difference is that in *Manual* mode will charge you the amount the RU/s chosen regardless if you use them or not, and *Autoscale* will only charge what you use up to the Max RU/s you selected. In either case, your collection will start throttling once its throughput reaches the selected value. Leave the predefined value for this example.
        - **Analytical Store** - The Azure Cosmos DB analytical store is beyond the scope of these lessons. Review the [What is Azure Cosmos DB analytical store][/azure/cosmos-db/analytical-store-introduction] article for more information on that topic. 
        - **Advanced/Indexing** - We'll discuss indexes in more detail under the *Design* module. Leave the checkbox checked.
             

[![Diagram showing the create an Azure Cosmos DB API for MongoDB collection](../media/4-create-azure-cosmos-db-collection-mongodb.png)](../media/4-create-azure-cosmos-db-collection-mongodb.png#lightbox)

We should now have a database and one collection to connect to.  In the next unit, we'll go into more detail on connecting to an Azure Cosmos DB API for MongoDB account.  Before that, let's review another way of creating our Azure Cosmos DB API for MongoDB databases and collections. 

## Create or connect to a database and collection for the Azure Cosmos DB API for MongoDB using the SDKs

You should be able to create or connect to your databases using the Java, Python, Node.js, .NET and other programming language Azure Cosmos DB SDKs. Let's introduce some functions you would use to create these elements using in some of the different language SDKs.  At the beginning of this module, we stated that *the developers can keep on using MongoDB drivers, SDKs and tools they're familiar with to create apps and connect to Azure Cosmos DB.* We'll leverage on those drivers and their properties and methods to program our access and operations against our Azure Cosmos DB API for MongoDB accounts. So the developers will continue using the same code to access the Azure Cosmos DB API for MongoDB accounts that they've used in the past.

### Create or connect to a database for the Azure Cosmos DB API for MongoDB using the SDKs

You can use your favorite development tool to create your Azure Cosmos DB API for MongoDB application. We'll leverage on the MongoDB driver for each respective programming language to create our databases and collections.  Let's review the code to connect to the Azure Cosmos DB API for Cosmos DB accounts and to connect to the *products* database.

::: zone pivot = "JavaScript"
  ***Node.js***

  ```JavaScript
  const {MongoClient} = require("mongodb");

  async function main() {

    // We will discuss connection string in more detail in the next unit of this module.
    // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
    // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
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

    // Add code to connect to a collection and add an entry here 

    // close the connection
    mongoClient.close();
  }

  main();
  ```
::: zone-end

::: zone pivot = "Java"
  ***Java***

  ```Java
  import org.bson.Document;
  import com.mongodb.MongoClient;
  import com.mongodb.MongoClientURI;
  import com.mongodb.client.MongoDatabase;
  import com.mongodb.client.MongoCollection;

  public class Program {
    public static void main(String[] args) {

      // We will discuss connection string in more detail in the next unit of this module
      // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
      // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
      MongoClientURI uri = new MongoClientURI("mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@");

      MongoClient mongoClient = null;
      try {
            // We use the "MongoClient" method and the "uri" value to connect to the account 
            mongoClient = new MongoClient(uri);

            // Connecting to your database is as simple as calling the GetDatabase method
            MongoDatabase ProductDatabase = mongoClient.getDatabase("products");

            // Add code to connect to a collection and add an entry here 
      }
      finally {
        if (mongoClient != null) {
          mongoClient.close();
        }
      }
    }
  }
  ```
::: zone-end

::: zone pivot = "Python"
  ***Python***

  ```Python
  import pymongo

  # We will discuss connection string in more detail in the next unit of this module
  #  Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
  #  account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
  uri = "mongodb://YourAzureCosmosDBAccount:YourAzureCosmosDBAccountKEY@YourAzureCosmosDBAccount.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@YourAzureCosmosDBAccount@"

  # We use the "MongoClient" method and the "uri" value to connect to the account 
  client = pymongo.MongoClient(uri)

  # To connect to the database, use the connection variable ("client" in this case), and the database name
  # inside brackets
  ProductDatabase = client["products"]
 
  # Add code to connect to a collection and add an entry here 
  ```
::: zone-end


::: zone pivot = "C#"
  ***C#***

  ```C#
  using MongoDB.Driver;

    public class Products {
      public int ProductId { get; set; }
      public string name { get; set; }
    }

  class test {
    public static void Main (string[] args) {
    
      // We will discuss connection string in more detail in the next section of this module
      // Remember to replace below "YourAzureCosmosDBAccount" with the name of your Azure Cosmos DB 
      // account name and "YourAzureCosmosDBAccountKEY" with the Azure Cosmos DB account key.
      string connectionString = 
        @"mongodb://calopezdp420mongodb01:6CKYlfyagNSQ2ZmP8XEmc2Z6gozF6NkIJ6w1WoYFehZ8Z3842jEhz7xRBl7KeGX2QajQt54Y2g9bJ9MZXU8Z9Q==@calopezdp420mongodb01.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@calopezdp420mongodb01@";

      MongoClientSettings settings = MongoClientSettings.FromUrl(new MongoUrl(connectionString));
      settings.SslSettings = new SslSettings() { EnabledSslProtocols = SslProtocols.Tls12 };

      // We use the "MongoClient" method and the "settings" value to connect to the account 
      var mongoClient = new MongoClient(settings);

      // Connecting to your database is as simple as calling the GetDatabase method
      var ProductDatabase = mongoClient.GetDatabase("products");

      // Add code to connect to a collection and add an entry here 
    }
  }
  ```
::: zone-end

It's that simple, once we connected using the driver, we either create a new database, or pointed to an existing one with the *GetDatabase* or similar methods depending on the language. Our application can now use the **ProductDatabase** variable to reference to the desired database.  Creating or connecting to a collection will be as simple as it was to create a new database.

### Create a collection for the Azure Cosmos DB API for MongoDB using .NET

To create or access an existing collection, we'll use a get collection method or reference depending on the programming language. Let's add some code to the previous example to create/connect to a collection and add one entry on that collection.

::: zone pivot = "JavaScript"
  ***Node.js***

  ```JavaScript
            // Add code to connect to a collection and add an entry here 
            var collection = db.collection('documents');
            var insertResult = await collection.insertOne({ ProductId: 10, name: "bread" });
  ```
::: zone-end

::: zone pivot = "Java"
  ***Java***

  ```Java
            // Add code to connect to a collection and add an entry here 
            MongoCollection collection = ProductDatabase.getCollection("products");

            collection.insertOne(new Document()
                        .append("ProductId", 1)
                        .append("name", "bread"));
  ```
::: zone-end

::: zone pivot = "Python"
  ***Python***

  ```Python
  # Add code to connect to a collection and add an entry here 
  collection = ProductDatabase["products"]
  collection.insert_one({ "ProductId": 1, "name": "bread" })
  ```
::: zone-end

::: zone pivot = "C#"
  ***C#***

```C#
      // Add code to connect to a collection and add an entry here 
      var mongoCollection = mongoDatabase.GetCollection<Products>("products");

      Products Product = new Products {ProductId=1,name="bread"};
      mongoCollection.InsertOne (Product);
  ```
::: zone-end

In the next unit, we'll see how exactly did we created our connection string.

[/azure/cosmos-db/analytical-store-introduction]: https://docs.microsoft.com/azure/cosmos-db/analytical-store-introduction
[/mongodb.driver]: https://www.nuget.org/packages/mongodb.driver