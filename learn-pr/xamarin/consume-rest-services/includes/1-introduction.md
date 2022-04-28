[!include[](../../includes/dotnet-maui-note.md)]

Think about the applications that are installed on your phone. You might have some games, social media apps, storage apps, and so on. As an exercise, try to think of any applications that have absolutely no connection to the internet. You might come up with some, but the chances are that most of your apps have some form of connection to the internet. Users expect apps to have social aspects or cross-device experiences. Because of that, if an application doesn't have a social aspect, users won't use it.

In this module, you build a Xamarin.Forms application that consumes data from a REST web service. You start by determining if your device is connected to the internet and only running code if you have an active connection. Then you use `HttpClient` to perform basic CRUD operations on a hosted REST web service. Finally, you use message handlers with `HttpClient` to take advantage of the native networking stacks on each device.

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Detect if your device is connected to the internet
- Consume a REST web service by using HttpClient
- Take advantage of the native networking stacks while using HttpClient

## Prerequisites

[!include[](../../../includes/prerequisites.md)]

- Basic knowledge of REST
