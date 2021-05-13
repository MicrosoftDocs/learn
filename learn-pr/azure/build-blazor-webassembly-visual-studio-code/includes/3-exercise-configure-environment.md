In this exercise, you'll install the tools and components needed to build a Blazor app locally using **Visual Studio Code** application.

This exercise assumes you've already installed Visual Studio Code. You can download Visual Studio Code for free for Windows, macOS, or Linux from https://code.visualstudio.com/.

## Install tools and templates

Start by downloading the Microsoft .NET 5 SDK. It includes the .NET Core SDK, the .NET Core runtime, and the ASP.NET Core runtime.

Install .NET 5 by downloading the latest version for your operating system from https://dotnet.microsoft.com/download/dotnet/5.0.

## Install Visual Studio Code extensions

To develop Blazor apps, install the Microsoft C# Visual Studio Code extension.

### Install the C# for Visual Studio Code extension

1. Open Visual Studio Code on your local machine.

1. Open the extensions browser by selecting the **Extensions** symbol on the leftmost pane. Or in Windows, select <kbd>Ctrl+Shift+X</kbd>.

1. Search for "C# for Visual Studio Code".

1. Install the **C# for Visual Studio Code (powered by OmniSharp)** extension by selecting **Install**.

## Create a new Blazor app

To validate your setup, make a new Blazor WebAssembly client web app that uses the installed template.

1. Open a terminal or Command Prompt window on your local development machine.

1. At the command prompt, enter **dotnet new blazorserver -o BlazorApp --no-https**.

1. Go to the BlazorApp subfolder.

## Run the app

1. At the command prompt, enter **dotnet watch run** to run the app.  This will build and start the app, and then rebuild and restart the app whenever you make code changes.  The browser should automatically open at the address https://localhost:5000.

    ![Screenshot showing the default Blazor WebAssembly client app running in a browser](../media/hello-blazor.png)

1. When you're ready to stop, return to the terminal in Visual Studio code, and press <kbd>Ctrl+C</kbd> to stop the app.

You'll use this Blazor app in the following exercises.
