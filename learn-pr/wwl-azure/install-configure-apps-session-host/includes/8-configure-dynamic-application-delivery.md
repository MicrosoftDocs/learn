App attach enables you to dynamically attach applications from an application package to a user session in Azure Virtual Desktop. Applications aren't installed locally on session hosts or images, enabling you to create fewer custom images for your session hosts, and reducing operational overhead and costs for your organization. Delivering applications with app attach also gives you greater control over which applications your users can access in a remote session.

This unit shows you how to add and manage applications with app attach in Azure Virtual Desktop using the Azure portal and Azure PowerShell. You can't add or manage app attach applications using Azure CLI.

> [!IMPORTANT]
> You have to choose whether you want to use app attach or MSIX app attach with a host pool. You can't use both versions with the same host pool.

In order to use app attach in Azure Virtual Desktop, you need the following things:

 -  An existing [host pool](/azure/virtual-desktop/create-host-pool) with [session hosts](/azure/virtual-desktop/add-session-hosts-host-pool), an [application group, and a workspace](/azure/virtual-desktop/create-application-group-workspace).
 -  Your session hosts need to run a [supported Windows client operating system](/azure/virtual-desktop/prerequisites#operating-systems-and-licenses) and at least one of them must be powered on. Windows Server isn't supported.

 -  Your host pool needs to be [configured as a validation environment](/azure/virtual-desktop/configure-validation-environment).

 -  Your session hosts need to be joined to Microsoft Entra ID or an Active Directory Domain Services (AD DS) domain.

 -  An SMB file share in the same Azure region as your session hosts. All session hosts in the host pool must have *read* access with their computer account. This file share is used to store your application images. For more information on the requirements for the file share, see [File share](/azure/virtual-desktop/app-attach-overview#file-share).
    
    To use Azure Files when your session hosts joined to Microsoft Entra ID, you need to assign the [Reader and Data Access](/azure/role-based-access-control/built-in-roles#reader-and-data-access) Azure role-based access control (RBAC) role to both the **Azure Virtual Desktop** and **Azure Virtual Desktop ARM Provider** service principals. To learn how to assign an Azure RBAC role to the Azure Virtual Desktop service principals, see [Assign RBAC roles to the Azure Virtual Desktop service principals](/azure/virtual-desktop/service-principal-assign-roles). In a future update of the preview, you won't need to assign the **Azure Virtual Desktop ARM Provider** service principal.

 -  An MSIX or Appx disk image that you created from an application package and stored on the file share. For more information, see [Create an image](/azure/virtual-desktop/app-attach-create-msix-image), where you can also download a prebuilt MSIX package for testing.

 -  To add MSIX images, you need the [Desktop Virtualization Contributor](/azure/virtual-desktop/rbac#desktop-virtualization-contributor) Azure role-based access control (RBAC) role assigned on the resource group as a minimum. To assign users to the application group, you also need Microsoft.Authorization/roleAssignments/write permissions on the application group. Built-in RBAC roles that include this permission are [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) and [Owner](/azure/role-based-access-control/built-in-roles#owner).
 -  If you want to use Azure PowerShell locally, see [Use Azure PowerShell with Azure Virtual Desktop](/azure/virtual-desktop/cli-powershell) to make sure you have the [Az.DesktopVirtualization](/powershell/module/az.desktopvirtualization) and [Microsoft Graph](/powershell/microsoftgraph/installation) PowerShell modules installed. Alternatively, use the [Azure Cloud Shell](/azure/cloud-shell/overview).

 -  You need to use version 4.2.1 of the *Az.DesktopVirtualization* PowerShell module, which contains the cmdlets that support app attach. You can download and install the Az.DesktopVirtualization PowerShell module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Az.DesktopVirtualization/).

Here's how to add an MSIX or Appx image as an app attach package using the Azure portal:

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, type *Azure Virtual Desktop* and select the matching service entry to go to the Azure Virtual Desktop overview.
3.  Select **App attach**, then select **+ Create**.
4.  On the **Basics** tab, complete the following information:
    
    | **Parameter**  | **Description**                                                                           |
    | -------------- | ----------------------------------------------------------------------------------------- |
    | Subscription   | Select the subscription you want to add an MSIX or Appx image to from the drop-down list. |
    | Resource group | Select an existing resource group or select **Create new** and enter a name.              |
    | Host pool      | Select an existing host pool from the drop-down list.                                     |
    | Location       | Select the Azure region for your app attach package.                                      |

5.  Once you've completed this tab, select **Next**.
6.  On the **Image path** tab, complete the following information:

## Assign an app attach package

You need to assign an app attach package to host pools as well as groups and users.

> [!NOTE]
> User accounts need to be hybrid accounts (created in AD DS and synchronized to Azure AD), but groups do not.

Here's how to assign an application package to host pools, users and groups using the Azure portal:

#### Host pools

1.  From the Azure Virtual Desktop overview, select **App attach**, then select the name of the app attach package you want to assign.
2.  In the section **Manage**, select **Host pools**:
3.  Select **+ Assign**, then select one or more host pools from the drop-down list. Make sure that all session hosts in the host pool must have *read* access with their computer account, as listed in the prerequisites.
4.  Select **Add**.

#### Groups and users

1.  From the Azure Virtual Desktop overview, select **App attach**, then select the name of the app attach package you want to assign.
2.  In the section **Manage**, select **Users**:
3.  Select **+ Add**, then select one or more groups and/or users from the list.
4.  Select **Select**.

## Change registration type and state

You can manage your MSIX and Appx packages by changing their [registration type](/azure/virtual-desktop/app-attach-overview#application-registration) and [state](/azure/virtual-desktop/app-attach-overview#application-state).

Here's how to change a package's registration type and state using the Azure portal:

1.  From the Azure Virtual Desktop overview, select **App attach**. You should see a list of all existing packages within the host pool.
2.  Select the name of the package you want to change.
    
    
     -  To change the registration type, select **On-demand** or **Register at log on**, then select **Save**.
     -  To change the state, select **Inactive** or **Active**, then select **Save**.

## Publish an MSIX or Appx application with a RemoteApp application group

You can make MSIX and Appx applications available to users by publishing them with a RemoteApp application group. You don't need to add applications to a desktop application group when using app attach as you only need to [Assign an app attach package](/azure/virtual-desktop/app-attach-setup?tabs=portal&pivots=app-attach#assign-an-app-attach-package).

Here's how to add an application from the package you added in this article to a RemoteApp application group using the Azure portal:

1.  From the Azure Virtual Desktop overview, select **Application groups**, then select the RemoteApp application group you want to add an application to.
2.  Select **Applications**, select **+ Add**. Make sure you have at least one session host powered on in the host pool the application group is assigned to.
3.  On the **Basics** tab, complete the following information:
    
    | **Parameter**          | **Value/Description**                                                                                                                                                                                                                                 |
    | ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Application source     | Select **App Attach** from the drop-down list. If you want to add applications from the *Start menu* or by specifying a file path, see [Publish applications with RemoteApp](/azure/virtual-desktop/publish-applications). |
    | Package                | Select a package available for the host pool from the drop-down list. Regional packages are from *app attach*.                                                                                                                                        |
    | Application            | Select an application from the drop-down list.                                                                                                                                                                                                        |
    | Application identifier | Enter a unique identifier for the application.                                                                                                                                                                                                        |
    | Display name           | Enter a friendly name for the application that is to users.                                                                                                                                                                                           |
    | Description            | Enter a description for the application.                                                                                                                                                                                                              |
4.  Once you've completed this tab, select **Next**.
5.  On the **Icon** tab, select **Default** to use the default icon for the application, or select **File path** to use a custom icon. For **File path**, select one of the following options:
     -  **Browse Azure Files** to use an icon from an Azure file share. Select **Select a storage account** and select the storage account containing your icon file, then select **Select icon file**. Browse to the file share and directory your icon is in, check the box next to the icon you want to add, for example MyApp.ico, then select **Select**. You can also use a .png file. For **Icon index**, specify the index number for the icon you want to use. This number is usually **0**.
     -  **UNC file path** to use an icon from a file share. For **Icon path**, enter the UNC path to your icon file, for example \\\\MyFileShare\\MyApp.ico. You can also use a .png file. For **Icon index**, specify the index number for the icon you want to use. This number is usually **0**.

7.  Once you've completed this tab, select **Review + add**.
8.  On the **Review + add** tab, ensure validation passes and review the information that is used to add the application, then select **Add** to add the application to the RemoteApp application group.
