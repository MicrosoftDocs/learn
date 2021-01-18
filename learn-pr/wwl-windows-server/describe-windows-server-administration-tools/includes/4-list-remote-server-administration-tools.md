
Following a recent security audit by a firm specializing in IT security, you are reviewing a report on shortcomings in Contoso's procedures regarding server management. One of the significant comments in the report highlights the security impact of using locally installed, interactive management tools. You decide to investigate what other options are available for remote management. You learn that Remote Server Administration Tools (RSAT) are a group of management tools that enables IT administrators to remotely manage roles and features in Windows Server from a computer that is running Windows 10. 

## Enable RSAT

You no longer need to download and install RSAT on Windows 10. With Windows 10 1803 and newer, you enable RSAT from the Settings app. In **Settings**, search for **Manage optional features**, select **Add a feature**, and then select the appropriate RSAT tool(s) from the returned list. Select **Install** to add the feature.

:::image type="content" source="../media/m2-enable-rsat.png" alt-text="A screenshot of the Add an optional feature dialog box. Displayed are a list of RSAT tools.":::

You can install the consoles available within RSAT on computers running Windows 10 or on server computers that are running the Server with Desktop Experience option of a Windows Server installation.

> [!NOTE]
> Until the introduction of Windows Admin Center, RSAT consoles were the primary graphical tools for administering the Windows Server operating system.

RSAT for Windows 10 consists of the full complement of available management tools including those described in the following table.

|Tool|Description|
|---|---|
|Active Directory Certificate Services Tools|Includes Certification Authority, Certificate Templates, Enterprise PKI, and Online Responder Management snap-ins.|
|Active Directory Domain Services Tools and Active Directory Lightweight Directory Services Tools|Includes Active Directory Administrative Center, Active Directory Domains and Trusts, Active Directory Sites and Services, Active Directory Users and Computers, ADSI Edit, Active Directory module for Windows PowerShell, and tools such as DCPromo.exe, LDP.exe, NetDom.exe, NTDSUtil.exe, RepAdmin.exe, DCDiag.exe, DSACLs.exe, DSAdd.exe, DSDBUtil.exe, DSMgmt.exe, DSMod.exe, DSMove.exe, DSQuery.exe, DSRm.exe, GPFixup.exe, KSetup.exe, KtPass.exe, NlTest.exe, NSLookup.exe, and W32tm.exe.|
|BitLocker Drive Encryption Administration Utilities|Includes Manage-bde, Windows PowerShell cmdlets for BitLocker, and BitLocker Recovery Password Viewer for Active Directory.|
|DHCP Server Tools|Includes the DHCP Management Console, the DHCP Server cmdlet module for Windows PowerShell, and the Netsh command-line tool|
|DNS Server Tools|Includes the DNS Manager snap-in, the DNS module for Windows PowerShell, and the Ddnscmd.exe command-line tool.|
|Failover Clustering Tools|Includes Failover Cluster Manager, Failover Clusters (Windows PowerShell cmdlets), MSClus, Cluster.exe, Cluster-Aware Updating management console, and Cluster-Aware Updating cmdlets for Windows PowerShell.|
|File Services Tools|Includes the following: Share and Storage Management Tools, Distributed File System Tools, File Server Resource Manager Tools, Services for NFS Administration Tools, iSCSI management cmdlets for Windows PowerShell|
|Group Policy Management Tools|Includes Group Policy Management Console, Group Policy Management Editor, and Group Policy Starter GPO Editor.|
|IP Address Management (IPAM) Tools|Includes tools for managing remote IPAM server.|
|Network Controller Management Tools|Includes PowerShell tools for managing Network Controller on Windows Server.|
|Network Load Balancing Tools|Includes the Network Load Balancing Manager, Network Load Balancing Windows PowerShell cmdlets, and the NLB.exe and WLBS.exe command-line tools.|
|Remote Access Management Tools|Includes graphical and PowerShell tools for managing the Remote Access role.|
|Remote Desktop Services Tools|Includes  snap-ins for Remote Desktop Licensing Manager, Remote Desktop Licensing Diagnostics, and Remote Desktop Gateway Manager.|
|Server Manager|Includes the Server Manager console.|
| Shielded VM Tools | Includes Provisioning Data File Wizard and Template Disk Wizard. |
| Storage Migration Service Management Tools | Provides management tools for storage migration tasks. |
| Storage Replica Module for Windows PowerShell | Includes the PowerShell module enabling you to remotely manage the Storage Replica feature. |
| System Insights Module for Windows PowerShell                | Provides System Insights PowerShell module. |
|Volume Activation Tools|Manages volume activation through the vmw.exe file.|
|Windows Server Update Services Tools|Includes the Windows Server Update Services snap-in, WSUS.msc, and PowerShell cmdlets|
