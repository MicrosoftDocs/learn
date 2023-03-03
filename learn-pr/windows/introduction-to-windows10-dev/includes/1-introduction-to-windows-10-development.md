Windows 10 is used on millions of desktop, laptop, and tablet computers worldwide. All these devices run apps that developers created with the same tools and frameworks. In this module, you'll learn about the various options for creating Windows 10 apps, their relative strengths, and the tools required to use them. By the time you finish, you'll be ready to start writing your own apps.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2MpwX]

## Windows 10 apps

Windows 10 can run all kinds of apps, including games, enterprise applications, utilities, mixed reality experiences, and word processors. You name it, Windows can run it. With so many possibilities, it can be a little overwhelming to know where to start.

That's where this module comes in. It will help set the scene and get you comfortable with the tools and platforms at your disposal. You won't be an expert at the end, but you'll at least have an idea about your next steps.

![Screenshot showing three different Windows devices.](../media/windows-devices.png)

## Windows development tools and platforms

Most developers who write software for Windows use Visual Studio, the development environment that supports code editing, designing, building and debugging. Visual Studio is your toolbox, and where you'll spend your time honing your apps. But you can't create anything with Visual Studio alone, so you'll need to make use of software development kits (SDKs) and platforms such as .NET to make a working app.

As needs and technologies change over the years, a variety of platforms and frameworks have been created to help developers write apps. Different types of application use different tools, and different developers prefer some tools over others. There is no "one size fits all" rule. In this module, we explain your choices and then walk you through building an app using some popular options.

## Advice on selecting a platform

Which development platform should you use? Well, that's really up to you. You may already have written an app by using Windows Presentation Foundation (WPF), in which case you'll probably want to continue using it. You can add features to WPF that are available from the Universal Windows Platform (UWP). If you're starting a new project from scratch, using UWP is an attractive option. With UWP you get immediate access to the latest Fluent Design System components for making modern user interfaces.

This module discusses UWP, WPF, and Windows Forms examples, but other platforms, such as [Progressive Web Apps](/microsoft-edge/progressive-web-apps-chromium/how-to/) (PWAs), are available as well.

## Common terms you will see

### C#

C# is a programming language, perhaps the most popular for developing Windows apps. C# is a modern language with sophisticated features, but it's still easy enough for a beginner to pick up quickly. You can also use other languages, such as Visual Basic, C++ (and WinRT/C++), F#, and JavaScript. C# looks something like this:

```csharp
void Hello()
{
    Console.WriteLine("Hello, World!");
}
```

If you are completely new to C#, here's a [C# Guide](/dotnet/csharp/) you will find useful.

### XAML

XAML is a markup language that's used to define user interfaces. Several Windows development platforms use XAML, and so there are variations in exact syntax and capabilities. XAML can be entered manually or generated automatically by tools such as the Visual Studio designer or the Blend editor. You'll see a lot of XAML if you develop with UWP or WPF. XAML looks like a typical XML-based markup language. For example:

```XAML
<Button Context="click me" />
```

### .NET

.NET is a free, cross-platform, open source developer platform for building many different types of applications. With .NET, you can use multiple languages, editors, and libraries to build for web, mobile, desktop, gaming, and the Internet of Things (IoT). .NET Standard is a base set of application programming interfaces (APIs) that are common to all .NET implementations. Bottom line: .NET is a collection of very useful, proven, high-quality features that make your code easier to write and more reliable.

When you write a Windows Form or WPF app, you're using .NET.

> [!NOTE]
> UWP has its own similar features but doesn't use .NET by default.

### GitHub

[GitHub](https://www.github.com) is a website and service that can act as a storage place for source code, individual and shared projects, and other forms of content. In practical terms, you can save your projects to GitHub and share them with other developers (a very common scenario with open source projects), or search it for code and tools that will help you. It uses the tool [Git](https://git-scm.com) to manage submissions and deal with changes from multiple developers.

### Windows Template Studio

[Windows Template Studio](https://marketplace.visualstudio.com/items?itemName=WASTeamAccount.WindowsTemplateStudio) is a Visual Studio extension that accelerates the creation of new UWP apps by using a wizard-based experience. The resulting UWP project is well-formed, readable code that incorporates Windows 10 features while implementing proven patterns and best practices. WTS is an [open source project on GitHub](https://aka.ms/wts).

### Windows Community Toolkit

The [Windows Community Toolkit](https://github.com/windows-toolkit/WindowsCommunityToolkit) is a collection of helper functions, custom controls, and app services. It simplifies and demonstrates common developer tasks that build UWP apps for Windows 10 and [ships through NuGet](https://www.nuget.org/profiles/Microsoft.Toolkit) for easy consumption by developers.
