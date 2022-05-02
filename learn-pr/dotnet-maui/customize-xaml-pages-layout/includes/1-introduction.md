.NET MAUI layout panels help you create consistent user interfaces for your application across a wide range of devices.

Suppose you're building a tip calculator application that you plan to deploy on many computers and devices. Each device could have a different screen size and pixel density. Your goal is to make the application look as similar as possible on all devices. You'd like to avoid manual calculation of view size and position for each screen size. .NET MAUI includes a layout management system that does these calculations for you. You put your views inside layout panels that automatically manage the size and position of their child views. The panels make it much easier to create consistent user interfaces across different devices.

In this module, you'll build a .NET MAUI application that looks similar across different devices. You'll start by setting the preferred size and position of a view. Then you'll arrange views vertically using a StackLayout. Next, you place views into rows and columns using a `Grid`. By the end of the module, you'll have a .NET MAUI application that looks consistent on every device type and screen size.

> [!NOTE]
>This module requires [Visual Studio 2022](https://visualstudio.microsoft.com/vs/). You can use either Windows or a Mac:
>
> - **Windows:** Make sure you have the **Mobile development with .NET** workload installed in Visual Studio 2022 for Windows, together with the MAUI templates. Refer to the [documentation](/visualstudio/install/modify-visual-studio) if you need to add it to your installation.
> - **macOS:** The standard Visual Studio 2022 for Mac installation includes everything you need to build mobile apps with .NET MAUI.

## Learning objectives

In this module, you will:

- Arrange user interface elements in an app and size them
- Display views in a vertical or horizontal list using `StackLayout`
- Display views in rows and columns using Grid

## Prerequisites

- Visual Studio 2022 with the MAUI workload installed
- Familiarity with C# and .NET
