Organizations must choose to balance the needs of their customers with the skills of their developers. In this unit, you learn how to analyze the decision criteria for a project to choose the best UI framework for a native Windows development project.

The consulting company has customers that want to build native Windows applications. The company needs to choose the best UI framework for each project. The company has a team of developers that are experienced in .NET, C#, and Extensible Application Markup Language (XAML). The company wants to use the skills of the existing development team to build the applications. Each project has unique requirements, so the company needs to choose the best UI framework for each project.

- A complex, line-of-business application with multiple windows that is deployed via a custom installer to enterprise customers in the healthcare industry.
- A log reader utility that is deployed via Windows Package Manager with WinGet scripting to enterprise customers.
- A file sync application that is deployed to the Microsoft Store for personal or business use.

In this unit, you learn the common factors that influence the decision of which UI framework to use for a native Windows development project:

- Appearance, style, and usability of the application
- Tablet usability (touch), device compatibility, and CPU architecture
- Skillset of the team's enterprise developers
- Application performance and responsiveness
- Deployment scenarios and options

![A picture visualizing a team selecting frameworks for three projects.](../media/windows-frameworks-for-projects.jpg)

## Healthcare line-of-business application

The line-of-business application is an enterprise application that can be deployed to enterprise customers in the healthcare industry. It's targeting healthcare professionals, who use it to manage patient records. The client wants the application to be deployed with a custom installer. Their enterprise customers have desktop PCs running Windows 10 and Windows 11 in a hospital setting. These facilities can be slow to adopt the latest hardware and software. Healthcare professionals use it primarily with a mouse and keyboard. Hospitals are typically a high-stress environment, so the app should be responsive and fast. The application should be easy to update with new features and bug fixes. It isn't important that the application have the look and feel of Windows 11 apps. However, the client would like to match the theme of the application to each hospital's branding.

The customer also has an existing WPF application, and they have the .NET Framework source code for the app. They plan to modernize and incorporate some of the existing screens and functionality in the new application over time.

## Log reader utility

The log reader utility is a simple application that must be deployed via Windows Package Manager with WinGet scripting to enterprise customers. IT professionals use it to read log files retrieved from customers in the field. The application is deployed to enterprise customers on desktop PCs running Windows 10 and Windows 11. It's primarily used with a keyboard and mouse by IT professionals with varying levels of experience. The application should be easy to update with new features and bug fixes, but updates aren't expected to be frequent. The appearance of this application isn't the primary concern of the customer. The customer wants to focus on simplicity, ease of use, and performance. The timeline for this project is short, so the company wants to use the skills of the existing development team to build the application to maximize the team's productivity. This utility won't be ported to other platforms in the future.

## Cloud-based file sync application

The cloud-based file sync application is a consumer-facing application that is available in the Microsoft Store. Consumers use this type of software to back up and synchronize their local Windows files to a cloud service. The application must be available for the latest Windows devices, including desktops and tablet PCs with x86, x64, or Arm64 processors. It should work well with pen and touch input. The application itself is free with optional in-app purchases for cloud storage subscriptions. It should be easy to update with new features and bug fixes. The client wants the application to have the look and experience of the latest in-box Windows apps. Performance is an important consideration for the file sync app. The app should be responsive and fast with great usability. It must be able to view photos and play media files, using the rendering power of modern GPUs. The company wants to take advantage of the performance of the latest versions of .NET. The application should also be able to incorporate the latest Windows features, including the latest Windows APIs.

The leadership team wants to use the skills of their top development team to build the file sync app to maximize the team's productivity. The company may decide to port the app to other platforms in the future. So, the code should be easy to port to a framework that supports iOS, Android, and macOS.

Let's continue by discussing which framework is the best fit for each of our projects. In the next unit, we start with the enterprise healthcare application.
