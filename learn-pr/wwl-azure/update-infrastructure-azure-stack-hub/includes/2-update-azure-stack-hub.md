Full and express updates, hotfixes, as well as driver and firmware updates from the original equipment manufacturer (OEM) all help keep Azure Stack Hub up to date. This unit explains the different types of updates, when to expect their release, and where to find more about the current release.

You can't apply Azure Stack Hub update packages to the Azure Stack Development Kit (ASDK). The update packages are designed for integrated systems.

## Update package types

There are three types of update packages for integrated systems:

**Azure Stack Hub software updates**. Microsoft is responsible for the end-to-end servicing lifecycle for the Microsoft software update packages. These packages can include the latest Windows Server security updates, non-security updates, and Azure Stack Hub feature updates. You download theses update packages directly from Microsoft.

Each update package has a corresponding type: **Full** or **Express**.

 -  **Full** update packages update the physical host operating systems in the scale unit and require a larger maintenance window.
 -  **Express** update packages are scoped and don't update the underlying physical host operating systems.

**Azure Stack Hub hotfixes**. Microsoft provides hotfixes for Azure Stack Hub that address a specific issue that's often preventive or time-sensitive. Each hotfix is released with a corresponding Microsoft Knowledge Base article that details the issue, cause, and resolution. You download and install hotfixes just like the regular full update packages for Azure Stack Hub. Hotfixes are cumulative and can install in minutes.

When you update to a new major version (for example, 1.2002.x to 1.2005.x), the latest hotfixes (if any) in the new major version are installed automatically. From that point forward, if a hotfix is released for your build, you should install it.

**OEM hardware-vendor-provided updates**. Azure Stack Hub hardware partners are responsible for the end-to-end servicing lifecycle (including guidance) for the hardware-related firmware and driver update packages. In addition, Azure Stack Hub hardware partners own and maintain guidance for all software and hardware on the hardware lifecycle host. The OEM hardware vendor hosts these update packages on their own download site.

## When to update

The three types of updates are released with the following cadence:

 -  **Azure Stack Hub software updates**. Microsoft releases multiple full and express software update packages per year.
 -  **Azure Stack Hub hotfixes**. Hotfixes are time-sensitive releases that can be released at any time. If you are upgrading from one major version to another (for example, 1.2002.x to 1.2005.x), the latest hotfixes (if any) in the new major version are installed automatically.
 -  **OEM hardware vendor-provided updates**. OEM hardware vendors release their updates on an as-needed basis.

To continue to receive support, you must keep your Azure Stack Hub environment on a supported Azure Stack Hub software version.

## How to know an update is available

Notice of updates varies on a couple of factors, such as your connection to the internet and the type of update.

 -  **Microsoft software updates and hotfixes**

An update alert for Microsoft software updates and hotfixes will appear in the **Update** blade for Azure Stack Hub instances that are connected to the internet. If the **Update** blade isn't displayed, restart the infrastructure management controller virtual machine.

If your instance isn't connected and you would like to be notified about each hotfix release, subscribe to the RSS or ATOM feed.

 -  **OEM hardware vendor-provided updates**

OEM updates depend on your manufacturer. You'll need to establish a communication channel with your OEM so that you can be aware of updates from your OEM that need to be applied.

### Major version to major version

An update from major version to major version must be step by step: the current environment can only update to the next major version, and you can't skip a major version update.

### Hotfixes within major versions

Within the same major version number, Azure Stack Hub may release multiple hotfixes. Hotfixes are cumulative; the latest hotfix package includes all past hotfixes for that version.

## Update process

Once you know you have an update, apply it by using the following steps.

:::image type="content" source="../media/update-process-25642ea9.png" alt-text="Image showing normalized relational tables.":::


1.  **Plan for the update**

2.  **Upload and prepare the update package**

3.  **Apply the update**

## The update resource provider

Azure Stack Hub includes an update resource provider that handles the application of Microsoft software updates. This provider checks that updates are applied across all physical hosts, Service Fabric apps and runtimes, and all infrastructure virtual machines and their associated services.

As updates install, you can view high-level status as the update process targets the various subsystems in Azure Stack Hub (for example, physical hosts and infrastructure virtual machines).
