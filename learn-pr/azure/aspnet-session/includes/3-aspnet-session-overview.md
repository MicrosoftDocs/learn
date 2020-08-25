The HTTP protocol that web applications use is inherently stateless. Many web applications need to maintain state information between requests, to provide some context for those requests. This context is called a *session*. You can save the state information for a session in many ways, but some are more appropriate than others. What's appropriate depends on the environment in which the web application is running.

## Options for storing session state

In an ASP.NET web application that depends on sessions, it's important to use an appropriate session state provider. The session state provider is responsible for persisting and maintaining the state for each user session. If a web application is meant to support many hundreds of thousands of concurrent users, the session state provider must support separate, private sessions for each user.

Typically, the web server manages session information. Session data is often simply a collection of key/value pairs. Each session has a unique identifier. 

When a client connects to a web app and starts a new session, the server generates a session identifier, and passes it back to the client as part of the HTTP response message. This identifier is typically returned in the form of a cookie that can be saved by the client's web browser or client application. All subsequent requests can include this cookie as part of the request, so the web app knows to which session each request belongs.

> [!div class="mx-imgBorder"]
> ![Image showing the relationships between client apps, the web app running on the web server, and session state information identified by using cookies.](..\media\3-session-state.png)

On the web server, session data can be stored in memory, in a disk file, in a shared location such as Azure Table storage, or in a database of some sort.

Retaining session data in memory ensures fast access, but affects horizontal scalability. If the web app is hosted by multiple servers acting as a web farm, or as part of a multiregion deployment, all requests from a client that specify a particular cookie must be directed to the same server. This situation results in *sticky* sessions. 

It's possible for this level of client/server affinity to result in some servers becoming overloaded while others are used less heavily. Additionally, if the server fails, then the state information will be lost.

Saving session data to a file reduces the chances of session data being lost. But it can have similar issues, if the file is stored on the local file system for a server. Client/server affinity is still an issue. If the web server fails, the session state information will be unavailable until the server has been recovered.

The most scalable approach is to write session data to a shared data store that all servers can access. This approach not only enables improved load balancing of requests across servers, but also ensures availability of session state if an individual web server fails. 

If you're using Azure, you can use Table storage, Azure SQL Database, or a service such as Azure Cache for Redis. Redis is a highly optimized caching service designed for storing key/value pairs. Of these options, Azure Cache for Redis provides the closest performance to storing sessions in memory.

## Configuring a session state provider in an ASP.NET web application

A session state provider manages session state in an ASP.NET web app. The session state provider organizes the session data for each client, handles the lifetime of session data (ensuring it's removed when a session expires), and maintains privacy. Session data is often encrypted, and shouldn't be shared between different users.

In an ASP.NET web app, you configure a session state provider by using the *\<sessionState\>* section of the web.config file. The *\<sessionState\>*  tag specifies the session provider. Each provider is configured in its own *\<providers\>* section, which contains provider-specific settings.

The default session state provider for ASP.NET operates in memory, and doesn't require a separate provider. The configuration looks like this:

```xml
<configuration>
  ...
  <system.web>
    ...
    <sessionState mode="InProc" />
    ...
  </system.web>
  ...
</configuration>
```

To use a different provider, set the mode to **Custom** in the *\<sessionState\>* element, and add the NuGet package that contains the provider to your web app. Then modify the *\<sessionState\>* section of the web.config file to reference the provider, and configure the settings for the provider. 

The following example shows the configuration for the Azure Cosmos DB session state provider. This provider writes session data to a container in a Cosmos DB database. You specify the database and collection by using the **databaseId** and **collectionId** parameters.

```xml
<sessionState mode="Custom" customProvider="CosmosDBSessionStateProviderAsync">
  <providers>
    <add name="CosmosDBSessionStateProviderAsync" 
         cosmosDBEndPointSettingKey="[cosmosDBEndPointSetting]" 
         cosmosDBAuthKeySettingKey="[cosmosDBAuthKeySetting]" 
         databaseId="[DataBaseId]" 
         collectionId="[CollectionId]" 
         offerThroughput="5000" 
         connectionMode="Direct" 
         connectionProtocol="Tcp" 
         requestTimeout="5" 
         maxConnectionLimit="50" 
         maxRetryAttemptsOnThrottledRequests="10" 
         maxRetryWaitTimeInSeconds="10" 
         preferredLocations="" 
         partitionKey="" 
         partitionNumUsedByProvider="" 
         type="Microsoft.AspNet.SessionState.CosmosDBSessionStateProviderAsync, Microsoft.AspNet.SessionState.CosmosDBSessionStateProviderAsync, Version=1.1.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
  </providers>
</sessionState>
```

You must have previously created a Cosmos DB account. You provide the address of the endpoint and the authentication key in the **cosmosDBEndPointSettingKey** and **cosmosDBAuthKeySettingKey** parameters.

The following second example shows the configuration for the Azure Cache for Redis provider. Again, the Azure Cache for Redis instance must already exist.

```xml
<sessionState mode="Custom" customProvider="MySessionStateStore">
  <providers>
    <add name="MySessionStateStore"
         type="Microsoft.Web.Redis.RedisSessionStateProvider"
         host="[AzureCacheFirRedisEndpoint]"
         accessKey="[AccessKey]"
         ssl="true" />
  </providers>
</sessionState>
```

You'll find the endpoint address to use for the **Host name** setting on the **Overview** page for the cache in the Azure portal:

> [!div class="mx-imgBorder"]
> ![Image showing Azure Cache for Redis page in the Azure portal. The host name for the cache is highlighted.](..\media\3-redis-host-name.png)

Specify **AccessKey** as either of the keys listed on the **Access keys** page in the portal:

> [!div class="mx-imgBorder"]
> ![Image showing the Access keys page for the cache in the Azure portal. The access keys are highlighted.](..\media\3-access-keys.png)

Many other providers that use different technologies to store session state information are available, from Microsoft and partner organizations.

> [!NOTE]
> The choice of session state provider is transparent to your application code. You shouldn't need to make any changes to your application if you switch session state providers.
