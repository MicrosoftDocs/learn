Many modern applications make use of REST web services to provide access to data or other features such as cloud storage. This is especially true of mobile applications running on phones and tablet devices. Most apps that incorporate social aspects and shared media are reliant on connectivity to these services. Without connectivity, many apps are limited in their functionality. They may be restricted to features cached locally on the device. A well-designed app can transparently detect whether a network connection is available and adjust its feature-set accordingly.

Imagine that you work as a developer for a power utilities company. You're creating an app that can be used by engineers when they visit customer sites to perform routine servicing. During a site visit, an engineer may need to order replacement parts. Part of the app should enable an engineer to quickly look up the details for a part. Your company has previously built a REST web service that provides information about electrical components and parts. This web service runs in Azure. The app must be able to connect to this web service to retrieve information about parts.

In this module, you'll build a .NET MAUI application that consumes data from a REST web service. You'll start by determining if your device is connected to the Internet and only attempt to communicate with the web service if you have an active connection. Then you'll use **HttpClient** to perform basic CRUD operations on a hosted REST web service. Finally, you'll configure the native networking stacks on each device to implement secure communications between the app and the web service.

> [!NOTE]
> This module requires Visual Studio 2022. You can use either Windows or a Mac.
> If you're running on Windows, make sure you have the .NET MAUI workloads installed in Visual Studio 2022. Refer to the documentation if you need to add it to your installation.
> If you're running on a Mac, the standard Visual Studio for Mac installation includes everything you need to build apps with .NET MAUI. <!-- NEED TO CHECK WHETHER THIS WILL BE TRUE FOR GA OF VS AND .NET MAUI !-->

## Learning objectives

In this module, you’ll learn how to:

- Detect if your device is connected to the internet
- Consume a REST web service by using **HttpClient**
- Configure client network security using the native networking features of the platform

## Prerequisites

- Visual Studio 2022 with the .NET MAUI workload
- Familiarity with C# and .NET
- Basic knowledge of REST
- [Git for Windows installed](https://gitforwindows.org/)
