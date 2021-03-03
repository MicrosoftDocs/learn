::: zone pivot="csharp"

Now that we have a Redis cache created in Azure, let's create an application to use it. Make sure you have your connection string information from the Azure portal.

> [!NOTE]
> The integrated Cloud Shell is available on the right. You can use that command prompt to create and run the example code we are building here, or perform these steps locally if you have a .NET Core development environment set up.

## Create a Console Application

We'll use a simple Console Application so we can focus on the Redis implementation.

1. In the Cloud Shell, create a new .NET Core Console Application, name it `SportsStatsTracker`.

    ```bash
    dotnet new console --name SportsStatsTracker
    ```

1. Change the current directory to the folder for the new project.

    ```bash
    cd SportsStatsTracker
    ```

## Add the connection string

Let's add the connection string we got from the Azure portal into the code. Never store credentials like this in your source code. To keep this sample simple, we're going to use a configuration file. A better approach for a server-side application in Azure would be to use Azure Key Vault with certificates.

1. Create a new **appsettings.json** file to add to the project.

    ```bash
    touch appsettings.json
    ```

1. Open the code editor by entering `code .` in the project folder. If you are working locally, we recommend using **Visual Studio Code**. The steps here will mostly align with its usage.

1. Select the **appsettings.json** file in the editor, and add the following text. Paste your connection string into the **value** of the setting.

    ```json
    {
      "CacheConnection": "[value-goes-here]"
    }
    ```

1. Save the changes.

    > [!IMPORTANT]
    > Whenever you paste or change code into a file in the editor, make sure to save afterwards using the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

1. Select the **SportsStatsTracker.csproj** file in the editor to open it.

1. Add the following `<ItemGroup>` configuration block into the root `<Project>` element to include the new file in the project, and copy it to the output folder. This ensures that the app configuration file is placed in the output directory when the app is compiled/built.

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">
       ...
        <ItemGroup>
            <None Update="appsettings.json">
              <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
            </None>
        </ItemGroup>
    </Project>
    ```

1. Save the file. (Make sure you do this or you will lose the change when you add the package later.)

## Add support to read a JSON configuration file

A .NET Core application requires additional NuGet packages to read a JSON configuration file.

In the command prompt section of the window, add a reference to the  **Microsoft.Extensions.Configuration.Json** NuGet package.

   ```bash
    dotnet add package Microsoft.Extensions.Configuration.Json
   ```

## Add code to read the configuration file

Now that we have added the required libraries to enable reading configuration, we need to enable that functionality within our console application.

1. Select **Program.cs** in the editor.

1. At the top of the file, a `using System` line is present. Underneath that line, add the following lines of code.

    ```csharp
     using Microsoft.Extensions.Configuration;
     using System.IO;
    ```

1. Replace the contents of the **Main** method with the following code. This code initializes the configuration system to read from the **appsettings.json** file.

    ```csharp
    var config = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json")
        .Build();
    ```

Your **Program.cs** file should now look like the following example.

   ```csharp
    using System;
    using Microsoft.Extensions.Configuration;
    using System.IO;
    
    namespace SportsStatsTracker
    {
        class Program
        {
            static void Main(string[] args)
            {
                var config = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json")
                    .Build();
            }
        }
    }
   ```

## Get the connection string from configuration

In **Program.cs**, at the end of the **Main** method, use the new **config** variable to retrieve the connection string, and store it in a new variable named **connectionString**.

The **config** variable has an indexer where you can pass in a string to retrieve from your **appSettings.json** file.

   ```csharp
    string connectionString = config["CacheConnection"];
   ```

## Add support for the Redis cache .NET client

Next, let's configure the console application to use the **StackExchange.Redis** client for .NET.

1. Add the **StackExchange.Redis** NuGet package to the project using the command prompt at the bottom of the Cloud Shell editor.

   ```bash
    dotnet add package StackExchange.Redis
   ```

1. Select **Program.cs** in the editor, and add a `using` for the namespace **StackExchange.Redis**

   ```csharp
    using StackExchange.Redis;
   ```

After the installation is completed, the Redis cache client is available to use with your project.

## Connect to the cache

Let's add the code to connect to the cache.

1. Select **Program.cs** in the editor.

1. Create a `ConnectionMultiplexer` using `ConnectionMultiplexer.Connect` by passing it your connection string. Name the returned value **cache**.

1. Because the created connection is _disposable_, wrap it in a `using` block. Your code should look something like the following.

   ```csharp
    string connectionString = config["CacheConnection"];
    
    using (var cache = ConnectionMultiplexer.Connect(connectionString))
    {
        
    }
   ```

> [!NOTE] 
> The connection to Azure Cache for Redis is managed by the `ConnectionMultiplexer` class. This class should be shared and reused throughout your client application. We do _not_ want to create a new connection for each operation. Instead, we want to store it off as a field in our class, and reuse it for each operation. Here, we are only going to use it in the **Main** method, but in a production application, it should be stored in a class field, or a singleton.

## Add a value to the cache

Now that we have the connection, let's add a value to the cache.

1. Inside the `using` block after the connection has been created, use the `GetDatabase` method to retrieve an `IDatabase` instance.

   ```csharp
    IDatabase db = cache.GetDatabase();
   ```

1. Call `StringSet` on the `IDatabase` object to set the key "test:key" to the value "some value".

The return value from `StringSet` is a `bool` indicating whether the key was added.

1. Display the return value from `StringSet` onto the console.

   ```csharp
    bool setValue = db.StringSet("test:key", "some value");
    Console.WriteLine($"SET: {setValue}");
   ```

## Get a value from the cache

1. Next, retrieve the value using `StringGet`. This takes the key to retrieve and returns the value.

1. Output the returned value.

   ```csharp
    string getValue = db.StringGet("test:key");
    Console.WriteLine($"GET: {getValue}");
   ```

1. Your code should look like this.

   ```csharp
    using System;
    using Microsoft.Extensions.Configuration;
    using System.IO;
    using StackExchange.Redis;
    
    namespace SportsStatsTracker
    {
        class Program
        {
            static void Main(string[] args)
            {
                var config = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json")
                    .Build();
    
                string connectionString = config["CacheConnection"];
    
                using (var cache = ConnectionMultiplexer.Connect(connectionString))
                {
                    IDatabase db = cache.GetDatabase();
    
                    bool setValue = db.StringSet("test:key", "some value");
                    Console.WriteLine($"SET: {setValue}");
    
                    string getValue = db.StringGet("test:key");
                    Console.WriteLine($"GET: {getValue}");
                }
            }
        }
    }
   ```

1. Run the application to see the result. Enter `dotnet run` in the terminal window below the editor. Make sure you are in the project folder or it won't find your code to build and run.

   ```bash
    dotnet run
   ```

> [!TIP] 
> If the program doesn't do what you expect, but compiles, it may be because you have not saved changes in the editor. Always remember to save changes as you switch between the terminal and the editor windows.

## Use the async versions of the methods

We have been able to get and set values from the cache, but we are using the older synchronous versions. In server-side applications, these are not an efficient use of our threads. Instead, we want to use the _asynchronous_ versions of the methods. You can easily spot them - they all end in **Async**.

To make these methods easy to work with, we can use the C# `async` and `await` keywords. However, we will need to be using _at least_ C# 7.1 to be able to apply these keywords to our **Main** method.

### Switch to C# 7.1

C#'s `async` and `await` keywords were not valid keywords in **Main** methods until C# 7.1. We can switch to that compiler through a flag in the **.csproj** file.

1. Open the **SportsStatsTracker.csproj** file in the editor.

1. Add `<LangVersion>7.1</LangVersion>` into the first `PropertyGroup` in the build file. It should look like the following when you are finished.

   ```xml
    <Project Sdk="Microsoft.NET.Sdk">
    
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp2.0</TargetFramework>
        <LangVersion>7.1</LangVersion> 
      </PropertyGroup>
    ...
   ```

### Apply the async keyword

Next, apply the `async` keyword to the **Main** method. We will have to do three things.

1. Add the `async` keyword onto the **Main** method signature.

1. Change the return type from `void` to `Task`.

1. Add a `using` statement to include `System.Threading.Tasks`.

   ```csharp
    using System;
    using Microsoft.Extensions.Configuration;
    using System.IO;
    using StackExchange.Redis;
    using System.Threading.Tasks;
    
    namespace SportsStatsTracker
    {
        class Program
        {
            static async Task Main(string[] args)
            {
            ...
   ```

### Get and set values asynchronously

We can leave the synchronous methods in place. Let's add a call to the `StringSetAsync` and `StringGetAsync` methods to add another value to the cache. Set "counter" to the value "100".  

1. Use the `StringSetAsync` and `StringGetAsync` methods to set and retrieve a key named "counter". Set the value to "100".

1. Apply the `await` keyword to get the results from each method.

1. Output the results to the console window, just as you did with the synchronous versions.

   ```csharp
    // Simple get and put of integral data types into the cache
    setValue = await db.StringSetAsync("test", "100");
    Console.WriteLine($"SET: {setValue}");
    
    getValue = await db.StringGetAsync("test");
    Console.WriteLine($"GET: {getValue}");
   ```

1. Run the application again. It should still work and now have two values.

#### Increment the value

1. Use the `StringIncrementAsync` method to increment your **counter** value. Pass the number **50** to add to the counter:

    - Notice that the method takes the key _and_ either a `long` or `double`.

    - Depending on the parameters passed, it either returns a `long` or `double`.

1. Output the results of the method to the console.

    ```csharp
    long newValue = await db.StringIncrementAsync("counter", 50);
    Console.WriteLine($"INCR new value = {newValue}");
    ```

## Other operations

Finally, let's try executing a few additional methods with the `ExecuteAsync` support.

1. Execute "PING" to test the server connection. It should respond with "PONG".

1. Execute "FLUSHDB" to clear the database values. It should respond with "OK".

   ```csharp
    var result = await db.ExecuteAsync("ping");
    Console.WriteLine($"PING = {result.Type} : {result}");
    
    result = await db.ExecuteAsync("flushdb");
    Console.WriteLine($"FLUSHDB = {result.Type} : {result}");
   ```
    
The final code should look something like the following.

   ```csharp
    using System;
    using Microsoft.Extensions.Configuration;
    using System.IO;
    using StackExchange.Redis;
    using System.Threading.Tasks;
    
    namespace SportsStatsTracker
    {
        class Program
        {
            static async Task Main(string[] args)
            {
                var config = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json")
                    .Build();
    
                string connectionString = config["CacheConnection"];
    
                using (var cache = ConnectionMultiplexer.Connect(connectionString))
                {
                    IDatabase db = cache.GetDatabase();
    
                    bool setValue = db.StringSet("test:key", "some value");
                    Console.WriteLine($"SET: {setValue}");
    
                    string getValue = db.StringGet("test:key");
                    Console.WriteLine($"GET: {getValue}");
    
                    setValue = await db.StringSetAsync("test", "100");
                    Console.WriteLine($"SET: {setValue}");
    
                    getValue = await db.StringGetAsync("test");
                    Console.WriteLine($"GET: {getValue}");
    
                    var result = await db.ExecuteAsync("ping");
                    Console.WriteLine($"PING = {result.Type} : {result}");
                    
                    result = await db.ExecuteAsync("flushdb");
                    Console.WriteLine($"FLUSHDB = {result.Type} : {result}");
                }
            }
        }
    }
   ```

## Challenge

As a challenge, try serializing an object type to the cache. Here are the basic steps.

1. Create a new `class` with some public properties. You can invent one of your own ("Person" or "Car" are popular), or use the "GameStats" example given in the previous unit.

1. Add support for the **Newtonsoft.Json** NuGet package using `dotnet add package`.

1. Add a `using` for the `Newtonsoft.Json` namespace.

1. Create one of your objects.

1. Serialize it with `JsonConvert.SerializeObject` and use `StringSetAsync` to push it into the cache.

1. Get it back from the cache with `StringGetAsync` and then deserialize it with `JsonConvert.DeserializeObject<T>`.

::: zone-end

::: zone pivot="javascript"

Now that we have a Redis cache created in Azure, let's create an application to use it. Make sure you have your connection information from the Azure portal.

> [!NOTE]
> The integrated Cloud Shell is available on the right. You can use that command prompt to create and run the example code we are building here, or perform these steps locally if you have a Node.js development environment set up.

## Create a Console Application

We'll use a simple console application so we can focus on the Redis implementation.

1. In the Cloud Shell, create a new directory called `redisapp`, and initialize a new Node.js app there.

   ```bash
    mkdir redisapp
    cd redisapp
    npm init -y
    touch app.js
   ```

1. Our app is going to use the following npm packages:

    - **redis**: The most commonly used JavaScript package for connecting to redis.
    - **bluebird**: Used to convert the callback-style methods in the `redis` package to awaitable Promise.
    - **dotenv**: Loads environment variables from a `.env` file, which is where we'll store our Redis connectivity information.

    Let's install them now. Run this command to add them to our app.

   ```bash
    npm install redis bluebird dotenv
   ```
    
## Add configuration

Let's add the connection information we got from the Azure portal into a `.env` configuration file.

1. Create a new **.env** file to the project.

   ```bash
    touch .env
   ```

1. Open the code editor by entering `code .` in the project folder. If you are working locally, we recommend using **Visual Studio Code**. The steps here will mostly align with its usage.

1. Select the **.env** file in the editor, and paste in the following text.

   ```
    REDISHOSTNAME=
    REDISKEY=
    REDISPORT=
   ```

1. Paste in the hostname, primary key, and port after the equals sign on each respective line. The complete file will look similar to the following example.

   ```
    REDISHOSTNAME=myredishost.redis.cache.windows.net
    REDISKEY=K21mLSMN++z8d1FvIeMGy3VOAgoOmqaNYCqeE44eMDc=
    REDISPORT=6380
   ```

1. Save the file with <kbd>Ctrl+S</kbd> on Windows and Linux or <kbd>Cmd+S</kbd> on macOS.

## Set up the implementation

Now it's time to write the code for our application.

1. Select **app.js** in the editor.

1. First, we'll add our `require` statements. Paste in the following code at the top of the file.

   ```javascript
    var Promise = require("bluebird");
    var redis = require("redis");
   ```

1. Next, we'll load our `.env` configuration, and use bluebird's `promisifyAll` function to convert the `redis` package's functions and methods to awaitable Promise. Paste in the following code.

   ```javascript
    require("dotenv").config();
    Promise.promisifyAll(redis);
   ```

1. Now, we'll initialize a Redis client. Paste in the boilerplate code from the previous unit (using `process.env` to access our host name, port and key) to create the client.

   ```javascript
    const client = redis.createClient(
      process.env.REDISPORT,
      process.env.REDISHOSTNAME,
      {
        password: process.env.REDISKEY,
        tls: { servername: process.env.REDISHOSTNAME }
      }
    );
   ```

## Use the client to work with the cache

We're ready to write code to interact with our Redis cache.

1. First, add an `async` function wrapper at the bottom of the file to contain our main code. We need this to be able to `await` the asynchronous function calls we'll be using. All of the rest of the code you'll be adding in this unit will be in this wrapper.

   ```javascript
    (async () => {

      // The rest of the code you'll paste in goes here.

    })();
   ```

1. Add a value to the cache with the `setAsync` method, and read it back with `getAsync`.

   ```javascript
    console.log("Adding value to the cache");
    await client.setAsync("myKey", "myValue");

    console.log("Reading value back:");
    console.log(await client.getAsync("myKey"));
   ```

1. Send a ping to the cache with `pingAsync`.

   ```javascript
    console.log("Pinging the cache");
    console.log(await client.pingAsync());
   ```

1. Delete all the keys in the cache with `flushdbAsync`.

   ```javascript
    await client.flushdbAsync();
   ```

1. Finally, close the connection with `quitAsync`.

   ```javascript
    await client.quitAsync();
   ```

1. Save the file. Your finished application should look like this.

   ```javascript
    var Promise = require("bluebird");
    var redis = require("redis");

    require("dotenv").config();

    Promise.promisifyAll(redis);

    const client = redis.createClient(
    process.env.REDISPORT,
    process.env.REDISHOSTNAME,
    {
      password: process.env.REDISKEY,
      tls: { servername: process.env.REDISHOSTNAME }
    }
    );

    (async () => {
      console.log("Adding value to the cache");
      await client.setAsync("myKey", "myValue");
      console.log("Reading value back:");
      console.log(await client.getAsync("myKey"));
      console.log("Pinging the cache");
      console.log(await client.pingAsync());
      await client.flushdbAsync();
      await client.quitAsync();
    })();
   ```

1. Run the application. In the Cloud Shell, execute the following command.

   ```bash
    node app.js
   ```

    You'll see the following results.

   ```output
    Adding value to the cache
    Reading value back:
    myValue
    Pinging the cache
    PONG
   ```

::: zone-end
