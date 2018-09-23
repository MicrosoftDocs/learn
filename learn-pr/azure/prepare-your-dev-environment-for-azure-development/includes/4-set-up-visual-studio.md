Visual Studio is a full featured integrated development environment (IDE) for a wide range of programming application types and languages. Visual Studio has a full set of tools and features specifically aimed at developing applications with Microsoft Azure. This means that Azure development, debugging, and deployment tools are tightly integrated with the IDE.

## Visual Studio 2017

Visual Studio 2017 is a fully featured IDE used to develop applications for a wide range of application types in including Windows, Android, iOS, web, and Azure.

When installing Visual Studio, you'll see that several *workloads* are available. Workloads are collections of libraries and components that define an area of functionality that can be installed. Instead of installing an individual component where you must know and remember the dependencies between each, you can use workloads to do "themed" installations. This ensures that all necessary components are included.

The base installation of Visual Studio comes with no tools or libraries for Azure development. For that, you'll need to include the Azure development workload which includes the Azure SDKs, tooling, and template projects.

To install Visual Studio, [download the installer](https://visualstudio.microsoft.com/). The installer will ask which workloads to install; you'll specify the Azure development workload. If additional functionality is needed, this is typically added via NuGet packages or Visual Studio extension.

## Visual Studio for Mac

Visual Studio for Mac is a natively designed and developed IDE for macOS. It lets you build solutions for mobile apps on Android and iOS, the web, and .NET Core.

The base installation of Visual Studio for Mac comes with contextual integration of Azure tooling. For example, if you are building a Xamarin app for Android, then the included Connected Services template will provide a link to create a mobile back end with Azure App Service. If you want to create an Azure function, there is a project template under the Cloud category.

If you require tools for Azure features and functions that aren't in the base installation, you'll likely need to add NuGet package or a Visual Studio for Mac extension.

To install Visual Studio for Mac, [download the installer](https://visualstudio.microsoft.com/). The installer will inspect your system to determine what components are needed or need to be updated.

> [!NOTE]
> You may be prompted for administrator credentials on your machine to install certain components.