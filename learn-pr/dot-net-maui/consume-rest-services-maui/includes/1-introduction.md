Many modern applications make use of REST web services to provide access to data or other features such as cloud storage. This is especially true of mobile applications running on phones and tablet devices. Most apps that incorporate social aspects and shared media are reliant on connectivity to these services. Without connectivity, many apps are limited in their functionality. They might be restricted to features cached locally on the device. A well-designed app can transparently detect whether a network connection is available and adjust its feature set accordingly.

Imagine that you work as a developer for a power-utilities company. You're creating an app that your engineers can use when they visit customer sites to perform routine servicing. During a site visit, an engineer might need to order replacement parts. Part of the app should allow an engineer to quickly look up the details for a part. Your company previously built a REST web service that provides information about electrical components and parts. This web service runs in Azure. The app must be able to connect to this web service to retrieve information about parts.

In this module, you'll build a .NET MAUI application that consumes data from a REST web service. You'll start by determining if your device is connected to the Internet and only attempt to communicate with the web service if you have an active connection. Then, you'll use **HttpClient** to perform basic CRUD operations on a hosted REST web service. Finally, you'll configure the native networking stacks on each device to implement secure communications between the app and the web service.

## Learning objectives

In this module, you learned how to:

- Detect if your device is connected to the internet.
- Consume a REST web service by using **HttpClient**.
- Configure client network security using the native networking features of the platform.

## Prerequisites

- Visual Studio 2022 with the .NET MAUI workload installed
- Optional: Visual Studio Code with the .NET MAUI Extension and .NET SDK with the .NET MAUI Workload installed
- Familiarity with C# and .NET
- Basic knowledge of REST

[!include[](../../../includes/install-dotnet-maui-workload.md)]
