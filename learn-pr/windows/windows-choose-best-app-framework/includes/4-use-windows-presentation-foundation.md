One of the consulting company's largest clients wants to build a complex, multi-window application for the healthcare industry. The application is used for mission-critical tasks in a hospital setting.

In this scenario, we discuss the requirements of the application and decide which native UI framework is the best option for the development team.

<!--![A picture visualizing a team selecting frameworks for a healthcare app project.](../media/windows-healthcare-app-req.jpg)-->

## Building the healthcare application

The healthcare application is an enterprise application that is intended to be deployed to healthcare professionals such as doctors, nurses, and administrators in hospitals. The key requirements to focus on for this application are:

- **Appearance and style of the application.** The application should incorporate each hospital's branding components such as color theme and logo.
- **Device compatibility.** Hospitals don't always have the latest hardware and software, so backward compatibility is important.
- **Application performance is key.** Hospitals are high-stress environments, so the application must be responsive and fast.
- **Modernize existing app.** The customer has a .NET Framework WPF application and wants to modernize and incorporate some of the existing screens and functionality in the new application over time.

Let's walk through all the decision criteria for this project and see how each framework can be used to meet those requirements.

## Analyzing the decision criteria

In this section, we analyze the requirements for the healthcare application and see which framework can be used to meet those requirements. We also look at the benefits and limitations of each framework and how they may affect the decision to use them for this line-of-business application.

### Appearance and style of the application

The customer says it's not important for the application to have the look and experience of modern in-box Windows apps. However, they would like to match the theme of the application to each hospital's branding. This style must be configurable without redistributing a custom version of the application. Both Windows Presentation Foundation (WPF) and WinUI can meet their theming needs. Theming can also be accomplished in Windows Forms, but it's more difficult to implement and may require some third-party libraries. Because the customer isn't concerned about creating a Windows in-box app experience, the team isn't limited to selecting WinUI.

### Device compatibility

The healthcare clients that are using this application have a mix of device types. Most of the existing hospital workstations have Windows 10 desktop PCs. However, some healthcare professionals access the application on tablet PCs running the latest version of Windows. The application must be used with a keyboard and mouse, but it should also work well with touch input. The application should also be responsive and fast on all of these devices.

WPF appears to be a good fit for this requirement. WPF enables applications to detect and respond to touch by raising events when users touch the screen. It also has native support for the stylus. WPF applications can treat the stylus as a mouse by using the mouse API, but WPF also exposes a stylus device abstraction that uses a model similar to the keyboard and mouse.

Windows Forms applications are more difficult to use on a touch device. They can be used with a stylus, but it isn't as easy to use as WPF. WinUI is a good choice for touch devices, but it isn't available on every version of Windows 10. WinUI apps can be deployed to Windows 11 and Windows 10, version 1809 and later. The healthcare clients have an unknown mix of Windows 10 and Windows 11 devices, so WinUI isn't the best fit for this requirement.

### Skillset of the team's enterprise developers

The development team is familiar with all three frameworks being considered for this project. The team has experience building applications with WPF, Windows Forms, and WinUI and is familiar with the latest versions of .NET and C#. The developers are also familiar with Extensible Application Markup Language (XAML), so they can use the XAML designer or editor in Visual Studio to build the UI for the application.

### Application performance and responsiveness

This application is used in a hospital setting, which is a high-stress environment, so it's important that it's responsive and fast.

WPF fits this requirement. Applications built with WPF and .NET are performant and responsive. It's a good option for enterprise applications with multiple screens and complex data binding requirements. WPF also has a rich set of controls that can be used to build the application.

### Deployment scenarios and options

This application must be deployed via a custom installer to enterprise customers on desktop PCs running Windows 10 and Windows 11. The application should be easy to update with new features and bug fixes.

WPF and Windows Forms applications can be deployed using Microsoft Store (with MSIX), ClickOnce, Windows Installer, or third-party installer solutions. They can be deployed to all currently supported versions of Windows. WinUI applications can't be deployed to all versions of Windows 10. WinUI is available on Windows 11 and Windows 10, version 1809 and later. WinUI applications can be deployed using Microsoft Store (with MSIX), ClickOnce, or third-party installer solutions.

### Modernizing existing WPF application

The customer has an existing WPF application and has the .NET Framework source code for the app. They plan to modernize and incorporate some of the existing screens and functionality in the new application over time. WPF is the best choice for this requirement. The team can use the .NET Upgrade Assistant to upgrade the exising .NET Framework codebase to a modern .NET solution and import the necessary components into the new WPF application.

## Choosing the framework

For this project, WPF is a great choice. WPF fits the bill for building enterprise applications with multiple screens and complex data binding requirements. WPF also has a rich set of controls that can be used to build the application. Additionally, Microsoft is refreshing WPF with new Windows 11 theming for .NET 9. They continue to invest in WPF as one of the preferred native UI platforms on Windows. This theming update is currently in preview. WPF can also support the customer's performance and deployment requirements.
