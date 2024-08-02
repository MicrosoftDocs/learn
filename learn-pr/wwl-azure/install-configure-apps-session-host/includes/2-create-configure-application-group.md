There are two ways to make applications available to users in Azure Virtual Desktop: as part of a full desktop or as individual applications with RemoteApp. You publish applications by adding them to an application group, which is associated with a host pool and workspace, and assigned to users.

You publish applications in the following scenarios:

 -  For *RemoteApp* application groups, you publish applications to stream remotely that are installed locally on session hosts or delivered dynamically using *app attach* and *MSIX app attach* and presented to users as individual applications in one of the [supported Remote Desktop clients](/azure/virtual-desktop/users/remote-desktop-clients-overview).
 -  For *desktop* application groups, you can only publish a full desktop and all applications in MSIX packages using *MSIX app attach* to appear in the user's start menu in a desktop session. If you use *app attach*, applications aren't added to a desktop application group.

This unit shows you how to publish applications that are installed locally with RemoteApp using the Azure portal.

In order to publish an application to a RemoteApp application group, you need the following things:

 -  An Azure account with an active subscription.
 -  An existing [host pool](/azure/virtual-desktop/create-host-pool) with [session hosts](/azure/virtual-desktop/add-session-hosts-host-pool), a [RemoteApp application group, and a workspace](/azure/virtual-desktop/create-application-group-workspace).
 -  At least one session host is powered on in the host pool the application group is assigned to.
 -  The applications you want to publish are installed on the session hosts in the host pool the application group is assigned to. If you're using app attach, you must add and assign an MSIX package to your host pool before you start. For more information, see [Add and manage app attach applications](/azure/virtual-desktop/app-attach-setup).
 -  As a minimum, the Azure account you use must have the [Desktop Virtualization Application Group Contributor](/azure/virtual-desktop/rbac#desktop-virtualization-application-group-contributor) built-in role-based access control (RBAC) roles on the resource group, or on the subscription to create the resources.

## Add applications to a RemoteApp application group

Here's how to add applications to a RemoteApp application group using the Azure portal.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, type *Azure Virtual Desktop* and select the matching service entry.
3.  Select **Application groups**, then select the RemoteApp application group you want to add an application to.
4.  Select **Applications**, select **+ Add**. Make sure you have at least one session host powered on in the host pool the application group is assigned to.
5.  On the **Basics** tab, from application source drop-down list, select **App Attach**, **Start** menu, or **File path**. The remaining fields change depending on the application source you select.
    
    
     -  Complete the following information. Your MSIX package must already be [added and assigned to your host pool](/azure/virtual-desktop/app-attach-setup).
        
        | **Parameter**          | **Value/Description**                                                                                                                                            |
        | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
        | Package                | Select a package available for the host pool from the drop-down list. Regional packages are from *app attach* and host pool packages are from *MSIX app attach*. |
        | Application            | Select an application from the drop-down list.                                                                                                                   |
        | Application identifier | Enter a unique identifier for the application.                                                                                                                   |
        | Display name           | Enter a friendly name for the application that is to users.                                                                                                      |
        | Description            | Enter a description for the application.                                                                                                                         |
     -  For **Start** menu, complete the following information:
        
        | **Parameter**        | **Value/Description**                                                                                                                              |
        | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
        | Application          | Select an application from the drop-down list.                                                                                                     |
        | Display name         | Enter a friendly name for the application that is to users.                                                                                        |
        | Description          | Enter a description for the application.                                                                                                           |
        | Application path     | Review the file path to the .exe file for the application and change it if necessary.                                                              |
        | Require command line | Select if you need to add a specific command to run when the application launches. If you select Yes, enter the command in the Command line field. |
     -  For **File path**, complete the following information:
        
        | **Parameter**          | **Value/Description**                                                                                                                             |
        | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
        | Application path       | Enter the file path to the .exe file for the application.                                                                                         |
        | Application identifier | Enter a unique identifier for the application.                                                                                                    |
        | Display name           | Enter a friendly name for the application that is displayed to users.                                                                             |
        | Description            | Enter a description for the application.                                                                                                          |
        | Require command line   | Select if you need to add a specific command to run when the application launches. If you select Yes, enter the command in the Command line field |
6.  On the **Icon** tab, the options you see depend on the application source you selected on the Basics tab. With app attach you can use a UNC path. For the **Start Menu and File** path you only use a local path.
    
    
     -  If you selected **App Attach**, select **Default** to use the default icon for the application, or select **File path** to use a custom icon.
        
        For **File path**, select one of the following options:
        
        
         -  Browse **Azure Files** to use an icon from an Azure file share. Select **Select a storage account** and select the storage account containing your icon file, then select **Select** icon file. Browse to the file share and directory your icon is in, check the box next to the icon you want to add, for example MyApp.ico, then select **Select**. You can also use a .png file. For Icon index, specify the index number for the icon you want to use. This is usually 0.
         -  UNC file path to use an icon from a file share. For **Icon path**, enter the UNC path to your icon file, for example *\\\\MyFileShare\\MyApp.ico*. You can also use a .png file. For **Icon index**, specify the index number for the icon you want to use. This is usually 0.
     -  If you selected **Start menu** or **File path**, for **Icon path**, enter a local path to the .exe file or your icon file, for example *C:\\Program Files\\MyApp\\MyApp.exe.* For Icon index, specify the index number for the icon you want to use. This is usually 0.
    
    Once you've completed this tab, select Review + add.
7.  On the **Review + add** tab, ensure validation passes and review the information that is used to add the application, then select **Add** to add the application to the RemoteApp application group.

## Assign applications to users

Applications aren't assigned individually to users unless you're using app attach. Instead, users are assigned to application groups. When a user is assigned to an application group, they can access all the applications in that group.

## Publish Microsoft Store applications

Applications in the Microsoft Store are updated frequently and often install automatically. The directory path for an application installed from the Microsoft Store includes the version number, which changes each time an application is updated. If an update happens automatically, the path changes and the application is no longer available to users. You can publish applications using the Windows shell:appsFolder location in the format shell:AppsFolder\\&lt;PackageFamilyName&gt;!&lt;AppId&gt;, which doesn't use the .exe file or the directory path with the version number. This method ensures that the application location is always correct.

Using shell:appsFolder means the application icon isn't picked up automatically from the application. You should provide an icon file on a local drive on each session host in a path that doesn't change, unlike the application installation directory.

Here's how to publish a Microsoft Store application using the Windows user interface and the Azure portal:

1.  On your session host, open File Explorer and go to the path shell:appsFolder.
2.  Find the application in the list, right-click it, then select **Create a shortcut**.
3.  For the shortcut prompt that appears, select **Yes** to place the shortcut on the desktop.
4.  View the properties of the shortcut and make a note of the **Target value**. This value is the package family name and application ID you need to publish the application.
5.  Follow the steps in the section [Add applications to a RemoteApp application group](/azure/virtual-desktop/publish-applications-stream-remoteapp?tabs=portal#add-applications-to-a-remoteapp-application-group) for publishing an application based on **File path**. For the parameter Application path, use the value from the **Target field** of the shortcut you created, then specify the icon path as your local icon file.
