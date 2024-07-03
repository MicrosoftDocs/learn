Domain controllers authenticate all users and computers in a domain. Therefore, it's critical to ensure the optimal number and placement of domain controllers in any Active Directory Domain Services (AD DS) environment, especially in larger, distributed environments such as the one that Contoso is transitioning to.

## Deploy AD DS domain controllers in an on-premises environment

The domain controller deployment process has two steps. First, you install the binaries necessary to implement the domain controller role. For this purpose, you can use Windows Admin Center or Server Manager. At the end of the initial installation process, you have installed the AD DS files, but not yet configured AD DS on the server. The second step is to configure AD DS role. The simplest way to perform this configuration is by using the **Active Directory Domain Services Configuration Wizard**. You start the wizard by selecting the AD DS link in Server Manager.

As part of AD DS role configuration, you need to provide answers to the questions in the following table:

| **Question**                                                                                            | **Comments**                                                                                                                                                                                                           |
| ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Are you installing a new forest, a new tree, or an additional domain controller for an existing domain? | Answering this question determines what additional information you might need, such as the parent domain name.                                                                                                         |
| What is the Domain Name System (DNS) name for the AD DS domain?                                         | When you create the first domain controller for a domain, you must specify the fully qualified domain name (FQDN). When you add a domain controller to an existing domain or forest, you use the existing domain name. |
| Which level will you choose for the forest functional level?                                            | The forest functional level determines the available forest features and the supported domain controller operating system (OS). This also sets the minimum domain functional level for the domains in the forest.      |
| Which level will you choose for the domain functional level?                                            | The domain functional level determines the domain features that will be available and the supported domain controller operating systems.                                                                               |
| Will the domain controller be a DNS server?                                                             | You can install the DNS role as part of the domain controller deployment.                                                                                                                                              |
| Will the domain controller host the global catalog?                                                     | This option is selected by default.                                                                                                                                                                                    |
| Will the domain controller be a read-only domain controller (RODC)?                                     | This option is not available for the first domain controller in a forest.                                                                                                                                              |
| What will be the Directory Services Restore Mode (DSRM) password?                                       | This is necessary for restoring AD DS database objects from a backup.                                                                                                                                                  |
| What is the NetBIOS name for the AD DS domain?                                                          | When you create the first domain controller for a domain, you must specify the NetBIOS name for the domain.                                                                                                            |
| Where will the database, log files and SYSVOL folders be created?                                       | By default, the database and log files folder is located at **C:\\Windows\\NTDS**. By default, the SYSVOL folder is located at **C:\\Windows\\SYSVOL**.                                                                |

:::image type="content" source="../media/deployment-configuration-dfd90c9e.png" alt-text="A screenshot of the Active Directory Domain Services Configuration Wizard Deployment Configuration page is set to add a domain controller to an existing domain.":::


### Install a domain controller on a Server Core installation of Windows Server

A Windows Server computer that is running a Server Core installation doesn't have the Server Manager graphical user interface (GUI). Therefore, you must use alternative methods to install the files for the domain controller role, and to install the domain controller role itself. You can use Windows Admin Center, Server Manager, Windows PowerShell, or Remote Server Administration Tools (RSAT) installed on any supported version of Windows Server that has the **Desktop Experience** feature, or any supported Windows client such as Windows 10.

### Install a domain controller from media

If you have a network connection between sites that is slow, unreliable, or costly, you might find it beneficial to add another domain controller at a remote location or branch office. In this scenario, to significantly reduce the amount of traffic moving over the wide area network (WAN) link, you can create an AD DS backup (perhaps to a USB drive) and take this backup to the remote location. When you're at the remote location and run Server Manager to install AD DS, you can select the **Install from media** option. Most of the copying occurs locally. In this scenario, the WAN link transfers only security-related traffic and AD DS changes following the backup. The WAN link also helps ensure that the new domain controller receives any changes made to the central AD DS after you created the Install from media backup.

### Branch office considerations

When you deploy a domain controller in a branch office that can't guarantee physical security, you can use additional measures to reduce the impact of a security breach. One option is to deploy an RODC. The RODC contains a read-only copy of the AD DS database, and by default, it doesn't cache any user passwords. However, you can configure the RODC to cache the passwords for users in the branch office. If an RODC is compromised, the potential loss of information risk is much lower than with a full read/write domain controller.

## Upgrade domain controllers from the previous version

The process for upgrading a domain controller is the same for any version of Windows Server starting with Windows Server 2012 R2 through Windows Server 2022. You can upgrade to a Windows Server 2022 domain using either of the following methods:

 -  Upgrade the OS on existing domain controllers that are running Windows Server 2012 R2 or later.
 -  Add servers running Windows Server 2022 as domain controllers in a domain that already has domain controllers running earlier Windows Server versions.

We recommend the latter method, because when you finish you'll have a clean installation of both the Windows Server 2022 OS and the AD DS database. Whenever you add a new domain controller, Windows Server automatically updates the domain DNS records so clients will be able to locate and use this domain controller.
