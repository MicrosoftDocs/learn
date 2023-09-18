A common pattern used for cross-platform app development is to factor the business logic from the user interface, and then develop separate user interfaces and UI logic for each platform. While the business logic remains unchanged for each type of device, the code that drives the app and presents the data can vary. This variance is because of the differing capabilities, APIs, and features the devices provide. Building a multiplatform app in this way involves dealing with not only separate SDKs, but altogether different languages and toolsets.

The purpose of .NET MAUI is to simplify multiplatform app development. Using .NET MAUI, you create multiplatform apps using a single project, but you can add platform-specific source code and resources if necessary. The key aim of .NET MAUI is to enable you to implement as much of your application logic and UI layout as possible in a single codebase.

In this unit, you'll learn about the .NET MAUI architecture and the tools required to build .NET MAUI applications.

## What is the .NET MAUI technology stack?

.NET provides a series of platform-specific frameworks for creating apps: .NET for Android, .NET for iOS (and iPadOS), .NET for Mac, and WinUI 3 (leveraging the Windows App SDK). These frameworks all have access to the same .NET 6 Base Class Library (BCL). This library provides the functionality for creating and managing resources, and for generally abstracting the details of the underlying device away from your code. The BCL depends on the .NET runtime to provide the execution environment for your code. For Android, iOS (and iPadOS), and macOS, the environment is implemented by Mono, an open-source implementation of the .NET runtime. On Windows, Win32 performs the same role, except it's optimized for the Windows platform.

While the BCL enables applications running on different types of devices to share common business logic, the various platforms have different ways of defining an application's user interface. The platforms provide varying models for specifying how the user interface elements communicate and interoperate. You can craft the UI for each platform separately using the appropriate platform-specific framework (.NET for Android, .NET for iOS, .NET for Mac, or WinUI 3), but this approach then requires you to maintain a codebase for each individual family of devices. .NET MAUI provides a single framework for building the UIs for mobile and desktop applications. You create the UI using this framework (indicated by Arrow 1 in the following diagram), and .NET MAUI takes care of converting it to the appropriate platform (Arrow 2).

There might be times when you need to implement a platform-specific feature. In these situations, you can invoke methods in the platform-specific framework, as highlighted by Arrow 3 in the following diagram.

:::image type="content" source="../media/2-architecture.png" border="false" alt-text="Diagram of the .NET MAUI technology stack and how to implement a platform-specific feature.":::

## How does .NET MAUI work?

.NET MAUI abstracts a UI element's implementation from its logical description. You can describe the UI using XAML, a platform-neutral language based on XML. For example, the XAML following fragment shows the description of a button control:

```xml
<Button Text="Click me"
        SemanticProperties.Hint="Counts the number of times you click"
        Clicked="OnCounterClicked"
        HorizontalOptions="Center" />
```

This example defines the label for the button ("Click me"), and specifies that a method named `OnCounterClicked` should be run when the user selects the button. Other properties can modify the layout of the button and the text; in this example, the text is centered on the button. Semantic properties provide support for accessibility for users with visual impairment.

.NET MAUI always generates native code for the target device, so you get optimal performance. .NET MAUI uses "handlers" specific to each platform and UI element to carry out an operation. For example, if you target iOS for the app, a .NET MAUI handler will map this code to an iOS UIButton. If you run on Android, you'll get an Android AppCompatButton. These handlers are accessed indirectly through a control-specific interface provided by .NET MAUI, such as IButton for a button.

:::image type="content" source="../media/2-button-handler.png" border="false" alt-text="Diagram of how .NET MAUI maps a XAML control to a native control. It shows the .NET MAUI control implements an interface that each native handler also implements.":::

> [!NOTE]
> If you prefer, you can also create the UI dynamically using C# code. This approach enables you to modify the layout according to the environment. For example, you might not want certain controls to appear if the user doesn't have an appropriate authorization level.

.NET MAUI makes it easy to access common controls such as buttons. Other common controls—like text entry fields, labels, and date pickers—are just as easy. However, individual controls aren't enough to make a good platform for creating rich apps. .NET MAUI also provides:

- An elaborate layout engine for designing pages.
- Multiple page types for creating rich navigation types, like drawers.
- Support for data binding, for more elegant and maintainable development patterns.
- The ability to create custom handlers to enhance the way in which UI elements are presented.
- Access to native APIs directly and an abstraction of many common needs of mobile & desktop apps that are separate from the UI. The essentials library enables an app to access things like the GPS, the accelerometer, and the battery and network states. There are dozens of sensors and services common to mobile development also available through this library.

## Requirements for .NET MAUI development

To create .NET MAUI apps, you need to install [Visual Studio version 17.3](https://visualstudio.microsoft.com/vs/preview/) or newer with the following workload installed:

- .NET Multi-Platform App UI development

Additionally, if you want to build .NET MAUI Blazor apps, you must install the ASP.NET and web development workload. If you're developing on macOS, you'll need to install [Visual Studio for Mac Preview version 17.4](https://visualstudio.microsoft.com/vs/mac/preview).

:::image type="content" source="../media/2-visual-studio-workloads.png" alt-text="Screenshot of the Visual Studio installer showing the workloads required to support .NET MAUI development.":::
