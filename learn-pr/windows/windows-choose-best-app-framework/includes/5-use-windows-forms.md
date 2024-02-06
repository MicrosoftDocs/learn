Your company has another client that wants a simple Windows utility to read log files from their server-side application. The utility is used by their support team to troubleshoot issues with their application.

In this scenario, we discuss the requirements of the utility and decide which Windows UI framework is the best option for your development team.

In this unit, you learn the benefits and limitations the frameworks and how they may work with the requirements for the log reader application.

<!--![A picture visualizing a team selecting frameworks for a Windows utility app project.](../media/windows-utility-app-req.jpg)-->

## Building the log reader utility

The log reader application is a utility to be used by IT professionals. Some requirements to focus on for this application are:

- **Appearance and style of the application.** The client wants to focus on simplicity, ease of use, and performance. Style is not a key consideration.
- **Project timeline.** The timeline for this project is short, so choosing a framework that supports rapid development is important.
- **Deployment scenarios and options.** The application must be deployed via Windows Package Manager with WinGet scripting to internal workstations. It's deployed to enterprise customers on desktop PCs running Windows 10 and Windows 11.

Let's walk through all the decision criteria for this project and see how each framework can be used to meet those requirements.

## Analyzing the decision criteria

In this section, we're going to analyze the requirements for the log reader utility and see how each UI framework can be used to meet those requirements. We also look at the benefits and limitations of the frameworks and how they may affect the decision to use them for the project.

### Appearance and style of the application

Appearance isn't an important consideration for the project. The client isn't concerned with the appearance of the utility. Their primary concern is that it's responsive and fast and delivered on time. The timeline is short, so the team needs to be able to build the utility quickly. None of the frameworks have a significant advantage over the others in this area.

### Tablet usability (touch) and device compatibility

This utility must be deployed to Windows desktop PCs. It is used primarily with a keyboard and mouse. The client doesn't have any requirements for touch input. This application would seem to be a good fit for a rapidly developed Windows Forms project.

### Skillset of the team's enterprise developers

The development team is familiar with all three of the frameworks being considered for this project. The team has experience building applications with WPF, Windows Forms, and WinUI and is familiar with the latest versions of .NET and C#. The team has a track record of delivering simple and reliable Windows Forms applications to clients on short timelines. They're confident that they can deliver this utility on time using Windows Forms.

### Application performance and responsiveness

Overall performance is important with this utility. The application is used on a daily basis by the client's support team on typical Windows business workstations. There are no high-end graphics cards or other specialized hardware. The rendering capabilities of WPF and WinUI aren't needed for this project. Windows Forms user interface is rendered with Windows GDI. It must be fast and responsive on the client's desktop PCs. For all non-UI code, Windows Forms applications built on the latest version of .NET have the same benefits as .NET WPF applications. .NET 8 is the fastest version of .NET to date.

### Deployment scenarios and options

Windows Forms applications can be deployed to all currently supported versions of Windows. They can be deployed using Microsoft Store (with MSIX), ClickOnce, Windows Installer, or third-party installer solutions. However, all of the frameworks would meet the client's requirements for deployment.

## Choosing the framework

Windows Forms is the best choice for this project. The client doesn't have any specific requirements for the appearance and style of the application. They just want it to be simple, easy to use, and responsive. The client wants the utility to be deployed via a custom installer to their support team's desktop PCs running supported Windows versions.
