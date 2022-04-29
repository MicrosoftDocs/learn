.NET MAUI enables you to create the user interface for an app dynamically by using C# code. However, sometimes it's more appropriate and efficient to define the UI statically. EXtensible Application mark-up Language (XAML) provides a way to lay out the UI at compile time. The XAML description of the UI also provides a degree of documentation, enabling you to quickly grasp the way in which the UI is presented to a user without having to delve through the application code.

Suppose you work for a power utility company as a mobile developer. You're responsible for improving the company's mobile app that engineers use when visiting customer premises. Currently the app's UI is built using C# code. However, you've started to notice it's becoming more difficult to manage UI updates. This difficulty is due to the app getting more complex. It's becoming increasingly hard to understand the core behavior logic as it's mixed in with UI code.

You want to find a solution that will introduce clean separation of UI and behavior. Separation of UI and behavior will allow your design expert to focus on what they do best, and you'll have time to focus on coding the behavior of the app. .NET MAUI lets you define your UI using XAML. XAML gives you a clean separation of user interface (UI) and behavior. XAML also makes it easier to use a design expert and design tools. In this module, you'll learn how to create a .NET MAUI app that defines its pages and controls using XAML instead of C# code. Creating UI on XAML will allow you to separate all your UI code from your behavior code to make it easier to manage both.

> [!NOTE]
> This module requires Visual Studio 2022. You can use either Windows or a Mac.
> If you're running on Windows, make sure you have the Mobile development with .NET workload installed together with the optional MAUI workload. Refer to the documentation if you need to add it to your installation.
> If you're running on a Mac, the standard Visual Studio for Mac installation includes everything you need to build apps with .NET MAUI. <!-- NEED TO CHECK WHETHER THIS WILL BE TRUE FOR GA OF VS AND .NET MAUI !-->

## Learning objectives

In this module, you'll learn:

- The benefits of using XAML over defining the UI for a .NET MAUI app in C#
- How to create pages and controls, and set their properties using XAML
- How to handle UI events and wire them up in XAML
- How to create and use XAML mark-up extensions
- How to set platform-specific values in XAML mark-up

## Prerequisites

- Visual Studio 2022 with the MAUI workload installed
- Familiarity with C# and .NET
