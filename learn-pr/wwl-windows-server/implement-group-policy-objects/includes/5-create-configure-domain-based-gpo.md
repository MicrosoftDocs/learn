You manage GPOs by using two primary tools:

 -  The Group Policy Management console
 -  The Group Policy Management Editor

You can also use Windows PowerShell cmdlets to manage GPOs and their settings, including those described in the following table.

:::row:::
  :::column:::
    **Cmdlet**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `New-GPO`
  :::column-end:::
  :::column:::
    Creates a new GPO.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `New-GPLink`
  :::column-end:::
  :::column:::
    Links a GPO to a site, domain, or OU.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `Get-GPInheritance`
  :::column-end:::
  :::column:::
    Gets Group Policy inheritance information for a specified domain or OU.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `Set-GPInheritance`
  :::column-end:::
  :::column:::
    Blocks or unblocks inheritance for a specified domain or organizational unit.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `Get-GPO`
  :::column-end:::
  :::column:::
    Gets one GPO or all the GPOs in a domain.
  :::column-end:::
:::row-end:::


## What can you manage with GPOs?

There are two major categories of policy settings: computer settings, which are contained in the **Computer Configuration** node, and user settings, which are contained in the **User Configuration** node:

 -  The **Computer Configuration** node contains the settings that apply to computers, regardless of who logs on to them. Computer settings apply when the operating system starts, during background refreshes, and every 90 to 120 minutes thereafter.
 -  The **User Configuration** node contains settings that apply when a user logs on to a computer, during background refreshes, and every 90 to 120 minutes thereafter.

Within the **Computer Configuration** and **User Configuration** nodes are the **Policies** and **Preferences** nodes.

The **Policies** nodes in Computer Configuration and User Configuration have a hierarchy of folders that contain policy settings. Because there are thousands of settings, the scope of this course doesn't include individual settings. However, it's worth reviewing the types of settings that you can configure.

### Apply security settings

In the Windows Server operating system, GPOs include a large number of security-related settings that you can apply to both users and computers. For example, you can enforce settings for the domain password policy, for Windows Defender Firewall, and you can configure auditing and other security settings. You also can configure full sets of user-rights assignments.

### Manage desktop and application settings

You can use Group Policy to provide a consistent desktop and application environment for all users in your organization. By using GPOs, you can configure each setting that affects the representation of the user environment. You also can configure settings for some applications that support GPOs.

### Deploy software

With Group Policy, you can deploy software to users and computers. You can use Group Policy to deploy all software that is available in the .msi format. Additionally, you can enforce automatic software installation, or you can let your users decide whether they want the software to deploy to their computers.

> [!IMPORTANT]
> Deploying large software packages with GPOs might not be the most efficient way to distribute an application to your organization’s computers. In some circumstances, it might be more effective to distribute applications as part of the desktop computer image.

### Manage Folder Redirection

With the Folder Redirection option, it is easier to back up users’ data files. By redirecting folders, you also ensure that users have access to their data regardless of the computer to which they sign in. Additionally, you can centralize all users’ data to one place on a network server, while still providing a user experience that is similar to storing these folders on their computers. For example, you can configure Folder Redirection to redirect users’ Documents folders to a shared folder on a network server.

### Configuring network settings

By using Group Policy, you can configure various network settings on client computers. For example, you can enforce settings for wireless networks to allow users to connect only to specific Wi-Fi network SSIDs and with predefined authentication and encryption settings. You also can deploy policies that apply to wired network settings, and some Windows Server roles use Group Policy to configure the client side of services, such as DirectAccess.

## Troubleshooting the application of GPOs?

Group Policy inheritance, filters, and exceptions are complex, and it can often be difficult to determine which policy settings will apply. RSoP is the net effect of GPOs applied to a user or computer, considering GPO links, exceptions such as Enforced and Block Inheritance, and the application of security and WMI filters.

RSoP also is a collection of tools that you can use to evaluate, model, and troubleshoot the application of Group Policy settings. RSoP can query a local or remote computer and report the exact settings that applied to the computer and to any user who has logged on to the computer. RSoP also can model the policy settings that are anticipated to be applied to a user or computer under a variety of scenarios, including moving the object between OUs or sites, or changing the object’s group membership. With these capabilities, RSoP can help you manage and troubleshoot conflicting policies. The following tools exist for performing RSoP analysis:

 -  The Group Policy Results Wizard.
 -  The Group Policy Modeling Wizard.
 -  GPResult.exe.

## Demonstration

The following video demonstrates how to create, configure, and apply GPOs. The main steps in the process are:

1.  Open the Group Policy Management console.
2.  Navigate to the Group Policy Objects container.
3.  Create a new GPO.
4.  Open the GPO for editing and modify some user settings.
5.  Link the GPO to the `Contoso.com` domain.
6.  Sign in to a client computer as an administrator and enable Remote Event Log Management and WMI through the firewall.
7.  Sign in as a standard user and review the effect of the GPO on the local computer.
8.  Create a new GPO, edit its settings, and link it to an OU. Review the inheritance settings.
9.  Change the security filtering settings so that the policy only applies to a group, and not Authenticated Users.
10. Verify the effect of the change of inheritance and security filtering.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4McIe]

---

##