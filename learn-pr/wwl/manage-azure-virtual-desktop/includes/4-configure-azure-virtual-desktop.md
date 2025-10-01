## Create and connect to a Windows 11 desktop with Azure Virtual Desktop
 
Azure Virtual Desktop is a desktop and app virtualization service that runs on the cloud. This tutorial shows you a simple method to deploy a Windows 11 Enterprise desktop in Azure Virtual Desktop using the Azure portal and how to connect to it. To learn more about the terminology used for Azure Virtual Desktop, see [Azure Virtual Desktop terminology.](/azure/virtual-desktop/environment-setup)

You will:
- Create a personal host pool.
- Create a session host virtual machine (VM) joined to your Microsoft Entra tenant with Windows 11 Enterprise and add it to the host pool.
- Create a workspace and an application group that publishes a desktop to the session host VM.
- Assign users to the application group.
- Connect to the desktop.

### Prerequisites
You'll need:

- An Azure account with an active subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.
- The account must be assigned the Owner or Contributor [built-in role-based access control (RBAC) roles](/azure/role-based-access-control/role-assignments-portal) on the subscription.
- A [virtual network](/azure/virtual-network/quick-create-portal) in the same Azure region you want to deploy your session hosts to.
- A user account in Microsoft Entra ID you can use for connecting to the desktop. This account must be assigned the Virtual Machine User Login or Virtual Machine Administrator Login RBAC role on the subscription. Alternatively, you can assign the role to the account on the session host VM or the resource group containing the VM after deployment.
- A Remote Desktop client installed on your device to connect to the desktop. You can find a list of supported clients in [Remote Desktop clients for Azure Virtual Desktop](/azure/virtual-desktop/users/remote-desktop-clients-overview). Alternatively, you can use the [Remote Desktop Web client](/azure/virtual-desktop/users/connect-web), which you can use through a supported web browser without installing any extra software.

### Create a personal host pool, workspace, application group, and session host VM
To create a personal host pool, workspace, application group, and session host VM running Windows 11:

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search bar, type **Azure Virtual Desktop** and select the matching service entry.
1. From the Azure Virtual Desktop overview page, select **Create a host pool**.
1. On the **Basics** tab, complete the following information:

    | Parameter | Value/Description |
    |-----------|-------------------|
    | Project details | |
    | Subscription | Select the subscription you want to deploy your host pool, session hosts, workspace, and application group in from the drop-down list. |
    | Resource group | Select an existing resource group or select **Create new** and enter a name. |
    | Host pool name | Enter a name for the host pool, for example `aad-hp01`. |
    | Location | Select the Azure region from the list where the host pool, workspace, and application group will be deployed. |
    | Validation environment | Select **No**. This setting enables your host pool to receive service updates before all other production host pools, but isn't needed for this tutorial. |
    | Preferred app group type | Select **Desktop**. This setting designates what type of resource users see in their feed if they're assigned both **Desktop** and **Remote App** application groups in the same host pool. |
    | **Host pool type** | |
    | Host pool type | Select **Personal**. This means that end users have a dedicated assigned session host that they'll always connect to. Selecting Personal shows a new option for Assignment type. |
    | Assignment type | Select **Automatic**. Automatic assignment means that a user will automatically get assigned the first available session host when they first sign in, which will then be dedicated to that user. |

    Once you've completed this tab, select **Next: Virtual Machines**.
1. On the **Virtual machines** tab, complete the following information:

    On the Virtual machines tab, complete the following information:

    | Parameter                       | Value/Description                                                                                                                       |
    |---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
    | Add Azure virtual machines      | Select Yes. This shows several new options.                                                                                            |
    | Resource group                  | This automatically defaults to the resource group you chose your host pool to be in on the Basics tab.                                |
    | Name prefix                     | Enter a name for your session hosts, for example Microsoft Entra ID-hp01-sh.                                                                          |
    | Virtual machine location        | Select the Azure region where your session host VMs will be deployed. This must be the same region that your virtual network is in.   |
    | Availability options            | Select No infrastructure dependency required. This means that your session host VMs won't be deployed in an availability set or in availability zones. |
    | Security type                   | Select Standard.                                                                                                                        |
    | Image                           | Select Windows 11 Enterprise, version 22H2.                                                                                            |
    | Virtual machine size            | Accept the default SKU. If you want to use a different SKU, select Change size, then select from the list.                            |
    | Number of VMs                   | Enter 1 as a minimum. You can deploy up to 400 session host VMs at this point if you wish, or you can add more, later.                 |
    | OS disk type                    | Select Premium SSD for best performance.                                                                                                |
    | Boot Diagnostics                | Select Enable with managed storage account (recommended).                                                                               |
    | Network and security            |                                                                                                                                         |
    | Virtual network                 | Select your virtual network.                                                                                                            |
    | Network security group          | Select Basic.                                                                                                                           |
    | Public inbound ports            | Select No.                                                                                                                              |
    | Domain to join                  |                                                                                                                                         |
    | Select which directory you would like to join | Select Microsoft Entra ID.                                                                                   |
    | Enroll VM with Intune           | Select No.                                                                                                                              |
    | Virtual Machine Administrator account |                                                                                                   |
    | Username                        | Enter a name to use as the local administrator account for these session host VMs.                                                     |
    | Password                        | Enter a password for the local administrator account.                                                                                  |
    | Confirm password                | Re-enter the password.                                                                                                                 |
    | Custom configuration            |                                                                                                                                         |
    | ARM template file URL           | Leave this blank.                                                                                                                      |
    | ARM template parameter file URL | Leave this blank.                                                                                                                      |

    Once you've completed this tab, select Next: Workspace.

1. On the Workspace tab, complete the following information:

    | Parameter                 | Value/Description                                                                                                       |
    |---------------------------|-------------------------------------------------------------------------------------------------------------------------|
    | Register desktop app group | Select Yes. This registers the default desktop application group to the selected workspace.                             |
    | To this workspace         | Select Create new and enter a name, for example Microsoft Entra ID-ws01.                                                               |

    Once you've completed this tab, select Next: Review + create.

1. On the Review + create tab, ensure validation passes and review the information that will be used during deployment. If validation doesn't pass, review the error message and check what you entered in each tab.

1. Select Create. A host pool, workspace, application group, and session host will be created. Once your deployment is complete, select Go to resource. This goes to the host pool overview.

### Assign users to the application group

Once your host pool, workspace, application group, and session host VM(s) have been deployed, you need to assign users to the application group that was automatically created. After users are assigned to the application group, they'll automatically be assigned to an available session host VM because Assignment type was set to Automatic when the host pool was created.

1. From the host pool overview, select Application groups.

1. Select the application group from the list, for example Microsoft Entra ID-hp01-DAG.

1. From the application group overview, select Assignments.

1. Select + **Add**, then search for and select the user account you want to be assigned to this application group.

1. Finish by selecting Select.

## Enable connections from Remote Desktop clients

>[!TIP]
>This section is optional if you're going to use a Windows device to connect to Azure Virtual Desktop that is joined to the same Microsoft Entra tenant as your session host VMs and you're using the [Remote Desktop client for Windows.](/azure/virtual-desktop/users/connect-windows?toc=/azure/virtual-desktop/toc.json)

To enable connections from all of the Remote Desktop clients, you'll need to add an RDP property to your host pool configuration.

1. Go back to the host pool overview, then select RDP Properties.
1. Select the Advanced tab.
1. In the RDP Properties box, add targetisaadjoined:i:1; to the start of the text in the box.
1. Select Save.

### Connect to the desktop

You're ready to connect to the desktop. The desktop takes longer to load the first time as the profile is being created, however subsequent connections will be quicker.

>[!IMPORTANT]
>Make sure the user account you're using to connect has been assigned the *Virtual Machine User Login* or *Virtual Machine Administrator Login* RBAC role on the subscription, session host VM, or the resource group containing the VM, as mentioned in the prerequisites, else you won't be able to connect.

Select the relevant tab below and follow the steps, depending on which Remote Desktop client you're using. We've only listed the steps here for Windows, Web and macOS, but if you want to connect using one of our other Remote Desktop clients, see [Remote Desktop clients for Azure Virtual Desktop.](/azure/virtual-desktop/users/remote-desktop-clients-overview)
