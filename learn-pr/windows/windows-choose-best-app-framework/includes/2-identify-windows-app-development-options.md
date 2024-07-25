In the software consulting firm scenario, you must choose the best UI framework for each upcoming project. You have multiple options for building native Windows applications. Each option has its own strengths and benefits. This unit describes the options for building a native Windows application and discusses how to choose the best option based on your needs.

Windows offers exciting and diverse choices for creating native applications. Each UI framework that Microsoft provides has its own advantages and features. You may be familiar with Windows Presentation Foundation (WPF) and Windows Forms, which are popular .NET frameworks for building powerful desktop applications. The latest option for Windows developers is WinUI and the Windows App SDK, which enable you to create beautiful, native Windows apps with high performance and modern experiences.

![A picture visualizing Windows UI framework options for developers.](../media/windows-development-options.jpg)

## WPF applications

WPF is an Extensible Application Markup Language (XAML)-based UI framework that is built to take advantage of modern graphics hardware. WPF provides a comprehensive set of features: controls, data binding, layout, graphics & animation, styles, templates, documents, media, and typography. WPF is part of .NET, so you can build applications that incorporate other elements of the .NET API. While .NET is cross-platform, WPF is specific to Windows.

WPF is an industry-proven framework for building enterprise applications. It has an extensive ecosystem of third-party libraries and controls. WPF is a great choice for building desktop applications that require a high degree of customization, rich functionality, and the high performance of a native Windows application. It joins WinUI as one of the two recommended native UI platforms for developers.

Users interact with WPF applications through windows, and its windowing system is advanced. WPF windows can be modal or modeless, and can be hosted in other applications. WPF also supports multiple windows. There are third-party libraries that enable you to incorporate various design options and advanced controls into your WPF applications. WPF apps can be distributed through the Microsoft Store, installed via stand-alone packages, or deployed with enterprise software management systems.

![A picture visualizing WPF application development.](../media/create-windows-presentation-foundation-app.jpg)

## Windows Forms applications

Windows Forms is a UI framework that creates rich desktop client apps for Windows. The Windows Forms development platform supports a broad set of app development features: controls, graphics, data binding, and user input. Windows Forms features a drag-and-drop visual designer in Visual Studio to quickly and easily create Windows Forms apps.

Windows Forms is part of .NET, so you can build applications that incorporate other elements of the .NET API. While .NET is cross-platform, the Windows Forms framework, like WPF, is a native Windows UI framework. Windows Forms is a good choice for building desktop applications that require a high degree of customization, rich functionality, and the high performance of a native Windows application built on the modern .NET stack.

Windows Forms is still used to create system utility apps or line-of-business applications. Windows Forms is a mature framework that has a large ecosystem of third-party libraries and controls. Unlike XAML-based UI frameworks, Windows Forms isn't well-suited for apps that require animations or rich graphics. Like WPF apps, Windows Forms applications can be distributed through the Microsoft Store, installed via stand-alone packages, or deployed with enterprise software management systems.

![A picture visualizing Windows Forms application development.](../media/create-windows-forms-app.jpg)

## WinUI applications with Windows App SDK

WinUI is the native UI platform component that ships with the Windows App SDK. Unlike its predecessor the Universal Windows Platform (UWP), Windows App SDK APIs are decoupled from the Windows Software Development Kits (SDKs). The Windows App SDK provides a set of APIs and tools that are used to create desktop apps for Windows. The Windows App SDK can be used to create applications on Windows 11 and downlevel to Windows 10, version 1809.

> [!NOTE]
> Windows App SDK use is not limited to WinUI projects. You can leverage the Windows App SDK and its APIs when creatings apps with WinUI, WPF, or Windows Forms. Learn how to use the Windows App SDK in an existing project [here](/windows/apps/windows-app-sdk/use-windows-app-sdk-in-existing-project).

WinUI apps offer a modern UI design, providing the look-and-feel in-box Windows apps with the same great usability. WinUI apps can be written in C# or C++. The XAML UI framework feels familiar to Windows developers who are experienced in WPF development. It's the best choice for native app development if the current feature set meets your requirements, and the ongoing development efforts in the framework regularly provide new features and functionality. Microsoft is accelerating the adoption of WinUI and the Windows App SDK in its own Windows apps including Photos, File Explorer, Dev Home, PowerToys, Phone Link, and others. WinUI is currently positioned as the framework of choice for teams that want to build first-class Windows applications.

Modern Windows design principles aren't just a set of styles and themes. They also include accessibility and the overall user experience when interacting with applications. WinUI embodies all that. The upcoming version of in .NET 9 WPF will have a modern Windows style, but it won't go all the way if the best overall user experience is a requirement.

WinUI applications can be distributed through the Microsoft Store, installed via stand-alone packages, or deployed with enterprise software management systems.

![A picture visualizing WinUI application development.](../media/create-windows-ui-app.jpg)
