MSIX is a Windows app package format that provides a modern packaging experience to all Windows apps. The MSIX package format preserves the functionality of existing app packages and/or installs files in addition to enabling new, modern packaging and deployment features to Win32, WPF, and Windows Forms apps.

MSIX app attach is a way to deliver MSIX applications to both physical and virtual machines. However, MSIX app attach is different from regular MSIX because it's made especially for Azure Virtual Desktop. This unit will describe what MSIX app attach is and what it can do for you.

## Application delivery options in Azure Virtual Desktop

You can deliver apps in Azure Virtual Desktop through one of the following methods:

 -  Put apps in a master image.
 -  Use tools like SCCM or Intune for central management.
 -  Dynamic app provisioning (AppV, VMware AppVolumes, or Citrix AppLayering).
 -  Create custom tools or scripts using Microsoft and a third-party tool.

## What does MSIX app attach do?

In an Azure Virtual Desktop deployment, MSIX app attach can:

 -  Create separation between user data, the OS, and apps by using MSIX containers.
 -  Remove the need for repackaging when delivering applications dynamically.
 -  Reduce the time it takes for a user to sign in.
 -  Reduce infrastructure requirements and cost.
