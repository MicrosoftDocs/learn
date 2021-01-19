
Contoso IT infrastructure staff are migrating Contoso on-premises servers to Windows Server 2019. As lead Windows Server admin, one of the first decisions you must make is whether to perform in-place upgrades for existing servers. The alternative is to migrate workloads to newly deployed Windows Server 2019 server computers.

## What is an in-place upgrade?

An upgrade preserves the files, settings, and applications that are installed on the original server. You perform an upgrade when you want to keep all these items and want to continue using the same server hardware.

An in-place upgrade involves upgrading a Windows Server operating system on the server that is running an earlier Windows Server edition.

A benefit of an in-place upgrade is that you avoid hardware expenses because you install Windows Server 2019 on the existing hardware. Another benefit is that files, settings, and programs are kept intact on the server.  

The following table describes scenarios in which you would choose an in-place upgrade of the Windows Server operating system.

| Scenario                                                     | Explanation                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Hardware configuration of existing servers meets  requirements for Windows Server 2019 | Because the hardware requirements for Windows Server 2019 do not differ significantly from those for Windows Server 2016, you can  perform an in-place upgrade on those servers. |
| Software products that run on existing servers support in-place upgrade of Windows Server 2019 | Before performing an in-place upgrade, you must list all of the software products that are running on the server, such as SQL Server, Exchange Server, non-Microsoft software, and antivirus software. Next, verify that these products support an in-place upgrade of Windows Server 2019. |
| You want to keep all user data on the existing servers and security permissions for accessing that data | When performing an in-place upgrade, user data and security permissions for accessing the data remain unchanged. This scenario is convenient, because after the in-place upgrade, users can continue to access their data on the same file servers. |
| You want to keep all roles, features, and settings of the existing server | Before performing an in-place upgrade on a server that has specific roles, features, or settings—such as DHCP, DNS, or AD DS—list those configurations. Then verify that those configurations support an in-place upgrade of Windows Server 2019. |

If any of these scenarios do not meet your organization’s requirements, then you should perform a migration to Windows Server 2019.

## What is server migration?

When deploying Windows Server 2019, some organizations consider migration instead of an in-place upgrade. There can be risks that arise from an in-place upgrade, such as server unavailability or data being inaccessible. Therefore, your organization might choose to perform a migration because of the benefits described in the following table.

| Benefit                                                      | Explanation                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| You'll deploy servers with the Windows Server 2019 operating system installed, and they will not affect the current IT infrastructure | After you install Windows Server 2019, you can perform tests, such as drivers or system performance tests, before you introduce that server to the domain. In this way, the process of installation and testing is less likely to affect your current IT infrastructure. |
| You'll perform software product migration in a separate environment | For any software solution with an earlier Windows Server edition, you must refer to the product documentation for information about how to migrate that solution to Windows Server 2019. In some scenarios, software products that you are using aren't supported for installation on Windows Server 2019, and you'll require newer editions of those software products. In this case, by using migration, you can perform systematic installation of the operating system and the software products, in a separate environment. This ensures that the migration doesn't affect the availability of current services that the software provides. |
| You'll perform migration of server roles, features, and settings in a separate environment | As with the migration of software products, refer to the documentation on how to migrate the specific roles, features, or settings, such as DHCP, DNS, or AD DS, to Windows Server 2019. Again, migration enables you to perform systematic configuration in a separate environment, which means that the migration shouldn't affect availability of server roles, features, and settings. |
| New operating system enhancements are installed by default   | When performing an in-place upgrade, for compatibility reasons, Windows Server 2019 is configured with settings for the earlier, upgraded version of Windows Server. This means that many enhancements that Windows Server 2019 introduces, such as security, functionality, or performance enhancements, aren't enabled by default. When performing migration, Windows Server 2019 deploys as a clean installation with all new enhancements installed. This ensures that the operating system is more secure and has new functionalities installed by default. |

> [!IMPORTANT]
> You can migrate only certain roles to new Windows Server 2019 computers. However, when you perform an upgrade, all roles are preserved on the newly upgraded server. But you can't control that preservation behavior.
