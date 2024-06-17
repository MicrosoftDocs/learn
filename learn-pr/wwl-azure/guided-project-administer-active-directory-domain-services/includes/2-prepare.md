## Project overview

In this guided project, you go through the major steps of creating, configuring, and maintaining a domain controller. You also have the opportunity to promote a domain controller.

## Setup

To reduce resource access requirements (such as access to Windows Server or a Microsoft Azure subscription), this guided project uses a Windows 10 or Windows 11 machine to run a virtualized environment. You configure a Windows 10 or Windows 11 computer’s Hyper-V subsystem to support the two Windows Server 2022 Evaluation Edition virtual machines that you use in this project. You require the Professional or Enterprise edition of Windows 10 or Windows 11 to perform these tasks.

The computer that functions as the Hyper-V virtualization host should have at least 16 GB of RAM. You can also use an evaluation version of Windows Server with the Hyper-V role installed as the host for these virtual machines, or to configure a third-party virtualization platform to host both virtual machines. The exercises and tasks in this lab use Windows 11 when describing the Hyper-V host. The options presented here make it easy to locate large virtual machine files if you want to remove the configuration after you finish with the project.

The Setup section consists of three main tasks:

 -  Install Hyper-V
 -  Create Windows Server Domain Controller Virtual Machine
 -  Create Windows Server Domain Member Server

### Install Hyper-V

In this task, you install Hyper-V and configure a NAT switch. You configure Hyper-V to use a different set of default directories to store virtual machine files and hard disks. You can use the options presented in these instructions or choose your own location.

1.  Sign in to the Windows 11 computer with an account that has local Administrator privileges.
2.  On the Windows 11 Computer click **Start**, select **Settings** and on the Settings page select **System**.
3.  On the System page of Settings, scroll down until you locate Optional Features. Select **Optional Features**.
4.  On the Optional Features page, scroll down until you locate **More Windows Features** under Related Settings.
5.  On the Windows Feature page, select the checkbox next to Hyper-V and click **OK** as shown in the exhibit.
    
    :::image type="content" source="../media/optional-features.png" alt-text="Screenshot of the Optional Features page with Hyper-V selected.":::
    
6.  When the installation completes, on the Windows Features page, click **Restart Now**.
7.  After the computer restarts, sign in again using the same account that has local Administrative privileges.
8.  Click **Start** and search for Hyper-V Manger. Pin Hyper-V Manager to the Taskbar.
9.  Open Hyper-V Manager, right click on the local computer, and select **Hyper-V Settings**.
10. On the **Hyper-V settings** dialog box, under Server, select **Virtual Machines**. Set the location of the Virtual Machines folder to C:\\VirtualMachines.
11. Under the **Hyper-V settings** dialog box, under Server, select **Virtual Machine Hard Disks**. Set the location of the Virtual Machine Hard Disks to C:\\VirtualMachines\\VHDs.
12. Click **OK** to close the **Hyper-V Settings** dialog box.
13. Open an Administrative command prompt and run the following commands to create a NAT network.<br>`New-VMSwitch -SwitchName “NATSwitch” -SwitchType Internal`<br>`New-NetIPAddress -IPAddress 10.10.10.1 -PrefixLength 24 -InterfaceAlias “vEthernet (NATSwitch)”`<br>`New-NetNat -Name “NATNetwork” –InternalIPInterfaceAddressPrefix “10.10.10.0/24”`
14. Close the Administrative command prompt.

### Create Windows Server Domain Controller Virtual Machine

In this task, you deploy and configure a Windows Server 2022 Domain Controller for the lab in which you perform tasks related to the Applied Skill Credential. To perform this task, ensure that you downloaded the Windows Server 2022 Evaluation Edition ISO file from [https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022). Place this file in the folder c:\\ISOs. This evaluation ISO allows you to run a full version of Windows Server 2022 for up to 180 days.

1.  In Hyper-V Manager on the **Actions** menu select **New** and then select **Virtual Machine**.
2.  On the Before you Begin page of the New Virtual Machine Wizard, click **Next**.
3.  On the Specify Name and Location page of the New Virtual Machine Wizard, type the name **TAILWIND-DC1** and click **Next**.
4.  On the Specify Generation page, select **Generation 2** and click **Next**.
5.  On the Assign Memory page, set the startup memory to 4096 MB and leave the **Use Dynamic Memory for this virtual machine** option selected. Click **Next**.
6.  On the Configure Networking page, set the Connection in the drop-down menu to NATSwitch and click **Next**.
7.  On the Connect Virtual Hard Disk page, accept the defaults and click **Next**.
8.  On the Installation Options page, select the **Install an operating system from a bootable image file** option and then click **Browse** to select the Windows Server 2022 Evaluation Edition iso file (named SERVER\_EVAL\_x64FRE\_en-us.iso). You already downloaded this file to the C:\\ISOs folder. Click **Next**.
9.  On the Summary page, click **Finish**.
10. In Hyper-V Manager, right-click TAILWIND-DC1 and select **Settings**.
11. On the TAILWIND-DC1 Settings page, under Management select **Checkpoints** and ensure that the **Use automatic checkpoints** option isn't selected as is shown in the screenshot. Click **OK**.
    
    :::image type="content" source="../media/checkpoints.png" alt-text="Screenshot of the Checkpoints selection on the Settings page.":::
    
12. Double-click TAILWIND-DC1. This opens the Virtual Machine Connection window. Select **Start**. When the Press any key to boot from CD or DVD message displays, use the mouse to select inside the virtual machine window and press the Space bar. This sets the virtual machine to boot from the attached ISO file.
13. On the Microsoft Server Operating System Setup page, accept the defaults and click **Next**.
14. On the Install now page, select **Install now**.
15. On the Microsoft Server Operating System Setup page, select **Windows Server 2022 Standard Evaluation (Desktop Experience)** as shown in the screenshot and click **Next**.
    
    :::image type="content" source="../media/server-install.png" alt-text="Screenshot of the Microsoft Server Operating System Setup screen with Windows Server 2022 Standard Evaluation selected.":::
    
16. On the Applicable notices and license terms page, review the license and then select the **I Accept** checkbox. Click **Next**.
17. On the Which type of installation do you want? page, select **Custom**.
18. On the Where do you want to install the operating system? page, select Drive 0 and click **Next**. The operating system will install. This takes several minutes depending on the speed of the computer you're using. The virtual machine will restart.
19. On the Customize settings page, you are asked to provide a password for the built-in Administrator account. Enter the password: **Pa55w.rdPa55w.rd** twice. The password is a demonstration password and shouldn't be used on production systems. You can also choose your own password here. After you have entered the Administrator password twice, click **Finish**. You won't be connected to the running virtual machine.
20. On the virtual machine’s lock screen, enter the Administrator password **Pa55w.rdPa55w.rd** to sign in.
21. After you sign in, right-click the network icon, represented by a globe on the task bar, and select **Open Network & Internet Settings**.
22. On the Network Status page, select **Change adapter options**.
23. On the Network Connections page, right-click **Ethernet** and select **Properties**.
24. On the Ethernet Properties page, select the Internet Protocol Version 4 (TCP/IPv4) item and click **Properties**.
25. On the General tab of the Internet Protocol Version 4 (TCP/IPv4) Properties page, set the IP address configuration as follows and click **OK**:
    
    
    1.  Use the following IP address:
        
        
        1.  IP address: 10.10.10.10
        2.  Subnet Mask: 255.255.255.0
        3.  Default Gateway: 10.10.10.1
    2.  Use the following DNS server addresses:
        
        
        1.  Preferred DNS server: 1.1.1.1
        2.  Alternate DNS server: 8.8.8.8
26. Click **Close**. When queried about whether you want to allow the computer to be discoverable, select **Yes**.
27. From the Start menu, open Server Manager, select Local Server and then select the Computer Name. This opens the System Properties dialog box. On the Computer Name page of the System Properties dialog box, select **Change**.
28. On the Computer Name/Domain Changes dialog box, set the computer name to **TAILWIND-DC1** and then click **OK**.<br>
29. In the dialog informing you that you need to restart your computer click **OK**.
30. On the System Properties dialog box, select **Close**.
31. In the **You must restart your computer to apply these changes** dialog box, click **Restart Now**. The computer will restart.
32. When the computer has restarted, sign in as Administrator with the password you configured during installation.
33. In Server Manager, select the Manage menu and then select **Add Roles and Features**.
34. On the Before you begin page of the Add Roles and Features wizard, select **Next**.
35. On the Select installation type page, select **Role-based or feature-based installation** and click **Next**.
36. On the Select destination server page, click **Select a server from the server pool**, ensure **TAILWIND-DC1** is selected and click **Next**.
37. On the Select server roles page, select the **Active Directory Domain Services** checkbox. This opens the Add features page. Select **Add Features**. On the Select server roles page, click **Next**.
38. On the Select features page, click **Next**.
39. On the Active Directory Domain Services page, click **Next**.
40. On the Confirm installation selections page, select **Install**. Depending on the speed of the computer, installation may take several minutes. When the installation completes, click **Close**.
41. On the Server manager menu, select the notification icon next to the flag in the top right corner shown in the screenshot.
    
    :::image type="content" source="../media/server-manager-menu.png" alt-text="Screenshot of the server manager menu with the alert icon displayed.":::
    
42. On the menu that opens when you select the notification icon, select **Promote this server to a domain controller**. This starts the Active Directory Domain Services Configuration Wizard.
43. On the Deployment Configuration page, select **Add a new forest** and set the root domain name to **tailwindtraders.internal**. Click **Next**.
44. On the Domain Controller options page, accept the default settings and provide the Directory Services Restore Mode (DSRM) password. To do this, enter the following password twice: Pa55w.rdPa55w.rd. Click **Next**.
45. On the DNS Options page, click **Next**.
46. On the Additional Options page, click **Next**.
47. On the Paths page, click **Next**.
48. On the Review Options page, click **Next**.
49. On the Prerequisites Check page, click **Install**. The installation takes several minutes depending on the speed of the virtual machine. The virtual machine will restart.
50. When the virtual machine restarts, sign in as **tailwindtraders\\administrator** with the password you configured for the default administrator account (Pa55w.rdPa55w.rd)

### Create Windows Server Domain Member Server<br>

In this task, you deploy and configure a Windows Server 2022 Domain member server for the lab in which you perform tasks related to the Applied Skill Credential. This task also uses the evaluation edition iso file.

1.  In Hyper-V Manager on the Actions menu, select **New** and then select **Virtual Machine**.
2.  On the Before you Begin page of the New Virtual Machine Wizard, click **Next**.
3.  On the Specify Name and Location page of the New Virtual Machine Wizard, enter the name **TAILWIND-MBR1** and click **Next**.
4.  On the Specify Generation page, select **Generation 2** and click **Next**.
5.  On the Assign Memory page, set the startup memory to 4096 MB and leave the **Use Dynamic Memory for this virtual machine** option selected. Click **Next**.
6.  On the Configure Networking page, set the Connection in the drop-down menu to **NATSwitch** and click **Next**.
7.  On the Connect Virtual Hard Disk page, accept the defaults and click **Next**.
8.  On the Installation Options page, select the **Install an operating system from a bootable image file** option and then click **Browse** to select the Windows Server 2022 Evaluation Edition iso file (named SERVER\_EVAL\_x64FRE\_en-us.iso) that you have downloaded to the C:\\ISOs folder. Click **Next**.
9.  On the Summary page, click **Finish**.
10. In Hyper-V Manager, right-click **TAILWIND-MBR1** and select **Settings**.
11. On the TAILWIND-MBR1 Settings page, under Management, select **Checkpoints**, ensure that the **Use automatic checkpoints** option isn't selected, and click **OK**.
12. Double click TAILWIND-MBR1. This brings up the Virtual Machine Connection window. Click **Start**. When the Press any key to boot from CD or DVD message appears, use the mouse to select inside the virtual machine window and press the Space bar. This sets the virtual machine to boot from the attached ISO file.
13. On the Microsoft Server Operating System Setup page, accept the defaults and click **Next**.
14. On the Install now page, click **Install now**.
15. On the Microsoft Server Operating System Setup page, select **Windows Server 2022 Standard Evaluation (Desktop Experience)** and click **Next**.
16. On the Applicable notices and license terms page, review the license and then select the **I Accept** checkbox. Click **Next**.
17. On the Which type of installation do you want? page, select **Custom**.
18. On the Where do you want to install the operating system? page, select **Drive 0** and click **Next**. The operating system will install. This takes several minutes depending on the speed of the computer you're using. The virtual machine will restart.
19. On the Customize settings page, you are asked to provide a password for the built-in Administrator account. Enter the password: **Pa55w.rdPa55w.rd** twice. The password is a demonstration password and shouldn't be used on production systems. You can also choose your own password here. After you have entered the Administrator password twice, select **Finish**. You won't be connected to the running virtual machine.
20. On the virtual machine’s lock screen, enter the Administrator password **Pa55w.rdPa55w.rd** to sign in.
21. After you have signed in, right-click the network icon, represented by a globe on the task bar, and select **Open Network & Internet Settings**.
22. On the Network Status page, select **Change adapter options**.
23. On the Network Connections page, right-click **Ethernet** and select **Properties**.
24. On the Ethernet Properties page, select the **Internet Protocol Version 4 (TCP/IPv4)** item and click **Properties**.
25. On the General tab of the Internet Protocol Version 4 (TCP/IPv4) Properties page, set the IP address configuration as follows and click **OK**:
    
    
    1.  Use the following IP address:
        
        
        1.  IP address: 10.10.10.20
        2.  Subnet Mask: 255.255.255.0
        3.  Default Gateway: 10.10.10.1
    2.  Use the following DNS server addresses:
        
        
        1.  Preferred DNS server: 10.10.10.10
        2.  Alternate DNS server: 8.8.8.8
26. Click **Close**. When queried about whether you want to allow the computer to be discoverable, select **Yes**.
27. From the Start menu, open Server Manager, select **Local Server** and then select the Computer Name. This opens the System Properties dialog box. On the Computer Name page of the System Properties dialog box, select **Change**.
28. On the Computer Name/Domain Changes dialog box, set the computer name to **TAILWIND-MBR1** and then click **OK**.<br>
29. On the dialog informing you that you need to restart your computer, click **OK**.
30. On the System Properties dialog box, click **Close**.
31. On the You must restart your computer to apply these changes dialog box, click **Restart Now**. The computer will restart.
32. When the computer has restarted, sign in as Administrator with the password you configured during installation.
33. In the Server Manager console, select the Local Server section. In the Local Server section, select TAILWIND-MBR1 next to Computer Name. this opens the System Properties dialog box.
34. On the System Properties dialog box, click **Change**.
35. On the Computer Name/Domain Changes dialog box, select **Domain under Member of**, enter the domain name **TAILWINDTRADERS,** and click **OK**.
36. On the Computer Name/Domain Changes dialog box, enter the following username and password and click **OK**:
    
    
    1.  Username: TAILWINDTRADERS\\Administrator
    2.  Password: Pa55w.rdPa55w.rd
37. Momentarily, the Welcome to the Tailwintraders domain dialog will appear. Click **OK**.
38. On the System Properties dialog box, click **Close**.
39. On the dialog asking you to restart the computer, click **Restart Now**.
