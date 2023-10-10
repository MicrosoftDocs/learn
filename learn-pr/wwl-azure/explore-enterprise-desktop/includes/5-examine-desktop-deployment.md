


Deployments comprise the activities that make a computer device available for use. The general deployment process consists of several interrelated activities, with transitions between the build and deployment phases.

The desktop deployment life cycle provides a framework for the tasks required to deploy a software application or operating system successfully. It would be best if you understood the lifecycle phases to properly plan for the resources and tools needed for effective implementation. The critical phases of the desktop deployment lifecycle are Building and Deploying.

### Building
The building phase allows you to improve efficiencies when developing a strategy for a base OS configuration. Its key steps include:

- **Streamlining the deployment process:** This step includes developing automated solutions and procedures that you can use for deployment.
- **Developing the deployment process:** Using traditional imaging may consist of a baseline OS image. Using newer features such as Windows Autopilot may involve creating a base device configuration.
- **Testing:** With a test system, you may identify and correct errors before deployment. Many IT professionals use Virtual machines to simulate deployment and validate configurations quickly and effectively; however, a testing plan should include testing deployments to physical devices before deployment.
- **Configuration:** This step includes developing an automation solution, testing and configuring standardized images or device configurations, accounting for IT labor to configure computers, and planning for network access configuration.
- **Managing the logistics:** This step includes storing computers, deploying and setting up physical hardware, and communicating to end users. This step can also include providing the hardware vendor with configuration requirements to be done by the vendor before shipping the device to the organization.

### Deployment
After you build and test your baseline OS, you can begin deploying them and ensure they're stable and usable. A typical deployment takes place in phases throughout the networking environment. The deployment team stabilizes each phase before progressing to performing upgrades or installations. You can use the early phases to validate scenarios such as device configuration profiles, image configurations, the end-user experience, application deployment success, and so forth.

### Enrollment
With enrollment, there’s no operating system deployment. The existing device becomes a recognized entity within the organization and can access resources. For devices that already have Windows 10 and later, modern methods don't require the OS to be redeployed to configure the device. Instead, the device is reconfigured to the organization’s requirements by enrolling the device and using Windows Autopilot.

You can also use enrollment for mobile devices and the support for bring-your-own-device (BYOD) scenarios. The scenarios supported can range from accessing e-mail utilizing the user’s personal device to deploying organizational applications and complete management of the device.

Each organizational group within each use-case scenario might have different requirements. You might have additional requirements for your use-case and sub-use-case scenarios and their associated organizational groups and mobile device platforms. You may define which devices you'll support and the minimum required configurations to access a resource. For example, your organizational device requirements might require devices to enroll with a more restrictive set of device settings, like a PIN of 6 characters or disabled cloud backup. BYOD scenarios may be less restrictive and allow a four-character PIN and cloud backup.

### Data Migration

Even with a successful deployment, data loss is almost always unacceptable. Many organizations are moving to cloud solutions, such as Microsoft 365 or OneDrive, to minimize or even eliminate the need for data migration. Organizations should ensure users are aware of and use the supported options. It would be best to consider scenarios where cloud solutions aren’t available or feasible. There are several solutions available that this course will cover, but it’s important to understand that data is a critical part of the process. When planning for data during a deployment, some best practices are:

- **Migrate essential data to a cloud or non-local solution before deployment:** It's generally easier and safer than continuing the risk and solving the problem after migration. Tools like Known Folder Move (KFM) can help seamlessly migrate local data to the cloud. When cloud solutions aren’t feasible, consider migrating data to network file shares or work folders. You can use features like *Enterprise State Roaming* to migrate common settings.
- **Use in-place upgrades when possible.** This process is the recommended practice for deploying upgrades. While re-imaging devices were historically recommended in the past, this is only the case today if there’s a scenario where in-place upgrades aren’t supported.
- **Use the User State Migration tool** The User State Migration Tool is used when local data or application settings migration is necessary. You can use User State Migration Tool (USMT) 10.0 to streamline and simplify user state migration during large deployments of Windows operating systems. USMT captures user accounts, user files, operating system settings, and application settings and migrates them to a new Windows installation. You can use USMT for both PC replacement and PC refresh migrations.

>[!Note]
>For more information, see Common migration scenarios. "https://learn.microsoft.com/windows/deployment/usmt/usmt-common-migration-scenarios"