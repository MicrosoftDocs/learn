
You want your users be able to customize which language their Windows 10 Enterprise multi-session image displays.

There are two ways you can accommodate the language needs of your users:

 -  Build dedicated host pools with a customized image for each language.
 -  Have users with different language and localization requirements in the same host pool, but customize their images to ensure they can select whichever language they need.

The latter method is a lot more efficient and cost-effective. However, it's up to you to decide which method best suits your needs. This unit will show you how to customize languages for your images.

You need the following to customize Windows 10 Enterprise multi-session images to add multiple languages:

 -  An Azure virtual machine (VM) with Windows 10 Enterprise multi-session.
 -  The Language ISO, Feature on Demand (FOD) Disk 1, and Inbox Apps ISO of the OS version the image uses.
 -  An Azure Files Share or a file share on a Windows File Server Virtual Machine

The file share (repository) must be accessible from the Azure VM you plan to use to create the custom image.

## Create a content repository for language packages and features on demand

To create the content repository for language packages and FODs and a repository for the Inbox Apps packages:

1.  On an Azure VM, download the Windows 10 Multi-Language ISO, FODs, and Inbox Apps for Windows 10 Enterprise multi-session, version 1903/1909, and 2004 images.
2.  Open and mount the ISO files on the VM.
3.  Find the language pack ISO and copy the content from the **LocalExperiencePacks** and **x64\\langpacks** folders, then paste the content into the file share.
4.  Find the FOD ISO file, copy all the content, then paste it into the file share.
5.  Go to the **amd64fre** folder on the Inbox Apps ISO and copy the content in the repository for the inbox apps that you've prepared.
6.  Set the permissions on the language content repository share so that you have read access from the VM you'll use to build the custom image.

## Create a custom Windows 10 Enterprise multi-session image manually

To create a custom Windows 10 Enterprise multi-session image manually:

1.  Deploy an Azure VM, then go to the Azure Gallery and select the current version of Windows 10 Enterprise multi-session you're using.
2.  After you've deployed the VM, connect to it using RDP as a local admin.
3.  Make sure your VM has all the latest Windows Updates. Download the updates and restart the VM, if necessary.
4.  Connect to the language package, FOD, and Inbox Apps file share repository and mount it to a letter drive (for example, drive E).

## Finish customizing your image

After you've installed the language packs, you can install any other software you want to add to your customized image.

Once you're finished customizing your image, you'll need to run the system preparation tool (sysprep).

To run sysprep:

1.  Open an elevated command prompt and run the following command to generalize the image:

```
C:\Windows\System32\Sysprep\sysprep.exe /oobe /generalize /shutdown

```

2.  Stop the VM, then capture it in a managed.
3.  You can now use the customized image to deploy an Azure Virtual Desktop host pool.

## Enable languages in Windows settings app

Finally, after you deploy the host pool, you'll need to add the language to each user's language list so they can select their preferred language in the Settings menu.

To ensure your users can select the languages you installed, sign in as the user, then run the following PowerShell cmdlet to add the installed language packs to the Languages menu. You can also set up this script as an automated task or logon script that activates when the user signs in to their session.

PowerShell

```
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("es-es")
$LanguageList.Add("fr-fr")
$LanguageList.Add("zh-cn")
Set-WinUserLanguageList $LanguageList -force

```

After a user changes their language settings, they'll need to sign out of their Azure Virtual Desktop session and sign in again for the changes to take effect.
