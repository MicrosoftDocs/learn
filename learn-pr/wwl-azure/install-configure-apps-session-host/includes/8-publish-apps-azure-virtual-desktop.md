This unit will tell you how to publish apps, such as Microsoft Edge browser, in your Azure Virtual Desktop environment.

## Publish built-in apps

To publish a built-in app:

1.  Connect to one of the virtual machines in your host pool.
2.  Get the **PackageFamilyName** of the app you want to publish.
3.  Run the following cmdlet with the PackageFamilyName replaced by the PackageFamilyName found in the previous step:

```
New-AzWvdApplication -Name <applicationname> -ResourceGroupName <resourcegroupname> -ApplicationGroupName <appgroupname> -FilePath "shell:appsFolder\<PackageFamilyName>!App" -CommandLineSetting <Allow|Require|DoNotAllow> -IconIndex 0 -IconPath <iconpath> -ShowInPortal:$true

```

Azure Virtual Desktop only supports publishing apps with install locations that begin with *C:\\Program Files\\WindowsApps*.

## Update app icons

After you publish an app, it will have the default Windows app icon instead of its regular icon picture. To change the icon to its regular icon, put the image of the icon you want on a network share. Supported image formats are PNG, BMP, GIF, JPG, JPEG, and ICO.

## Publish Microsoft Edge

The process you use to publish Microsoft Edge is a little different from the publishing process for other apps. To publish Microsoft Edge with the default homepage, run this cmdlet:

```
New-AzWvdApplication -Name -ResourceGroupName -ApplicationGroupName -FilePath "shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" -CommandLineSetting <Allow|Require|DoNotAllow> -iconPath "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\microsoftedge.exe" -iconIndex 0 -ShowInPortal:$true

```
