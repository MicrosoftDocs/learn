One of the consulting company's largest clients wants to build a line-of-business application for the healthcare industry. The application is used for mission-critical tasks in a hospital setting.

In this scenario, we discuss the requirements of the application and decide which Windows framework is the best option for the development team.

<!--![A picture visualizing a team selecting frameworks for a healthcare app project.](../media/windows-healthcare-app-req.jpg)-->

## Building the healthcare application

The healthcare application is an enterprise application that is intended to be deployed to healthcare professionals such as doctors, nurses, and administrators in hospitals. The key requirements to focus on for this application are:

- **Appearance and style of the application.** The application should incorporate each hospital's branding components such as color theme and logo.
- **Device compatibility.** Hospitals don't always have the latest hardware and software, so backward compatibility is important.
- **Application performance is key.** Hospitals are high-stress environments, so the application must be responsive and fast.

Let's walk through all the decision criteria for this project and see how each framework can be used to meet those requirements.

## Analyzing the decision criteria

In this section, we analyze the requirements for the healthcare application and see which framework can be used to meet those requirements. We also look at the benefits and limitations of each framework and how they may affect the decision to use them for this line-of-business application.

### Appearance and style of the application

The customer says it's not important for application to support the latest Fluent design system guidance. However, they would like to match the theme of the application to each hospital's branding. This style must be configurable without redistributing a custom version of the application. Both WPF and WinUI can meet their theming needs. Theming can also be accomplished in Windows Forms, but it's more difficult to implement and may require some third-party libraries. Because Fluent design isn't a requirement, the team isn't limited to selecting WinUI.

### Device compatibility

The healthcare clients that are using this application have a mix of device types. Most of the existing hospital workstations have Windows 10 desktop PCs. However, some healthcare professionals access the application on tablet PCs running the latest version of Windows. The application must be used with a keyboard and mouse, but it should also work well with touch input. The application should also be responsive and fast on all of these devices.

WPF appears to be the best fit for this requirement. WPF enables applications to detect and respond to touch by raising events when users touch the screen. It also has native support for the stylus. WPF applications can treat the stylus as a mouse by using the mouse API, but WPF also exposes a stylus device abstraction that uses a model similar to the keyboard and mouse.

Windows Forms applications are more difficult to use on a touch device. They can be used with a stylus, but it isn't as easy to use as WPF. WinUI is a good choice for touch devices, but it isn't available on every version of Windows 10. WinUI is only available on Windows 11 and Windows 10, version 1809 and later. The healthcare clients have an unknown mix of Windows 10 and Windows 11 devices, so WinUI isn't the best fit for this requirement.

### Skillset of the team's enterprise developers

The development team is familiar with all three frameworks being considered for this project. The team has experience building applications with WPF, Windows Forms, and WinUI and is familiar with the latest versions of .NET and C#. The developers are also familiar with XAML, so they can use the XAML designer or editor in Visual Studio to build the UI for the application.

### Application performance and responsiveness

This application is used in a hospital setting, which is a high-stress environment, so it's important that it's responsive and fast.

WPF is a good choice for this requirement. WPF applications built with .NET Framework aren't as performant as applications built with the latest versions of .NET. However, WPF applications built with .NET 8 are performant and responsive. WPF is a great choice for enterprise applications with multiple screens and complex data binding requirements. WPF also has a rich set of controls that can be used to build the application.

### Deployment scenarios and options

This application must be deployed via a custom installer. It's deployed to enterprise customers on desktop PCs running Windows 10 and Windows 11. The application should be easy to update with new features and bug fixes.

WPF and Windows Forms applications can be deployed using Microsoft Store (with MSIX), ClickOnce, Windows Installer, or third-party installer solutions. They can be deployed to all currently supported versions of Windows. WinUI applications can't be deployed to all versions of Windows 10. WinUI is only available on Windows 11 and Windows 10, version 1809 and later. WinUI applications can be deployed using Microsoft Store (with MSIX), ClickOnce, or third-party installer solutions.

## Choosing the framework

For this project, WPF is the best choice. WPF is a great choice for complex, enterprise applications with multiple screens and complex data binding requirements. WPF also has a rich set of controls that can be used to build the application. It supports their performance and deployment requirements as well.
