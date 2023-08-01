In this exercise, we enhance the current logging of the chat app, by building on the code from the previous exercises.

For simplicity, we focus on logging messages to the console in this exercise. The following list enumerates the information you'd like to log:

- Time the error occurred
- Number of retries
- Time the error was resolved
- Location in the code
- Transient errors should be at the warning level
- Exceptions that cause the app to close should be errors

You'll write the code in a way that can be enhanced in the future to write these log messages to files, or other services like Azure Application Insights.

::: zone pivot="csharp"
### Add logging provider

Microsoft provides a `Microsoft.Extensions.Logging` NuGet package that adds a great set of functionality for logging. It can be customized with providers, and has a built-in console provider to log messages to the console. You can also use the new dependency injection features of .NET Core to enable log messages to print the class they're in.

1. Make sure you're still in the C# **chatapp-retry** folder with the following command.

    ```bash
    cd ~/mslearn-handle-transient-errors-in-your-app/csharp/chatapp-retry/
    ```

1. In the Cloud Shell, add `Microsoft.Extensions.Logging` to the app by installing the following three dependencies.

    ```azurecli
    dotnet add package Microsoft.Extensions.Logging --version 2.2.0
    ```

    ```azurecli
    dotnet add package Microsoft.Extensions.DependencyInjection --version 2.2.0
    ```

    ```azurecli
    dotnet add package Microsoft.Extensions.Logging.Console --version 2.2.0
    ```

    Make sure you installed all three packages successfully before proceeding with this exercise.

1. Open the Cloud Shell editor with the following command.

    ```azurecli
    code .
    ```

    The code editor opens and displays all files in the current folder in the left-hand navigation window.

1. Select **Program.cs** from the left-hand navigation window to open it in the editor. 

1. Reference `Microsoft.Extensions.Logging` in **Program.cs** by adding `using` statements as shown in the following snippet.

    ```csharp
    using Microsoft.Extensions.Logging;
    using Microsoft.Extensions.DependencyInjection;
    ```

1. Add a private member to the class for our logging object.

    ```csharp
    private static ILogger main_logger;
    ```

### Add logging

1. Add the following code to the beginning of the `Main()` method in **Program.cs**.

    ```csharp
    // Instantiate Dependency Injection and configure logger
    var serviceProvider = new ServiceCollection()
        .AddLogging(cfg => cfg.AddConsole())
        .Configure<LoggerFilterOptions>(cfg => cfg.MinLevel=LogLevel.Debug)
        .BuildServiceProvider();

    // Set instances of logger
    var logger = serviceProvider.GetService<ILogger<RetryPolicy>>();
    main_logger = serviceProvider.GetService<ILogger<Program>>();

    retries = new RetryPolicy(logger);
    ```

    The preceding code instantiates a ServiceCollection, adds a console provider, and sets a default logging level to debug. The next two lines create two loggers, one to be used in the retry policy class, the other for the main app.

1. We created the retry policy in the previous code, so now the following code should be changed:

    ```csharp
        private static RetryPolicy retries = new RetryPolicy();
    ```

    **To:**

    ```csharp
        private static RetryPolicy retries;
    ```

1. Replace `getAllChats` with the following update. This code replaces all the `Console.WriteLine` calls that are related to system errors, but keeps the calls to `Console.WriteLine` for the user interface.

    ```csharp
    private static void getAllChats()
    {
        messages = database.GetCollection<ChatMessage>(collectionName);
        try
        {
            allMessages = messages.Find(new BsonDocument()).ToList();
            foreach (ChatMessage chat in allMessages)
            {
                Console.WriteLine($"{chat.Name}: {chat.Message}");
                main_logger.LogInformation($"{DateTime.Now} - Messages read from database.");
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
                main_logger.LogError($"{DateTime.Now} - Maximum retries - need to close.");
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
                main_logger.LogError($"{DateTime.Now} - Maximum retries - need to close.");
                throw e;
            }
        }
        catch (Exception e)
        {
            main_logger.LogError($"{DateTime.Now} - Full stack trace: {e.StackTrace}");
            throw e;
        }
    }
    ```

    Now that we've enhanced logging from the main app, let's turn our attention to the `RetryPolicy` class we created earlier. The `RetryPolicy` class also needs do some logging to add meaningful information about transient errors.

1. Select the three ellipses (**...**) to the top right of the editor and then select **Save**.

1. Select **RetryPolicy.cs** in the navigation window to the left, to open **RetryPolicy.cs** in the code editor.

1. Add a reference to the logging library with the following `using` statement.

    ```csharp
    using Microsoft.Extensions.Logging;
    ```

1. Add a private member to the class for our logging object.

    ```csharp
    private readonly ILogger retrylogger;
    ```

1. Update the constructor of the class with the following code to Instantiate the logger. Notice that the constructor now takes a parameter of type `ILogger`.

    ```csharp
    public RetryPolicy(ILogger logger)
    {
        retrylogger = logger;
        ConfigurationBuilder configurationBuilder = new ConfigurationBuilder();
        configurationBuilder.SetBasePath(Directory.GetCurrentDirectory());
        configurationBuilder.AddJsonFile("appsettings.json");
        configuration = configurationBuilder.Build();
    }
    ```

1. Replace the `Console.WriteLine` call in `CanRetry`:

    ```csharp
    Console.WriteLine($"Retrying: {currentTries}");
    ```

    **With:**

    ```csharp
    retrylogger.LogWarning($"{DateTime.Now} - Retries: {currentTries}");
    ```

1. Save the file, and close the editor. You can select the ellipsis "..." in the right corner of the editor, or use the accelerator key (press <kbd>Ctrl+S</kbd> on Windows and Linux; press <kbd>Cmd+S</kbd> on macOS).

1. Compile and run app.

    ```bash
    dotnet build
    dotnet run
    ```

::: zone-end
::: zone pivot="java"
### Add logging provider

The Java runtime provides a `import java.util.logging` library that adds a great set of functionality for logging. It can be customized with providers, messages can have formats applied, and it logs to the console by default. You don't need to add this library to the Chat App as it's already being used to hide MongoDB log messages. You add a new logger for use in the main app and retry policy, and add the new time library to allow access to the current time.

1. In the Cloud Shell, navigate to the node chatapp-retry folder.

    ```bash
    cd ~/mslearn-handle-transient-errors-in-your-app/java/chatapp-retry/
    ```

1. Edit `javaChat.java` in the code editor.

    ```bash
    code javaChat.java
    ``` 

1. Import time helper libraries  by adding the following `import` statements to **javaChat.java**.

    ```java
    import java.time.format.DateTimeFormatter;
    import java.time.LocalDateTime;
    ```

1. Add a logger private member variable to `javaChat` that we can use across the app.

    ```java
    private static Logger logger = Logger.getLogger( javaChat.class.getName() );
    ```

1. Update `printAllMessages` to the following code. The update replaces the `System.out.Println` calls in the catch blocks. There are still calls to `System.out.Println` for the user interface.

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

1. The retry policy class also needs do some logging to add meaningful information about transient errors.

1. Select the three ellipses (**...**) to the top right of the editor and then select **Save**.

1. Select the three ellipses (**...**) to the top right of the editor and then select **Open**, and in the dialog type **RetryPolicy.java**, and press Enter.

1. Import logging and time libraries by adding the following `import` statements to the class.

    ```java    
    import java.util.logging.Logger;
    import java.util.logging.Level;
    import java.time.format.DateTimeFormatter;
    import java.time.LocalDateTime;
    ```

1. Declare a variable for our logger instance.

    ```java
    private Logger retryLogger = Logger.getLogger( RetryPolicy.class.getName() );
    ```

1. Replace the `System.out.printf` call in `canRetry()` with a logging message:

    ```java
    System.out.printf("Retrying: %s\n", currentTries);
    ```

    With:

    ```java
    retryLogger.log(Level.WARNING, LocalDateTime.now() + " - Retrying: " + currentTries);
    ```

1. Save the file, and close the editor. You can select the ellipsis "..." in the right corner of the editor, or use the accelerator key (press <kbd>Ctrl+S</kbd> on Windows and Linux; press <kbd>Cmd+S</kbd> on macOS).

1. Compile and run app.

    ```bash
    javac -cp .:lib/* -d . javaChat.java RetryPolicy.java
    java -cp .:lib/* learn.javachatapp.javaChat
    ```

::: zone-end
::: zone pivot="node"
### Add a logging provider

There's no inbuilt logging library provided as Node.js is built on the JavaScript language. There are many other logging libraries, but your team has decided to standardize on Winston across all its node apps. Winston can write to the console by default, and also has options for different transports and log message formats.

1. Make sure you're still in the Node.js **chatapp-retry** folder by running the following command. 

    ```bash
    cd ~/mslearn-handle-transient-errors-in-your-app/node/chatapp-retry/
    ```

1. Install the Winston package.

    ```bash
    npm install winston
    ```

1. Edit `server.js` in the code editor.

    ```bash
    code server.js
    ```

1. Require the new Winston logging library, by adding JavaScript to line 16.

    ```javascript
    const { createLogger, format, transports } = require('winston');
    
    const logger = createLogger({
      level: 'debug',
      format: format.combine(
        format.colorize(),
        format.timestamp({
          format: 'YYYY-MM-DD HH:mm:ss'
        }),
        format.printf(info => `${info.timestamp} ${info.level}: ${info.message}`)
      ),
      transports: [new transports.Console()]
    });
    ```

1. Replace all the `console.log` calls with the new logger.


    ```javascript
    // Connect to MongoDB
    function connectWithRetry() {
      mongoose.connect( dbUrl, options )
      .then(() => logger.log('info',  'Connection to MongoDB successful') )
      .catch(function(e) {
        if (retries.checkRetries()) {
          connectWithRetry();
        } else {
          logger.log('error',  'Error occured trying to connect to the database.');
        }
      });
    }
    ```

    ```javascript
    // Get all messages from the database
    app.get('/messages', (req, res) => {
      Message.find({})
        .then(messages => {
          res.send(messages);
          logger.log('info', 'Messages Refreshed.');
        })
        .catch(function(e) {
          logger.log('error', 'Error reading from the database.' + e);
        });
      }
    );
    ```

    ```javascript
    // Save a message
    app.post('/messages', (req, res) => {
      var message = new Message(req.body);
      message.save()
        .then( () => {
          res.sendStatus(200);
          logger.log('info', 'Message Posted.');
        })
        .catch(function(e) {
          logger.log('error', 'Error saving to the database.' + e);
        });
      }
    );
    ```

    ```javascript
    // Delete all messages from the database
    app.post('/deleteall', (req, res) => {
      Message.deleteMany({})
        .then( () => {
          res.sendStatus(200);
          logger.log('info', 'Messages Deleted.');
        })
        .catch(function(e) {
          logger.log('error', 'Error deleting from database.' + e);
        });
      }
    );
    ```
1. The retry policy class also needs do some logging to add meaningful information about transient errors.

1. Select the three ellipses (**...**) to the top right of the editor and then select **Save**.

1. Select the three ellipses (**...**) to the top right of the editor and then select **Open**, and in the dialog type **retryPolicy.js**, and press Enter.

1. Enhance the  **retryPolicy.js** to log information about transient errors by adding code to use Winston at line 4.

    ```javascript
    const { createLogger, format, transports } = require('winston');

    const logger = createLogger({
      level: 'debug',
      format: format.combine(
        format.colorize(),
        format.timestamp({
          format: 'YYYY-MM-DD HH:mm:ss'
        }),
        format.printf(info => `${info.timestamp} ${info.level}: ${info.message}`)
      ),
      transports: [new transports.Console()]
    });
    ```

1. Replace the `console.log` line in the `checkRetries` method:

    ```javascript
    console.log('Retrying: ' + this._currentTries);
    ```

    **With:**

    ```javascript
    logger.log('warn', 'Retrying: ' + this._currentTries);
    ```

1. Save the file, and close the editor. You can select the ellipsis "..." in the right corner of the editor, or use the accelerator key (press <kbd>Ctrl+S</kbd> on Windows and Linux; press <kbd>Cmd+S</kbd> on macOS).

1. Run app.

    ```bash
    npm start
    ```

> [!TIP]
> If you no longer have the browser page opened on the app, run `curl -X POST http://localhost:8888/openPort/8000;` and click on the url.

::: zone-end

### Test the new logging

1. If the firewall is still switched on for the Azure Cosmos DB, the chat app can't connect to the database. Otherwise, if the chat app is still working then follow these steps to switch on the firewall.

1. Sign into the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure portal menu or from the **Home** page, select **Azure Cosmos DB**.

1. You should see a database account with a name beginning with **learn-cosmos-db-**. Select that database account.

1. In the Azure Cosmos DB panel, select **Firewall and virtual networks**.

1. Select **Selected networks**.

1. Uncheck **Allow access from Azure portal**.

1. Select **I understand that the current settings will block all VNets and IPs including Azure portal**.

1. Select **Save**.

1. Return to the Cloud Shell and try to refresh the messages. You should see the new logging messages in the console, similar to the following messages. 

::: zone pivot="csharp"
```bash
    warn: csharp_chatapp_retry.RetryPolicy[0]
          20/03/2019 10:37:24 - Retries: 1
    warn: csharp_chatapp_retry.Program[0]
          Exception raised: System.TimeoutException
    
    warn: csharp_chatapp_retry.RetryPolicy[0]
          20/03/2019 10:37:29 - Retries: 2
    warn: csharp_chatapp_retry.Program[0]
          Exception raised: System.TimeoutException
    
    warn: csharp_chatapp_retry.RetryPolicy[0]
          20/03/2019 10:38:34 - Retries: 3
    warn: csharp_chatapp_retry.Program[0]
          Exception raised: System.TimeoutException
    
    warn: csharp_chatapp_retry.RetryPolicy[0]
          20/03/2019 10:39:39 - Retries: 4
    warn: csharp_chatapp_retry.Program[0]
          Exception raised: System.TimeoutException
    
    warn: csharp_chatapp_retry.RetryPolicy[0]
          20/03/2019 10:40:44 - Retries: 5
    fail: csharp_chatapp_retry.Program[0]
          20/03/2019 10:41:44 - Maximum retries - need to close.
```
::: zone-end
::: zone pivot="java"
```bash
Mar 20, 2019 11:35:30 AM learn.javachatapp.RetryPolicy checkRetries
WARNING: 2019-03-20T11:35:30.484755400 - Retrying: 1
Mar 20, 2019 11:35:30 AM learn.javachatapp.javaChat diagnose
WARNING: 2019-03-20T11:35:30.523755300 - Exception raised: com.mongodb.MongoSecurityException: Exception authenticating
Mar 20, 2019 11:35:30 AM learn.javachatapp.RetryPolicy checkRetries
WARNING: 2019-03-20T11:35:30.680967900 - Retrying: 2
Mar 20, 2019 11:36:30 AM learn.javachatapp.javaChat diagnose
WARNING: 2019-03-20T11:36:30.682929400 - Exception raised: com.mongodb.MongoSecurityException: Exception authenticating
Mar 20, 2019 11:36:30 AM learn.javachatapp.RetryPolicy checkRetries
WARNING: 2019-03-20T11:36:30.898297400 - Retrying: 3
Mar 20, 2019 11:37:30 AM learn.javachatapp.javaChat diagnose
WARNING: 2019-03-20T11:37:30.901201300 - Exception raised: com.mongodb.MongoSecurityException: Exception authenticating
Mar 20, 2019 11:37:31 AM learn.javachatapp.RetryPolicy checkRetries
WARNING: 2019-03-20T11:37:31.125043 - Retrying: 4
Mar 20, 2019 11:38:31 AM learn.javachatapp.javaChat diagnose
WARNING: 2019-03-20T11:38:31.126188100 - Exception raised: com.mongodb.MongoSecurityException: Exception authenticating
Mar 20, 2019 11:38:31 AM learn.javachatapp.RetryPolicy checkRetries
WARNING: 2019-03-20T11:38:31.329202 - Retrying: 5
Mar 20, 2019 11:39:31 AM learn.javachatapp.javaChat printAllMessages
SEVERE: 2019-03-20T11:39:31.330523900 - Maximum retries - need to close.
Exception in thread "main" com.mongodb.MongoSecurityException: Exception authenticating
```
::: zone-end
::: zone pivot="node"
```bash
2019-03-20 14:06:45 warn: Retrying: 1
2019-03-20 14:06:45 warn: Retrying: 2
2019-03-20 14:07:45 warn: Retrying: 3
2019-03-20 14:08:45 warn: Retrying: 4
2019-03-20 14:09:45 warn: Retrying: 5
2019-03-20 14:10:45 error: Error occurred trying to connect to the database.
```
::: zone-end
