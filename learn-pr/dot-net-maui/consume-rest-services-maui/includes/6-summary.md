Many modern applications make use of REST web services to provide access to data or other features such as cloud storage.

In .NET MAUI, you can use **HttpClient** to consume REST web services and perform CRUD operations. .NET MAUI also has APIs that you can use to detect if you have an active Internet connection. This information is important because if you run code that uses the Internet without having a network connection, your application could stop responding. Finally, both iOS and Android have native networking stacks that you can configure to ensure that your app connects in a secure manner.

In this module, you saw how to connect to the Internet from within a .NET MAUI app and use a REST web service. Specifically, you learned how to:

- Detect if your device is connected to the internet.
- Consume a REST web service by using **HttpClient**.
- Configure client network security using the native networking features of the platform.

## Learn more

- [Tutorial: Make HTTP requests in a .NET console app using C#](/dotnet/csharp/tutorials/console-webapiclient)
- [HttpClient Class](/dotnet/api/system.net.http.httpclient)
