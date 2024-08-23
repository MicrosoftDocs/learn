In this exercise, you install Windows Server Active Directory and create a user. This user can be used for testing purposes.

:::image type="content" source="../media/4-exercise-1.png" alt-text="Diagram shows progression of this module with the second exercise highlighted.":::

## Change the ISO file in Hyper-V

Now that you have the virtual machine (VM) up and the operating system installed, you want to change the *.iso* file that VM is using. You're taking this action so that you can run the remaining scripts from within the virtual machine. To change the *.iso* file, do the following tasks:

1. In Hyper-V, right-click **DC1** and select **Settings**.
1. On the left, select **DVD Drive**.
1. On the right, browse for the **LEARN_Scripts_Basic_AD_Azure_AD.iso** file that you downloaded in the prepare section of this module.

   :::image type="content" source="../media/4-exercise-2.png" alt-text="Screenshot shows the Settings dialog box with the image file highlighted." lightbox="../media/4-exercise-2.png":::

1. Select **Apply** and **OK**.

## Install Active Directory prerequisites

You need to do a few things before you install Windows Server AD.

- Rename the virtual machine
- Set a static IP address and DNS information
- Install the Remote Server Administration tools

You can use this PowerShell script to accomplish these tasks. The script contains the following variables. You can change the variables to suit your environment or preferences.

| Variable   | Description |
|:-----------|:------------|
| $ipaddress | The IP address of our network card |
| $ipprefix  | Defines the local subnet size, and is also known as a subnet mask |
| $ipgw      | Specifies the IPv4 address of the default gateway for the host. Default gateways provide a default route for TCP/IP hosts to use when communicating with other hosts on remote networks |
| $ipdns     | The first DNS server to set for the interface |
| $ipdns2    | The second DNS server to set for the interface |
| $ipif      | Specifies the index number of the interface |
| $featureLogPath | Sets the log file path |
| $newname   | The new name of the server |
| $addsTools | The remote administration tools to install |

1. Open the PowerShell ISE as Administrator.
1. Run the following script.

   ```powershell
    #Declare variables
    $ipaddress = "10.0.1.117" 
    $ipprefix = "24" 
    $ipgw = "10.0.1.1" 
    $ipdns = "10.0.1.117"
    $ipdns2 = "8.8.8.8" 
    $ipif = (Get-NetAdapter).ifIndex 
    $featureLogPath = "c:\poshlog\featurelog.txt" 
    $newname = "DC1"
    $addsTools = "RSAT-AD-Tools" 

    #Set static IP address
    New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix -InterfaceIndex $ipif -DefaultGateway $ipgw 

    # Set the DNS servers
    Set-DnsClientServerAddress -InterfaceIndex $ipif -ServerAddresses ($ipdns, $ipdns2)

    #Rename the computer 
    Rename-Computer -NewName $newname -force 

    #Install features 
    New-Item $featureLogPath -ItemType file -Force 
    Add-WindowsFeature $addsTools 
    Get-WindowsFeature | Where installed >>$featureLogPath 

    #Restart the computer 
    Restart-Computer
    ```

## Create a Windows Server AD environment

After your VM is renamed and has a static IP address, you can install and configure Active Directory Domain Services.

This PowerShell script can accomplish this task. The script contains the following variables. You can change the variables to suit your environment or preferences.

| Variable | Description |
|:---------|:-----------|
| $DatabasePath       | The fully qualified, non-Universal Naming Convention (UNC) path to a directory on a fixed disk of the local computer that contains the domain database, for instance, C:\Databases\NTDS. The default is %SYSTEMROOT%\NTDS |
| $DomainMode         | The domain functional level of the first domain in the creation of a new forest |
| $DomainName | Specifies the fully qualified domain name (FQDN) for the root domain in the forest |
| $DomaninNetBIOSName | The NetBIOS name for the root domain in the new forest |
| $ForestMode         | The forest functional level for the new forest |
| $LogPath            | The fully qualified, non-UNC path to a directory on a fixed disk of the local computer where the log file for this operation is written |
| $SysVolPath         | The fully qualified, non-UNC path to a directory on a fixed disk of the local computer where the sysvol file is written |
| $featureLogPath     | The feature log file path |
| $Password           | The password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode |
| $SecureString       | Converts $Password to a secure string |

1. Open the PowerShell ISE as Administrator.
1. Run the following script.

    ```powershell
    #Declare variables
    $DatabasePath = "c:\windows\NTDS"
    $DomainMode = "WinThreshold"
    $DomainName = "contoso.com"
    $DomaninNetBIOSName = "CONTOSO"
    $ForestMode = "WinThreshold"
    $LogPath = "c:\windows\NTDS"
    $SysVolPath = "c:\windows\SYSVOL"
    $featureLogPath = "c:\poshlog\featurelog.txt" 
    $Password = "Pass1w0rd"
    $SecureString = ConvertTo-SecureString $Password -AsPlainText -Force

    #Install AD DS, DNS and GPMC 
    start-job -Name addFeature -ScriptBlock { 
    Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
    Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
    Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools } 
    Wait-Job -Name addFeature 
    Get-WindowsFeature | Where installed >>$featureLogPath

    #Create New AD Forest
    Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath $DatabasePath -DomainMode $DomainMode -DomainName $DomainName -SafeModeAdministratorPassword $SecureString -DomainNetbiosName $DomainNetBIOSName -ForestMode $ForestMode -InstallDns:$true -LogPath $LogPath -NoRebootOnCompletion:$false -SysvolPath $SysVolPath -Force:$true
    ```

## Create a Windows Server AD user

After you create your Active Directory environment, you need to a test account. Create this account in your on-premises Windows Server AD environment and then synchronize it to Microsoft Entra ID.

This PowerShell script can accomplish this task. The script contains the following variables. You can change the variables to suit your environment or preferences.

| Variable     | Description |
|:-------------|:------------|
| $Givenname   | The user's given name |
| $Surname     | The user's family name or surname |
| $Displayname | The display name of the user |
| $Name        | The name of the user |
| $Password    | The password for the user |
| $Identity    | Specifies an Active Directory user object by providing the DN of the user |
| $SecureString| Converts $Password to a secure string |

1. Open the PowerShell ISE as Administrator.
1. Run the following script.

    ```powershell 
     #Declare variables
    $Givenname = "Anna"
    $Surname = "Ringdal"
    $Displayname = "Anna Ringdal"
    $Name = "aringdal"
    $Password = "Pass1w0rd"
    $Identity = "CN=aringdal,CN=Users,DC=contoso,DC=com"
    $SecureString = ConvertTo-SecureString $Password -AsPlainText -Force


    #Create the user
    New-ADUser -Name $Name -GivenName $Givenname -Surname $Surname -DisplayName $Displayname -AccountPassword $SecureString

    #Set the password to never expire
    Set-ADUser -Identity $Identity -PasswordNeverExpires $true -ChangePasswordAtLogon $false -Enabled $true

## Create a checkpoint

After you create the user, create a snapshot of the work you have done. You can roll back to this point if you need to. To do this task, do the following steps:

1. In Hyper-V, right-click **DC1**.
1. Select **Checkpoint**.

   :::image type="content" source="../media/4-exercise-3.png" alt-text="Screenshot shows the Hyper-V window with your newly created snapshot." lightbox="../media/4-exercise-3.png":::

You should now see a checkpoint created.

## Check your work

At this point, your server should be renamed and have Windows Server Active Directory installed. The new user named Anna Ringdal should be created.

To verify this exercise, connect to the virtual machine.

1. From the Windows button, select **Server Manager**.
1. On the left, select **Local Server**.
1. On the right, under **Properties**, the computer name should be **DC1**.
1. Next, at the top of **Server Manager**, select **Tools** and then **Active Directory Users and Computers (ADUC)**.
1. In ADUC, on the left, select **contoso**.
1. On the right, select **Users** and verify that **Anna Ringdal** is there.

> [!VIDEO https://msit.microsoftstream.com/embed/video/6aae0840-98dc-b478-91f5-f1ecf1b8ddd0?autoplay=false&amp;showinfo=true]
