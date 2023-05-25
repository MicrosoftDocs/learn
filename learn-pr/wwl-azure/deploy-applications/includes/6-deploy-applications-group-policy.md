

Windows Server 2022 and later includes a feature called Software Installation and Maintenance that Active Directory Domain Services (AD DS), Group Policy, and the Windows Installer service use to install, maintain, and remove software from your organization’s computers.

#### Use Group Policy to manage the software lifecycle

The software lifecycle consists of four phases: preparation, deployment, maintenance, and removal.

:::image type="content" source="../media/deployment-lifecycle-edc0b417.png" alt-text="Diagram showing the four software lifecycle phases.":::


You can use Group Policy to manage all phases except the preparation. You can apply Group Policy settings to users or computers in a site, domain, or organizational unit (OU) to install, upgrade, or remove software automatically.

By applying Group Policy settings to software, you can manage the phases of software deployment without deploying software on each computer individually.

Using Group Policy to manage the software lifecycle has some advantages and some disadvantages that are important to consider. The advantages of using Group Policy to manage the software lifecycle are:

 -  **Group Policy software distribution is available as part of Group Policy and AD DS**. Thus, using Group Policy doesn't incur any extra costs for your organization, and is always available to implement because it’s already installed and ready for use.
 -  **Group Policy software distribution does not require client software, agent software, or additional management software**. IT administrators can use familiar tools to manage the software lifecycle.
 -  **Group Policy software distribution is quick and easy to use**. This allows for both faster software distribution and reduced IT training costs.

The disadvantages of using Group Policy to manage the software lifecycle are:

 -  **Group Policy software distribution has a minimal feature set**. This minimal feature set limits the ability to control aspects of the distribution such as the day and time of installation, the order of installation when deploying multiple applications, and the reboot process, such as reboot suppression or reboot windows.
 -  **Group Policy software distribution does not have any reporting**. Thus, you can't easily gather information such as how many computers have the distributed software, which computers an installation failed on, or which computers don't have the distributed software. This could lead to a scenario in which you deploy an update to an application and the update attempts to install on computers that no longer have the application to be updated.
 -  **Group Policy software distribution is limited to deployment of Windows Installer packages**. IT administrators have to convert non-MSI installation programs into MSI packages before being able to deploy the software by using Group Policy.

For larger organizations, especially organizations that have more than 500 computers, and for any organizations with specific software distribution requirements, Configuration Manager provides enterprise-level features and control. These enterprise-level features and control eliminate the disadvantages found in Group Policy software distribution.

#### How Windows Installer enhances software distribution

To enable Group Policy to deploy and manage software, Windows Server 2022 or later uses the Windows Installer service. This component automates the installation and removal of applications by applying a set of centrally defined setup rules during the installation process. The Windows Installer service installs the `.msi` package files. `.msi` files contain a database that stores all the instructions required to install the application. Small applications may be entirely stored as `.msi` files, whereas other larger applications will have many associated source files that the MSI references. Many software vendors provide `.msi` files for their applications.

The Windows Installer service has the following characteristics:

 -  This service runs with elevated privileges, so that the Windows Installer service can install software regardless of which user is signed into the system. Users only require read access to the software distribution point.
 -  Applications are resilient. If an application becomes corrupted, the installer will detect and reinstall or repair the application.
 -  Windows Installer can't install `.exe` files. To distribute a software package that installs with an `.exe` file, you must convert the `.exe` file must to an `.msi` file by using a third-party utility.

#### Manage software upgrades by using Group Policy

Software vendors occasionally release software updates. These usually address minor issues, such as a performance update or a feature enhancement that doesn't warrant a complete application reinstallation. Microsoft releases some software patches as .msp files. Major updates that provide new functionality require users to upgrade a software package to a newer version. You can open the GPO that deploys a software package, modify the software installation settings, and then use the Upgrades tab to upgrade a package. When you perform upgrades by using Group Policy, you’ll notice the following characteristics:

 -  You can redeploy a package if the original Windows Installer file has been modified.
 -  Upgrades will often remove the old version of an application and install a newer version. These upgrades usually maintain application settings.
 -  You can remove software packages if they were delivered originally by using Group Policy. This is useful if you’re replacing a line-of-business (LOB) application with a different application. Removal can be mandatory or optional.
