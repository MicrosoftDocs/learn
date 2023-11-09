Your team's chat app has been improved to detect errors. When you use a cloud-based database, there are different transient errors that can occur. In this exercise, we focus on resolving connection problems by implementing a retry policy.

If the error is due to database connection issues, we adopt the following strategy:

- If the error is network-related, quickly try to reconnect
- Keep retrying to reconnect every 60 seconds
- Retry up to five times
- After five retries, notify the end user of the database problem and quit

For other unknown errors, quit the app.

::: zone pivot="csharp"
## Use a class to implement a retry policy

1. Run the following command in the Cloud Shell to navigate to the C# chatapp-retry folder.

    ```azurecli
    cd ~/mslearn-handle-transient-errors-in-your-app/csharp/chatapp-retry/
    ```

1. This version includes your first draft at coding a retry policy class. It includes an appsettings.json configuration file to allow system administrators to set the delay and number of retries.

    ```json
    {
        "number-of-retries": 5,
        "delay": 60000
    }
    ```

1. Open the **RetryPolicy** class.

    ```azurecli
    code RetryPolicy.cs
    ```

    Take a moment to read through the code in this class.

    The **RetryPolicy** class keeps track of the number of retries, and handles adding a delay before code can be retried. Most of the logic for our retry policy is in the `CanRetry()` method:

    [!code-csharp[](../src/csharp-chatapp-retry/RetryPolicy.cs?highlight=30-47)]

    The `canRetry` method checks the number of retries, and then returns `true` to the calling code if it's OK to keep retrying, or `false` if the app should now stop.

    Now we can use this class in our app to implement a retry policy.

## Add a retry policy

1. Select the three ellipses (**...**) to the top right of the editor and then select **Open File ...**. Select  **Program.cs** in the file chooser dialog, and press **Enter**.

1. Update the `connectionString` variable in this class to the value of the connection string of your Azure Cosmos DB database we found earlier.

1. Scroll down to the `getAllChats()` method.

    [!code-csharp[](../src/csharp-chatapp-retry/Program.cs?range=69-94)]

1. Add the code to retry the connection in the two MongoDB-specific catch blocks.

    ```csharp
        if (retries.CanRetry())
        {
            diagnose(e);
            getAllChats(); //retry
        } else {
            Console.WriteLine("Maximum retries - need to close.");
            throw e;
        }
    ```

1. The method should be the following code:

    ```csharp
        private static void getAllChats()
        {
            messages = database.GetCollection<ChatMessage>(collectionName);
            try
            {
                allMessages = messages.Find(new BsonDocument()).ToList();
                foreach (ChatMessage chat in allMessages)
                {
                    Console.WriteLine(String.Format("{0}: {1}", chat.Name, chat.Message));
                }
                Console.WriteLine("\n");
            }
            catch (MongoDB.Driver.MongoConnectionException e)
            {
                if (retries.CanRetry())
                {
                    diagnose(e);
                    getAllChats(); //retry
                } else {
                    Console.WriteLine("Maximum retries - need to close.");
                    throw e;
                }
            }
            catch (System.TimeoutException e)
            {
                if (retries.CanRetry())
                {
                    diagnose(e);
                    getAllChats(); //retry
                } else {
                    Console.WriteLine("Maximum retries - need to close.");
                    throw e;
                }
            }
            catch (Exception e)
            {
                diagnose(e);
                throw e;
            }
        }
    ```

1. Define the retries object, and reset it with each call to the database. Add a declaration for the retries object before the main method:

    ```csharp
        private static RetryPolicy retries = new RetryPolicy();
    ```

1. Reset the retries in the while loop of the `Main()` method in **Program.cs**, as shown in the following code snippet.

    [!code-csharp[](../src/csharp-chatapp-retry.1/Program.cs?range=46-53&highlight=48)]


1. To save our changes, select the three ellipses (**...**) to the top right of the editor and then select **Close Editor** and then **Save**.

1. Compile and run app.

    ```bash
    dotnet build
    dotnet run
    ```

1. The app should compile, and then run, add a new message press N, and then Enter a name and message.

1. List all the messages by pressing **R** then enter.

1. Leave the app running.

::: zone-end
::: zone pivot="java"
## Use a class to implement a retry policy

1. In the Cloud Shell, navigate to the Java chatapp-retry folder.

    ```bash
    cd ~/mslearn-handle-transient-errors-in-your-app/java/chatapp-retry/
    ```

1. This version includes your first draft at coding a retry policy class. It includes a config.properties configuration file to allow system administrators to set the delay and number of retries.

    ```
    number_of_retries=5
    delay=60
    ```

1. Open the **RetryPolicy** class.

    ```bash
    code RetryPolicy.java
    ```

1. The class keeps track of the number of retries, and handles adding a delay before code can be retried. The main logic in the `canRetry` method:

    [!code-java[](../src/java-chatapp-retry/RetryPolicy.java?range=22-38)]

    The `canRetry` method checks the number of retries, and then returns `true` to the calling code if it's OK to keep retrying, or `false` if the app should now stop.

1. Now we can use this class to add a retry policy to the chat app.

## Add a retry policy

1. Select the three ellipses (**...**) to the top right of the editor and then select **Open** in the dialog type **javaChat.java**, and press **Enter**.

1. Locate the `printAllMessages()` method in **javaChat.java**.

1. Replace the implementation of `printAllMessages` with the following code. This code adds retry logic to the MongoDB catch blocks.

    ```java
        private static void printAllMessages (MongoCollection<Document> collection) throws InterruptedException {
            try {
                // Return all messages
                collection.find().forEach((Consumer<Document>) document -> {
                    System.out.printf("%s: %s\n", document.get("name"), document.get("message"));
                });
            }
            catch (com.mongodb.MongoCommandException e) {
                if (retries.canRetry())
                {
                    diagnose(e);
                    printAllMessages(collection); //retry
                } else {
                    System.out.println("Maximum retries - need to close.");
                    throw e;
                }
            }
            catch (com.mongodb.MongoSecurityException e) {
                if (retries.canRetry())
                {
                    diagnose(e);
                    printAllMessages(collection); //retry
                } else {
                    System.out.println("Maximum retries - need to close.");
                    throw e;
                }
            }
            catch (Exception e) {
                diagnose(e);
                throw e;
            }
        }
    ```

1.  Add a declaration for the RetryPolicy object before the `Main` method in **javaChat.java**.

    ```java
    private static RetryPolicy retries;
    ```

1. Instantiate the `retries` variable inside the `Main` method:

    ```java
        try{
            retries = new RetryPolicy();
        } catch(FileNotFoundException e) {
            e.printStackTrace();
        }
    ```

1. Add the following line of code at the top of the while loop to reset the retries.

    ```java
        retries.resetRetries();
    ```

1. Save the file, and close the editor. Use the commands in the **...** menu in the top right corner of the editor, or use the accelerator keys <kbd>Ctrl+S</kbd> to save the file, and <kbd>Ctrl+Q</kbd> to close the editor.

1. Build the project using the following command:

    ```bash
    javac -cp .:lib/* -d . javaChat.java RetryPolicy.java
    ```

1. Run the app with the following command in the Cloud Shell.

    ```bash
    java -cp .:lib/* learn.javachatapp.javaChat
    ```
::: zone-end
::: zone pivot="node"
## Use a function to implement a retry policy

1. In the Cloud Shell, navigate to the node chatapp-retry folder.

    ```bash
    cd ~/mslearn-handle-transient-errors-in-your-app/node/chatapp-retry/
    ```

1. This version includes your first draft at coding a retry policy class. It includes an appsettings.json configuration file to allow system administrators to set the delay and number of retries.

    ```json
    {
        "number_of_retries": 5,
        "delay": 60000
    }
    ```

1. Download the dependencies.

    ```bash
    npm install
    ```

1. Open the **retryPolicy.js** script.

    ```bash
    code retryPolicy.js
    ```

1. The class keeps track of the number of retries, and handles adding a delay before code can be retried. The main logic in the `checkRetries` function:

    [!code-javascript[](../src/node-chatapp-retry/retryPolicy.js?range=10-26&highlight=14-18)]

    The `canRetry` method checks the number of retries, and then returns `true` to the calling code if it's OK to keep retrying, or `false` if the app should now stop.

1. Now we can use this class to add a retry policy to the chat app.

## Add a retry policy

1. Select the three ellipses (**...**) to the top right of the editor and then select **Open** in the dialog type **server.js**, and press **Enter**.

1. Scroll down to the mongoose call to connect to the database.

    [!code-javascript[](../src/node-chatapp-retry/server.js?range=39-46&highlight=44)]

1. Add code to use the retry policy inside the catch promise.

    ```javascript
      .catch(function(e) {
        if (retries.checkRetries()) {
          // need to retry
        } else {
          console.log(e); // "error connecting to the database"
        }
      });
    ```

1. There are several ways in JavaScript to retry the code. For simplicity, this example uses recursion. Replace the connection code with the following.

    ```javascript
    // Connect to MongoDB
    function connectWithRetry() {
      mongoose.connect( dbUrl, options )
      .then(() => console.log('Connection to MongoDB successful'))
      .catch(function(e) {
        if (retries.checkRetries()) {
          connectWithRetry();
        } else {
          console.log(e); // "error connecting to the database"
        }
      });
    }

    // Using the retry policy
    connectWithRetry();
    ```

    > [!TIP]
    > There are other retry npm packages, including polly-js, that can simplify the code and offer additional features like exponential back-off.

1. Define the retries object, and include retryPolicy.js at line 6:

    [!code-javascript[](../src/node-chatapp-retry/server.js?range=1-13&highlight=6)]

    By adding this code:

    ```javascript
    // add the retry policy
    let retry = require('./retryPolicy.js');
    let retries = new retry();
    ```

1. Save the file, and close the editor. Use the commands in the **...** menu in the top right corner of the editor, or use the accelerator keys <kbd>Ctrl+S</kbd> to save the file, and <kbd>Ctrl+Q</kbd> to close the editor.

1. If your browser isn't open from the previous exercise, run:

    ```bash
    curl -X POST http://localhost:8888/openPort/8000;
    ```

1. Run the node app with:

    ```bash
    npm build
    npm start
    ```

1. Select the returned hyperlink from the previous step.

1. Add some messages, and refresh the page. Leave the app running.

::: zone-end

## Test the retry code

If the firewall is still switched on for the Azure Cosmos DB, the chat app can't connect to the database. Otherwise, if the chat app is still working then follow these steps to switch on the firewall.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Azure Cosmos DB**.

1. In the list of database accounts, select the database account with a name beginning with **learn-cosmos-db-**.

1. In the Azure Cosmos DB panel, select **Firewall and virtual networks**.

1. In *Allow access from*, choose the option **Selected networks**.

1. Uncheck **Allow access from Azure portal**.

1. Select **I understand that the current settings will block all VNets and IPs including Azure portal**.

1. Select **Save** to save the firewall configuration updates. These changes have enabled a firewall for the Azure Cosmos DB account, which blocks access from the Cloud Shell, simulating a connection outage.

    > [!NOTE]
    > It can take a while for these firewall updates to complete, so wait for them to finish before proceeding to the next step.

1. Run the app and select **R** to refresh all the messages. The app catches a `System.TimeoutException` and retries the connection to the database once again.

::: zone pivot="csharp"
Based on the `number-of-retries` setting in the **appsettings.json** file of our project, the code retries connecting up to five times.
::: zone-end
::: zone pivot="java"
Based on the `number_of_retries` setting in the **config.properties** file of our project, the code retries connecting up to five times.
::: zone-end
::: zone pivot="node"
Based on the `number-of-retries` setting in the **appsettings.json** file of our project, the code retries connecting up to five times.
::: zone-end



1. Back on the Azure portal, select **All networks**, and then select **Save** to disable the firewall.

1. If the app has finished, restart it.

1. If the firewall is removed in time, the Chat App recovers, reconnects, and displays the stored messages.

## Change the retry policy

1. Quite the app, and update the retry policy configuration to only wait 5 seconds (5000 milliseconds) before each retry.

::: zone pivot="csharp"
1. Open the configuration file in the code editor.

    ```bash
    code appsettings.json
    ```

1. Change the delay from `60000` to `5000`.

1. Save the file, and close the editor. Use the commands in the **...** menu in the top right corner of the editor, or use the accelerator keys <kbd>Ctrl+S</kbd> to save the file, and <kbd>Ctrl+Q</kbd> to close the editor.

1. Run app, and note that the retries happen much more quickly.

    ```bash
    dotnet run
    ```

::: zone-end
::: zone pivot="java"
1. Open the configuration file in the code editor.

    ```bash
    code config.properties
    ```

1. Change the delay from `60` to `5`.

1. Save the file, and close the editor. Use the commands in the **...** menu in the top right corner of the editor, or use the accelerator keys <kbd>Ctrl+S</kbd> to save the file, and <kbd>Ctrl+Q</kbd> to close the editor.

1. Run app, and note that the retries happen much more quickly.

    ```bash
    java -cp .:lib/* learn.javachatapp.javaChat
    ```

::: zone-end
::: zone pivot="node"
1. Open the configuration file in the code editor.

    ```bash
    code appsettings.json
    ```

1. Change the delay from `60000` to `5000`.

1. Save the file, and close the editor. Use the commands in the **...** menu in the top right corner of the editor, or use the accelerator keys <kbd>Ctrl+S</kbd> to save the file, and <kbd>Ctrl+Q</kbd> to close the editor.

1. Run app, and note that the retries happen much more quickly.

    ```bash
    npm start
    ```

::: zone-end
