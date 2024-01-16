
An app that is written for a specific operating system may cause problems when you install it on a computer with a different operating system. Generally, apps and hardware that work on Windows 7 or 8.1 will continue to work on Windows 11 or later.

The few Windows apps that don't run in Windows 11 are primarily security-class apps (such as anti-virus protection) and apps that perform low-level kernel calls that bypass the standard Windows application-programming interface (API) and communicates with system hardware. Changes between 32-bit and 64-bit architectures and the deprecation and removal of some components that were available in earlier Windows versions from Windows 11 may also impact apps that were dependent on these features. Problems can also occur if a legacy app isn’t User Account Control (UAC)–aware, or if developers didn’t follow guidelines on how to develop Windows apps.

It's critical that you follow a set process for assessing and mitigating application compatibility issues. You must address application compatibility as an environment-wide approach rather than an unplanned activity. You can assess application compatibility with a measured and manageable process by following these steps:

1.  Discover the apps that you want to continue to use in the Windows 11 environment.
2.  Rationalize the apps to ensure that all discovered apps still fit into the organization’s app portfolio. If an app no longer has a practical use, you can remove it from the compatibility-assessment process.
3.  Prioritize apps. Organizations might have hundreds, or even thousands of apps. It's financially and operationally impossible to test such a multitude of apps; therefore, you must prioritize your apps and decide which ones to test.
4.  Test apps to ensure that the functionality that you require is available when the app runs in Windows 11 or later.
5.  Mitigate any issues that you discover, which might include using built-in operating system compatibility functionality, upgrading an app, or replacing the app with one that functions properly in Windows 11 or later.

Mitigating an application compatibility issue typically depends on various factors, such as the type of application and the current support for the application.

### Mitigation methods

Some common mitigation methods include:

 -  **Modifying the configuration of an existing app**. Compatibility issues can sometimes require modification of an app configuration, such as moving files to different folders, modifying registry entries, or changing file or folder permissions. Tools such as Compatibility Administrator can be used to detect and create app fixes, called shims, to address compatibility issues. You should contact software vendors for information about any other compatibility solutions.
 -  **Applying updates to an app**. Updates might be available to address many compatibility issues, and they help an app run better on Windows 11. After applying an update, other app tests can ensure mitigation of compatibility issues.
 -  **Upgrading an app to a compatible version**. If a newer, compatible version of an app exists, the best long-term mitigation is to upgrade to the newer version. By using this approach, you must consider both the cost of the upgrade and any potential problems that might arise from having two different versions of an app.
 -  **Modifying the security configuration**. If your compatibility issues appear to be permissions-related, a short-term solution is to modify the security configuration of an app. When you use this approach, you must conduct a full risk analysis and gain consensus from your organization’s security team regarding the modifications. For example, you can mitigate Internet Explorer Protected Mode by adding a site to the trusted site list.
 -  **Running an app in a virtualized environment**. If all other methods are unavailable, you can run an app in an older version of the Windows operating system by using virtualization tools such as client Hyper-V.
 -  **Using app compatibility features**. You can mitigate application issues such as operating system versioning by running an application in compatibility mode. You can access this mode by right-clicking the shortcut or .exe file and then selecting compatibility mode from the Compatibility tab.
 -  **Selecting another app that performs the same business function**. If another compatible app is available, consider switching to it. When using this approach, you must consider both the cost of the app and the cost of employee support and training.

When compatibility issues can’t be solved through updates or configuration, there are several options available to facilitate continued use of an application without blocking an upgrade.
