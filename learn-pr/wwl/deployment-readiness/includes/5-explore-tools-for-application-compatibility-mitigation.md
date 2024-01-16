
#### The following sections introduce the tools that can be used to mitigate application compatibility issues.

#### Application Compatibility Toolkit

Application Compatibility Toolkit (ACT) is a set of tools used during the application compatibility testing process's inventory, analysis, and mitigation phases. ACT consists of several features, including:

 -  A database of known application issues and mitigations for those issues.
 -  The Compatibility Administrator tool that can be used to create fixes for your applications to enable them to run correctly.
 -  A setup analysis tool that helps identify problems with application setup.
 -  The Standard User Analyzer that can identify issues with UAC restrictions that might affect your application’s functionality.

ACT can diagnose application compatibility issues in Windows. ACT can also solve application compatibility problems depending on the type of incompatibility issues you encounter. One of the most significant benefits of ACT is that it can provide a solution that requires no significant change to the users’ operating environment. ACT mitigates compatibility issues by attaching shims to apps. Shims redirect calls from apps to the appropriate location in Windows. They also simulate the operating system components the app is attempting to access. These fixes can be applied as part of an application’s deployment.

#### Client Hyper-V

Client Hyper-V enables you to provide a local, virtualized environment in which previous versions of Windows can run on virtual machines. This environment enables you to run incompatible apps on supported versions of Windows while maintaining Windows 10 or Windows 11 as the main operating system and using only local resources.

When choosing Client Hyper-V to mitigate potential compatibility issues, the client hardware should be considered. You must have a computer with a 64-bit processor capable of Second-level Address Translation (SLAT) to run Client Hyper-V in Windows. Because an additional OS is running, you must ensure the client has sufficient processor, memory, and disk space to support this method.

#### Remote Desktop Services (RDS)

RDS allows you to connect to a remote computer to use the computer’s resources and applications. You can set up an RDS Server Host running a version of the operating system that is compatible with specific applications. You can also allow users to connect remotely to the computer to use specific applications. You also can use Windows Server 2016 RemoteApp to provide the same functionality, except that RemoteApp runs the application inside its own window within the user’s desktop.

#### Windows 365 and Azure Virtual Desktop

The Azure Virtual Desktop and Windows 365 solutions combine RDS and Hyper-V virtualization technology to provide a more personalized and compartmentalized user experience. Instead of the client running the compatible OS in Hyper-V, Azure hosts the necessary OS. This allows administrators to implement and manage virtual machines more easily without relying on either client hardware to support running an additional OS or dependencies on the application being compatible with a server OS as RDS requires.

You can create desktop collections, which are pooled collections that users share, or dedicated personal virtual machines that you can maintain and manage similarly to physical devices.